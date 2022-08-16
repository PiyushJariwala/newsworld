import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:newsworld/const/api_key_const.dart';
import 'package:newsworld/model/news_model.dart';

class NewsApiController extends GetxController {
  late RxString share_country;
  RxString selected_country = "in".obs;
  RxInt tabIndex = 0.obs;


  Future<NewsModel> apiCall(String category) async {
    Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=$selected_country&category=$category&apiKey=$apiKey",
    );
    var response = await http.get(uri);
    var jsonNews = convert.jsonDecode(response.body);

    return NewsModel.fromJson(jsonNews);
  }
}
