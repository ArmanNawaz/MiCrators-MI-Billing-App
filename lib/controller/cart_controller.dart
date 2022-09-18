import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/bill_item_model.dart';
import 'package:mi_crators/model/cart_model.dart';


// {
//   pos_id: ...,
//     bills :[
//       {
//         total_amount: ...,
//         cus_ph: ...,
//         discount: ...,
//         offline_payment: True/False,
//         successful: ...,
//         billItems: [
//           {
//           serial_no: ,
//           date: ,
//           cost: ,
//           warranty_id: ,
//         },
//         {
//             ""
//         }
//       ...
//       ]
//     },
//     ...
//   ]
// }

class CartController extends GetxController{
  var cartSet  = <String>{}.obs;
  var cart = <BillItemModel>[].obs;
  var total_amount = 0.obs;
  Rx<bool> offlinePay = false.obs;
  CartModel cartModel = CartModel();

  clearCart(){
    cart.value = [];
    total_amount.value = 0;
    cartSet.value.clear();
    offlinePay.value = false;
    print(cartSet);
  }

  addInCart(BillItemModel item){
    print(cartSet.contains(item.serial_no));
    if(cartSet.contains(item.serial_no)) return;
    total_amount += int.parse(item.cost);
    cart.value.add(item);
    cartSet.add(item.serial_no);
  }

  paymentIsOffline(){
    offlinePay.value = true;
  }

  Map<String, dynamic> createApi(String cus_ph){
    Map<String, dynamic> finalJson = {
      'total_amount' : total_amount.value,
      'cus_ph': cus_ph,
      'discount': 0,
      'successful' : true,
      'offline_payment': offlinePay.value,
      'billItems': []
    };

    for(var item in cart.value){
      finalJson['billItems'].add({
          'serial_no': item.serial_no,
          'date': DateTime.now().toString().substring(0, 19),
          'cost': item.cost,
          'warranty_id': item.warranty_id,
        }
      );
    }

    print(finalJson);

    return finalJson;
  }

  // TODO: IMPLEMENT AN INTERFACE FOR LEFT OVER PAYMENETS.

  Future<bool> sendCartPayment(String cus_ph) async {
    Map<String, dynamic> dataToSend = createApi(cus_ph);
    List<Map<String, dynamic>> list = [dataToSend]; // [{pos_id: , bills: []}]

    Map<String, dynamic> response = await cartModel.registerPayment(list);

    if(response.length == 0){
      Hive.box(unsuccessfulTransactions).put(cus_ph, dataToSend);
      return false;
    }else if(response['failed_transactions'].length > 0){
      Hive.box(unsuccessfulTransactions).put(cus_ph, dataToSend);
      return false;
    }else{
      Hive.box(succesfulTransactions).put(cus_ph, dataToSend);
      cart.value = [];
      total_amount.value = 0;
      offlinePay.value = false;
      return true;
    }



  }

  sendLeftOverPayments() async{
    List<Map<String, dynamic>> list;

    // TODO: To be implemented

    // Map<String, dynamic> response = await cartModel.registerPayment(Hive.box(unsuccessfulTransactions).);



    // if(response['failed_transactions'].length > 0){
    //   Hive.box(unsuccessfulTransactions).put(cus_ph, dataToSend);
    // }else{
    //   Hive.box(succesfulTransactions).put(cus_ph, dataToSend);
    // }

  }



}

