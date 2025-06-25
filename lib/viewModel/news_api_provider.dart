import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:practice_api/model/news_model.dart';

class NewsApiProvider with ChangeNotifier{
  bool _isLoading = false;
  List<NewsModel> _newsList = [];
  String _errorMessage = '';
  
  
  bool get isLoading =>_isLoading;
  List<NewsModel> get newsList => _newsList;
  String  get errorMessage =>_errorMessage;
  
  Future<void>fetchData() async{
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
  final List jsonData = jsonDecode(response.body);
    _newsList = jsonData.map((toElement)=>NewsModel.fromJson(toElement)).toList();
      }
      else{
        _errorMessage ="server ${response.statusCode}";
      }
    }catch(e){
      e.toString();
    }
    _isLoading = false;
    notifyListeners();

  }
  
}