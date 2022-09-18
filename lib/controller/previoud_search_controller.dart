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
    var transactionBox = Hive.box(prevTransactions);
    var localDataBox = Hive.box(local_data);

    // await transactionBox.clear();

    for(int i = 0; i < transactionBox.length; i++){
      var transaction = transactionBox.getAt(i);
      print(transaction['pos_id'] == localDataBox.get('pos_id'));
      previoudPayments.add(TransactionTab(transactionId: transaction['transaction_id'], customerId: transaction['cus_ph'],
          cus_name: transaction['cus_name'], cost: transaction['amount'], transactionTime: transaction['date'].toString() ));
    }

    var prevSearches1 = await previousSearchModel.getPreviousSearches();
    // print(prevSearches1);
    List prevSearches = prevSearches1;
    // print('prevSearches');
    // print(prevSearches);

    for(Map<String, dynamic> searchModel in prevSearches){
      var transactionId = searchModel['transaction_id'];
      print(transactionId);
      if(transactionBox.containsKey(transactionId)) continue;
      transactionBox.put(transactionId, searchModel);
      previoudPayments.add(TransactionTab(transactionId: transactionId, customerId: searchModel['cus_ph'],
      cus_name: searchModel['cus_name'], cost: searchModel['amount'], transactionTime: searchModel['date'].toString() ));
    }
    super.onInit();
  }

}