import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:build_daemon/constants.dart';
import 'package:mi_crators/constants.dart';

class OperatorModel {
  late String username;
  late String first_name;
  late String second_name;
  late int age;
  late String gender;
  late int total_items_billed;
  late String nationality;
  late String city_id;
  late String city_name;
  late int area_id;
  late String area_name;
  late int store_id;
  late String store_name;
  late String store_type;
  late String pos_id;

  bool checkLoggedIn() {
    DateTime currentDate = DateTime.now();
    var hiveBox = Hive.box(local_data);
    // if(hiveBox.get('username') != null ) return true;
    return false;
  }

  // response
  // [{
  // "username": "operator1",
  // "password": "$2b$08$FxEftJWgCkuPnKgbn3Zf.OWi8e6xwW.eDEIg2nN/A/Ztor7zf64.m",
  // "first_name": "Asim",
  // "second_name": "Junaid",
  // "age": 27,
  // "gender": "M",
  // "total_items_billed": 1,
  // "nationality": "Indian",
  // "city_id": "KNP",
  // "city_name": "Kanpur",
  // "area_id": 1,
  // "area_name": "Express Rd",
  // "store_id": 1,
  // "store_name": "MI STORE 1",
  // "store_type": "MI Homes",
  // "pos_id": "KNP_01_01_2@3DRF"
  // }]

  // OperatorModel({
  //   required this.username,
  //   required this.first_name,
  //   required this.second_name,
  //   required this.age,
  //   required this.gender,
  //   required this.total_items_billed,
  //   required this.nationality,
  //   required this.city_id,
  //   required this.city_name,
  //   required this.area_id,
  //   required this.area_name,
  //   required this.store_id,
  //   required this.store_name,
  //   required this.store_type,
  //   required this.pos_id
  // });
  //
  // factory OperatorModel.fromJSON(var jsonData) {
  //
  //   return OperatorModel(
  //       username : jsonData['username'],
  //       first_name : jsonData['first_name'],
  //       second_name : jsonData['second_name'],
  //       age : jsonData['age'],
  //       gender : jsonData['gender'],
  //       total_items_billed : jsonData['total_items_billed'],
  //       nationality : jsonData['nationality'],
  //       city_id : jsonData['city_id'],
  //       city_name : jsonData['city_name'],
  //       area_id : jsonData['area_id'],
  //       area_name : jsonData['area_name'],
  //       store_id : jsonData['store_id'],
  //       store_name : jsonData['store_name'],
  //       store_type : jsonData['store_type'],
  //       pos_id : jsonData['pos_id']
  //   );
  // }
  //
  // factory OperatorModel.fromLocalDatabase(var hiveBox){
  //   return OperatorModel(
  //   username : hiveBox.get('username'),
  //   first_name : hiveBox.get('first_name'),
  //   second_name : hiveBox.get('second_name'),
  //   age : hiveBox.get('age'),
  //   gender : hiveBox.get('gender'),
  //   total_items_billed : hiveBox.get('total_items_billed'),
  //   nationality : hiveBox('nationality'),
  //   city_id : hiveBox('city_id'),
  //   city_name : hiveBox('city_name'),
  //   area_id : hiveBox('area_id'),
  //   area_name : hiveBox('area_name'),
  //   store_id : hiveBox('store_id'),
  //   store_name : hiveBox('store_name'),
  //   store_type : hiveBox('store_type'),
  //   pos_id : hiveBox('pos_id'),
  //   );
  // }


  Future<bool> login(String username, String password, String posId) async {

    var hiveBox = Hive.box(local_data);

    bool loggedIn = checkLoggedIn();
    if (!loggedIn) {
      try{
        var response = await http.post(Uri.parse(backendUrlPc + 'user'),
            body: {'username': username, 'password': password}
        );
        if(response.statusCode == 200){
          var decodedResponse = jsonDecode(response.body)[0] as Map<String, dynamic>;
          decodedResponse.forEach((key, value) {
            hiveBox.put(key, value);
          });
          print(hiveBox.get('username'));
          hiveBox.put('date', DateTime.now());
          return true;
        }
      }catch(err){
        print(err);
        return false;
      }
      return false;
    }else{
      hiveBox.put('date', DateTime.now());
      return true;
    }
  }
}
