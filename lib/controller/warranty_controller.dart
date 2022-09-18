import 'package:get/get.dart';

class WarrantyController extends GetxController {
  Rx<int> warrantySelected = 0.obs;

  selectWarranty(int value) {
    // print('Warranty id selected');
    warrantySelected.value = value;
  }
}
