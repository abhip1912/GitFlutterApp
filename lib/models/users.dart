class Users {
  String login;
  int id;
  String avatarUrl;
  String url;
  String type;

  // Users({
  //   @required this.login,
  //   @required this.id,
  //   @required this.avatarUrl,
  //   @required this.type,
  // });

  Users.fromJson(Map<String, dynamic> jsonData) {
    login = jsonData['login'];
    id = jsonData['id'];
    avatarUrl = jsonData['avatar_url'];
    url = jsonData['url'];
    type = jsonData['type'];
  }

  Map<String, dynamic> toJson() {
    var jsonData = <String, dynamic>{
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'url': url,
      'type': type,
    };
    return jsonData;
  }
}
