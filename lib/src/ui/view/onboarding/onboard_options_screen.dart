import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/ui/view/onboarding/login_screen.dart';
import 'package:myntra_test_app/src/ui/view//onboarding/sign_up_screen.dart';
import 'package:myntra_test_app/src/ui/widget/custom_app_bar.dart';
import 'package:myntra_test_app/src/ui/widget/custom_button_with_image.dart';

class OnboardOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _normalLoginBtnClicked() {
      final route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.push(context, route);
    }

    void _signupClicked() {
      final route = MaterialPageRoute(builder: (context) => SignUpScreen());
      Navigator.push(context, route);
    }

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: '',
        ),
        preferredSize: Size(null, AppConstants.preferredAppBarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: CustomButtonWithImage(
                        imageNameString: AppIcons.Facebook,
                        titleString: 'Facebook',
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      child: CustomButtonWithImage(
                        imageNameString: AppIcons.Google,
                        titleString: 'Google',
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: CustomButtonWithImage(
                  imageNameString: AppIcons.MailBlack,
                  titleString: 'Log in using email',
                ),
                onTap: _normalLoginBtnClicked,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: CustomButtonWithImage(
                  imageNameString: AppIcons.PhoneBlack,
                  titleString: 'Log in using mobile number',
                ),
                onTap: _normalLoginBtnClicked,
              ),
              SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'New to Friendly Shopping? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign up ',
                      style: TextStyle(
                        color: AppColors.cabaret,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _signupClicked(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
