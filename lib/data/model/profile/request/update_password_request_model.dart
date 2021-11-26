class UpdatePasswordRequestModel {
  String oldPassword;
  String newPassword;

  UpdatePasswordRequestModel({this.newPassword, this.oldPassword});

  UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    newPassword = json['newPassword'];
    oldPassword = json['oldPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newPassword'] = this.newPassword;
    data['oldPassword'] = this.oldPassword;
    return data;
  }
}
