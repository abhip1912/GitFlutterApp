import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:git_users/providers/users_provider.dart';
import 'package:git_users/views/homePage/widgets/check_network.dart';
import 'package:git_users/views/homePage/widgets/list_item.dart';
import 'package:git_users/views/homePage/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    CheckNetwork().checkConnection(context);
    setState(() {
      isLoading = true;
      _loadMore(true);
    });
  }

  @override
  void dispose() {
    CheckNetwork().listener.cancel();
    super.dispose();
  }

  Future _loadMore(bool firstLoad) async {
    var connection = await DataConnectionChecker().hasConnection;
    if (connection) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchUsers(firstLoad);
    } else {
      Provider.of<UsersProvider>(context, listen: false).fetchDb();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SearchBar(),
              IconButton(
                  onPressed: () =>
                      Provider.of<UsersProvider>(context, listen: false)
                          .deleteAll(),
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (users.userName == "" &&
                        !isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadMore(false);
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => ListItem(users.users[i]),
                    itemCount: users.users.length,
                  ),
                ),
              ),
              Container(
                height: isLoading ? 50.0 : 0.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
