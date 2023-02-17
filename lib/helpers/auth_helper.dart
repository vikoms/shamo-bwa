import 'package:shamo_clone/presentation/pages/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthHelper {
  static const String _accessTokenKey = 'access_token';

  static Future<void> setAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }

  static void logOut(BuildContext context) {
    removeAccessToken();
    Navigator.pushNamedAndRemoveUntil(
        context, SignInPage.ROUTE_NAME, (route) => false);
  }
}
