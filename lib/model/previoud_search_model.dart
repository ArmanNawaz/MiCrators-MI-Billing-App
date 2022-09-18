import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/model/search_tab_model.dart';


class PreviousSearchModel{

  Future<List> getPreviousSearches() async{
    try{
      var localDataBox = Hive.box(local_data);
      // print(localDataBox.get('pos_id'));
      var response;
      print(backendUrlPc+'transaction/' + '${localDataBox.get('pos_id')}');
      if(Platform.isWindows){
        response = await http.get(Uri.parse(backendUrlPc+'transaction/' + '${localDataBox.get('pos_id')}'));
      }else{
        response = await http.get(Uri.parse(backendUrlMobile+'transaction/' + '${localDataBox.get('pos_id')}'));
      }

      // print(response.statusCode);
      if(response.statusCode == 200){
        var decodedJson = jsonDecode(response.body);
        // print('jsonDecode: ${decodedJson}');
        return decodedJson;
      }else return [];

    }catch(err){
      return [];
    }
  }

}