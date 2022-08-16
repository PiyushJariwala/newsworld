import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsworld/view/country_list_page.dart';
import 'package:newsworld/view/user_details_page.dart';

class FirebaseHalper {
  FirebaseAuth auth = FirebaseAuth.instance;

  void SignUp(String email, String password){
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => Get.off(User_Details()));
    }
    on FirebaseAuthException catch (e){
      throw GetSnackBar(message: "${e.message}",);
    }
    catch(e){
      print(e);
    }
  }

  void SignIn(String email, String password) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password).then((value) => Get.off(CountryListPage()));
    }
    on FirebaseAuthException catch (e){
      throw GetSnackBar(message: "${e.message}",);
    }
    catch(e){
      print(e);
    }
  }

  Future<UserCredential> googleSignUp() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth!.idToken,
      accessToken: googleAuth.accessToken,
    );

    return auth.signInWithCredential(credential);
  }

  Future<UserCredential> facebookSignIn() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential faceBookCredntail = FacebookAuthProvider.credential(
        loginResult.accessToken!.token);

    return auth.signInWithCredential(faceBookCredntail);
  }

}