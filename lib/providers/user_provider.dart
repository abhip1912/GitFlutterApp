import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_users/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Map<int, User> _userInfo = {};

  Map<int, User> get userInfo {
    return {..._userInfo};
  }

  fetchUserInfo(String url) async {
    var resp = await http.get(Uri.parse(url));
    User user;
    if (resp.statusCode == 200) {
      user = User.fromJson(json.decode(resp.body));
      _userInfo.putIfAbsent(user.id, () => user);
      notifyListeners();
    }
  }
}
