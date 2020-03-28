import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';

class AlertActionModel {
  final String title;
  Function action;
  bool isDestructiveAction;

  AlertActionModel({
    @required this.title,
    @required this.action,
    this.isDestructiveAction = false,
  });
}

class AlertHelper {
  static void showOnlyOkAlertDialog({
    @required BuildContext ctx,
    @required String msg,
  }) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              content: Text(msg),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            )
          : AlertDialog(
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    AppStrings.Ok,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
    );
  }

  static void showAlertDialogWithMultipleActions({
    @required BuildContext ctx,
    @required String msg,
    @required List<AlertActionModel> actions,
    bool doAddCancelAction = false,
  }) {
    if (doAddCancelAction) {
      actions.add(
        AlertActionModel(
          title: AppStrings.Cancel,
          action: () {},
          isDestructiveAction: true,
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              content: Text(msg),
              actions: actions
                  .map((action) => CupertinoDialogAction(
                        isDestructiveAction: action.isDestructiveAction,
                        child: Text(action.title),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          action.action();
                        },
                      ))
                  .toList(),
            )
          : SimpleDialog(
              title: Text(
                msg,
                textAlign: TextAlign.center,
              ),
              children: actions
                  .map((action) => FlatButton(
                        child: Text(
                          action.title,
                          style: TextStyle(
                            color: action.isDestructiveAction
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          action.action();
                        },
                      ))
                  .toList(),
            ),
    );
  }
}
