import 'package:flutter/material.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/helpers/helper.dart';

import 'package:myntra_test_app/models/product_model.dart';

class ItemGridTile extends StatelessWidget {
  final ProductModel product;

  ItemGridTile({@required this.product});

  DiscountTypes get getDiscountType {
    return Helper.getDiscountTypeFor(code: product.priceMap.discountType);
  }

  String get getDiscountString {
    String discountString = '';
    final discountType = getDiscountType;
    switch (discountType) {
      case DiscountTypes.Amount:
        discountString = 'Rs ${product.priceMap.discountAmount} off';
        break;

      case DiscountTypes.Percentage:
        discountString = '${product.priceMap.discountPercentage}% off';
        break;

      default:
        break;
    }
    return discountString;
  }

  Widget _buildPriceDiscountView() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 5,
        ),
        Text(
          'Rs ${product.priceMap.price}',
          style: TextStyle(
            color: Colors.grey[500],
            decoration: TextDecoration.lineThrough,
            fontSize: 11,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          getDiscountString,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Text(
            '${AppStrings.RupeeSign} ${Helper.getIteratedPriceToShowFor(product: product)}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
          if (getDiscountType != DiscountTypes.None) _buildPriceDiscountView(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.silver,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: FadeInImage(
              placeholder: AssetImage(
                AppIcons.flutter,
              ),
              image: NetworkImage(product.imgUrlsArray.first),
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product.manufacturerDetailMap.brandName,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product.descriptionMap.short1,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  _buildPriceView(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product.specialMsg,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                width: 20,
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.pink,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
