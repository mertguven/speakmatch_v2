class ListenFreezeTimeResponseMessage {
  String freezeTime;

  ListenFreezeTimeResponseMessage({this.freezeTime});

  ListenFreezeTimeResponseMessage.fromJson(Map<String, dynamic> json) {
    freezeTime = json['freezeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freezeTime'] = this.freezeTime;
    return data;
  }
}
