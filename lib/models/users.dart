import 'package:flutter/material.dart';
import 'package:git_users/DBHelper/users_db_helper.dart';

class Users with ChangeNotifier {
  String login;
  int id;
  String avatarUrl;
  String url;
  String type;
  String _notes = "";

  Users();

  var dbHelper = UsersDBHelper();

  void updateNote(String str) {
    _notes = str;
    print(_notes);
  }

  Future<String> userNote(int id) async {
    _notes = await dbHelper.getNote(id);
    return _notes;
  }

  Future<void> setNote(int id, String txt) async {
    await dbHelper.updateNote(id, txt);
    return;
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
