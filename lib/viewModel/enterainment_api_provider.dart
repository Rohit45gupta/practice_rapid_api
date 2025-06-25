import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EntertainmentApiprovider with ChangeNotifier{

  bool _isLoading = false;
  List<dynamic> _entertainmentList = [];
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  List<dynamic> get entertainmentList  => _entertainmentList;
  String get errorMessage => _errorMessage;


  Future<void> fetchEntertainment() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();


    final url = Uri.parse("https://google-news13.p.rapidapi.com/entertainment?lr=en-US");
    final headers = {
      'x-rapidapi-key': '803cd0cb5amshb2546b201e0638dp18a063jsne57063f358eb',
      'x-rapidapi-host': 'google-news13.p.rapidapi.com'
    };

    try{
    var response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      _entertainmentList = jsonData['items'];
    }else{
      _errorMessage = 'Server error: ${response.statusCode}';
    }
    }catch(e){
     _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}