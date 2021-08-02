class sendindividualHistory {
  int status;
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
  int id;
  String name;
  String amount;
  String message;
  String image;
  String userId;
  String userProfile;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.name,
        this.amount,
        this.message,
        this.image,
        this.userId,
        this.userProfile,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    message = json['message'];
    image = json['image'];
    userId = json['user_id'];
    userProfile = json['user_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['user_profile'] = this.userProfile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}