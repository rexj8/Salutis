import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String condition = "lock";
  static String police = "police";
  static String uid = "uid";
  //custom
  //static String sharedPreferenceUserImageKey = "USERIMAGEKEY";

  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  //custom
  static Future<bool> saveUserImageSharedPreference(String userImage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uid, userImage);
  }
  //custom

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  /// fetching data from sharedpreference
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

  //location
  static Future<String> policeDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(police);
  }

  static Future<bool> policeSavedetails(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(police, value);
  }

  static Future<String> lockDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(condition);
  }

  static Future<bool> lockSaveDetails(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(condition, value);
  }

  //custom
  static Future<String> getUserImageSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(uid);
  }
  //custom
}
