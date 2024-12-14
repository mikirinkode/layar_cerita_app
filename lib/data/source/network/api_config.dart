class ApiConfig {
  ApiConfig._();

  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Map<String, String> getHeadersWithAuth(String token) => {
        ...headers,
        "Authorization": "Bearer $token",
      };
}

class Endpoints {
  static const baseURL = "https://story-api.dicoding.dev/v1";
  static const login = "$baseURL/login";
  static const register = "$baseURL/register";
  static const stories = "$baseURL/stories";
  static String getDetailStoryURL(String id) => "$stories/$id";
}
