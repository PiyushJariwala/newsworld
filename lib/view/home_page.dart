import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/cntroller/news_controller.dart';
import 'package:newsworld/const/uid_const.dart';
import 'package:newsworld/shared-prefrecnce/country_shared.dart';
import 'package:newsworld/view/drower_page.dart';
import 'package:newsworld/view/logIn_page.dart';
import 'package:newsworld/view/search_page.dart';
import 'package:newsworld/view/tab_page.dart';
import '../const/news_category_const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsApiController newsApiController = Get.put(NewsApiController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCountry();
  }

  void setCountry() async {
    SharedPafreController().getCountryCode();
    SharedPafreController().getUid();
    print(uid);
    print(newsApiController.selected_country.value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: Drower_Page(),
          ),
          appBar: AppBar(
            title: Text("News World"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: category[0]),
                Tab(text: category[1]),
                Tab(text: category[2]),
                Tab(text: category[3]),
                Tab(text: category[4]),
                Tab(text: category[5]),
              ],
              isScrollable: true,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(SearchApiPage());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: TabBarView(
            children: [
              Obx(
                () => NewsTabPage(
                  country: newsApiController.selected_country.value,
                  category: category[0],
                ),
              ),
              Obx(
                () => NewsTabPage(
                    country: newsApiController.selected_country.value,
                    category: category[1]),
              ),
              Obx(
                () => NewsTabPage(
                    country: newsApiController.selected_country.value,
                    category: category[2]),
              ),
              Obx(
                () => NewsTabPage(
                    country: newsApiController.selected_country.value,
                    category: category[3]),
              ),
              Obx(
                () => NewsTabPage(
                    country: newsApiController.selected_country.value,
                    category: category[4]),
              ),
              Obx(
                () => NewsTabPage(
                    country: newsApiController.selected_country.value,
                    category: category[5]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
