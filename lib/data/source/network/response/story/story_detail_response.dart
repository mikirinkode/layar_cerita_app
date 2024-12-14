import 'story_response.dart';

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
      StoryDetailResponse(
        error: json["error"],
        message: json["message"],
        story: StoryResponse.fromJson(
          json["story"],
        ),
      );
}
