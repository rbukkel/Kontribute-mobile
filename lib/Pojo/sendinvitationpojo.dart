class sendinvitationpojo {
  bool status;
  String message;
  String invitationlink;

  sendinvitationpojo({this.status, this.message, this.invitationlink});

  sendinvitationpojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    invitationlink = json['invitationlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['invitationlink'] = this.invitationlink;
    return data;
  }
}