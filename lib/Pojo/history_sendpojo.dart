class history_sendpojo {
  bool status;
  List<Data> data;
  String message;

  history_sendpojo({this.status, this.data, this.message});

  history_sendpojo.fromJson(Map<String, dynamic> json) {
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
  String name;
  String amount;
  String message;
  String image;
  String groupName;
  String time;
  String post;
  String specialTerms;
  String groupMembers;
  String target;
  String postedDate;
  String userId;
  String recieverId;
  String dateStatus;
  String paymentStatus;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;

  Data(
      {this.id,
        this.name,
        this.amount,
        this.message,
        this.image,
        this.groupName,
        this.time,
        this.post,
        this.specialTerms,
        this.groupMembers,
        this.target,
        this.postedDate,
        this.userId,
        this.recieverId,
        this.dateStatus,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    message = json['message'];
    image = json['image'];
    groupName = json['group_name'];
    time = json['time'];
    post = json['post'];
    specialTerms = json['special_terms'];
    groupMembers = json['group_members'];
    target = json['target'];
    postedDate = json['posted_date'];
    userId = json['user_id'];
    recieverId = json['reciever_id'];
    dateStatus = json['date_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['image'] = this.image;
    data['group_name'] = this.groupName;
    data['time'] = this.time;
    data['post'] = this.post;
    data['special_terms'] = this.specialTerms;
    data['group_members'] = this.groupMembers;
    data['target'] = this.target;
    data['posted_date'] = this.postedDate;
    data['user_id'] = this.userId;
    data['reciever_id'] = this.recieverId;
    data['date_status'] = this.dateStatus;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}