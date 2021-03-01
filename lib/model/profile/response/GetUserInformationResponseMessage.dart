class GetUserInformationResponseMessage {
  bool success;
  String id;
  String username;
  bool active;
  String age;
  String email;
  String sex;
  String url;
  String createDate;

  GetUserInformationResponseMessage(
      {this.success,
      this.id,
      this.username,
      this.active,
      this.age,
      this.email,
      this.sex,
      this.url,
      this.createDate});

  GetUserInformationResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    id = json['id'];
    username = json['username'];
    active = json['active'];
    age = json['age'];
    email = json['email'];
    sex = json['sex'];
    url = json['url'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['id'] = this.id;
    data['username'] = this.username;
    data['active'] = this.active;
    data['age'] = this.age;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['url'] = this.url;
    data['create_date'] = this.createDate;
    return data;
  }
}
