class ForgotPasswordResponseModel {
  bool success;

  ForgotPasswordResponseModel({this.success});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}
