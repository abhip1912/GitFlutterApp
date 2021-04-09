import 'package:flutter/material.dart';
import 'package:git_users/models/user_info.dart';
import 'package:git_users/models/users.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget {
  final UserInfo user;
  UserData(this.user);
  @override
  Widget build(BuildContext context) {
    return user == null
        ? Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ),
          )
        : Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Column(children: [
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Followers:${user.followers}",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Following:${user.following}",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 150,
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Id: "),
                            Text("Name: "),
                            Text("Email: "),
                            Text("Bio: "),
                            Text("Blog: "),
                            Text("Company: "),
                            Text("Location: "),
                            Text("PublicGits: "),
                            Text("PublicRepos: "),
                            Text("TwitterUserName: "),
                            Text("Hireable: "),
                          ],
                        ),
                        Column(
                          children: [
                            Text(user.id.toString()),
                            Text(user.name.toString()),
                            Text(user.email.toString()),
                            Text(user.bio.toString()),
                            Text(user.blog.toString()),
                            Text(user.company.toString()),
                            Text(user.location.toString()),
                            Text(user.publicGists.toString()),
                            Text(user.publicRepos.toString()),
                            Text(user.twitterUsername.toString()),
                            Text(user.hireable.toString()),
                          ],
                        ),
                      ],
                    )),
                    decoration: BoxDecoration(border: Border.all()),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: Provider.of<Users>(context, listen: false)
                      .userNote(user.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return TextFormField(
                        decoration:
                            InputDecoration(hintText: "Save Your Note..."),
                        initialValue: snapshot.data,
                        maxLines: 5,
                        onChanged: (value) =>
                            Provider.of<Users>(context, listen: false)
                                .setNote(user.id, value),
                        keyboardType: TextInputType.multiline,
                      );
                    }
                  },
                ),
              ),
            ],
          );
  }
}
