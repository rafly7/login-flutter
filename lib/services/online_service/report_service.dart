import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smm_project/utils/constants.dart';

class ReportService {
  Dio dio = Dio();
  //final _url = 'http://192.168.43.166:4000/user';

  getReport() async {
    final response = await dio.get('http://80.211.230.155:3001/report');
    print('${response.statusCode}');
    if(response.statusCode == 200) {
      List result = jsonDecode(jsonEncode(response.data));
      return result;
    } else {
      throw Exception('Error with ${response.statusCode}');
    }
  }
}