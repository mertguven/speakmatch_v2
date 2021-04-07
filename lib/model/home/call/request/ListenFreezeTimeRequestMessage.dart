class ListenFreezeTimeRequestMessage {
  String odaNo;

  ListenFreezeTimeRequestMessage({this.odaNo});

  ListenFreezeTimeRequestMessage.fromJson(Map<String, dynamic> json) {
    odaNo = json['oda_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oda_no'] = this.odaNo;
    return data;
  }
}
