class ApiConfig {
  ApiConfig._();

  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Map<String, String> getHeadersWithAuth(String token) => {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

  static Map<String, String> getFileUploadHeader(String token) => {
        // "Content-Type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $token",
      };
}

class Endpoints {
  static const baseURL = "https://story-api.dicoding.dev/v1";
  static const login = "$baseURL/login";
  static const register = "$baseURL/register";
  static const stories = "$baseURL/stories";
  static String getDetailStoryURL(String id) => "$stories/$id";
  static String getPaginationStoryURL(int page, int size) =>
      "$stories?page=$page&size=$size&location=0";
}
