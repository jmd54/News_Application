import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application/models/categories_news_model.dart';
import 'package:news_application/models/news_headline_model.dart';


class NewsRepository{

Future<news_headline_model> fetchNewsChannelApi(String channelName) async{
 String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=b82d74f0ea094645be9e23c8c7320116' ;
 final responce= await http.get(Uri.parse(url));
 if(responce.statusCode==200){
 final body=jsonDecode(responce.body);
 return news_headline_model.fromJson(body);
 }
 throw Exception("Error");

}

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=b82d74f0ea094645be9e23c8c7320116' ;
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } 
    throw Exception('Error');
  }

}