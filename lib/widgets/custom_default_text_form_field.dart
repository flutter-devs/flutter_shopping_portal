import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';

class CustomDefaultTextFormField extends StatelessWidget {
  final String placeHolderString;
  final TextEditingController textController;
  final FocusNode ownFocusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxTextCount;
  final bool isObscureText;
  Function validationFunc;

  CustomDefaultTextFormField({
    this.placeHolderString = '',
    this.textController,
    this.ownFocusNode,
    this.nextFocusNode,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxTextCount,
    this.isObscureText = false,
    this.validationFunc,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800], width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800], width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800], width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        labelText: placeHolderString,
        labelStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: TextStyle(
        fontSize: 13,
      ),
      obscureText: isObscureText,
      cursorColor: AppColors.silver,
      cursorWidth: 0.5,
      textInputAction: textInputAction,
      controller: textController,
      focusNode: ownFocusNode,
      keyboardType: textInputType,
      maxLength: maxTextCount,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      validator: validationFunc,
    );
  }
}
