import 'package:flutter/material.dart';
import 'package:restaurant_app/core/api_client.dart';
import 'package:restaurant_app/core/config.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'dart:async'; 

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() =>
      _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {

List restaurants = [];
bool isLoading = true;
String? error;
//search bar 

TextEditingController searchController = TextEditingController();
Timer? debounce;
String query = "";

  @override
  void initState() {
    super.initState(); 
    fetchData();
  }



@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: const Text("Restaurants"),
      centerTitle: true,
    ),
    body: 
     Column(
  children: [

   
    Padding(
      padding: const EdgeInsets.all(12),
      child: 
      TextField(
  controller: searchController,
  onChanged: onSearchChanged,
  style: const TextStyle(color: Colors.black),

  decoration: InputDecoration(
  hintText: "Search restaurants...",
  hintStyle: const TextStyle(color: Colors.black),

  prefixIcon: const Icon(Icons.search, color: Colors.black),

  suffixIcon: IconButton(
    icon: const Icon(Icons.clear, color: Colors.black),
    onPressed: () {
      searchController.clear();
      onSearchChanged("");
    },
  ),

  filled: true,
  fillColor: Colors.white,

  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black),
  ),

 
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black, width: 2),
  ),
),
),
    ),
      const SizedBox(height: 20),
     Expanded(
    child : isLoading
        ? const Center(child: CircularProgressIndicator())
        : error != null
            ? Center(child: Text(error!))
            : restaurants.isEmpty
                ? const Center(child: Text("No restaurants found"))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final item = restaurants[index];

                      return Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 25),// space between cards 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RestaurantDetailScreen(
                                  restaurantId: item['id'],
                                  image: item['image'] ?? "",
                                  name: item['name'] ?? "",
                                ),
                              ),
                            );
                          },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Hero(
                                    tag: item['id'],
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        item['image'] ?? "",
                                        height: 129,//160,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const SizedBox(
                                          height: 120,//160,
                                          child: Icon(Icons.image, size: 50),
                                        ),
                                      ),
                                    ),
                                  ),
                        
                               
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'] ?? "No Name",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item['description'] ??
                                            "No description available",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
     ),
  ],
     ),
    // );
  );
  
}
void onSearchChanged(String value) {
  if (debounce?.isActive ?? false) debounce!.cancel();

  debounce = Timer(const Duration(milliseconds: 500), () {
    setState(() {
      query = value;
      isLoading = true;
    });

    fetchData();
  });
}

final ApiClient apiClient = ApiClient();

void fetchData() async {
  try {
    final url = AppConfig.searchRestaurantUrl(query, 1);

    final response = await apiClient.post(url, {
      "categoryId": ""
    });

    print(url);
 print(response);

    final data = response['data']['restaurants'];

    setState(() {
      restaurants = data;
      isLoading = false;
    });

  } catch (e) {
    setState(() {
      error = e.toString();
      isLoading = false;
    });
  }
}

// void fetchData() async {
//   try {
//     final url = AppConfig.searchRestaurantUrl("", 1);
//     final response = await apiClient.post(url, {"categoryId": ""});
//    // print(response); 
//     final data = response['data']['restaurants']; 
//     setState(() {
//       restaurants = data;
//       isLoading = false;
//     });
//   } catch (e) {
//     setState(() {
//       error = e.toString();
//       isLoading = false;
//     });
//   }
// }

}