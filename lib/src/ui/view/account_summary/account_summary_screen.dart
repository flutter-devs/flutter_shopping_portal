import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/helpers/alert_helper.dart';
import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/view_model/auth_provider.dart';
import 'package:myntra_test_app/src/ui/view/account_summary/account_summary_top_view.dart';
import 'package:myntra_test_app/src/ui/view/home_screen.dart';
import 'package:myntra_test_app/src/ui/widget/custom_app_bar.dart';

class AccountSummaryScreen extends StatelessWidget {
  final isComingAfterSignUp;

  AccountSummaryScreen({this.isComingAfterSignUp = false});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _logOutBtnClicked() {
      AlertHelper.showAlertDialogWithMultipleActions(
        ctx: context,
        msg: 'Are you sure to logout?',
        actions: [
          AlertActionModel(
            title: AppStrings.Yes,
            action: () {
              authProvider.logOut();

              final route = MaterialPageRoute(builder: (ctx) => HomeScreen());
              Navigator.push(context, route);
            },
          ),
          AlertActionModel(
            title: AppStrings.No,
            action: () {},
          ),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(null, AppConstants.preferredAppBarHeight),
        child: CustomAppBar(
          title: '',
//          leftButton: isComingAfterSignUp
//              ? CustomAppBarLeftButtonsTypes.Menu
//              : CustomAppBarLeftButtonsTypes.Back,
          popRoute: isComingAfterSignUp
              ? MaterialPageRoute(builder: (ctx) => HomeScreen())
              : null,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              AccountSummaryTopView(),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 90,
                color: Colors.grey[200],
                child: OutlineButton(
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  onPressed: _logOutBtnClicked,
                  borderSide: BorderSide(color: AppColors.cabaret),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  textColor: AppColors.cabaret,
                ),
              ),
            ],
          ),
        ),
      ),
//      if (isComingAfterSignUp)
//      drawer: isComingAfterSignUp ? AppDrawer() : null,
    );
  }
}
