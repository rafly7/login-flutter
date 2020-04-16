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
import 'package:smm_project/services/online_service/user_service.dart';
import 'package:smm_project/utils/style_constant.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key key}) : super(key: key);

  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final departmentService = DepartmentService();
  final departmentId = TextEditingController();
  final departmentName = TextEditingController();
  final bloc = ConnectivityBloc();
  LocalService local = LocalService();
  bool click = false;
  Future<void> getDepartmentList() async {
    var asd = await departmentService.getDepartment();
    await local.deleteDB();
    await local.open();
    await local.addDepartmentFirstOf(asd);
    //return await local.getAllDepartment();
  }

  Future<List<dynamic>> getDepartmentListFirstOffline() async {
    await getDepartmentList();
    var getAll = await local.getAllDepartment();
    return getAll;
  }

  Future<List<dynamic>> getDepartmentListOfflineClick() async {
    var getAll = await local.getAllDepartment();
    return getAll;
  }

  Future addDepartment(String id, String data) async {
    await local.addDepartment(id, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.blue,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  color: Colors.green ,
                  icon: Icon(Icons.add_box),
                  iconSize: 70,
                  onPressed: () {
                    this._scaffoldKey
                    .currentState
                    .showBottomSheet(
                      ((context) => _buildBottomSheet(context, 'Add Department'))
                    );
                  }
                ),
                IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.autorenew),
                  iconSize: 70,
                  onPressed: () {
                    
                  }
                ),
                IconButton(
                  color: Colors.amber,
                  icon: Icon(Icons.edit),
                  iconSize: 70,
                  onPressed: () {
                    this._scaffoldKey
                    .currentState
                    .showBottomSheet(
                      ((context) => _buildBottomSheet(context, 'Update Department'))
                    );
                  }
                ),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.cancel),
                  iconSize: 70,
                  onPressed: () {
                    this._scaffoldKey
                    .currentState
                    .showBottomSheet(
                      ((context) => _buildBottomSheet(context, 'Update Department'))
                    );
                  }
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            height: 415,
            color: Color(0x4442BCF5),
            child: StreamBuilder<Object>(
              stream: bloc.connectionSubject$,
              builder: (context, snapshot1) {
                return snapshot1.hasData ? StreamBuilder<Object>(
                  stream: click == true ? getDepartmentListOfflineClick().asStream() : getDepartmentListFirstOffline().asStream(),
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
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(Icons.account_circle),
                            title: Text((content[index]['departmentId']).toString()),
                            subtitle: Text(content[index]['departmentName']),
                            trailing: Icon(Icons.check_box, color: Colors.green),
                          ),
                        );
                      },
                      itemCount: content.length,
                    );
                  },
                ) : Container();
              },
            )
          ),
        ],
      ),
      // child: RaisedButton(
      //   onPressed: () async {
      //     //User sad;
      //     final response = await Dio().get('http://192.168.43.166:4000/user');
      //     if(response.statusCode == 200) {
      //       final result = User.fromJson(jsonDecode(jsonEncode(response.data))[0]).userId;
      //       print(result);
      //     }
      //   },
      // ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, String text) {
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
              decoration: inputDecoration,
              controller: departmentId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: inputDecoration,
              controller: departmentName,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save and refresh'),
              onPressed: () async {
                //var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10)
                print('masukkkkkkkkkkkkkkkk');
                addDepartment(departmentId.text, departmentName.text);
                setState(() {
                  click = true;
                });
                Navigator.pop(context);
                departmentId.clear();
                departmentName.clear();
                try {
                  var str = r'$2a$10$1XPZSc3EhWR0sjWIJmDtMuijsr5Ax5VrtIh8FkrjA095Esbb3juYe';
                  var res = new DBCrypt().checkpw("123456", str);
                  print('===================$res');
                } on PlatformException {
                  print('error');
                }
              }
            ),
          )
        ],
      ),
    );
  }
}

// FutureBuilder(
//               future: click == true ? getDepartmentListOfflineClick() : getDepartmentListFirstOffline(),
//               builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
//                 if(!snapshot.hasData)
//                   return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
//                 List content =  snapshot.data;
//                 return ListView.separated(
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       color: Colors.white70,
//                       thickness: 10,
//                     );
//                   },
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListTile(
//                         onTap: () {},
//                         leading: Icon(Icons.account_circle),
//                         title: Text((content[index]['departmentId']).toString()),
//                         subtitle: Text(content[index]['departmentName']),
//                         trailing: Icon(Icons.check_box, color: Colors.green),
//                       ),
//                     );
//                   },
//                   itemCount: content.length,
//                 );
//               },
//             ),

//$2a$10$1XPZSc3EhWR0sjWIJmDtMuijsr5Ax5VrtIh8FkrjA095Esbb3juYe