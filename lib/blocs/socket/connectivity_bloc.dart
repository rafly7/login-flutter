import 'package:rxdart/rxdart.dart';
import 'package:smm_project/services/socket/notification.dart';
import 'package:smm_project/services/socket/ws_service.dart';
import 'package:smm_project/utils/constants.dart';

class ConnectivityBloc {
  var status = AppConnectivityStatus.OFFLINE.name;
  final localNotif = LocalNotificationService();

  final _connectionSubject =
      BehaviorSubject<String>.seeded(AppConnectivityStatus.OFFLINE.name);

  Stream<String> get connectionSubject$ => _connectionSubject.stream;

  Sink<String> get connectionStatusUpdate => _connectionSubject.sink;

  _notificationCall(data, message) {
    if (status != data.toString()) {
      localNotif.showNotificationWithoutSound(message);
      status = data.toString();
    }
  }

  _socketStatus(dynamic data) {
    if (data.toString() == WsConnectivityStatus.connect.name) {
      connectionStatusUpdate.add(AppConnectivityStatus.ONLINE.name);
      _notificationCall(data, AppConnectivityStatus.ONLINE.name);
    } else if (data.toString() == WsConnectivityStatus.connect_error.name) {
      connectionStatusUpdate.add(AppConnectivityStatus.OFFLINE.name);
      _notificationCall(data, AppConnectivityStatus.OFFLINE.name);
    }
  }

  ConnectivityBloc() {
    WsService(callback: _socketStatus)..connectSocket01();
  }
}
