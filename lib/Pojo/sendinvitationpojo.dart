class sendinvitationpojo {
  bool success;
  String shareLink;
  String message;

  sendinvitationpojo({this.success, this.shareLink, this.message});

  sendinvitationpojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    shareLink = json['share_link'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['share_link'] = this.shareLink;
    data['message'] = this.message;
    return data;
  }
}