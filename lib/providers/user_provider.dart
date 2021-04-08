import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_users/models/user_info.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Map<int, UserInfo> _userInfo = {};

  Map<int, UserInfo> get userInfo {
    return {..._userInfo};
  }

  fetchUserInfo(String url) async {
    var resp = await http.get(Uri.parse(url));
    UserInfo user;
    if (resp.statusCode == 200) {
      user = UserInfo.fromJson(json.decode(resp.body));
      _userInfo.putIfAbsent(user.id, () => user);
      notifyListeners();
    }
  }
}
