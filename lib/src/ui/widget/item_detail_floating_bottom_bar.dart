import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/helpers/common_constants.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/models/product_model.dart';
import 'package:myntra_test_app/src/core/view_model/product_provider.dart';

class ItemDetailFloatingBottomBar extends StatefulWidget {
  @override
  _ItemDetailFloatingBottomBarState createState() =>
      _ItemDetailFloatingBottomBarState();

  final ProductModel product;

  ItemDetailFloatingBottomBar({
    @required this.product,
  });
}

class _ItemDetailFloatingBottomBarState
    extends State<ItemDetailFloatingBottomBar> {
  var _isWishListLoading = false;
  var _isCartLoading = false;

  @override
  Widget build(BuildContext context) {
    final prodProvider = Provider.of<ProductProvider>(context, listen: false);
    void wishListBtnClicked() async {
      setState(() {
        _isWishListLoading = true;
      });

      final status =
          await prodProvider.addProdToWishListWith(prodID: widget.product.id);
      setState(() {
        _isWishListLoading = false;
      });
    }

    void addToCartBtnClicked() async {
      setState(() {
        _isCartLoading = true;
      });
      final status =
          await prodProvider.addProdToCartListWith(prodID: widget.product.id);
      setState(() {
        _isCartLoading = false;
      });
    }

    _buildWishListLoader() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
        padding: EdgeInsets.all(
          5,
        ),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.cabaret,
          ),
        ),
      );
    }

    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: _isWishListLoading
                ? _buildWishListLoader()
                : OutlineButton.icon(
                    onPressed: wishListBtnClicked,
                    icon: Icon(Icons.bookmark),
                    label: const Text(
                      'ADD TO WISHLIST',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 11,
            child: _isCartLoading
                ? _buildWishListLoader()
                : FlatButton.icon(
                    onPressed: addToCartBtnClicked,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: Text(
                      'ADD TO BAG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    color: Colors.pink,
                  ),
          ),
        ],
      ),
    );
  }
}
