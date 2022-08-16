import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsworld/const/sizebox_const.dart';
import 'package:get/get.dart';
import 'package:newsworld/firebase/firebase_storage.dart';
import 'package:newsworld/firebase/realtime_database.dart';
import 'package:permission_handler/permission_handler.dart';

class User_Details extends StatelessWidget {
  const User_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<File> profile_image= File("").obs;
    RxBool click = false.obs;

    TextEditingController user_name = TextEditingController();
    TextEditingController mobile = TextEditingController(text: "+91");

    FireStorage fireStorage = Get.put(FireStorage());

    final textFormcheck = GlobalKey<FormState>();


    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child: Form(
          key: textFormcheck,
          child: SingleChildScrollView(
            child: Column(
              children: [
                h(60),
                Text(
                  "News World",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                h(30),
                Container(
                  height: 425,
                  width: 425,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Photo Select",
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () async {
                                      ImagePicker image = ImagePicker();
                                      XFile? setimage = await image.pickImage(
                                          source: ImageSource.camera);
                                      profile_image.value = File(setimage!.path);
                                      (profile_image.value == File("")) ?click.value = false:click.value= true;
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.camera),
                                    label: Text("Camera")),
                                w(20),
                                TextButton.icon(
                                    onPressed: () async{
                                      if(await Permission.storage.isGranted){
                                        ImagePicker image = ImagePicker();
                                        XFile? setimage = await image.pickImage(
                                            source: ImageSource.gallery);
                                        profile_image.value = File(setimage!.path);
                                        (profile_image.value == File("")) ?click.value = false:click.value= true;
                                        Navigator.pop(context);
                                      }
                                      else{
                                        await Permission.storage.request();
                                      }
                                    },
                                    icon: Icon(Icons.image),
                                    label: Text("Gallery")),
                              ],
                            ),
                          );
                        },
                        child: Obx(
                              ()=> Container(
                            height: 125,
                            width: 125,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 2),
                              image: (click.value) ?DecorationImage(
                                image: FileImage(profile_image.value),
                                fit: BoxFit.fill,
                              ) : DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0B1hvrP4tbDITpi9JOprE--ze6QIInKCNAu_P_pG56-rVZ3wC2Shg8Y_ojxxE3aTVbCE&usqp=CAU"),fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),

                      h(20),
                      TextFormField(
                        controller: user_name,
                        validator: (value){
                          if(value!.isEmpty ||value == null || value.length<4)
                            {
                              return "please enter valid user name";
                            }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "User name",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),

                      h(20),

                      TextFormField(
                        controller: mobile,
                        validator: (value){
                          if(value!.isEmpty ||value == null || value.length<10)
                          {
                            return "please enter valid phone number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(onPressed: ()async{
                          if(textFormcheck.currentState!.validate())
                            {
                              String image_url = await fireStorage.upload(profile_image.value,context);
                              FireDataBase().setUserDetails(user_name.text, mobile.text, FirebaseAuth.instance.currentUser!.uid,image_url);
                            }
                        }, child: Text("Submit")),
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

