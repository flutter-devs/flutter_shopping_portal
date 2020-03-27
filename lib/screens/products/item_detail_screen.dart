import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'package:myntra_test_app/blocs/item_detail_bloc.dart';
import 'package:myntra_test_app/helpers/common_constants.dart';
import 'package:myntra_test_app/helpers/helper.dart';
import 'package:myntra_test_app/models/product_model.dart';
import 'package:myntra_test_app/models/search_models.dart';
import 'package:myntra_test_app/widgets/custom_app_bar.dart';
import 'package:myntra_test_app/widgets/item_detail_carousel_with_indicator.dart';
import 'package:myntra_test_app/widgets/item_detail_floating_bottom_bar.dart';
import 'package:myntra_test_app/widgets/tiles/item_tiles/item_size_grid_tile.dart';
import 'package:provider/provider.dart';

import '../../blocs/item_detail_bloc.dart';

class ItemDetailScreen extends StatefulWidget {
//  static const routeName = '/item-detail';

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();

  final SearchProductsModel searchProductsModel;
  final ProductModel product;

  ItemDetailScreen({
    @required this.searchProductsModel,
    @required this.product,
  });
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  ItemDetailBloc _itemDetailBloc;

  @override
  void initState() {
    print('ItemDetailScreen initState');
    super.initState();
  }

  @override
  void dispose() {
    print('ItemDetailScreen dispose');

    if (_itemDetailBloc != null) {
      _itemDetailBloc.dispose();
    }
    super.dispose();
  }

  void didTappedAtItemId(String id) {
//    Navigator.of(context).pushNamed(ItemDetailScreen.routeName,
//        arguments: {'id': id, 'category': _category});
  }

  DiscountTypes get getDiscountType {
    return Helper.getDiscountTypeFor(
        code: widget.product.priceMap.discountType);
  }

  String get getDiscountString {
    String discountString = '';
    final discountType = getDiscountType;
    switch (discountType) {
      case DiscountTypes.Amount:
        discountString = 'Rs ${widget.product.priceMap.discountAmount} off';
        break;

      case DiscountTypes.Percentage:
        discountString = '${widget.product.priceMap.discountPercentage}% off';
        break;

      default:
        break;
    }
    return discountString;
  }

  @override
  Widget build(BuildContext context) {
    _itemDetailBloc = ItemDetailBloc();

    _moreInfoView() => Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'VIEW INFORMATION',
//                style: TextStyle(color: AppColors.silver),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Product Code: ${widget.product.manufacturerDetailMap.prodCode}',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Sold by: ${widget.product.manufacturerDetailMap.brandName}',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'VIEW MORE',
                  style: TextStyle(
                    color: AppColors.cabaret,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

    _deliveryView() => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DELIVERY & SERVICES FOR',
                style: TextStyle(color: AppColors.silver),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.silver,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
//                      textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
//                      maxLength: 6,
                        decoration: InputDecoration(
//                        filled: true,
//                        fillColor: AppColors.cabaret,
                          border: InputBorder.none,
                          hintText: 'Enter PIN Code',
                          hintStyle: TextStyle(
                            color: AppColors.cabaret,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'CHANGE',
                        style: TextStyle(
                          color: AppColors.cabaret,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Cash on delivery might be available',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Try & Buy might be available',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );

    _productDetailView() => StreamProvider.value(
          initialData: _itemDetailBloc.getProdDetailStatus,
          value: _itemDetailBloc.showHideProdDetailStream,
          child: ProductDetailView(
            product: widget.product,
            itemDetailBloc: _itemDetailBloc,
          ),
        );

    _couponView() => Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
//      height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('You Pay Only:'),
                  Text(
                    'Rs319',
                    style: TextStyle(color: Colors.pink),
                  ),
                  Spacer(),
                  Text(
                    'Save: Rs30',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                'Apply the coupon during checkout',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Text(
                'Orders above Rs. 1499 (only on first purchase). T&C apply.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    child: Text('ASD324HBHBH3J24'),
                    color: Colors.pink[50],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Tap to copy'),
                  )
                ],
              )
            ],
          ),
        );

