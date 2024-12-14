class ApiConfig {
  ApiConfig._();


  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

}

class Endpoints {
  static const baseURL = "https://story-api.dicoding.dev/v1";
  static const login = "$baseURL/login";
  static const register = "$baseURL/register";
  static const stories = "$baseURL/stories";
  static String getDetailStoryURL(String id) => "$stories/$id";
}
