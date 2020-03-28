import 'package:flutter/cupertino.dart';

class ProductModel {
  final int customerReviewsCount;
  final ProdDescriptionModel descriptionMap;
  final String id;
  final List<String> imgUrlsArray;
  final ProdManufacturerModel manufacturerDetailMap;
  final ProdPriceModel priceMap;
  int selectedSizeIndex;
  final ProdSizesDetailModel sizesmap;
  final String specialMsg;

  ProductModel({
    @required this.customerReviewsCount,
    @required this.descriptionMap,
    @required this.id,
    @required this.imgUrlsArray,
    @required this.manufacturerDetailMap,
    @required this.priceMap,
    this.selectedSizeIndex = 0,
    @required this.sizesmap,
    @required this.specialMsg,
  });
}

class ProdDescriptionModel {
  final String long;
  final String materialAndCare;
  final String short1;
  final String short2;
  final String sizeAndFit;

  ProdDescriptionModel({
    @required this.long,
    @required this.materialAndCare,
    @required this.short1,
    @required this.short2,
    @required this.sizeAndFit,
  });
}

class ProdPriceModel {
  final int discountAmount;
  final int discountMaxAmountViaPercentage;
  final int discountPercentage;
  final int discountType;
  final int price;

  ProdPriceModel({
    @required this.discountAmount,
    @required this.discountMaxAmountViaPercentage,
    @required this.discountPercentage,
    @required this.discountType,
    @required this.price,
  });
}

class ProdManufacturerModel {
  final String brandName;
  final String brandId;
  final String id;
  final String name;
  final String prodCode;

  ProdManufacturerModel({
    @required this.brandId,
    @required this.brandName,
    @required this.id,
    @required this.name,
    @required this.prodCode,
  });
}

class ProdSizesDetailModel {
  final List<ProdSizeModel> list;
  final String specialMsg;

  ProdSizesDetailModel({
    @required this.list,
    @required this.specialMsg,
  });
}

class ProdSizeModel {
  final int id;
  final String name;
  final int remainingQty;

  ProdSizeModel({
    @required this.id,
    @required this.name,
    @required this.remainingQty,
  });
}
