import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/warranty_model.dart';

class NewPaymentController extends GetxController {
  Rx<String> productName = 'Product name will be displayed here.'.obs;
  Rx<String> categoryName = 'Category Name will be displayed here.'.obs;
  var warranties = <WarrantyModel>[].obs;

  reset() {
    productName.value = 'Product name will be displayed here.';
    categoryName.value = 'Category Name will be displayed here.';
    warranties.value = [];
  }

  loadItem(serialNo) async {
    print('Loading item... ');
    var stockBox = await Hive.lazyBox(stock);
    // print(stockBox.containsKey(serialNo.toString()));
    // print(stockBox.keys);

    if (stockBox.containsKey(serialNo)) {
      var data = await stockBox.get(serialNo);
      print('data');
      print(data);
      productName.value = data['product_name'];
      categoryName.value = data['category_name'];
      for (int i = 0; i < data['warranty'].length; i++) {
        warranties.add(WarrantyModel(
          warranty_name: data['warranty'][i]['warranty_name'],
          warranty_id: data['warranty'][i]['warranty_id'],
          warranty_type: data['warranty'][i]['warranty_type'],
          days_valid: data['warranty'][i]['days_valid'],
        ));
      }
      // print(warranties);
    } else {
      reset();
    }
  }
}
