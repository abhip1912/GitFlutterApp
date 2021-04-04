import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.bottomCenter,
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(height: 2.0),
        onChanged: (value) => print(value),
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
