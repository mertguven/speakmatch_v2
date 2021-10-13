class AuthenticationResponseModel {
  String displayName;
  String email;
  bool emailVerified;
  DateTime creationTime;
  DateTime lastSignInTime;
  String uid;

  AuthenticationResponseModel(
      {this.displayName,
      this.email,
      this.emailVerified,
      this.creationTime,
      this.lastSignInTime,
      this.uid});

  AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    creationTime = json['creationTime'];
    lastSignInTime = json['lastSignInTime'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['creationTime'] = this.creationTime;
    data['lastSignInTime'] = this.lastSignInTime;
    data['uid'] = this.uid;
    return data;
  }
}
