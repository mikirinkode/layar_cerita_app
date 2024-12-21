class AddStoryBody {
  final String description;
  final double? lat;
  final double? lon;

  AddStoryBody({
    required this.description,
    this.lat,
    this.lon,
  });

  Map<String, String> toJson() {
    final map = {
        "description": description,
       };

    if (lat != null) {
      map["lat"] = lat.toString();
    }
    if (lon != null) {
      map["lon"] = lon.toString();
    }
    return map;
  }
}
