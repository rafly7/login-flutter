import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:smm_project/blocs/socket/connectivity_bloc.dart';
import 'package:smm_project/models/user_model.dart';
import 'package:smm_project/services/local_service/local_service.dart';
import 'package:smm_project/services/online_service/department_service.dart';
import 'package:smm_project/services/online_service/report_service.dart';
import 'package:smm_project/services/online_service/user_service.dart';
import 'package:smm_project/utils/style_constant.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key key}) : super(key: key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final reportService = ReportService();
  final employeeId = TextEditingController();
  final bloc = ConnectivityBloc();

  LocalService local = LocalService();
  bool click = false;
  bool connect;

  Future<void> getReportList() async {
    var asd = await reportService.getReport();
    await local.deleteDB();
    await local.open();
    await local.addreportFirstOf(asd);
    //return await local.getAllDepartment();
  }

  Future<List<dynamic>> getReportListFirstOffline() async {
    await getReportList();
    print('ONLINE LIST');
    var getAll = await local.getAllReport();
    return getAll;
  }

  Future<List<dynamic>> getReportListEventOffline() async {
    print('OFFLINE LIST');
    var getAll = await local.getAllReport();
    return getAll;
  }

  Future<List<dynamic>> getReportListOfflineClick() async {
    var getAll = await local.getAllReport();
    return getAll;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getReportList().then((val) {
    //   print('SUCCESS GET REPORT LIST');
    // }).catchError((err) {
    //   print('ERROR GET REPORT LIST');
    // });
  }
  // Future getReport(String id, String data) async {
  //   await local.addDepartment(id, data);
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            height: 500,
            color: Color(0x4442BCF5),
            child: StreamBuilder<Object>(
              stream: bloc.connectionSubject$,
              builder: (context, snapshot1) {
                connect = snapshot1.hasData;
                print('========*======${snapshot1.data}');
                print('========*======${snapshot1.hasData}');
                print('========*======${snapshot1.connectionState}');
                return snapshot1.hasData
                    ? _listReportSync(getReportListFirstOffline().asStream())
                    : _listReportSync(getReportListEventOffline().asStream());
              },
            )
          ),
        ],
      ),
    );
  }

  Widget _listReportSync(Stream<List<dynamic>> stream) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
        List content = snapshot.data;
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.white70,
              thickness: 10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('id: '+content[index]['id']),
                  Text('employeeId: '+content[index]['employeeId']),
                  ListTile(
                    onTap: () {
                      this._scaffoldKey
                      .currentState
                      .showBottomSheet(
                        ((context) => _buildBottomSheet(context, 'Update Report', content[index]['id']))
                      );
                    },
                    leading: Icon(Icons.account_circle),
                    title: Text((content[index]['inTime']).toString()),
                    subtitle: Text(content[index]['outTime'].toString()),
                    trailing: Text((content[index]['dateReport']).toString()),
                  ),
                  content[index]['status'] == 'Y' ? Icon(Icons.check_box, color: Colors.green, size: 20)
                  : Icon(Icons.check_box, color: Colors.red, size: 20)
                ],
              ),
            );
          },
          itemCount: content.length,
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, String text, String id) {
    String intime = '08:00:00';
    return Container(
      height: 300,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(title: Text(text)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: intime
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save and refresh'),
              onPressed: () async {
                //var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10)
                print('UPDATE REPORT');
                if(connect) {
                  //local.updateReport(intime, 'Y', id)
                  print('Connect');
                } else {
                  print('NOT CONNECT');
                  // await local.updateReport(intime, 'N', id);
                }
                Navigator.pop(context);
              }
            ),
          )
        ],
      ),
    );
  }
}
