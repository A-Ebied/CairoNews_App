import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:finalproject/models/artical.dart';
import 'package:http/http.dart';

class News {

  List<ArticalModel> datatobesavedin = [];

  Future<void> getNews() async {

    var response = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=9cb3b05fd597402ba741e02c7bf3b817"));
    var jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticalModel article = ArticalModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          datatobesavedin.add(article);
        }
      });
    }
  }
}

//}

class NewsForCategorie {

  List<ArticalModel> datatobesavedin = [];

  Future<void> getNews(String category) async {
    var response = await get(Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=9cb3b05fd597402ba741e02c7bf3b817"));
    var jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // initliaze our model class

          ArticalModel article = ArticalModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          datatobesavedin.add(article);
        }
      });
    }
  }
}


