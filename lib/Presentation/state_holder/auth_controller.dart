import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _accessTokenKey = 'access-token';
  static String? accessToken;
  Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  bool isLoggedInUser() {
    return accessToken != null;
  }
  Future<void> clearUserData()async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
  Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    accessToken = null;
  }
}
