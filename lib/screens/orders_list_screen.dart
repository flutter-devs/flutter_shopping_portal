import 'package:flutter/material.dart';

import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/screens/home_screen.dart';
import 'package:myntra_test_app/widgets/custom_app_bar.dart';

class OrdersListScreen extends StatelessWidget {
  static const routeName = '/order-list';

  final ordersArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: 'ORDERS',
        ),
        preferredSize: Size(null, AppConstants.preferredAppBarHeight),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.grey[100],
              ),
            ),
            ordersArray.length == 0
                ? Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'NO ACTIVE ORDERS',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'There are no recent orders to show.',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Image.asset('assets/images/img_empty_box.png'),
                          height: 220,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
//                          width: double.infinity,
                          height: 90,
//                          color: Colors.grey[200],
                          child: OutlineButton(
                            child: Text('     START SHOPPING     '),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName,
                                  (Route<dynamic> route) => false);
                            },
                            borderSide: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            textColor: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => null,
                      itemCount: 0,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
