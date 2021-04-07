class TrackMeetTimeResponseMessage {
  bool success;

  TrackMeetTimeResponseMessage({this.success});

  TrackMeetTimeResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    return data;
  }
}
