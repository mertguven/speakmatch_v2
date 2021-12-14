import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponseModel {
  String displayName;
  String email;
  bool emailVerified;
  DateTime creationTime;
  DateTime lastSignInTime;
  String gender;
  String uid;
  String imageUrl;
  bool isVip;

  UserResponseModel(
      {this.displayName,
      this.email,
      this.gender,
      this.emailVerified,
      this.creationTime,
      this.lastSignInTime,
      this.uid,
      this.imageUrl,
      this.isVip});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    gender = json['gender'];
    emailVerified = json['emailVerified'];
    creationTime = (json['creationTime'] as Timestamp).toDate();
    lastSignInTime = (json['lastSignInTime'] as Timestamp).toDate();
    uid = json['uid'];
    isVip = json['isVip'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['imageUrl'] = this.imageUrl ??
        "https://firebasestorage.googleapis.com/v0/b/speakmatch-30ca9.appspot.com/o/user.png?alt=media&token=6c742266-21ba-4dab-b30e-086152cdaa08";
    data['creationTime'] = Timestamp.fromDate(this.creationTime);
    data['lastSignInTime'] = Timestamp.fromDate(this.lastSignInTime);
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['emailVerified'] = this.emailVerified;
    data['isVip'] = this.isVip;
    return data;
  }
}
