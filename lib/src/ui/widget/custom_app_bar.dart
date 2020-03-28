import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/helpers/common_constants.dart';

class CustomAppBar extends StatelessWidget {
  final CustomAppBarLeftButtonsTypes leftButton;
  final MaterialPageRoute popRoute;
  final String title;
  final bool isShowDivider;
  final List<Widget> rightWidgets;

  CustomAppBar({
    this.leftButton = CustomAppBarLeftButtonsTypes.Back,
    this.popRoute,
    @required this.title,
    this.rightWidgets,
    this.isShowDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
//        color: Colors.white,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
//              color: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: <Widget>[
                    buildLeftIconButton(context),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    if (rightWidgets != null) ...rightWidgets
                  ],
                ),
              ),
            ),
            Container(
              height: 0.3,
              color: AppColors.silver,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeftIconButton(BuildContext context) {
    switch (leftButton) {
      case CustomAppBarLeftButtonsTypes.Back:
        return Container(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            icon: Image(
              image: AssetImage(
                AppIcons.left_arrow_black,
              ),
              fit: BoxFit.cover,
            ),
            onPressed: () {
              if (popRoute != null) {
                Navigator.popUntil(context, (popRoute) => true);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        );
        break;

//      case CustomAppBarLeftButtons.Cross:

      case CustomAppBarLeftButtonsTypes.Menu:
        return Container(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            icon: Image(
              image: AssetImage(
                AppIcons.menu_black,
              ),
              fit: BoxFit.cover,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        );

      default:
        return Container();
    }
  }
}
