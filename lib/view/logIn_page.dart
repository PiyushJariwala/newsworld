import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/const/sizebox_const.dart';
import 'package:newsworld/firebase/firebase_auth.dart';
import 'package:newsworld/view/country_list_page.dart';
import 'package:newsworld/view/home_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
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
                  h(20),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        h(20),
                        Text(
                          "Login To News World",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        h(40),
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
                        h(10),
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
                        h(30),
                        OutlinedButton(
                          onPressed: () {
                            FirebaseHalper().SignIn(email.text, password.text);
                          },
                          child: Text("Login"),
                        ),
                        h(20),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signUp');
                            },
                            child: Text("Creat a new account"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  h(20),
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
                    onTap: () async{
                      await FirebaseHalper().googleSignUp().then((value) => Get.off(CountryListPage()));
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
                            "Google Login",
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
                            "Facebook Login",
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
