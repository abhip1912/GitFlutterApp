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

  void fetchDB() async {
    _users = await dbHelper.getUsers();
    print(_users);
    notifyListeners();
  }

  Future fetchUsers() async {
    fetchDB();
    try {
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
    } catch (e) {
      print("Error" + e);
    }
  }
}
