import 'package:flutter/material.dart';
import 'package:myntra_test_app/src/core/models/common_models.dart';
import 'package:myntra_test_app/src/ui/view/products/items_list_screen.dart';

class AppDrawerSubListTile extends StatelessWidget {
  final SubCategoryModal subCategory;
  final bool isSelected;
  final int index;
  Function subCategoryViewTapped;
  Function subSubCategoryViewTapped;

  AppDrawerSubListTile({
    @required this.subCategory,
    this.isSelected = false,
    @required this.index,
    @required this.subCategoryViewTapped,
    @required this.subSubCategoryViewTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 50,
//      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () => subCategoryViewTapped(subCategory),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//              color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    subCategory.name,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey[800],
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w400 : FontWeight.w300,
                    ),
                  ),
                  if (subCategory.subSubCategoriesIDs.length != 0)
                    Icon(
                      isSelected
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey[400],
                    ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.3,
            color: Colors.grey[400],
          ),
          if (isSelected)
            Column(
              children: subCategory.subSubCategories.map((subSubCategory) {
                return InkWell(
                  onTap: () => subSubCategoryViewTapped(subSubCategory),
                  child: AppDrawerSubSubListTile(
                    subSubCategory: subSubCategory,
                  ),
                );
//                return AppDrawerSubSubListTile(
//                  title: subSubCategory.name,
//                );
              }).toList(),
            )
        ],
      ),
    );
  }
}

class AppDrawerSubSubListTile extends StatelessWidget {
  final SubSubCategoryModal subSubCategory;

  AppDrawerSubSubListTile({
    @required this.subSubCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  subSubCategory.name,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.3,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
//    return InkWell(
//      onTap: () {
//        final route =
//            MaterialPageRoute(builder: (ctx) => ItemsListScreen(title: title));
//        Navigator.push(context, route);
////        Navigator.of(context)
////            .pushNamed(ItemsListScreen.routeName, arguments: title);
//      },
//      child: Container(
//        padding: EdgeInsets.only(left: 40),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.symmetric(vertical: 15),
//              child: Row(
//                children: <Widget>[
//                  Text(
//                    title,
//                    style: TextStyle(
//                      color: Colors.grey[800],
//                      fontSize: 12,
//                      fontWeight: FontWeight.w300,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              height: 0.3,
//              color: Colors.grey[400],
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
