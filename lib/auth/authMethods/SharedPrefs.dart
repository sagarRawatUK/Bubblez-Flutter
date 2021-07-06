import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserFullNameKey = "USERFULLNAMEKEY";
  static String sharedPreferenceUserNumberKey = "USERNUMBERKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserUidKey = "USERUIDKEY";
  static String sharedPreferenceUserAvatarKey = "USERAVATARKEY";

  /// Setting SharedPreference data

  static Future<void> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPreference(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserNameKey, userName);
  }

  static Future<void> saveUserFullNameSharedPreference(
      String userFullName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserFullNameKey, userFullName);
  }

  static Future<void> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<void> saveUserUidSharedPreference(String userUid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserUidKey, userUid);
  }

  static Future<void> saveUserImgSharedPreference(String userImg) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserAvatarKey, userImg);
  }

  static Future<void> saveUserNumberSharedPreference(String userNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserNumberKey, userNumber);
  }

  /// GEtting SharedPreference data

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getFullUserNameSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserFullNameKey);
  }

  static Future<String> getUserAvatarSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserAvatarKey);
  }

  static Future<String> getUserNumberSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserNumberKey);
  }

  static Future<String> getUserUidSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUserUidKey);
  }

  static Future<void> setAllSharedPrefs(
      bool isUserLoggedIn,
      String userName,
      String userFullName,
      String userEmail,
      String userUid,
      String userImg,
      String userNumber) async {
    await saveUserLoggedInSharedPreference(isUserLoggedIn);
    await saveUserNameSharedPreference(userName);
    await saveUserEmailSharedPreference(userEmail);
    await saveUserFullNameSharedPreference(userFullName);
    await saveUserImgSharedPreference(userImg);
    await saveUserNumberSharedPreference(userNumber);
    await saveUserUidSharedPreference(userUid);
  }
}
