import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/helpers/alert_helper.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/helpers/validators.dart';
import 'package:myntra_test_app/src/core/view_model//auth_provider.dart';
import 'package:myntra_test_app/src/ui/view/account_summary/account_summary_screen.dart';
import 'package:myntra_test_app/src/ui/widget/custom_app_bar.dart';
import 'package:myntra_test_app/src/ui/widget/custom_default_text_form_field.dart';
import 'package:myntra_test_app/src/ui/widget/custom_progress_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobNumEmailFocus = FocusNode();
  final _mobNumEmailController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _submitLogInRequest() async {
      setState(() {
        _isLoading = true;
      });

      Helper.dismissKeyboard(ctx: context);

      try {
        final isLogInDone = await authProvider.signIn(
          ctx: context,
          email: _mobNumEmailController.text,
          password: _passwordController.text,
        );
        if (isLogInDone) {
          print('Move to profile screen');
          final route = MaterialPageRoute(
            builder: (ctx) => AccountSummaryScreen(
              isComingAfterSignUp: true,
            ),
          );
          Navigator.push(context, route);
        } else {
          print('authProvider isLogInDone false');
        }
      } catch (error) {
        AlertHelper.showOnlyOkAlertDialog(ctx: context, msg: error.message);
      }
      setState(() {
        _isLoading = false;
        _loginFormKey.currentState.reset();
      });
    }

    void _loginBtnClicked() {
      Helper.dismissKeyboard(ctx: context);

      final isValid = _loginFormKey.currentState.validate();
      if (isValid) {
        _loginFormKey.currentState.save();
        _submitLogInRequest();
      }
    }

    Widget _buildScaffoldView() {
      return Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(
            title: 'Login',
          ),
          preferredSize: Size(
            null,
            AppConstants.preferredAppBarHeight,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Mobile Number or Email ID',
                    textController: _mobNumEmailController,
                    ownFocusNode: _mobNumEmailFocus,
                    nextFocusNode: _passwordFocus,
                    validationFunc: Validator.validateEmpty,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Password',
                    textController: _passwordController,
                    ownFocusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    isObscureText: true,
                    validationFunc: Validator.validateLoginPassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _loginBtnClicked,
//                  icon: Icon(
//                    Icons.shopping_cart,
//                    color: Colors.white,
//                  ),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: OutlineButton(
                      child: Text(
                        'QUICK LOG IN USING OTP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {},
                      borderSide: BorderSide(
                        color: AppColors.silver,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      textColor: AppColors.cabaret,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.cabaret,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
//                  color: Colors.pink,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        _buildScaffoldView(),
        CustomProgressBar(status: _isLoading),
      ],
    );
  }
}
