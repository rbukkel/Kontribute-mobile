class request_sendpojo {
  bool status;
  List<Data> data;
  String message;

  request_sendpojo({this.status, this.data, this.message});

  request_sendpojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String id;
  String groupName;
  String postedDate;
  String target;
  String message;
  String amount;
  String groupMembers;
  String userId;
  String specialTerms;
  String post;
  String recieverId;
  String image;
  String name;
  String time;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;

  Data(
      {this.id,
        this.groupName,
        this.postedDate,
        this.target,
        this.message,
        this.amount,
        this.groupMembers,
        this.userId,
        this.specialTerms,
        this.post,
        this.recieverId,
        this.image,
        this.name,
        this.time,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    postedDate = json['posted_date'];
    target = json['target'];
    message = json['message'];
    amount = json['amount'];
    groupMembers = json['group_members'];
    userId = json['user_id'];
    specialTerms = json['special_terms'];
    post = json['post'];
    recieverId = json['reciever_id'];
    image = json['image'];
    name = json['name'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_name'] = this.groupName;
    data['posted_date'] = this.postedDate;
    data['target'] = this.target;
    data['message'] = this.message;
    data['amount'] = this.amount;
    data['group_members'] = this.groupMembers;
    data['user_id'] = this.userId;
    data['special_terms'] = this.specialTerms;
    data['post'] = this.post;
    data['reciever_id'] = this.recieverId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}