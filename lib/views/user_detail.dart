import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:git_users/providers/user_provider.dart';
import 'package:git_users/widgets/user_info.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatefulWidget {
  static final routeName = '/user-detail';

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  var _isInit = true;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final Users user = ModalRoute.of(context).settings.arguments;
      await Provider.of<UserProvider>(context).fetchUserInfo(user.url);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Users user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                user.avatarUrl,
                fit: BoxFit.cover,
              ),
            ),
            Consumer<UserProvider>(
                builder: (_, data, ch) => UserInfo(data.userInfo[user.id])),
          ],
        ),
      ),
    );
  }
}
