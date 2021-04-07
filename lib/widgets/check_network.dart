import 'dart:async';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class CheckNetwork with ChangeNotifier {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";
  bool _connection;

  Future<bool> get connection async {
    _connection = await DataConnectionChecker().hasConnection;
    return _connection;
  }

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]);
        });
  }

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      if (status == DataConnectionStatus.disconnected) {
        _connection = false;
        internetStatus = "You are disconnected to the Internet. ";
        contentmessage = "Please check your internet connection";
        _showDialog(internetStatus, contentmessage, context);
      } else {
        _connection = true;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
