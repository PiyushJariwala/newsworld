import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/const/sizebox_const.dart';
import 'package:newsworld/firebase/realtime_database.dart';

import 'logIn_page.dart';

class Drower_Page extends StatefulWidget {
  const Drower_Page({Key? key}) : super(key: key);

  @override
  State<Drower_Page> createState() => _Drower_PageState();
}

class _Drower_PageState extends State<Drower_Page> {
  @override
  Widget build(BuildContext context) {
    FireDataBase fireDataBase = Get.put(FireDataBase());

    return Container(
      color: Colors.blue.shade50,
      child: Column(
        children: [
          h(20),
          Container(
            height: 100,
            width: double.infinity,
            child: StreamBuilder(
              stream: fireDataBase.getUserDetails(FirebaseAuth.instance.currentUser!.uid),
              builder: (context,AsyncSnapshot snapshot){
                if(snapshot.hasError)
                  {
                    return Center(child: Text("${snapshot.error}"));
                  }
                else if (snapshot.hasData){

                  DataSnapshot data = snapshot.data.snapshot;

                  return SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${data.child("image_url").value.toString()}"),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                    "${data.child("username").value.toString()}",
                                    style: TextStyle(color: Colors.grey, fontSize: 20),
                                  ),
                              ),
                              Expanded(
                                child: Text(
                                  "${data.child("phone").value.toString()}",
                                  style: TextStyle(color: Colors.grey, fontSize: 20),
                                ),
                              ),
                              Text(
                                "${FirebaseAuth.instance.currentUser!.email.toString()}",
                                style: TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Get.offAll(LogInPage()));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
