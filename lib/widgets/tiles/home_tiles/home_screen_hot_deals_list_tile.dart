import 'package:flutter/material.dart';

class HomeScreenHotDealsListTile extends StatelessWidget {
  final String imageName;
  final String heading;
  final String msg;
  final String title;

  HomeScreenHotDealsListTile(
      {@required this.imageName,
      @required this.heading,
      @required this.msg,
      @required this.title});

  final double totalWidth = 350;
  final double gapWidth = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: totalWidth,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      child: Card(
        elevation: 2,
        child: Row(
          children: <Widget>[
            Container(
//              color: Colors.red,
              width: (totalWidth - gapWidth) / 2,
              child: Image.asset(
                imageName,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            SizedBox(
              width: gapWidth,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
//                color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 1,
                          child: Container(
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          heading,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          msg,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          child: Container(
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
