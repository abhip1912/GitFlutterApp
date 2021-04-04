import 'package:flutter/material.dart';
import 'package:git_users/models/user.dart';

class UserInfo extends StatelessWidget {
  final User user;
  UserInfo(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user.name),
    );
  }
}
