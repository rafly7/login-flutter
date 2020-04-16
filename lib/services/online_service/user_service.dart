import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smm_project/models/user_model.dart';

class UserService {
  Dio dio = Dio();
  final _url = 'http://192.168.43.166:4000/user';

  getUser() async {
    final response = await dio.get('http://192.168.43.166:4000/user');
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

class Repository {
  final userApiProvider = UserService();

  Future<User> fetchAllUser() => userApiProvider.getUser();
}

class UserBloc {
  final _repository = Repository();
  final _userFetcher = PublishSubject<User>();
  
}