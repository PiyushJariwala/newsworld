import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/cntroller/search_controller.dart';
import 'package:newsworld/view/artical_page.dart';
import 'package:newsworld/view/home_page.dart';
import 'package:newsworld/view/search_page.dart';

import '../model/news_model.dart';

class SearchResultPage extends StatelessWidget {
  final String? searchResult;

  const SearchResultPage({Key? key, this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchApiCantroller searchApiCantroller = Get.put(SearchApiCantroller());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("News World"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.to(HomePage());
              },
              icon: Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(SearchApiPage());
                },
                icon: Icon(Icons.search)),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: "Search result for  ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "\"$searchResult\"",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: FutureBuilder(
                    future: searchApiCantroller
                        .searchApiCall(searchResult.toString()),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        NewsModel news = snapshot.data;
                        return RefreshIndicator(
                          onRefresh: () async {
                            await searchApiCantroller
                                .searchApiCall(searchResult.toString());
                          },
                          child: ListView.builder(
                              itemCount: news.articles!.length,
                              itemBuilder: (context, index) {
                                return (news.articles![index].title != null &&
                                        news.articles![index].urlToImage !=
                                            null &&
                                        news.articles![index].description !=
                                            null &&
                                        news.articles![index].author != null)
                                    ? GestureDetector(
                                        onTap: () {
                                          Get.to(ArticalPage(articles: news.articles![index],));
                                        },
                                        child: Container(
                                          height: 400,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                    "${news.articles![index].urlToImage}"),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${news.articles![index].title}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "${news.articles![index].description}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Text(
                                                          "- ${news.articles![index].author}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
