import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_users/DBHelper/db_helper.dart';
import 'package:git_users/models/users.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {
  int sinceCount = 0;
  String userName = '';
  List<Users> _users = [];

  var dbHelper = DBHelper();

  List<Users> get users {
    return _users.where((element) => element.login.contains(userName)).toList();
  }

  void updateUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void deleteAll() {
    _users = [];
    sinceCount = 0;
    dbHelper.deleteAllRecords();
    notifyListeners();
  }

  fetchDB() async {}

  fetchUsers(bool firstLoad) async {
    var db = await dbHelper.db;
    if (db != null) {
      _users = await dbHelper.getUsers();
      if (_users.length == 0) {
        firstLoad = false;
      }
      var lastId = await dbHelper.getLastId();
      sinceCount = lastId == null ? 0 : lastId;
      notifyListeners();
    }
    if (!firstLoad) {
      var url = 'https://api.github.com/users?since=$sinceCount';
      var resp = await http.get(Uri.parse(url));
      List<Users> users = [];
      if (resp.statusCode == 200) {
        List<dynamic> usersJson = json.decode(resp.body);
        for (var userJson in usersJson) {
          users.add(Users.fromJson(userJson));
        }
      }
      if (users.length != 0) {
        _users.addAll(users);
        sinceCount = _users[_users.length - 1].id;
        notifyListeners();
        dbHelper.save(users);
      }
    }
  }
}
