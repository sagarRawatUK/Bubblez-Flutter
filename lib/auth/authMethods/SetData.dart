import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication.dart';
import 'FirebaseOperations.dart';

class SetData with ChangeNotifier {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserFullNameKey = "USERFULLNAMEKEY";
  static String sharedPreferenceUserNumberKey = "USERNUMBERKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserUidKey = "USERUIDKEY";
  static String sharedPreferenceUserAvatarKey = "USERAVATARKEY";

  getAllSharedPrefs(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provider.of<Authentication>(context, listen: false).userUid =
        sharedPreferences.getString(sharedPreferenceUserUidKey);
    Provider.of<FirebaseOperations>(context, listen: false).initUserName =
        sharedPreferences.getString(sharedPreferenceUserNameKey);
    Provider.of<FirebaseOperations>(context, listen: false).initUserFullName =
        sharedPreferences.getString(sharedPreferenceUserFullNameKey);
    Provider.of<FirebaseOperations>(context, listen: false).initUserEmail =
        sharedPreferences.getString(sharedPreferenceUserEmailKey);
    Provider.of<FirebaseOperations>(context, listen: false).initUserImage =
        sharedPreferences.getString(sharedPreferenceUserAvatarKey);
    Provider.of<FirebaseOperations>(context, listen: false).initUserPhone =
        sharedPreferences.getString(sharedPreferenceUserNumberKey);
    notifyListeners();
  }
}
