import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../core/config.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final int restaurantId;
  final String image;
  final String name;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
    required this.image,
    required this.name,
  });

  @override
  State<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final ApiClient apiClient = ApiClient();


  Map? data;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text( widget.name, style: const TextStyle(color: Colors.black,),),
      centerTitle: false,
    ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : _buildContent(),
    );
  }

 Widget _buildContent() {
  final address = data?['address'];

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

    
        Hero(
          tag: widget.restaurantId,
          child: Image.network(
            widget.image,
            height: 280,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

    
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [


    Expanded(
      child: Text(
        data?['name'] ?? widget.name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),

    const SizedBox(width: 10),


    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (data?['isOpen'] == 1)
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        (data?['isOpen'] == 1) ? "Open" : "Closed",
        style: TextStyle(
          color: (data?['isOpen'] == 1)
              ? Colors.green
              : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

             
              // Text(
              //   data?['name'] ?? widget.name,
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              const SizedBox(height: 10),

             
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text("${data?['rating'] ?? 0}"),
                  const SizedBox(width: 20),
                  const Icon(Icons.timer, size: 18),
                  const SizedBox(width: 4),
                  Text("${data?['deliveryTime'] ?? '-'} min"),
                ],
              ),
               const SizedBox(height: 20),
              _infoCard(
                icon: Icons.map,
                title: "Distance",
                value: "${data?['distance']} km",
              ),
               const SizedBox(height: 20),
              _infoCard(
                icon: Icons.local_shipping,
                title: "Delivery",
                value: data?['isFreeDelivery'] == 1 ? "Free Delivery" : "Paid Delivery",
              ),

              const SizedBox(height: 20),
              // _infoCard(
              //     icon: Icons.store,
              //     title: "Status",
              //     value: data?['isOpen'] == 1 ? "Open" : "Closed",
              //   ),
              //    const SizedBox(height: 20),

        
             _infoCard(
                icon: Icons.location_on,
                title: "Address",
                value:
                    "${address?['block'] ?? ''}, "
                    "${address?['street'] ?? ''}, "
                    "${address?['building'] ?? ''}, "
                    "Floor ${address?['floor'] ?? ''}, "
                    "${address?['areaName'] ?? 'N/A'}",
              ),

              const SizedBox(height: 12),

            
              _infoCard(
                icon: Icons.shopping_cart,
                title: "Minimum Order",
                value: "₹${data?['minimumOrderValue'] ?? 0}",
              ),

              const SizedBox(height: 12),

           
              _infoCard(
                icon: Icons.delivery_dining,
                title: "Delivery Charge",
                value: "₹${data?['deliveryCharge'] ?? 0}",
              ),

              const SizedBox(height: 12),

         
              _infoCard(
                icon: Icons.phone,
                title: "Support Phone",
                value: "${data?['supportPhone'] ?? 'N/A'}",
              ),

              const SizedBox(height: 12),

           
              _infoCard(
                icon: Icons.email,
                title: "Support Email",
                value: "${data?['supportEmail'] ?? 'N/A'}",
              ),

              const SizedBox(height: 20),

             
              const Text(
                "About Restaurant",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                data?['description'] ??
                    "No description available for this restaurant.",
                style: const TextStyle(height: 1.5),
              ),
             
            ],
          ),
        ),
      ],
    ),
  );
}

  
  Widget _infoCard({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  void fetchDetail() async {
    try {
      final url =
     AppConfig.restaurantDetailUrl(widget.restaurantId);
    final response = await apiClient.get(url);
 print(url);
 print(response);
      setState(() {
        data = response['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

}