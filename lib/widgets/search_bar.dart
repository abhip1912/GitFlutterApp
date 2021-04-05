import 'package:flutter/material.dart';
import 'package:git_users/providers/users_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.bottomCenter,
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(height: 2.0),
        onChanged: (value) => Provider.of<UsersProvider>(context, listen: false)
            .updateUserName(value),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(36),
            ),
          ),
          prefixIcon: Icon(Icons.search),
          hintText: 'Enter a search term',
        ),
      ),
    );
  }
}
