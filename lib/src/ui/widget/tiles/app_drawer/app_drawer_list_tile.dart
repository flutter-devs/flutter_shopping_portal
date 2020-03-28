import 'package:flutter/material.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/models/common_models.dart';

class AppDrawerListTile extends StatelessWidget {
  final MenuOptions menuOption;
  final Color titleColor;
  final FontWeight titleWeight;
  final Widget leadItem;
  final Widget trailingItem;

  Function menuOptionViewTapped;

  AppDrawerListTile({
    @required this.menuOption,
    this.titleColor = Colors.black,
    this.titleWeight = FontWeight.w500,
    @required this.leadItem,
    this.trailingItem,
    @required this.menuOptionViewTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => menuOptionViewTapped(menuOption),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: <Widget>[
            Container(
//              color: Colors.green,
//            padding: EdgeInsets.symmetric(horizontal: 5,),
              height: 30,
              width: 20,
              alignment: Alignment.center,
              child: leadItem,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              Helper.getMenuOptionValue(menuOption),
              style: TextStyle(
                color: titleColor,
                fontWeight: titleWeight,
                fontSize: 13,
              ),
            ),
            Spacer(),
            if (trailingItem != null) trailingItem,
          ],
        ),
      ),
    );
  }
}

class AppDrawerCategoryListTile extends StatelessWidget {
  final CategoryModal category;
  final Color titleColor;
  final FontWeight titleWeight;
  final Widget leadItem;
  final Widget trailingItem;

  Function categoryViewTapped;

  AppDrawerCategoryListTile({
    @required this.category,
    this.titleColor = Colors.black,
    this.titleWeight = FontWeight.w500,
    @required this.leadItem,
    this.trailingItem,
    @required this.categoryViewTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => categoryViewTapped(category),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: <Widget>[
            Container(
//              color: Colors.green,
//            padding: EdgeInsets.symmetric(horizontal: 5,),
              height: 30,
              width: 20,
              alignment: Alignment.center,
              child: leadItem,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              category.name,
//              Helper.getMenuOptionValue(menuOption),
              style: TextStyle(
                color: titleColor,
                fontWeight: titleWeight,
                fontSize: 13,
              ),
            ),
            Spacer(),
            if (trailingItem != null) trailingItem,
          ],
        ),
      ),
    );
  }
}
