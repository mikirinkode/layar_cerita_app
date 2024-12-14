class ApiResponse<T> {
  final bool error;
  final String message;
  final T? data; // TODO

  ApiResponse({
    required this.error,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json.containsKey('data') ? fromJsonT(json['data']) : null, // TODO
    );
  }
}
