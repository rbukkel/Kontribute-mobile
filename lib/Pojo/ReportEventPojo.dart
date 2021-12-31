class ReportEventPojo {
  bool success;
  String message;
  Commentsdata commentsdata;

  ReportEventPojo({this.success, this.message, this.commentsdata});

  ReportEventPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    commentsdata = json['commentsdata'] != null
        ? new Commentsdata.fromJson(json['commentsdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.commentsdata != null) {
      data['commentsdata'] = this.commentsdata.toJson();
    }
    return data;
  }
}

class Commentsdata {
  String eventId;
  String comments;
  String userId;
  int giftId;
  String updatedAt;
  String createdAt;
  int id;

  Commentsdata(
      {this.eventId,
      this.comments,
      this.userId,
      this.giftId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Commentsdata.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    comments = json['comments'];
    userId = json['user_id'];
    giftId = json['gift_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['comments'] = this.comments;
    data['user_id'] = this.userId;
    data['gift_id'] = this.giftId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}