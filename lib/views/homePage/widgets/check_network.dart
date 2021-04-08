import 'dart:async';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class CheckNetwork {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

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
        internetStatus = "You are disconnected to the Internet. ";
        contentmessage = "Please check your internet connection";
        _showDialog(internetStatus, contentmessage, context);
      } else {}
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