    _buildPriceDiscountView() {
      return Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Text(
            'Rs ${widget.product.priceMap.price}',
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

    _buildPriceView() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: Row(
          children: <Widget>[
            Text(
              '${AppStrings.RupeeSign} ${Helper.getIteratedPriceToShowFor(product: widget.product)}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
            if (getDiscountType != DiscountTypes.None)
              _buildPriceDiscountView(),
          ],
        ),
      );
    }

    _sizeView() => StreamProvider.value(
          initialData: _itemDetailBloc.getSizeChartVisibilityStatus,
          value: _itemDetailBloc.sizeChartVisiblityCheckerStream,
          child: SizeView(
            product: widget.product,
            itemDetailBloc: _itemDetailBloc,
          ),
        );

    _mainBody() => Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: ItemDetailCarouselWithIndicator(
                        itemsArray: widget.product.imgUrlsArray,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                widget.product.manufacturerDetailMap.brandName,
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.product.descriptionMap.short2,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.product.descriptionMap.short1,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                          _buildPriceView(),
                          Text(
                            widget.product.specialMsg,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(color: Colors.white, height: 10),
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 0.2,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton.icon(
                                  icon: Icon(Icons.content_copy),
                                  label: Text('Similar'),
                                  onPressed: () {},
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: 0.4,
                                  color: Colors.grey,
                                ),
                                FlatButton.icon(
                                  icon: Icon(Icons.compare),
                                  label: Text('Compare'),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _couponView(),
                    SizedBox(
                      height: 20,
                    ),
                    _sizeView(),
                    SizedBox(
                      height: 20,
                    ),
                    _productDetailView(),
                    SizedBox(
                      height: 20,
                    ),
                    _deliveryView(),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  similarItemsView(),
                    SizedBox(
                      height: 20,
                    ),
                    _moreInfoView(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              StreamBuilder<bool>(
                stream: _itemDetailBloc.sizeChartVisiblityCheckerStream,
                builder: (ctx, snapshot) {
                  return snapshot.data == true
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: ItemDetailFloatingBottomBar(
                              product: widget.product,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          ),
        );

    _buildAppBar() => PreferredSize(
          preferredSize: Size(null, AppConstants.preferredAppBarHeight),
          child: CustomAppBar(
            title: widget.product.manufacturerDetailMap.brandName,
          ),
        );

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _mainBody(),
      ),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  final ProductModel product;
  final ItemDetailBloc itemDetailBloc;

  ProductDetailView({
    @required this.product,
    @required this.itemDetailBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Provider.of<bool>(context)
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Product Details',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        itemDetailBloc.updateProdDetailViewStatus();
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),
                Text(
                  product.descriptionMap.long,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Material & Care',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  product.descriptionMap.materialAndCare,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Product Details',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    itemDetailBloc.updateProdDetailViewStatus();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          );
  }
}

class SizeView extends StatelessWidget {
  final ProductModel product;
  final ItemDetailBloc itemDetailBloc;

  SizeView({
    @required this.product,
    @required this.itemDetailBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'SELET SIZE (UK SIZE)',
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Text(
                'SIZE CHART',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 75,
            child: ListView.builder(
              itemBuilder: (ctx, index) => ProductSizeGridTile(
                prodSize: product.sizesmap.list[index],
                isSelected: product.selectedSizeIndex == index,
              ),
              itemCount: product.sizesmap.list.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          VisibilityDetector(
            key: Key("unique key"),
            child: ItemDetailFloatingBottomBar(
              product: product,
            ),
            onVisibilityChanged: (VisibilityInfo info) {
              if (info.visibleFraction == 1.0) {
                itemDetailBloc.changeBottomBarVisibiltyTo(false);
              } else if (info.visibleFraction == 0.0) {
                itemDetailBloc.changeBottomBarVisibiltyTo(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
