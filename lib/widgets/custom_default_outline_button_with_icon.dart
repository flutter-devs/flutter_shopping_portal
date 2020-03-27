import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';

class CustomDefaultOutlineButtonWithIcon extends StatelessWidget {
  final String titleString;
  final TextStyle titleTextStyle;

  final double height;

  Function buttonClicked;

  CustomDefaultOutlineButtonWithIcon({
    @required this.titleString,
    this.titleTextStyle,
    this.height = 40,
    this.buttonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(
        titleString,
        style: TextStyle(
          color: titleTextStyle.color ?? AppColors.cabaret,
          fontSize: titleTextStyle.fontSize ?? 14,
          fontWeight: titleTextStyle.fontWeight ?? FontWeight.w600,
        ),
      ),
      onPressed: buttonClicked ??
          () {
            print(
                'CustomDefaultOutlineButtonWithIcon clicked with title: $titleString');
          },
      borderSide: BorderSide(
        color: AppColors.silver,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      textColor: AppColors.cabaret,
    );
  }
}
