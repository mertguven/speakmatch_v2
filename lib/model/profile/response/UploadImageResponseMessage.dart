class UploadImageResponseMessage {
  bool success;
  String messages;
  String url;

  UploadImageResponseMessage({this.success, this.messages, this.url});

  UploadImageResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    messages = json['Messages'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Messages'] = this.messages;
    data['Url'] = this.url;
    return data;
  }
}
