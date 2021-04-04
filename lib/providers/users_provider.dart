import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {
  List<Users> _users = [];

  List<Users> get users {
    return [..._users];
  }

  fetchUsers() async {
    var url = 'https://api.github.com/users?since=0';
    var resp = await http.get(Uri.parse(url));
    List<Users> users = [];
    if (resp.statusCode == 200) {
      List<dynamic> usersJson = json.decode(resp.body);
      for (var userJson in usersJson) {
        users.add(Users.fromJson(userJson));
      }
    }
    _users = users;
    notifyListeners();
  }
}
