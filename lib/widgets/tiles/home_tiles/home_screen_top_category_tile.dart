import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';

class HomeScreenTopCategoryListTile extends StatelessWidget {
  final String imageName;
  final String title;

  HomeScreenTopCategoryListTile(
      {@required this.imageName, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      child: Card(
        elevation: 2,
        child: Column(
          children: <Widget>[
            Expanded(
              child:
              FadeInImage(
                placeholder: AssetImage(
                  AppIcons.flutter,
                ),
                image: NetworkImage(imageName),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 25,
//              color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
