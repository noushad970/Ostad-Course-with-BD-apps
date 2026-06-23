import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? name;

  bool get isLoggedIn => name != null && name!.isNotEmpty;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('user_name');
    notifyListeners();
  }

  Future<void> login(String userName) async {
    name = userName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', userName);
    notifyListeners();
  }

  Future<void> logout() async {
    name = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    notifyListeners();
  }
}
