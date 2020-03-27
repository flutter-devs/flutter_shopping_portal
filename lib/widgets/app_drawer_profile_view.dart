import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/prefs_constants.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/providers/auth_provider.dart';

class AppDrawerProfileView extends StatefulWidget {
  @override
  _AppDrawerProfileViewState createState() => _AppDrawerProfileViewState();
}

class _AppDrawerProfileViewState extends State<AppDrawerProfileView> {
  String _name = 'Login - Sign up';

  _loadUserPrefs() async {
    final userPrefsMap = await FSPrefs.getUserPrefsMap();
    setState(() {
      _name = userPrefsMap[FSPrefs.UserName];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthorized) {
      _loadUserPrefs();
    }
//    final titleString =
//        authProvider.isAuthorized ? 'Welcome' : 'Login - Sign up';

    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
        ),
      ),
//      color: Colors.black45,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      height: 70,
                      padding: authProvider.isAuthorized
                          ? EdgeInsets.all(15)
                          : EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(AppIcons.UserBlack),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
