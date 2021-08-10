class searchsendreceivedpojo {
  String message;
  bool status;
  List<ResultPush> resultPush;

  searchsendreceivedpojo({this.message, this.status, this.resultPush});

  searchsendreceivedpojo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['result_push'] != null) {
      resultPush = new List<ResultPush>();
      json['result_push'].forEach((v) {
        resultPush.add(new ResultPush.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.resultPush != null) {
      data['result_push'] = this.resultPush.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultPush {
  String id;
  String name;
  String groupName;
  String postedDate;
  String target;
  String groupMembers;
  String specialTerms;
  String post;
  String amount;
  String time;
  String message;
  String image;
  String recieverId;
  String paymentStatus;
  String dateStatus;
  String createdAt;
  String updatedAt;
  String userId;
  String fullName;
  String profilePic;

  ResultPush(
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
        this.paymentStatus,
        this.dateStatus,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.fullName,
        this.profilePic});

  ResultPush.fromJson(Map<String, dynamic> json) {
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
    paymentStatus = json['payment_status'];
    dateStatus = json['date_status'];
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
    data['payment_status'] = this.paymentStatus;
    data['date_status'] = this.dateStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}