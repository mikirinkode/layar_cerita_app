class StoryResponse {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;

  StoryResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) => StoryResponse(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        photoUrl: json['photoUrl'] as String,
        createdAt: json['createdAt'] as String,
        lat: json['lat'] as double?,
        lon: json['lon'] as double?,
      );
}
