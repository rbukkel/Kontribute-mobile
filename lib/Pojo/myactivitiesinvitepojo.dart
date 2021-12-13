class myactivitiesinvitepojo {
  bool success;
  String message;
  List<Result> result;

  myactivitiesinvitepojo({this.success, this.message, this.result});

  myactivitiesinvitepojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
  String receiverName;
  String receiverMobile;
  String senderId;
  String senderName;
  String senderProfilePic;
  String senderFacebookId;
  String receiverMessage;
  String receiverRequestPrice;
  String receiverEndDate;
  String receiverInvitationFrom;
  String receiverStatus;
  String receiverCreatedAt;

  Result(
      {this.id,
      this.receiverName,
      this.receiverMobile,
      this.senderId,
      this.senderName,
      this.senderProfilePic,
      this.senderFacebookId,
      this.receiverMessage,
      this.receiverRequestPrice,
      this.receiverEndDate,
      this.receiverInvitationFrom,
      this.receiverStatus,
      this.receiverCreatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverName = json['receiver_name'];
    receiverMobile = json['receiver_mobile'];
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    senderProfilePic = json['sender_profile_pic'];
    senderFacebookId = json['sender_facebook_id'];
    receiverMessage = json['receiver_message'];
    receiverRequestPrice = json['receiver_request_price'];
    receiverEndDate = json['receiver_end_date'];
    receiverInvitationFrom = json['receiver_invitation_from'];
    receiverStatus = json['receiver_status'];
    receiverCreatedAt = json['receiver_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiver_name'] = this.receiverName;
    data['receiver_mobile'] = this.receiverMobile;
    data['sender_id'] = this.senderId;
    data['sender_name'] = this.senderName;
    data['sender_profile_pic'] = this.senderProfilePic;
    data['sender_facebook_id'] = this.senderFacebookId;
    data['receiver_message'] = this.receiverMessage;
    data['receiver_request_price'] = this.receiverRequestPrice;
    data['receiver_end_date'] = this.receiverEndDate;
    data['receiver_invitation_from'] = this.receiverInvitationFrom;
    data['receiver_status'] = this.receiverStatus;
    data['receiver_created_at'] = this.receiverCreatedAt;
    return data;
  }
}