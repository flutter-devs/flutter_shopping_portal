import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/models/common_models.dart';
import 'package:myntra_test_app/src/core/view_model/category_provider.dart';
import 'package:myntra_test_app/src/ui/widget/app_drawer.dart';
import 'package:myntra_test_app/src/ui/widget/custom_app_bar.dart';
import 'package:myntra_test_app/src/ui/widget/tiles/home_tiles/home_screen_hot_deals_list_tile.dart';
import 'package:myntra_test_app/src/ui/widget/tiles/home_tiles/home_screen_top_category_tile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  List<CategoryModal> topCategoriesArray = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      if (mounted) {
        print('HomeScreen mounted: $mounted');
      }
      setState(() {
        _isLoading = true;
      });
      final catProvider = Provider.of<CategoryProvider>(context, listen: false);
      catProvider.fetchAndSetCategories().then((_) {
        setState(() {
          topCategoriesArray = catProvider.categories.values.toList();
          _isLoading = false;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    print('HomeScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildAppBar(BuildContext context) {
      return PreferredSize(
        preferredSize: Size(null, AppConstants.preferredAppBarHeight),
        child: CustomAppBar(
          leftButton: CustomAppBarLeftButtonsTypes.Menu,
          title: 'Friendly Shopping',
        ),
      );
    }

    _buildScaffoldView() {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildTopListView(),
                    Image.asset(
                      AppImages.banner1,
                      fit: BoxFit.cover,
//                    height: 300,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) => HomeScreenHotDealsListTile(
                          heading: 'THE DESI WAY',
                          title: 'Shop Ethnic Wear At Min. 50% Off!',
                          imageName: AppImages.women,
                          msg: '+ DON\'T MISS THIS',
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: topCategoriesArray.length,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      AppImages.banner2,
                      fit: BoxFit.cover,
//                    height: 300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), // T
        drawer:
            AppDrawer(), // his trailing comma makes auto-formatting nicer for build methods.
      );
    }

    return _buildScaffoldView();
  }

  _buildTopListView() {
    return Container(
      height: 110,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => HomeScreenTopCategoryListTile(
                title: topCategoriesArray[index].name,
                imageName: topCategoriesArray[index].homePageImageUrl,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: topCategoriesArray.length,
            ),
    );
  }
}
