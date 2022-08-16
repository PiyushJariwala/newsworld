import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsworld/view/home_page.dart';

class SplashScreeenPage extends StatefulWidget {
  const SplashScreeenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreeenPage> createState() => _SplashScreeenPageState();
}

class _SplashScreeenPageState extends State<SplashScreeenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigtor();
  }

  void navigtor() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/icon.png",fit: BoxFit.fill,),
          ],
        ),
      ),
    );
  }
}
