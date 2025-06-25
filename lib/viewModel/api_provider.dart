import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_api/model/RapidApiModel1.dart';

class ApiProvider with ChangeNotifier {
  bool _isLoading = false;
  List<RapidApiModel1> _users = [];
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  List<RapidApiModel1> get users => _users;
  String get errorMessage => _errorMessage;

  Future<void> fetchApi() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url = Uri.parse('https://google-news13.p.rapidapi.com/latest?lr=en-US');
    final headers = {
      'x-rapidapi-key': '803cd0cb5amshb2546b201e0638dp18a063jsne57063f358eb',
      'x-rapidapi-host': 'google-news13.p.rapidapi.com'
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _users = [RapidApiModel1.fromJson(data)];
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
