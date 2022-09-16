import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/previoud_search_model.dart';
import 'package:mi_crators/model/search_tab_model.dart';

// {
//    "transaction_id" : ...,
//   "cus_ph": ...,
//   "cus_name": ...,
//   "cost" : ...,
//   "date" : ...,
// }

class PreviousSearchController extends GetxController{

  var previoudPayments = <TransactionTab>[].obs;
  PreviousSearchModel previousSearchModel = PreviousSearchModel();

  @override
  void onInit() async {
    // TODO: implement onInit
    var transactionBox = Hive.box(prevTransactions);

    for(int i = 0; i < transactionBox.length; i++){
      Map<String, dynamic> transaction = transactionBox.getAt(i);
      previoudPayments.add(TransactionTab(transaction['transaction_id'], transaction['cus_id'], transaction['cus_name'], transaction['cost'], transaction['date']));
    }

    List prevSearches = await previousSearchModel.getPreviousSearches();

    for(Map<String, dynamic> searchModel in prevSearches){
      var transactionId = searchModel['transactionId'];
      if(transactionBox.containsKey(transactionId)) continue;
      transactionBox.put(transactionId, searchModel);
      previoudPayments.add(TransactionTab(transactionId, searchModel['cus_id'], searchModel['cus_name'], searchModel['cost'], searchModel['date']));
    }
    super.onInit();
  }

}