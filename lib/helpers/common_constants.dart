import 'dart:core';

import 'package:myntra_test_app/extensions/color_extension.dart';

enum CustomAppBarLeftButtonsTypes {
  Back,
  Cross,
  Menu,
}

enum DiscountTypes {
  Amount,
  None,
  Percentage
}

enum GenderTypes {
  Female,
  Male,
  None,
}

enum MenuOptions {
  Account,
  None,
}

class AppColors {
  static final cabaret = HexColor('#DA4C6E');
  static final ocean_green = HexColor('#46A786');
  static final silver = HexColor('#BDBDBD');
}

class AppConstants {
  static const preferredAppBarHeight = 50.0;
}

class AppIcons {
  static const account_black = 'assets/icons/icon_account_black.png';
  static const bell_black = 'assets/icons/icon_bell_black.png';
  static const bookmark_black = 'assets/icons/icon_bookmark_black.png';
  static const box_black = 'assets/icons/icon_box_black.png';
  static const cosmetics_black = 'assets/icons/icon_cosmetics_black.png';
  static const cross_black = 'assets/icons/icon_cross_black.png';
  static const down_arrow = 'assets/icons/icon_down_arrow.png';
  static const flutter = 'assets/icons/icon_flutter.png';
  static const home_black = 'assets/icons/icon_home_black.png';
  static const kid_cloth_black = 'assets/icons/icon_kid_cloth_black.png';
  static const left_arrow_black = 'assets/icons/icon_left_arrow_black.png';
  static const men_dress = 'assets/icons/icon_men_dress.png';
  static const menu_black = 'assets/icons/icon_menu_black.png';
  static const portfolio_black = 'assets/icons/icon_portfolio_black.png';
  static const right_direct_black = 'assets/icons/icon_right_direct_black.png';
  static const shopping_bag_black = 'assets/icons/icon_shopping_bag.png';
  static const winter_cloth_black = 'assets/icons/icon_winter_cloth_black.png';
  static const women_dress = 'assets/icons/icon_women_dress.png';
  static const UserBlack = 'assets/icons/user_black.png';

  static const Facebook = 'assets/icons/social/facebook.png';
  static const Google = 'assets/icons/social/google.png';
  static const MailBlack = 'assets/icons/social/mail_black.png';
  static const PhoneBlack = 'assets/icons/social/phone_black.png';
}

class AppImages {
  static const banner1 = 'assets/images/img_banner1.jpg';
  static const banner2 = 'assets/images/img_banner2.jpg';
  static const emptyBox = 'assets/images/img_empty_box.png';
  static const free_delivery = 'assets/images/img_free_delivery.png';
  static const kids = 'assets/images/img_kid.jpg';
  static const lowest_price = 'assets/images/img_lowest_price.jpg';
  static const men = 'assets/images/img_men.png';
  static const user = 'assets/images/img_user.jpg';
  static const women = 'assets/images/img_women.png';
}

class AppStrings {
  static const Cancel = 'Cancel';
  static const No = 'No';
  static const Ok = 'Ok';
  static const RupeeSign = '₹';
  static const Yes = 'Yes';
}
