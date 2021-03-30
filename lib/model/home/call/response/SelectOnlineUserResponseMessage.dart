class SelectOnlineUserResponseMessage {
  bool success;
  String messages;
  String roomNo;
  String id;
  String username;
  String status;
  String age;
  String email;
  String sex;
  String url;

  SelectOnlineUserResponseMessage(
      {this.success,
      this.messages,
      this.roomNo,
      this.id,
      this.username,
      this.status,
      this.age,
      this.email,
      this.sex,
      this.url});

  SelectOnlineUserResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    roomNo = json['room_no'];
    messages = json['Messages'];
    id = json['id'];
    username = json['username'];
    status = json['status'];
    age = json['age'];
    email = json['email'];
    sex = json['sex'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['room_no'] = this.roomNo;
    data['Messages'] = this.messages;
    data['id'] = this.id;
    data['username'] = this.username;
    data['status'] = this.status;
    data['age'] = this.age;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['url'] = this.url;
    return data;
  }
}
