import 'package:flutter/material.dart';
import 'package:myntra_test_app/models/product_model.dart';

class ProductSizeGridTile extends StatelessWidget {
  final ProdSizeModel prodSize;
  final bool isSelected;
  final bool isSelectable;
  final Function newSizeSelected;

  final double tileWidth = 55;

  ProductSizeGridTile({
    @required this.prodSize,
    this.isSelected = false,
    this.isSelectable = false,
    this.newSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: isSelectable ? () => newSizeSelected(prodSize) : null,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
//              color: Colors.t,
                borderRadius: BorderRadius.all(
                  Radius.circular((tileWidth - 10) / 2),
                ),
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.black,
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              width: tileWidth - 10,
              height: tileWidth - 10,
              child: Text(
                prodSize.name ?? '',
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
          if (prodSize.remainingQty < 10)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(1.5),
                ),
                border: Border.all(
                  color: Colors.pink,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
//            color: Colors.yellow,
              child: Text(
                '${prodSize.remainingQty} left',
                style: TextStyle(color: Colors.pink, fontSize: 8),
              ),
            ),
          Spacer(),
        ],
      ),
    );
  }
}
