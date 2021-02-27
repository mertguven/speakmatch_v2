class GetUserInformationResponseMessage {
  bool success;
  String id;
  String username;
  String recordDate;

  GetUserInformationResponseMessage(
      {this.success, this.id, this.username, this.recordDate});

  GetUserInformationResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    id = json['id'];
    username = json['username'];
    recordDate = json['record_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['id'] = this.id;
    data['username'] = this.username;
    data['record_date'] = this.recordDate;
    return data;
  }
}
