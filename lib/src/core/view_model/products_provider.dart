import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/helpers/alert_helper.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/models/table_schemas/prod_table_schema.dart';
import 'package:myntra_test_app/src/core/helpers/url_constants.dart';
import 'package:myntra_test_app/src/core/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  final databaseReference = Firestore.instance;

  Future<List<ProductModel>> fetchProducts({
    @required BuildContext ctx,
  }) async {
    try {
      final snapShot = await databaseReference
          .collection(Tables.products)
          .where(ProductTable.isActive, isEqualTo: true)
          .getDocuments();
      if (snapShot.documents.isEmpty) {
        return [];
      }
      List<ProductModel> _prodsArray = [];
      snapShot.documents.forEach((doc) {
//        print('${doc.documentID}');

        var imgUrlsJson = doc[ProductTable.imgUrlsArray];
        List<String> imgUrls =
            imgUrlsJson == null ? [] : List<String>.from(imgUrlsJson);

        var sizesJson =
            doc[ProductTable.sizesDetailMap][ProdSizesDetailMap.list];
        List<Map<String, dynamic>> sizesDynamicArray =
            sizesJson == null ? [] : List<Map<String, dynamic>>.from(sizesJson);
        List<ProdSizeModel> sizesArray = [];
        sizesDynamicArray.forEach((sizeDynamic) {
//          print('sizeDynamic: $sizeDynamic');
          final prodSize = ProdSizeModel(
            id: sizeDynamic[ProdSizeMap.id],
            name: sizeDynamic[ProdSizeMap.name],
            remainingQty: sizeDynamic[ProdSizeMap.remainingQty] ?? 0,
          );
//          print('prodSize name: ${prodSize.name}');
          sizesArray.add(prodSize);
        });

        final prod = ProductModel(
          id: doc.documentID,
          customerReviewsCount: doc[ProductTable.customerReviewsCount],
          descriptionMap: ProdDescriptionModel(
            long: doc[ProductTable.descriptionMap][ProdDescriptionMap.long],
            materialAndCare: doc[ProductTable.descriptionMap]
                [ProdDescriptionMap.materialAndCare],
            short1: doc[ProductTable.descriptionMap][ProdDescriptionMap.short1],
            short2: doc[ProductTable.descriptionMap][ProdDescriptionMap.short2],
            sizeAndFit: doc[ProductTable.descriptionMap]
                [ProdDescriptionMap.sizeAndFit],
          ),
          imgUrlsArray: imgUrls,
          manufacturerDetailMap: ProdManufacturerModel(
            brandId: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.brandId],
            brandName: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.brandName],
            id: doc[ProductTable.manufacturerDetailMap][ProdManufacturerMap.id],
            name: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.name],
            prodCode: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.prodCode],
          ),
          priceMap: ProdPriceModel(
            discountAmount: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountAmount],
            discountMaxAmountViaPercentage: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountMaxAmountViaPercentage],
            discountPercentage: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountPercentage],
            discountType: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountType],
            price: doc[ProductTable.priceDetailMap][ProdPriceMap.price],
          ),
          sizesmap: ProdSizesDetailModel(
            list: sizesArray,
            specialMsg: doc[ProductTable.sizesDetailMap]
                    [ProdSizesDetailMap.specialMsg] ??
                '',
          ),
          specialMsg: doc[ProductTable.specialMsg] ?? '',
        );
        _prodsArray.add(prod);
      });

      return _prodsArray;
    } catch (error) {
      print('fetchProducts error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: ctx, msg: error.message);
      return [];
    }
  }
}
