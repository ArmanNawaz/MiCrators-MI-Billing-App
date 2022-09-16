import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class StockModel extends GetxController{

  Future<List> getStock() async{

    // Get all the stock present in the store.

    var localData = Hive.box(local_data);
    var store_id = localData.get('store_id');
    print(store_id);

    try{
      var response = await http.get(Uri.parse(getHostUrl()+'stock/'+'${store_id}'));
      if(response.statusCode == 200){
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      }
    }catch(err){
      print(err);
      return [];
    }
    return [];
  }

}