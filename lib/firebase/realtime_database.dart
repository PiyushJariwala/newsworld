import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:newsworld/const/uid_const.dart';
import 'package:newsworld/view/country_list_page.dart';

class FireDataBase extends GetxController {

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;

  void setUserDetails(String username, String phone,String uid,String image_url) {
    databaseReference = firebaseDatabase.ref();
    databaseReference!.child("User").child(uid).set({'username':username,'phone':phone,'image_url':image_url}).then((value) => Get.offAll(CountryListPage()));
  }

  Stream<DatabaseEvent> getUserDetails(String uid){
    databaseReference = firebaseDatabase.ref();
    return databaseReference!.child("User").child(uid).onValue;
  }
}
