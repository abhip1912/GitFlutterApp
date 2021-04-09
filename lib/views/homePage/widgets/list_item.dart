import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:git_users/views/userDetailsPage/user_detail.dart';
import 'package:provider/provider.dart';

class ListItem extends StatefulWidget {
  final Users user;
  ListItem(this.user);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  var userNote = '';

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final String str =
        await Provider.of<Users>(context).userNote(widget.user.id);
    setState(() {
      userNote = str;
    });
  }

  bool isUserNoteEmpty(String str) {
    if (str.length > 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(UserDetail.routeName, arguments: widget.user),
        child: Card(
          child: ListTile(
            trailing: FutureBuilder(
              future: Provider.of<Users>(context).userNote(widget.user.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Icon(null);
                } else {
                  if (isUserNoteEmpty(snapshot.data)) {
                    return Icon(Icons.note);
                  }
                  return Icon(null);
                }
              },
            ),
            title: Text(widget.user.login),
            subtitle: Text("${widget.user.id}-${widget.user.type}"),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.user.avatarUrl),
            ),
          ),
        ),
      ),
    );
  }
}
