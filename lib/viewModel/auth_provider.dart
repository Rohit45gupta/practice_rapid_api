import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../view/bottom_navigation_bar/bottom_navigation_screen.dart';

class AuthProvider with ChangeNotifier {
  final String baseUrl = 'https://edugaondev.com/firebase-api-main/api';

  bool isLoading = false;


  Future<void> signUpUser(Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    notifyListeners();



    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(url, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userData', json.encode(data['data']));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Signup failed')),
        );
      }
    } catch (e) {
      print('Signup Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInUser(String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userData', json.encode(data['data']));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      print('Login Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
    }
}