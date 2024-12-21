import 'package:json_annotation/json_annotation.dart';

import 'story_response.dart';

part 'story_detail_response.g.dart';

@JsonSerializable()
class StoryDetailResponse {
  final bool error;
  final String message;
  final StoryResponse story;

  StoryDetailResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryDetailResponseToJson(this);

  // factory StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
  //     StoryDetailResponse(
  //       error: json["error"],
  //       message: json["message"],
  //       story: StoryResponse.fromJson(
  //         json["story"],
  //       ),
  //     );
}
