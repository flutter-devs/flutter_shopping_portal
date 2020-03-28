import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:myntra_test_app/src/core/models/table_schemas/common_tables_schema.dart';
import 'package:myntra_test_app/src/core/helpers/url_constants.dart';
import 'package:myntra_test_app/src/core/models/common_models.dart';

class CategoryProvider with ChangeNotifier {
  final databaseReference = Firestore.instance;

  Map<String, CategoryModal> _categories = {};

  Map<String, CategoryModal> get categories {
    return {..._categories};
  }

  CategoryModal getCategoryBy(String id) {
    return _categories[id];
  }

  void _addOrUpdate({@required CategoryModal category}) {
    if (_categories.containsKey(category.id)) {
      //Update category
//      print('Update category with name: ${category.name}');
      _categories.update(category.id, (existingCategory) {
        return CategoryModal(
          name: existingCategory.name,
          id: existingCategory.id,
          homePageImageUrl: existingCategory.homePageImageUrl,
          menuIconStoragePath: existingCategory.menuIconStoragePath,
          menuIconImageUrl: category.menuIconImageUrl,
          subCategoriesIDs: existingCategory.subCategoriesIDs,
          subCategories: category.subCategories,
        );
      });
    } else {
      _categories.putIfAbsent(category.id, () {
        return CategoryModal(
          name: category.name,
          id: category.id,
          homePageImageUrl: category.homePageImageUrl,
          menuIconStoragePath: category.menuIconStoragePath,
          menuIconImageUrl: category.menuIconImageUrl,
          subCategoriesIDs: category.subCategoriesIDs,
          subCategories: category.subCategories,
        );
      });
    }
  }

  Future<void> fetchAndSetCategories() async {
    if (_categories.isNotEmpty) {
//      notifyListeners();
      return;
    }
    try {
      print('fetchAndSetCategories from server');
//      final List<CategoryModal> loadedCategories = [];
      await databaseReference
          .collection(Tables.categories)
          .where(CategoryTable.isActive, isEqualTo: true)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        if (snapshot.documents.isEmpty) {
          return;
        }

        snapshot.documents.forEach((doc) {
          var subCategoriesIDsJson = doc[CategoryTable.subCatIDs];
          List<String> subCategoriesIDs = subCategoriesIDsJson == null
              ? []
              : List<String>.from(subCategoriesIDsJson);
          final newCat = CategoryModal(
            name: doc[CategoryTable.name],
            id: doc.documentID,
            homePageImageUrl: doc[CategoryTable.imageUrl],
            menuIconStoragePath: doc[CategoryTable.menuIconName],
            subCategoriesIDs: subCategoriesIDs,
            subCategories: [],
          );
          _getDownloadableUrlFor(category: newCat);
          _addOrUpdate(category: newCat);
//          loadedCategories.add(newCat);
        });

//        _categories = loadedCategories;
        notifyListeners();

        _fetchAndSetSubCategories();
      });
    } catch (error) {
      print('fetchAndSetCategories error: ${error.message}');
      throw error;
    }
  }

  Future<void> _getDownloadableUrlFor({CategoryModal category}) async {
    try {
//      print('GetDownloadableUrlFor from server');
//      print('${category.menuIconStoragePath}');
      if (category.menuIconStoragePath == '') {
        return;
      }

      FirebaseStorage.instance
          .getReferenceFromUrl(category.menuIconStoragePath)
          .then((storageRef) async {
        String url = (await storageRef.getDownloadURL()).toString();
//        print('Downloadable Url for ${category.name}: $url');
        category.menuIconImageUrl = url;
        _addOrUpdate(category: category);
      });
    } catch (error) {
      print('getDownloadableUrlFor ${category.name} error: $error');
      throw error;
    }
  }

  Future<void> _fetchAndSetSubCategories() async {
    try {
      print('fetchAndSetSubCategories from server');
      final List<SubCategoryModal> loadedSubCategories = [];

      await databaseReference
          .collection(Tables.subCategories)
          .where(SubCategoryTable.isActive, isEqualTo: true)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        if (snapshot.documents.isEmpty) {
          print('fetchAndSetSubCategoriesFor documents: isEmpty');
          return;
        }
        snapshot.documents.forEach((doc) {
          var subSubCategoriesIDsJson = doc[SubCategoryTable.subSubCatIDs];
//          print("subSubCategoriesIDsJson: $subSubCategoriesIDsJson");
          List<String> subSubCategoriesIDs = subSubCategoriesIDsJson == null
              ? []
              : List<String>.from(subSubCategoriesIDsJson);

//          print('fetchAndSetSubCategoriesFor doc: ${doc.documentID}');

          loadedSubCategories.add(SubCategoryModal(
            name: doc[SubCategoryTable.name],
            id: doc.documentID,
            subSubCategoriesIDs: subSubCategoriesIDs,
            subSubCategories: [],
          ));
        });

        _categories.values.forEach((var cat) {
//          print('cat name: ${cat.name}');
//          print('cat.subCategoriesIDs: ${cat.subCategoriesIDs}');
          loadedSubCategories.forEach((subCat) {
//            print('subCat.id: ${subCat.id}');
            if (cat.subCategoriesIDs.contains(subCat.id)) {
//              print(
//                  'cat name: ${cat.name} => add subCategory name: ${subCat.name}');
              cat.subCategories.add(subCat);
            }
          });
          _addOrUpdate(category: cat);
//            updateCategoriesArray.add(cat);
        });

        _fetchAndSetSubSubCategories();
      });
    } catch (error) {
      print('fetchAndSetSubCategories error: $error');
      throw error;
    }
  }

  Future<void> _fetchAndSetSubSubCategories() async {
    try {
      print('fetchAndSetSubSubCategories from server');
      final List<SubSubCategoryModal> loadedSubSubCategories = [];

      await databaseReference
          .collection(Tables.subSubCategories)
          .where(SubCategoryTable.isActive, isEqualTo: true)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        if (snapshot.documents.isEmpty) {
          print('fetchAndSetSubSubCategoriesFor documents: isEmpty');
          return;
        }
        snapshot.documents.forEach((doc) {
//          print('fetchAndSetSubSubCategoriesFor doc: ${doc.documentID}');

          loadedSubSubCategories.add(SubSubCategoryModal(
            name: doc[SubCategoryTable.name],
            id: doc.documentID,
          ));
        });

        _categories.values.forEach((cat) {
//          print('cat name: ${cat.name}');
          cat.subCategories.forEach((subCat) {
//            print('subCat.subSubCategoriesIDs: ${subCat.subSubCategoriesIDs}');
            loadedSubSubCategories.forEach((var subSubCat) {
//            print('subCat.id: ${subCat.id}');
              if (subCat.subSubCategoriesIDs.contains(subSubCat.id)) {
//                print(
//                    'cat name: ${cat.name},subCategory name: ${subCat.name}  => add subSubCategory name: ${subSubCat.name}');
                subCat.subSubCategories.add(subSubCat);
              }
            });
          });
          _addOrUpdate(category: cat);
        });
      });
    } catch (error) {
      print('fetchAndSetSubCategories error: $error');
      throw error;
    }
  }
}
