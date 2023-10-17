import 'dart:convert';

import 'package:news_application/models/categories_news_model.dart';
import 'package:news_application/models/news_headline_model.dart';
import 'package:news_application/repository/news_repository.dart';
import 'package:http/http.dart' as http;

class NewsViewModel{
  final _rep=NewsRepository();
  Future<news_headline_model> fetchNewsChannelApi(String channelName)async{
    final responce= await _rep.fetchNewsChannelApi(channelName);
    return responce;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=b82d74f0ea094645be9e23c8c7320116' ;
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } 
    throw Exception("error");
}}