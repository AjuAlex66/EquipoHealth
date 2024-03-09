import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveToken(String? token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token!);
  }

  static getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? "";
  }

  static saveUserId(String userId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', userId);
  }

  static getUserId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('userId');
  }

  static clearAll() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
