import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:smm_project/utils/constants.dart';

SocketIO soc;

class WsService {
  SocketIO socketIO;
  final Function callback;
  WsService({this.callback});
  connectSocket01() {
    try {
      socketIO = SocketIOManager()
          .createSocketIO(WS_HOST, "/", socketStatusCallback: callback);
      socketIO.destroy();
      socketIO.init();
      socketIO.connect();
      if(socketIO != null) {
        soc = socketIO;
        print('------------------ socket has connection $socketIO');
      } else {
        print('socket has not found ----------------------');
      }
    } catch (error) {
      print('xxx' + error.toString());
    }
  }
}