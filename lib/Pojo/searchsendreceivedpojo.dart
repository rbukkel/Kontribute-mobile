class searchsendreceivedpojo {
  bool status;
  List<Data> data;
  String message;

  searchsendreceivedpojo({this.status, this.data, this.message});

  searchsendreceivedpojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null)
    {
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
  int id;
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
  String createdAt;
  String updatedAt;
  String userId;

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
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.userId});

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
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }

}