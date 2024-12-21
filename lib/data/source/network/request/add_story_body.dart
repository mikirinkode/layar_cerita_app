
import 'package:json_annotation/json_annotation.dart';

part 'add_story_body.g.dart';

@JsonSerializable()
class AddStoryBody {
  final String description;
  final double? lat;
  final double? lon;

  AddStoryBody({
    required this.description,
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toJson() => _$AddStoryBodyToJson(this);

  Map<String, String> toFieldMap() {
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
