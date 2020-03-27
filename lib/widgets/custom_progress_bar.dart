import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:progress_hud/progress_hud.dart';

class CustomProgressBar extends StatelessWidget {
  final bool status;

  CustomProgressBar({@required this.status});

  @override
  Widget build(BuildContext context) {
    if (status) {
      return ProgressHUD(
        backgroundColor: Colors.black45,
        color: AppColors.silver,
        containerColor: Colors.black,
        borderRadius: 10.0,
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
//  Widget buildAndShowHideCircularProgressWith({@required bool status}) {
//    if (status) {
//      return CustomProgressBar();
//    }
//    return Container(
//      height: 0.0,
//      width: 0.0,
//    );
//  }

}
