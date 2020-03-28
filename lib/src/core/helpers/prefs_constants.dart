import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FSPrefs {
  static const UserData = 'userData';
  static const ExpDateTime = 'userExpDateTime';
  static const UserID = 'userID';
  static const UserDocID = 'UserDocID';
  static const UserImageUrl = 'userImageUrl';
  static const UserName = 'userName';
  static const UserToken = 'userToken';

  static Future<Map<String, Object>> getUserPrefsMap() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.UserData)) {
      return Map<String, Object>();
    }
    final extractedUserData =
        json.decode(prefs.getString(FSPrefs.UserData)) as Map<String, Object>;
    return extractedUserData;
  }
}
