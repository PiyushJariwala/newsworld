import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:newsworld/model/news_model.dart';

import '../const/api_key_const.dart';

class SearchApiCantroller extends GetxController{

  Future<NewsModel> searchApiCall(String search)
  async{
    Uri uri = Uri.parse("https://newsapi.org/v2/everything?q=$search&apiKey=$apiKey");
    final response = await http.get(uri);
    final jsonSearch = convert.jsonDecode(response.body);

    return NewsModel.fromJson(jsonSearch);
  }
}