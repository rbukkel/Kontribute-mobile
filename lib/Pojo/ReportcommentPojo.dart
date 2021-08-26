class ReportcommentPojo {
  bool success;
  Commentsdata commentsdata;
  String message;

  ReportcommentPojo({this.success, this.commentsdata, this.message});

  ReportcommentPojo.fromJson(Map<String, dynamic> json) {
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
  String projectId;
  String comments;
  String userId;
  int giftId;
  String updatedAt;
  String createdAt;
  int id;

  Commentsdata(
      {this.projectId,
      this.comments,
      this.userId,
      this.giftId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Commentsdata.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    comments = json['comments'];
    userId = json['user_id'];
    giftId = json['gift_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['comments'] = this.comments;
    data['user_id'] = this.userId;
    data['gift_id'] = this.giftId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}