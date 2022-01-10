class follow_Request_updatePojo {
  bool success;
  String message;
  Result result;

  follow_Request_updatePojo({this.success, this.message, this.result});

  follow_Request_updatePojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  String senderId;
  String receiverId;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
      this.senderId,
      this.receiverId,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];

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
    return data;
  }
}