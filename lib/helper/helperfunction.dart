import 'package:shared_preferences/shared_preferences.dart';

class HelperFuntion{
  static String sharedPreferenceloggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // saving data to sharedpreference

  static Future<void> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(sharedPreferenceloggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPreference(String username) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUserNameKey, username);
  }

   static Future<void> saveUserEmailInSharedPreference(String useremail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUserEmailKey, useremail);
  }

  //getting data from SharedPreference

   static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(sharedPreferenceloggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(sharedPreferenceUserEmailKey);
  }
 
}