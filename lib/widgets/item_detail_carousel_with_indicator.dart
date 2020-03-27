import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ItemDetailCarouselWithIndicator extends StatefulWidget {
  final List<String> itemsArray;

  ItemDetailCarouselWithIndicator({@required this.itemsArray});

  @override
  _ItemDetailCarouselWithIndicatorState createState() => _ItemDetailCarouselWithIndicatorState();
}

class _ItemDetailCarouselWithIndicatorState extends State<ItemDetailCarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(children: [
        CarouselSlider.builder(
          height: height / 2,
          itemCount: widget.itemsArray.length,
          itemBuilder: (BuildContext ctx, int itemIndex) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  widget.itemsArray[itemIndex],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 0.2,
                color: Colors.grey,
              ),
            ],
          ),
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.itemsArray.map((item) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == widget.itemsArray.indexOf(item)
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          }).toList(),
        ),
      ]),
    );
  }
}