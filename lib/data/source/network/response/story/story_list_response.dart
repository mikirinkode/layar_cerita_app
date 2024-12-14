import 'story_response.dart';

class StoryListResponse {
  final bool error;
  final String message;
  final List<StoryResponse> listStory;

  StoryListResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      StoryListResponse(
        error: json["error"],
        message: json["message"],
        listStory: List<StoryResponse>.from(
          json["listStory"].map(
            (x) => StoryResponse.fromJson(x),
          ),
        ),
      );
}
