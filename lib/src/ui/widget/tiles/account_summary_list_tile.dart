import 'package:flutter/material.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';

class AccountSummaryListTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final String summary;
  final MenuOptions menuOption;
  final bool isShowDivider;
  final Function goToScreen;

  AccountSummaryListTile(
      {@required this.icon,
      @required this.title,
      @required this.summary,
      this.menuOption,
      @required this.goToScreen,
      this.isShowDivider = true});

  final double tileHeight = 80;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: menuOption != null ? () => goToScreen(menuOption) : () {},
      child: Column(
        children: <Widget>[
          Container(
            height: tileHeight,
            child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: tileHeight - 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 25,
                  ),
                  child: icon,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        summary,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: tileHeight,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (isShowDivider)
            Container(
              height: 0.1,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }
}
