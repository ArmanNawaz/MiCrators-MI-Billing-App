import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mi_crators/constants.dart';

class CustomerModel{
  
  Future<Map<String, dynamic>> getCustomerDetails(String cus_ph) async{
    
    
    try{
      var response = await http.get(Uri.parse(getHostUrl() + 'customer/' + cus_ph));
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        return {
          "cus_ph": 0,
          "cus_name": "",
          "email": "",
          "shopped_amt": 0
        };
      }
    }catch(error){
      return {"cus_ph": 0,
        "cus_name": "",
        "email": "",
        "shopped_amt": 0
      };
    }
  }
  
}