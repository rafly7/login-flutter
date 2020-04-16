import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smm_project/blocs/root/bottom_nav_bloc.dart';
import 'package:smm_project/blocs/socket/connectivity_bloc.dart';
import 'package:smm_project/utils/constants.dart';
import 'package:smm_project/utils/style_constant.dart';
import 'package:smm_project/views/home/index_home.dart';
import 'package:smm_project/views/employes/index_employee.dart';
import 'package:smm_project/views/report/index_report.dart';

// class RootView extends StatefulWidget {
//   RootView({Key key}) : super(key: key);

//   static const ROUTE = "/home";

//   @override
//   _RootViewState createState() => _RootViewState();
// }

// class _RootViewState extends State<RootView> {
//   var _index = 0;

//   final List<Widget> _childrenViews = [
//     HomeView(),
//     EmployeeView()
//   ];

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (int index) {
//           setState(() {
//             _index = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text(
//               'Home'
//             )
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.accessibility),
//             title: Text(
//               'Employe'
//             ),
//           )
//         ],
//       ),
//       body: _childrenViews[_index]
//     );
//   }
// }

class RootView extends StatelessWidget {
  RootView({Key key}) : super(key: key);

  var indexNav;
  
  static const ROUTE = "/home";

  final List<Widget> _childrenViews = [
    ReportView(),
    HomeView(),
    EmployeeView()
  ];

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavigationBloc(),
        )
      ],
      child: BlocBuilder<BottomNavigationBloc, NumberIndex>(
        builder: (BuildContext context, NumberIndex state) {
          indexNav = state is BottomNavigationInitial ? 0 : (state is BottomNavigationSuccess ? state.result : Container());
          return BottomNav(childrenViews: _childrenViews, indexNav: indexNav);
        },
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key key,
    @required List<Widget> childrenViews,
    @required this.indexNav,
  }) : _childrenViews = childrenViews, super(key: key);

  final List<Widget> _childrenViews;
  final int indexNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          //margin: EdgeInsets.only(left: 12.0, bottom: 10.0),
          child: Material(
            elevation: 3.0,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () {}
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {}
                ),
                border: InputBorder.none
              )
            ),
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          // IconButton(
          //   alignment: Alignment.centerLeft,
          //   color: Colors.green,
          //   icon: Icon(Icons.check_circle),
          //   onPressed: () {}
          // ),
          InternetIndicator()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int number) {
          context.bloc<BottomNavigationBloc>().add(BottomNavigationEvent(number));
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            title: Text(
              'Report'
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home'
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            title: Text(
              'Employe'
            ),
          )
        ],
      ),
      body: _childrenViews[indexNav],
    );
  }
}

class InternetIndicator extends StatefulWidget {
  InternetIndicator({Key key}) : super(key: key);

  @override
  _InternetIndicatorState createState() => _InternetIndicatorState();
}

class _InternetIndicatorState extends State<InternetIndicator> {
  
  final bloc = ConnectivityBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: bloc.connectionSubject$,
      builder: (context, snapshot) {
        //EmployeeView(snapshot: snapshot);
        //print('-------------------${snapshot.hasData}---------------------');
        print('=============================${snapshot.hasData} ======= ${snapshot.data}');
        return Center(
          // child: snapshot.hasData &&
          //         snapshot.data == AppConnectivityStatus.ONLINE.name
            child: snapshot.hasData
              ? Icon(
                  Icons.signal_cellular_4_bar,
                  color: Color.fromRGBO(38, 163, 24, 50),
                )
              : Icon(
                  Icons.signal_cellular_off,
                  color: Colors.red,
                )
        );
      }
    );
  }
}