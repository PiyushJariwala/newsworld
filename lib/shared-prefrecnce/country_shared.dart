import 'package:get/get.dart';
import 'package:newsworld/cntroller/news_controller.dart';
import 'package:newsworld/const/uid_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPafreController{

  NewsApiController newsApiController = Get.put(NewsApiController());

  void setSharedData(String code,String uid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("code", code);
    sharedPreferences.setString("uid", uid);
  }

  void getCountryCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    newsApiController.selected_country.value = sharedPreferences.getString("code").toString();
  }

  void getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    uid = sharedPreferences.getString("uid").toString();
  }
}
