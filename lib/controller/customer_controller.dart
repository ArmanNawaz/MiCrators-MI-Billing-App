import 'package:get/get.dart';
import 'package:mi_crators/model/customer_model.dart';

class CustomerController extends GetxController{

  Rx<String> phoneNo = "".obs;
  Rx<String> email = "".obs;
  Rx<String> name = "".obs;
  Rx<String> address = "".obs;
  Rx<bool> isRetrieving = false.obs;
  CustomerModel customerModel = CustomerModel();


  getCustomer(String cus_ph) async{

    isRetrieving.value = true;
    var response = await customerModel.getCustomerDetails(cus_ph);
    if(response['email'].length == 0){
      return;
    }
    isRetrieving.value = false;
    email.value = response['email'].toString();
    name.value = response['cus_name'].toString();
    phoneNo.value = response['cus_ph'].toString();

    address.value = response['address'];

  }

  registerCustomer(String ccus_ph, String eemail, String aaddress, String nname) async{
    isRetrieving.value = true;
    var response = await customerModel.setCustomer(ccus_ph, eemail, aaddress, nname);
    if(response['email'].length == 0){
      return;
    }
    isRetrieving.value = false;
    email.value = response['email'].toString();
    name.value = response['cus_name'].toString();
    phoneNo.value = response['cus_ph'].toString();

    address.value = response['address'];
  }




}