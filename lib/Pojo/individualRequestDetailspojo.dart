class individualRequestDetailspojo {
  bool status;
  Data data;
  String message;

  individualRequestDetailspojo({this.status, this.data, this.message});

  individualRequestDetailspojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String id;
  String name;
  Null groupName;
  Null postedDate;
  Null target;
  Null groupMembers;
  Null specialTerms;
  Null post;
  String amount;
  String time;
  String message;
  String image;
  String recieverId;
  String createdAt;
  String updatedAt;
  String userId;
  String fullName;
  String profilePic;

  Data(
      {this.id,
      this.name,
      this.groupName,
      this.postedDate,
      this.target,
      this.groupMembers,
      this.specialTerms,
      this.post,
      this.amount,
      this.time,
      this.message,
      this.image,
      this.recieverId,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fullName,
      this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    groupName = json['group_name'];
    postedDate = json['posted_date'];
    target = json['target'];
    groupMembers = json['group_members'];
    specialTerms = json['special_terms'];
    post = json['post'];
    amount = json['amount'];
    time = json['time'];
    message = json['message'];
    image = json['image'];
    recieverId = json['reciever_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['group_name'] = this.groupName;
    data['posted_date'] = this.postedDate;
    data['target'] = this.target;
    data['group_members'] = this.groupMembers;
    data['special_terms'] = this.specialTerms;
    data['post'] = this.post;
    data['amount'] = this.amount;
    data['time'] = this.time;
    data['message'] = this.message;
    data['image'] = this.image;
    data['reciever_id'] = this.recieverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}