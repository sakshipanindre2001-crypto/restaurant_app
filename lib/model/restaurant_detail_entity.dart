class RestaurantDetail {
  final int id;
  final String name;
  final String description;
  final String image;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}