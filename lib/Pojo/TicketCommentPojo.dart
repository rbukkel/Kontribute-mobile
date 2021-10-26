class TicketCommentPojo {
  bool success;
  Commentsdata commentsdata;
  String message;

  TicketCommentPojo({this.success, this.commentsdata, this.message});

  TicketCommentPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    commentsdata = json['commentsdata'] != null
        ? new Commentsdata.fromJson(json['commentsdata'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.commentsdata != null) {
      data['commentsdata'] = this.commentsdata.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Commentsdata {
  String ticketId;
  String comment;
  String userId;
  String postedDate;
  String updatedAt;
  String createdAt;
  int id;

  Commentsdata(
      {this.ticketId,
      this.comment,
      this.userId,
      this.postedDate,
      this.updatedAt,
      this.createdAt,
      this.id});

  Commentsdata.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    comment = json['comment'];
    userId = json['user_id'];
    postedDate = json['posted_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['posted_date'] = this.postedDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}