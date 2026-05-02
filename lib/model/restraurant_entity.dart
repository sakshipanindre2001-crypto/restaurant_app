class Restaurant {
  final int id;
  final String name;
  final String image;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}