import 'package:get/get.dart';
import 'package:mi_crators/model/operator_model.dart';
import 'package:mi_crators/screens/home_page.dart';

class OperatorController extends GetxController{

  Rx<bool> loggedIn = false.obs;
  OperatorModel operatorModel = OperatorModel();
  final isLoading = false.obs;

  switchLoading() => isLoading.value = !isLoading.value;

  @override
  void onInit() {
    loggedIn.value = operatorModel.checkLoggedIn();
  }

  Future<void> login(String username, String password, String posId) async {
    switchLoading();
    loggedIn.value = await operatorModel.login(username, password, posId);
    print(loggedIn.value);
    switchLoading();
  }

}