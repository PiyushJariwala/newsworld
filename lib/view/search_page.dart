
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/view/search_result_page.dart';

class SearchApiPage extends StatelessWidget {
  const SearchApiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    String save_search = "";
    final fGkey = GlobalKey<FormState>();

    return SafeArea(
      child: Form(
        key: fGkey,
        child: Scaffold(
          body: Container(
            color: Colors.blueGrey.shade100,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
              ),
              child: TextFormField(
                controller: search,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter something for search";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: "Search",
                ),
                // onSaved: (search) {
                //   if(fGkey.currentState!.validate()){
                //     save_search = search!;
                //     Get.to(SearchResultPage(searchResult: save_search.removeAllWhitespace,));
                //     FocusScope.of(context).focusedChild;
                //   }
                //   fGkey.currentState!.reset();
                // },
                keyboardType: TextInputType.url,
                onFieldSubmitted: (search){
                  if(fGkey.currentState!.validate()){
                    FocusScope.of(context).focusedChild;
                    save_search = search;
                    Get.off(SearchResultPage(searchResult: save_search,));
                  }
                  fGkey.currentState!.reset();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
