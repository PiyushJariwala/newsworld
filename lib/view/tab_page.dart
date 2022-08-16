import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/cntroller/news_controller.dart';
import 'package:newsworld/model/news_model.dart';

import 'artical_page.dart';

class NewsTabPage extends StatelessWidget {
  final String? country;
  final String? category;

  const NewsTabPage({
    Key? key,
    this.category,
    this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsApiController get_news = Get.put(NewsApiController());
    return Obx(
      () => FutureBuilder(
          future: get_news.apiCall(category!),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              NewsModel news = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  await get_news.apiCall(category!);
                },
                child: ListView.builder(
                    itemCount: news.articles!.length,
                    itemBuilder: (context, index) {
                      return (news.articles![index].title != null &&
                              news.articles![index].urlToImage != null &&
                              news.articles![index].description != null &&
                              news.articles![index].author != null)
                          ? GestureDetector(
                              onTap: () {
                                Get.to(ArticalPage(
                                  articles: news.articles![index],
                                ));
                              },
                              child: Container(
                                height: 400,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 275,
                                      width: double.infinity,
                                      child: Image(
                                        image: NetworkImage(
                                            "${news.articles![index].urlToImage}"),fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                             Text(
                                                "${news.articles![index].title}",
                                                style: TextStyle(
                                                  color: (ThemeMode.system == ThemeMode.dark)?Colors.white:Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            Text(
                                              "${news.articles![index].description}",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                  color: Colors.grey),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "- ${news.articles![index].author}",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Divider(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container();
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
