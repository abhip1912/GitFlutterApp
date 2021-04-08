import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  String login;
  int id;
  String avatarUrl;
  String url;
  String type;
  String _notes = "";

  Users();

  void updateNote(String str) {
    _notes = str;
    print(_notes);
  }

  String get userNote {
    return _notes;
  }

  Users.fromJson(Map<String, dynamic> jsonData) {
    login = jsonData['login'];
    id = jsonData['id'];
    avatarUrl = jsonData['avatar_url'];
    url = jsonData['url'];
    type = jsonData['type'];
  }

  Map<String, dynamic> toJson() {
    var jsonData = <String, dynamic>{
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'url': url,
      'type': type,
    };
    return jsonData;
  }
}
