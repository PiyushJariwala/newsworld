import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsworld/cntroller/news_controller.dart';
import 'package:newsworld/cntroller/ui_controller.dart';
import 'package:newsworld/const/country_list_const.dart';
import 'package:newsworld/firebase/realtime_database.dart';
import 'package:newsworld/shared-prefrecnce/country_shared.dart';
import 'package:newsworld/view/home_page.dart';

class CountryListPage extends StatelessWidget {
  const CountryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIcontroller uIcontroller = Get.put(UIcontroller());
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue.shade200,
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select Your Country",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: GridView.builder(
                    itemCount: country.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2.8,
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          uIcontroller.select.value = index;
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: (uIcontroller.select.value == index)
                                  ? Colors.blueAccent.shade700
                                  : Colors.blueAccent.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "${country[index].name}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              GestureDetector(
                onTap: (){
                  SharedPafreController().setSharedData(country[uIcontroller.select.value].code.toString(),FirebaseAuth.instance.currentUser!.uid);
                  Get.offAll(HomePage());
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(bottom: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
