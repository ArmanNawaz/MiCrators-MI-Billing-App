import 'dart:convert';
import 'dart:io' show Platform;
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/search_tab_model.dart';


class PreviousSearchModel{

  Future<List<TransactionTab>> getPreviousSearches() async{
    try{
      var localDataBox = Hive.box(local_data);
      var response;
      if(Platform.isWindows){
        response = await http.get(Uri.parse(backendUrlPc+'search/' + '?pos_id=${localDataBox.get('pos_id')}'));
      }else{
        response = await http.get(Uri.parse(backendUrlMobile+'search/' + '?pos_id=${localDataBox.get('pos_id')}'));
      }
      if(response.statusCode == 200){
        var decodedJson = jsonDecode(response.body);
        return decodedJson;
      }else return [];

    }catch(err){
      return [];
    }
  }

}