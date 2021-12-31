class FollowinglistPojo {
  bool success;
  String message;
  List<Results> result;

  FollowinglistPojo({this.success, this.message, this.result});

  FollowinglistPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Results>();
      json['result'].forEach((v) {
        result.add(new Results.fromJson(v));
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

class Results {
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
  String connectionId;
  bool selectall;

  Results(
      {
        this.id,
        this.senderId,
        this.receiverId,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId,
        this.connectionId,
        this.selectall});

  Results.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else
    {
      id = json['id'];
    }

    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else
    {
      senderId = json['sender_id'];
    }

    if(json['receiver_id'] is int)
    {
      receiverId = json['receiver_id'].toString();
    }
    else
    {
      receiverId = json['receiver_id'];
    }

    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];

    if(json['connection_id'] is int)
    {
      connectionId = json['connection_id'].toString();
    }
    else
    {
      connectionId = json['connection_id'];
    }
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
    data['connection_id'] = this.connectionId;
    return data;
  }
}