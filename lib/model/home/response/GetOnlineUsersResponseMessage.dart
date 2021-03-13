class GetOnlineUsersResponseMessage {
  List<OnlineUsers> onlineUsers;
  bool success;

  GetOnlineUsersResponseMessage({this.onlineUsers, this.success});

  GetOnlineUsersResponseMessage.fromJson(Map<String, dynamic> json) {
    if (json['Online Users'] != null) {
      onlineUsers = <OnlineUsers>[];
      json['Online Users'].forEach((v) {
        onlineUsers.add(new OnlineUsers.fromJson(v));
      });
    }
    success = json['Success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlineUsers != null) {
      data['Online Users'] = this.onlineUsers.map((v) => v.toJson()).toList();
    }
    data['Success'] = this.success;
    return data;
  }
}

class OnlineUsers {
  String id;
  String username;
  String age;
  String email;
  String sex;
  String url;

  OnlineUsers(
      {this.id, this.username, this.age, this.email, this.sex, this.url});

  OnlineUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    age = json['age'];
    email = json['email'];
    sex = json['sex'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['age'] = this.age;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['url'] = this.url;
    return data;
  }
}
