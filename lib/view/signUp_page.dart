import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsworld/firebase/firebase_auth.dart';
import 'package:newsworld/view/home_page.dart';

import '../const/sizebox_const.dart';
import 'country_list_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    final finalKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: finalKey,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        h(30),
                        Text(
                          "Sign Up To News World",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        h(20),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains("@") ||
                                value == null) {
                              return "Places enter valid email address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        h(20),
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.length <= 7 ||
                                value == null) {
                              return "Places enter valid email address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        h(20),
                        OutlinedButton(
                            onPressed: () {
                              if(finalKey.currentState!.validate()){
                                FirebaseHalper().SignUp(email.text, password.text);
                              }
                            }, child: Text("Sign Up"),),
                        h(10),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text("Alradey have an account"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "Or",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseHalper().googleSignUp().then((value) => Get.off(CountryListPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign up using Google",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseHalper().facebookSignIn().then((value) => Get.off(CountryListPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                      ),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign up using Facebook",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
