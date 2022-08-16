import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:newsworld/model/news_model.dart';
import 'package:newsworld/view/search_page.dart';

class ArticalPage extends StatelessWidget {
  final Articles? articles;

  const ArticalPage({Key? key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("News World"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(
                      "${articles!.urlToImage}"),
                ),
                Padding(
                  padding:
                  const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${articles!.title}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 25
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${articles!.publishedAt}",
                              style: TextStyle(
                                  color:
                                  Colors.grey.shade700,fontSize: 15,),
                            ),
                          ),
                          Align(
                            alignment: Alignment
                                .bottomRight,
                            child: Text(
                              "- ${articles!.author}",
                              style: TextStyle(
                                  color:
                                  Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${articles!.description}",
                        style: TextStyle(
                            color:
                            Colors.grey.shade700,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${articles!.content}",
                        style: TextStyle(
                            color:
                            Colors.grey.shade700,
                          fontSize: 20,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
