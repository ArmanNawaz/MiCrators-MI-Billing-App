import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mi_crators/constants.dart';

class CartModel{

  Future<Map<String, dynamic>> registerPayment(List<Map<String, dynamic>> finalApi) async{

    var localDataBox = Hive.box(local_data);

    Map<String, dynamic> finalPayment = {
      "pos_id": localDataBox.get('pos_id'),
      "bills": finalApi
    };

    print('final Payment: ${finalPayment}');
    try{
      var response = await http.post(Uri.parse(getHostUrl() + 'bill/'), body: jsonEncode(finalPayment));
      if(response.statusCode == 200){
        print(response.body);
        return jsonDecode(response.body);
      }else{
        return jsonDecode(response.body);
      }
    }catch(err){
      print(err);
      return {};
    }

  }

}