import 'package:json_annotation/json_annotation.dart';

import 'story_response.dart';

part 'story_list_response.g.dart';

@JsonSerializable()
class StoryListResponse {
  final bool error;
  final String message;
  final List<StoryResponse> listStory;

  StoryListResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryListResponse.fromJson(Map<String, dynamic> json) => _$StoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryListResponseToJson(this);
  // factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
  //     StoryListResponse(
  //       error: json["error"],
  //       message: json["message"],
  //       listStory: List<StoryResponse>.from(
  //         json["listStory"].map(
  //           (x) => StoryResponse.fromJson(x),
  //         ),
  //       ),
  //     );
}
