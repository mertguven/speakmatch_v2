class ChangePasswordResponseMessage {
  bool success;
  String messages;

  ChangePasswordResponseMessage({this.success, this.messages});

  ChangePasswordResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    messages = json['Messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Messages'] = this.messages;
    return data;
  }
}
