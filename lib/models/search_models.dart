import 'package:flutter/material.dart';

class SearchProductsModel {
  final category;
  final subCategory;
  final subSubCategory;

  SearchProductsModel({
    @required this.category,
    @required this.subCategory,
    @required this.subSubCategory,
  });
}
