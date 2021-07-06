import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String userUid;
  User user;
  String get getUserUid => userUid;
  User get getUserInfo => user;

  Future logIntoAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    userUid = user.uid;
    print(userUid);
    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
      userUid = user.uid;
      print('Created account Uid => $userUid');
      print(firebaseAuth.currentUser.email);
    } catch (e) {
      print("####################################################" +
          e.toString());
    }
    notifyListeners();
  }

  Future logOutViaEmail() {
    return firebaseAuth.signOut();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);
    user = userCredential.user;
    assert(user.uid != null);

    userUid = user.uid;
    print('Google User Uid => $userUid');
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return googleSignIn.signOut();
  }
}
