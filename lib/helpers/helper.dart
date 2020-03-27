import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/models/product_model.dart';

class Helper {
  static void dismissKeyboard({@required BuildContext ctx}) {
    FocusScopeNode currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static DiscountTypes getDiscountTypeFor({@required int code}) {
    var discountType = DiscountTypes.None;

    switch (code) {
      case 1:
        discountType = DiscountTypes.Amount;
        break;

      case 2:
        discountType = DiscountTypes.Percentage;
        break;

      default:
        break;
    }

    return discountType;
  }

  static int getIteratedPriceToShowFor({@required ProductModel product}) {
    var iteratedPrice = product.priceMap.price;
    final discountType =
        getDiscountTypeFor(code: product.priceMap.discountType);
    switch (discountType) {
      case DiscountTypes.Amount:
        iteratedPrice = iteratedPrice - product.priceMap.discountAmount;
        break;

      case DiscountTypes.Percentage:
        iteratedPrice = (iteratedPrice -
            (iteratedPrice * product.priceMap.discountPercentage) / 100) as int;
        break;

      default:
        break;
    }

    return iteratedPrice;
  }

  static String getMenuOptionValue(MenuOptions menuOption) {
    switch (menuOption) {
      case MenuOptions.Account:
        return 'Account';
      case MenuOptions.None:
        return 'None';

      default:
        return '';
    }
  }
}
