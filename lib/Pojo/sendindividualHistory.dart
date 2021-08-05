class sendindividualHistory {
  bool status;
  List<Data> data;
  String message;

  sendindividualHistory({this.status, this.data, this.message});

  sendindividualHistory.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String recieverId;
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
        this.userId,
        this.recieverId,
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
    userId = json['user_id'];
    recieverId = json['reciever_id'];
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
    data['user_id'] = this.userId;
    data['reciever_id'] = this.recieverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}