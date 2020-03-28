import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/models/common_models.dart';
import 'package:myntra_test_app/src/core/models/search_models.dart';
import 'package:myntra_test_app/src/core/view_model/auth_provider.dart';
import 'package:myntra_test_app/src/core/view_model/category_provider.dart';
import 'package:myntra_test_app/src/ui/view/account_summary/account_summary_screen.dart';
import 'package:myntra_test_app/src/ui/view/onboarding/onboard_options_screen.dart';
import 'package:myntra_test_app/src/ui/view/products/items_list_screen.dart';
import 'package:myntra_test_app/src/ui/widget/app_drawer_profile_view.dart';
import 'package:myntra_test_app/src/ui/widget/tiles/app_drawer/app_drawer_list_tile.dart';
import 'package:myntra_test_app/src/ui/widget/tiles/app_drawer/app_drawer_sub_list_tile.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<CategoryModal> _topCategoriesArray = [];

  @override
  void initState() {
    print('App Drawer initState');
    Future.delayed(Duration.zero).then((_) {
      final catProvider = Provider.of<CategoryProvider>(context, listen: false);
      setState(() {
        _topCategoriesArray = catProvider.categories.values.toList();
      });
    });

    super.initState();
  }

  CategoryModal _selCategory = null;
  SubCategoryModal _selSubCategory = null;

  void _profileViewTapped() {
//    print('_profileViewTapped');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Navigator.pop(context);
    if (authProvider.isAuthorized) {
      final route = MaterialPageRoute(
        builder: (context) => AccountSummaryScreen(),
      );
      Navigator.push(context, route);
    } else {
      final route = MaterialPageRoute(
        builder: (context) => OnboardOptionsScreen(),
      );
      Navigator.push(context, route);
    }
  }

  void _categoryViewTapped(CategoryModal category) {
    if (category.subCategoriesIDs.length == 0) {
      return;
    }
    setState(() {
      _selCategory = category;
    });
  }

  void _subCategoryViewTapped(SubCategoryModal subCategory) {
    if (subCategory.subSubCategoriesIDs.length == 0) {
      return;
    }
    setState(() {
      if (_selSubCategory != null) {
        _selSubCategory = subCategory == _selSubCategory ? null : subCategory;
      } else {
        _selSubCategory = subCategory;
      }
    });
  }

  void _subSubCategoryViewTapped(SubSubCategoryModal subSubCategory) {
//    print(
//        'subSubCategoryViewTapped for ID: ${subSubCategory.id} and name: ${subSubCategory.name}');
    Navigator.pop(context);
    final searchProdModel = SearchProductsModel(
      category: _selCategory,
      subCategory: _selCategory,
      subSubCategory: subSubCategory,
    );
    final route = MaterialPageRoute(
      builder: (ctx) => ItemsListScreen(
        searchProductsModel: searchProdModel,
        title: subSubCategory.name,
      ),
    );
    Navigator.push(context, route);
  }

  void _menuOptionViewTapped(MenuOptions menuOption) {
    switch (menuOption) {
      case MenuOptions.Account:
        Navigator.pop(context);
        final route =
            MaterialPageRoute(builder: (ctx) => AccountSummaryScreen());
        Navigator.push(context, route);
//        Navigator.of(context).pushNamed(AccountSummaryScreen.routeName);
        break;

      default:
        print(
            'No action assigned yet for this MenuOptions: ${Helper.getMenuOptionValue(menuOption)}');
        break;
    }
  }

  Widget build(BuildContext context) {
    Widget getSubMenuList() {
      final _subCategoriesArray = _selCategory.subCategories;
      return ListView.builder(
        itemBuilder: (ctx, index) => AppDrawerSubListTile(
          subCategory: _subCategoriesArray[index],
          index: index,
          isSelected: _selSubCategory != null
              ? _selSubCategory == _subCategoriesArray[index] ? true : false
              : false,
          subCategoryViewTapped: _subCategoryViewTapped,
          subSubCategoryViewTapped: _subSubCategoryViewTapped,
        ),
        itemCount: _subCategoriesArray.length,
      );
    }

    Widget getSubMenuDrawer() {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 50,
//            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            _selCategory = null;
                            _selSubCategory = null;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _selCategory.name,
//                        Helper.getMenuOptionValue(_selMenuOption),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Expanded(
            child: getSubMenuList(),
//            child: _selCategory.subCategories.length == 0 ? FutureBuilder(
//              future: _getSubCategories(ctx: context),
//              builder: (ctx, snapShot) {
//                if (snapShot.connectionState == ConnectionState.waiting) {
//                  print('Showing CircularProgressIndicator');
//                  return Center(
//                    child: CircularProgressIndicator(),
//                  );
//                } else {
//                  print('Showing SubMenuList');
//                  return getSubMenuList();
//                }
//              },
//            ) : getSubMenuList(),
          ),
        ],
      );
    }

    Widget getMainDrawer() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: AppDrawerProfileView(),
              onTap: _profileViewTapped,
            ),
            Column(
              children: _topCategoriesArray.map((category) {
//                print(category.name);
                return AppDrawerCategoryListTile(
                  category: category,
                  leadItem: FadeInImage(
                    placeholder: AssetImage(
                      AppIcons.flutter,
                    ),
                    image: NetworkImage(category.menuIconImageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
//                  leadItem: Image.asset(
//                    AppIcons.women_dress,
//                    color: Colors.grey[700],
//                  ),
                  trailingItem: category.subCategoriesIDs.length == 0
                      ? null
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                        ),
                  categoryViewTapped: _categoryViewTapped,
                );
              }).toList(),
            ),
//              Divider(),
//              AppDrawerListTile(
//                title: 'Insider',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//                trailingItem: Icon(Icons.chevron_right),
//              ),
//              AppDrawerListTile(
//                title: 'Fashion Superstar',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//                trailingItem: Icon(Icons.chevron_right),
//              ),
//              AppDrawerListTile(
//                title: 'Scan for Coupon',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//              ),
//              AppDrawerListTile(
//                title: 'Theme Stores',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//                trailingItem: Icon(Icons.chevron_right),
//              ),
//              AppDrawerListTile(
//                title: 'Gift Cards',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//              ),
//              AppDrawerListTile(
//                title: 'Refer & Earn',
//                titleColor: Colors.grey,
//                leadItem: Icon(Icons.shop),
//              ),
            Container(
              height: 0.1,
              color: Colors.grey,
            ),
            AppDrawerListTile(
              menuOption: MenuOptions.Account,
              titleWeight: FontWeight.w300,
              leadItem: Image.asset(
                AppIcons.account_black,
                color: Colors.grey[700],
              ),
              menuOptionViewTapped: _menuOptionViewTapped,
            ),
            Container(
              height: 0.1,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    return Drawer(
      child: SafeArea(
        child: _selCategory == null ? getMainDrawer() : getSubMenuDrawer(),
      ),
    );
  }
}
