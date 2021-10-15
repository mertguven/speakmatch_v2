import 'package:cloud_firestore/cloud_firestore.dart';

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
    creationTime = (json['creationTime'] as Timestamp).toDate();
    // DateTime.parse(json['creationTime'].toString());
    lastSignInTime = (json['lastSignInTime'] as Timestamp).toDate();
    // DateTime.parse(json['lastSignInTime'].toString());
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['creationTime'] = Timestamp.fromDate(this.creationTime);
    data['lastSignInTime'] = Timestamp.fromDate(this.lastSignInTime);
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    return data;
  }
}
