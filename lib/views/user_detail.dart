import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:git_users/providers/user_provider.dart';
import 'package:git_users/widgets/user_info.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatelessWidget {
  static final routeName = '/user-detail';
  @override
  Widget build(BuildContext context) {
    final Users user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              user.avatarUrl,
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder(
            future: Provider.of<UserProvider>(context).fetchUserInfo(user.url),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<UserProvider>(
                    builder: (_, data, ch) => UserInfo(data.userInfo[user.id])),
          )
        ],
      ),
    );
  }
}
