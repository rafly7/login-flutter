import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smm_project/models/department_model.dart';

class DepartmentService {
  Dio dio = Dio();
  //final _url = 'http://192.168.43.166:4000/user';

  getDepartment() async {
    final response = await dio.get('http://192.168.43.166:4000/department');
    //print("=============getUser");
    //print(response);
    print('---------------${response.statusCode}');
    if(response.statusCode == 200) {
      List result = jsonDecode(jsonEncode(response.data));
//      final result = userFromJson(response.data);
      //return result;
      //print('======================$result');
      return result;
    } else {
      throw Exception('Error with ${response.statusCode}');
    }
  }
}