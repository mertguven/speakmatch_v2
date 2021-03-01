class ChangeUserInformationRequestMessage {
  String username;
  String sex;
  String age;
  String email;

  ChangeUserInformationRequestMessage(
      {this.username, this.sex, this.age, this.email});

  ChangeUserInformationRequestMessage.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    sex = json['sex'];
    age = json['age'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['email'] = this.email;
    return data;
  }
}
