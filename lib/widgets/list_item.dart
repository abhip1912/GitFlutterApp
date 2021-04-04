import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:git_users/views/user_detail.dart';

class ListItem extends StatelessWidget {
  final Users user;
  ListItem(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(UserDetail.routeName, arguments: user),
        child: Card(
          child: ListTile(
            title: Text(user.login),
            subtitle: Text("${user.id}-${user.type}"),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
        ),
      ),
    );
  }
}
