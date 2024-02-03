import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  static String userIdKey="USERKEY";
  static String userNameKey="USERNAMEKEY";
  static String userMailKey="USERMAILKEY";
  static String userPicKey="USERPICKEY";
  static String displayNameKey="DISPLAYNAMEKEY";

  Future <bool> saveUserId(String getUserId) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserId);
  }

  Future <bool> saveUserName(String getUserName) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }

  Future <bool> saveUserMail(String getUserMail) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userMailKey, getUserMail);
  }

  Future <bool> saveUserPic(String getUserPic) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userPicKey, getUserPic);
  }

  Future <bool> saveUserDisplayName(String getUserDisplayName) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(displayNameKey, getUserDisplayName);
  }

  Future <String?> getUserId()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future <String?> getUserName()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future <String?> getUserMail()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userMailKey);
  }

  Future <String?> getUserPic()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userPicKey);
  }

   Future <String?> getUserDisplayName()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(displayNameKey);
  }

}