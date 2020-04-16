const WS_HOST = 'http://80.211.230.155:3001';
enum AppConnectivityStatus { ONLINE, OFFLINE }

extension AppConnectivityStatusExtension on AppConnectivityStatus {
  String get name {
    switch (this) {
      case AppConnectivityStatus.ONLINE:
        return 'ONLINE';
      case AppConnectivityStatus.OFFLINE:
        return 'OFFLINE';
      default:
        return '';
    }
  }
}

enum WsConnectivityStatus { connect, connect_error }

extension WsConnectivityStatusExtension on WsConnectivityStatus {
  String get name {
    switch (this) {
      case WsConnectivityStatus.connect:
        return 'connect';
      case WsConnectivityStatus.connect_error:
        return 'connect_error';
      default:
        return '';
    }
  }
}

