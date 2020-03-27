import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myntra_test_app/helpers/url_constants.dart';
import 'package:myntra_test_app/models/table_schemas/user_table_schema.dart';

class ProductProvider with ChangeNotifier {
  String userID;
  String userDocID;

  final _databaseReference = Firestore.instance;

  Future<bool> addProdToCartListWith({@required String prodID}) async {
//    print('addProdToCartListWith prodID: $prodID');
    try {
      await _databaseReference
          .collection(Tables.users)
          .document('$userDocID')
          .updateData({
        UserTable.cartListDetailMap: {
          UserCartListMap.prodIDsList: FieldValue.arrayUnion([prodID])
        }
      });

      print('Add prod to cart done');

      ///${UserTable.wishListDetailMap}
      return true;
    } catch (e) {
      print('Add prod to cart error: $e');
      return false;
    }
  }

  Future<bool> addProdToWishListWith({@required String prodID}) async {
//    print('addProdToWishListWith prodID: $prodID');
    try {
      await _databaseReference
          .collection(Tables.users)
          .document('$userDocID')
          .updateData({
        UserTable.wishListDetailMap: {
          UserWishListMap.prodIDsList: FieldValue.arrayUnion([prodID])
        }
      });
      print('Add prod to wishlist done');

      ///${UserTable.wishListDetailMap}
      return true;
    } catch (e) {
      print('Add prod to wishlist error: $e');
      return false;
    }
  }
}
