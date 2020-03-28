import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:myntra_test_app/src/core/models/product_model.dart';
import 'package:myntra_test_app/src/core/models/search_models.dart';
import 'package:myntra_test_app/src/core/view_model/products_provider.dart';
import 'package:myntra_test_app/src/ui/view//products/item_detail_screen.dart';
import 'package:myntra_test_app/src/ui/widget/custom_app_bar.dart';
import 'package:myntra_test_app/src/ui/widget/custom_progress_bar.dart';
import 'package:myntra_test_app/src/ui/widget/tiles/item_tiles/item_grid_tile.dart';

class ItemsListScreen extends StatefulWidget {
  @override
  _ItemsListScreenState createState() => _ItemsListScreenState();

  final SearchProductsModel searchProductsModel;
  final title;

  ItemsListScreen({
    @required this.searchProductsModel,
    @required this.title,
  });
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  var _isLoading = false;
  List<ProductModel> _productArray = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      _productArray =
          await Provider.of<ProductsProvider>(context, listen: false)
              .fetchProducts(ctx: context);
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void didTappedAtItem({@required int index}) {
      final prod = _productArray[index];
      final route = MaterialPageRoute(
          builder: (ctx) => ItemDetailScreen(
                product: prod,
                searchProductsModel: widget.searchProductsModel,
              ));
      Navigator.push(context, route);
    }

    _buildAppBar() => PreferredSize(
          preferredSize: Size(null, AppConstants.preferredAppBarHeight),
          child: CustomAppBar(
            title: widget.title,
          ),
        );

    _buildBottomView() {
      return Container(
        height: 50,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 0.2,
              color: Colors.grey,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.sort_by_alpha),
                    label: Text('Sort'),
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: 0.4,
                    color: Colors.grey,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.filter_list),
                    label: Text('Filter'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    _buildGridView() {
      return Expanded(
        child: Container(
//          color: AppColors.silver,
          child: _productArray.length == 0
              ? Center(
                  child: Text('No data yet'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () => didTappedAtItem(index: index),
                      child: ItemGridTile(
                        product: _productArray[index],
                      ),
                    );
                  },
                  itemCount: _productArray.length,
                ),
        ),
      );
    }

    _buildScaffoldView() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _buildGridView(),
              _buildBottomView(),
            ],
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
