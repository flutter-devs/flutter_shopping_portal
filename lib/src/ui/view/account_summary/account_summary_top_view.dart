import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/helpers/prefs_constants.dart';

class AccountSummaryTopView extends StatefulWidget {
  @override
  _AccountSummaryTopViewState createState() => _AccountSummaryTopViewState();
}

class _AccountSummaryTopViewState extends State<AccountSummaryTopView> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadUserPrefs();
  }

  _loadUserPrefs() async {
    final userPrefsMap = await FSPrefs.getUserPrefsMap();
    setState(() {
      _name = userPrefsMap[FSPrefs.UserName] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 260,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            height: 100,
          ),
        ),
        Positioned(
          left: 15,
          bottom: 30,
          child: Container(
            height: 150,
//              padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: Image.asset(AppImages.user),
          ),
        ),
        Positioned(
          left: 180,
          bottom: 70,
          child: Text(
            _name,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
