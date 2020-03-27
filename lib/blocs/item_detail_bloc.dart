//StreamController(s)
//Streams and sinks getters
//Constructor - add data, listen to changes
//Core functions
//Dispose

import 'dart:async';

class ItemDetailBloc {
  bool _isBlocDisposed = false;

  bool _showFullProdDetail = false;
  bool _showBottomBar = true;

  //StreamController(s)

  final _showHideProdDetailStreamController = StreamController<bool>();

  Stream<bool> get showHideProdDetailStream =>
      _showHideProdDetailStreamController.stream;

  bool get getProdDetailStatus => _showFullProdDetail;

  final _sizeChartVisiblityCheckerStreamController = StreamController<bool>();

  Stream<bool> get sizeChartVisiblityCheckerStream =>
      _sizeChartVisiblityCheckerStreamController.stream;

  bool get getSizeChartVisibilityStatus => _showBottomBar;

  //Constructor - add data, listen to changes

  ItemDetailBloc() {
    _showHideProdDetailStreamController.add(_showFullProdDetail);

    _sizeChartVisiblityCheckerStreamController.add(_showBottomBar);
  }

  //Core functions

  void updateProdDetailViewStatus() {
    print('updateProdDetailViewStatus');
    _showFullProdDetail = !_showFullProdDetail;
    print('_showFullProdDetail: $_showFullProdDetail');
    _showHideProdDetailStreamController.sink.add(_showFullProdDetail);
  }

  void changeBottomBarVisibiltyTo(bool status) {
    if (_isBlocDisposed) {
      return;
    }
    _sizeChartVisiblityCheckerStreamController.sink.add(status);
  }

  //Dispose

  void dispose() {
    print('ItemDetailBloc closed');
    _showHideProdDetailStreamController.close();
    _sizeChartVisiblityCheckerStreamController.close();
    _isBlocDisposed = true;
  }
}
