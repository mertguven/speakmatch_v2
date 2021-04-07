class TrackMeetTimeRequestMessage {
  String odaNo;
  int freezeTime;

  TrackMeetTimeRequestMessage({this.odaNo, this.freezeTime});

  TrackMeetTimeRequestMessage.fromJson(Map<String, dynamic> json) {
    odaNo = json['oda_no'];
    freezeTime = json['meetStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oda_no'] = this.odaNo;
    data['freezeTime'] = this.freezeTime;
    return data;
  }
}
