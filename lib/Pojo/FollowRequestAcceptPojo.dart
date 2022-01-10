class FollowRequestAcceptPojo {
  bool success;
  String message;
  List<Result> result;

  FollowRequestAcceptPojo({this.success, this.message, this.result});

  FollowRequestAcceptPojo.fromJson(Map<String, dynamic> json) {
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
  String senderId;
  String receiverId;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  Result(
      {this.id,
        this.senderId,
        this.receiverId,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId});

  Result.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else{
      senderId = json['sender_id'];
    }

    if(json['receiver_id'] is int)
    {
      receiverId = json['receiver_id'].toString();
    }
    else{
      receiverId = json['receiver_id'];
    }

    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    return data;
  }
}