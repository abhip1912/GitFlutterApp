import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String type;
  bool siteAdmin;
  String name;
  String company;
  String blog;
  String location;
  dynamic email;
  dynamic hireable;
  dynamic bio;
  String twitterUsername;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  DateTime createdAt;
  DateTime updatedAt;
  String _note = "";

  // User({
  //   this.login,
  //   this.id,
  //   this.nodeId,
  //   this.avatarUrl,
  //   this.type,
  //   this.siteAdmin,
  //   this.name,
  //   this.company,
  //   this.blog,
  //   this.location,
  //   this.email,
  //   this.hireable,
  //   this.bio,
  //   this.twitterUsername,
  //   this.publicRepos,
  //   this.publicGists,
  //   this.followers,
  //   this.following,
  //   this.createdAt,
  //   this.updatedAt,
  // });

  void updateNote(String txt) {
    _note = txt;
  }

  String get note => _note;

  UserInfo.fromJson(Map<String, dynamic> jsonData) {
    login = jsonData["login"];
    id = jsonData["id"];
    nodeId = jsonData["node_id"];
    avatarUrl = jsonData["avatar_url"];
    type = jsonData["type"];
    siteAdmin = jsonData["site_admin"];
    name = jsonData["name"];
    company = jsonData["company"];
    blog = jsonData["blog"];
    location = jsonData["location"];
    email = jsonData["email"];
    hireable = jsonData["hireable"];
    bio = jsonData["bio"];
    twitterUsername = jsonData["twitter_username"];
    publicRepos = jsonData["public_repos"];
    publicGists = jsonData["public_gists"];
    followers = jsonData["followers"];
    following = jsonData["following"];
    createdAt = DateTime.parse(jsonData["created_at"]);
    updatedAt = DateTime.parse(jsonData["updated_at"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "login": login,
      "id": id,
      "node_id": nodeId,
      "avtarUrl": avatarUrl,
      "type": type,
      "site_admin": siteAdmin,
      "name": name,
      "company": company,
      "blog": blog,
      "location": location,
      "email": email,
      "hireable": hireable,
      "bio": bio,
      "twitter_username": twitterUsername,
      "public_repos": publicRepos,
      "public_gists": publicGists,
      "followers": followers,
      "following": following,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "note": _note,
    };
    return map;
  }
}
