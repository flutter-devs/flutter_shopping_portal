import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myntra_test_app/helpers/alert_helper.dart';

import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/helpers/prefs_constants.dart';
import 'package:myntra_test_app/models/table_schemas/user_table_schema.dart';
import 'package:myntra_test_app/helpers/url_constants.dart';
import 'package:myntra_test_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  GenderTypes _signUpSelectedGenderType = GenderTypes.Male;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;

//  DateTime _expDateTime;
  String _token;
  String _userID;
  String _userDocID;

  GenderTypes get getSignUpSelectedGenderType {
    return _signUpSelectedGenderType;
  }

  void setSignUpSelectedGenderTypeTo({@required GenderTypes gender}) {
    _signUpSelectedGenderType = gender;
    notifyListeners();
  }

  Future<bool> signUp({
    @required BuildContext ctx,
    @required String email,
    @required String password,
    String mobNum = '',
    @required String name,
  }) async {
    final status = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((authResult) async {
      FirebaseUser user = authResult.user;
//      AdditionalUserInfo additionalUserInfo = authResult.additionalUserInfo;
      print('FirebaseUser:');
      print('User ID: ${user.uid}');
      _userID = user.uid;
//      print('AdditionalUserInfo: ${additionalUserInfo}');

      try {
        final userData = {
          UserTable.userID: _userID,
          UserTable.emailID: email,
          UserTable.gender:
              _signUpSelectedGenderType == GenderTypes.Male ? '1' : '2',
          UserTable.mobNum: mobNum,
          UserTable.name: name,
        };
        await databaseReference
            .collection(Tables.users)
            .add(userData)
            .then((value) async {
          print('New user documentID: ${value.documentID}');
          _userDocID = value.documentID;

          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode(
            {
              FSPrefs.UserID: _userID,
              FSPrefs.UserDocID: _userDocID,
              FSPrefs.UserImageUrl: '',
              FSPrefs.UserName: name,
              FSPrefs.UserToken: _token ?? '',
//          UserPrefsConstants.ExpDateTime: _expDateTime.toIso8601String()
            },
          );
          prefs.setString(FSPrefs.UserData, userData);
        }).catchError((err) {
          print('New user server error: ${err.message}');
        });
      } catch (e) {
        print('New user method error: ${e.message}');
      }

      print('Return true');
      return true;
    }).catchError((error) {
      print('createUserWithEmailAndPassword error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: ctx, msg: error.message);
      return false;
    });
    return status;
  }

  Future<bool> signIn({
    @required BuildContext ctx,
    @required String email,
    @required String password,
  }) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      print('FirebaseUser:');
      print('User ID: ${user.uid}');

      final snapShot = await databaseReference
          .collection(Tables.users)
          .where(UserTable.userID, isEqualTo: user.uid)
//          .where(UserTable.emailID, isEqualTo: email)
          .getDocuments();

      if (snapShot.documents.isEmpty) {
        print('UserTable: No documents found!');
        throw HttpException(message: 'No user found!');
      }
      snapShot.documents.forEach((document) async {
        print('documentID: ${document.documentID}');

        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            FSPrefs.UserID: document[UserTable.userID],
            FSPrefs.UserDocID: document.documentID,
            FSPrefs.UserImageUrl: document[UserTable.imageUrl] ?? '',
            FSPrefs.UserName: document[UserTable.name],
            FSPrefs.UserToken: _token ?? '',
//          UserPrefsConstants.ExpDateTime: _expDateTime.toIso8601String()
          },
        );
        prefs.setString(FSPrefs.UserData, userData);

        _userID = user.uid;
        _userDocID = document.documentID;

//      print('AdditionalUserInfo.username: ${additionalUserInfo.username}');
      });

      return true;
    } catch (error) {
      print('signIn error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: ctx, msg: error.message);
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.UserData)) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString(FSPrefs.UserData)) as Map<String, Object>;
//    final expiryDateTime = DateTime.parse(extractedUserData['expiryDate']);
//    if (expiryDateTime.isBefore(DateTime.now())) {
//      return false;
//    }

    _token = extractedUserData[FSPrefs.UserToken] ?? '';
    _userID = extractedUserData[FSPrefs.UserID];
    _userDocID = extractedUserData[FSPrefs.UserDocID];
//    _expDateTime = expiryDateTime;

//    _autoLogOut();
    notifyListeners();
    return true;
  }

  bool get isAuthorized {
    return getUserID != null;
  }

//  String get getToken {
//    if (_expDateTime != null &&
//        _expDateTime.isAfter(DateTime.now()) &&
//        _token != null) {
//      return _token;
//    }
//    return null;
//  }

  String get getUserID {
    return _userID;
  }

  String get getUserDocID {
    return _userDocID;
  }

  Future<void> logOut() async {
//    _expDateTime = null;
    _userID = null;
    _token = null;
//    if (_authTimer != null) {
//      _authTimer.cancel();
//      _authTimer = null;
//    }

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.UserData)) {
      return false;
    }
    prefs.remove(FSPrefs.UserData);

//    notifyListeners();
  }
}
