import 'package:flutter/material.dart';

//class SubMenuModal {
//  final String title;
//  final List<String> subItems;
//
//  SubMenuModal({@required this.title, @required this.subItems});
//}

class CategoryModal {
  final String name;
  final String id;
  final String homePageImageUrl;
  final String menuIconStoragePath;
  String menuIconImageUrl;
  final List<String> subCategoriesIDs;
  List<SubCategoryModal> subCategories;

  CategoryModal({
    @required this.name,
    @required this.id,
    @required this.homePageImageUrl,
    @required this.menuIconStoragePath,
    this.menuIconImageUrl = '',
    @required this.subCategoriesIDs,
    this.subCategories,
  });
}

class SubCategoryModal {
  final String name;
  final String id;
  final List<String> subSubCategoriesIDs;
  List<SubSubCategoryModal> subSubCategories;

  SubCategoryModal({
    @required this.name,
    @required this.id,
    @required this.subSubCategoriesIDs,
    this.subSubCategories,
  });
}

class SubSubCategoryModal {
  final String name;
  final String id;

  SubSubCategoryModal({
    @required this.name,
    @required this.id,
  });
}
