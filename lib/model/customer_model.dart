import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mi_crators/constants.dart';

class CustomerModel{

  Future<Map<String, dynamic>> setCustomer(String cus_ph, String email, String address, String name) async{
    try{
      var response = await http.post(Uri.parse(getHostUrl() + 'customer/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "cus_ph" : cus_ph,
          "cus_name" : name,
          "email" : email,
          "name" : name
        })

      );

      if(response.statusCode == 200) {
        return {
        "cus_ph" : cus_ph,
        "cus_name" : name,
        "email" : email,
        "name" : name
      };
      } else return {};
    }catch(err){
      print(err);
      return {};
    }
  }

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