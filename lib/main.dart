import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:newsworld/view/country_list_page.dart';
import 'package:newsworld/view/home_page.dart';
import 'package:newsworld/view/logIn_page.dart';
import 'package:newsworld/view/signUp_page.dart';
import 'package:newsworld/view/splash_screen_page.dart';
import 'package:newsworld/view/user_details_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/':(context)=>StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          return LogInPage();
        }, ),
        '/splash':(context)=> SplashScreeenPage(),
        '/countrylist':(context)=>CountryListPage(),
        '/login':(context)=>LogInPage(),
        '/signUp':(context)=>SignUpPage(),
        '/user':(context)=>User_Details(),
      },
      themeMode: ThemeMode.system,
    ),
  );
}
