import 'package:flutter/material.dart';

import 'package:myntra_test_app/widgets/tiles/item_tiles/item_qty_grid_tile.dart';

class SelectQtyBottomSheet extends StatefulWidget {
  final int selectedQty;
  final Function doneBtnClickedWithNewQty;

  SelectQtyBottomSheet(
      {@required this.selectedQty, @required this.doneBtnClickedWithNewQty});

  @override
  _SelectQtyBottomSheetState createState() => _SelectQtyBottomSheetState();
}

class _SelectQtyBottomSheetState extends State<SelectQtyBottomSheet> {
  final qtyArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int _newSelectedQty;

  void newQtySelected(int newSize) {
    setState(() {
      _newSelectedQty = newSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Select Quantity',
//                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
//              color: Colors.green,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => ItemQtyGridTile(
                    itemQty: qtyArray[index],
                    isSelected: _newSelectedQty != null
                        ? qtyArray[index] == _newSelectedQty
                        : qtyArray[index] == widget.selectedQty,
                    isSelectable: true,
                    newQtySelected: newQtySelected,
                  ),
                  itemCount: qtyArray.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.white,
                child: FlatButton(
                  onPressed: () {
                    widget.doneBtnClickedWithNewQty(_newSelectedQty != null
                        ? _newSelectedQty
                        : widget.selectedQty);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
//                      fontSize: 11,
                    ),
                  ),
                  color: Colors.pink,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
