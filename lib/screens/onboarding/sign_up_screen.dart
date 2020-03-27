import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/helpers/validators.dart';
import 'package:myntra_test_app/providers/auth_provider.dart';
import 'package:myntra_test_app/screens/account_summary/account_summary_screen.dart';
import 'package:myntra_test_app/widgets/custom_progress_bar.dart';
import 'package:myntra_test_app/widgets/custom_app_bar.dart';
import 'package:myntra_test_app/widgets/custom_default_outline_button_with_icon.dart';
import 'package:myntra_test_app/widgets/custom_default_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailFocus = FocusNode();
  final _emailController = TextEditingController();
  final _mobNumFocus = FocusNode();
  final _mobNumController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _nameController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _buildReferalView() {
    return Container(
      height: 30,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.check_box_outline_blank,
            ),
//            child: address.isDefault == true
//                ? Icon(
//              Icons.check_box_outline_blank,
//            )
//                : Icon(
//              Icons.check_box,
//              color: AppColors.cabaret,
//            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'I have a referal registration code',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _femaleBtnClicked() {
      authProvider.setSignUpSelectedGenderTypeTo(gender: GenderTypes.Female);
    }

    void _maleBtnClicked() {
      authProvider.setSignUpSelectedGenderTypeTo(gender: GenderTypes.Male);
    }

    void _submitSignUpRequest() async {
      setState(() {
        _isLoading = true;
      });

//      try {
      await authProvider
          .signUp(
        ctx: context,
        email: _emailController.text,
        password: _passwordController.text,
        mobNum: _mobNumController.text,
        name: _nameController.text,
      )
          .then((isSignUpDone) {
        if (isSignUpDone) {
          print('Move to profile screen');
          final route = MaterialPageRoute(
              builder: (ctx) => AccountSummaryScreen(
//                    isComingAfterSignUp: true,
                  ));
          Navigator.pushAndRemoveUntil(
              context, route, (Route<dynamic> route) => false);
        } else {
          print('authProvider isSignUpDone false');
        }
      }).catchError((err) {
        print('authProvider catchError: $err');
      });
//        print('Signed up user: $userID');
      setState(() {
        _isLoading = false;
        _signUpFormKey.currentState.reset();
      });
    }

    void _createAccountBtnClicked() {
      final isValid = _signUpFormKey.currentState.validate();
      if (isValid) {
        _signUpFormKey.currentState.save();
        _submitSignUpRequest();
      }
    }

    Widget _buildGenderView() {
      return Container(
        height: 40,
        child: Selector<AuthProvider, GenderTypes>(
          selector: (context, authProvider) =>
              authProvider.getSignUpSelectedGenderType,
          builder: (ctx, signUpSelectedGenderType, _) {
            final gender = signUpSelectedGenderType;
            final normalTextStyle = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            );
            final selectedTextStyle = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
            );
            return Row(
              children: <Widget>[
                Expanded(
                  child: CustomDefaultOutlineButtonWithIcon(
                    titleString: 'Female',
                    titleTextStyle: gender == GenderTypes.Female
                        ? selectedTextStyle
                        : normalTextStyle,
                    buttonClicked: _femaleBtnClicked,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomDefaultOutlineButtonWithIcon(
                    titleString: 'Male',
                    titleTextStyle: gender == GenderTypes.Male
                        ? selectedTextStyle
                        : normalTextStyle,
                    buttonClicked: _maleBtnClicked,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    Widget _buildScaffoldView() {
      return Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(
            title: 'Sign up',
          ),
          preferredSize: Size(null, AppConstants.preferredAppBarHeight),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: <Widget>[
                  CustomDefaultTextFormField(
                    placeHolderString: 'Email address*',
                    textController: _emailController,
                    ownFocusNode: _emailFocus,
                    textInputType: TextInputType.emailAddress,
                    nextFocusNode: _passwordFocus,
                    validationFunc: Validator.validateEmail,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Password*',
                    textController: _passwordController,
                    ownFocusNode: _passwordFocus,
                    nextFocusNode: _mobNumFocus,
                    isObscureText: true,
                    validationFunc: Validator.validateLoginPassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Mobile Number(for order updates)',
                    textController: _mobNumController,
                    ownFocusNode: _mobNumFocus,
                    nextFocusNode: _nameFocus,
                    textInputType: TextInputType.number,
                    validationFunc: Validator.validateOptionalMobile,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Full Name*',
                    textController: _nameController,
                    ownFocusNode: _nameFocus,
                    validationFunc: Validator.validateEmpty,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildGenderView(),
//                SizedBox(
//                  height: 20,
//                ),
//                _buildReferalView(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _createAccountBtnClicked,
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: Colors.pink,
                    ),
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
