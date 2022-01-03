class commisionpojo {
  bool success;
  Commisiondata commisiondata;
  String message;

  commisionpojo({this.success, this.commisiondata, this.message});

  commisionpojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    commisiondata = json['commisiondata'] != null
    ? new Commisiondata.fromJson(json['commisiondata'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.commisiondata != null) {
      data['commisiondata'] = this.commisiondata.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Commisiondata {
  int id;
  int receiverCommision;
  int senderCommision;
  String postedDate;
  String createdAt;
  String updatedAt;

  Commisiondata(
      {this.id,
      this.receiverCommision,
      this.senderCommision,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  Commisiondata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverCommision = json['receiver_commision'];
    senderCommision = json['sender_commision'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiver_commision'] = this.receiverCommision;
    data['sender_commision'] = this.senderCommision;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}