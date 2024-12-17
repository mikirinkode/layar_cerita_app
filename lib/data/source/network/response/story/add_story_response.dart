class AddStoryResponse {
  final bool error;
  final String message;

  AddStoryResponse({required this.error, required this.message});

  factory AddStoryResponse.fromJson(Map<String, dynamic> json) {
    return AddStoryResponse(
      error: json['error'],
      message: json['message'],
    );
  }
}
