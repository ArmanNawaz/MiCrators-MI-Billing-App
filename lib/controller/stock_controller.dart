import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/stock_model.dart';

class StockController extends GetxController{
  // Here we will add the stock into the local Database
  Rx<bool> retriving = false.obs;
  StockModel stockModel = StockModel();

  @override
  void onInit() async {
    // TODO: implement onInit

    print('Getting stocks');
    var stocks = await Hive.lazyBox(stockBox);
    retriving.value = true;
    List stockList = await stockModel.getStock();
    print(stockList);

    for(Map<String, dynamic> stock in stockList){
      stocks.put(stock['serial_no'], stock);
    }


    super.onInit();
  }
}