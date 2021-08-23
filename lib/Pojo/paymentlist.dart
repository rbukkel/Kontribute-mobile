class paymentlist {
  bool success;
  String message;
  Paymentdetails paymentdetails;

  paymentlist({this.success, this.message, this.paymentdetails});

  paymentlist.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    paymentdetails = json['paymentdetails'] != null
        ? new Paymentdetails.fromJson(json['paymentdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.paymentdetails != null) {
      data['paymentdetails'] = this.paymentdetails.toJson();
    }
    return data;
  }
}

class Paymentdetails {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Paymentdetails(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Paymentdetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int id;
  String senderId;
  String receiverId;
  String groupId;
  String amountRequested;
  String amountPaid;
  String payDate;
  String status;
  String requestId;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String groupName;

  Data(
      {this.id,
      this.senderId,
      this.receiverId,
      this.groupId,
      this.amountRequested,
      this.amountPaid,
      this.payDate,
      this.status,
      this.requestId,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.profilePic,
      this.groupName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    groupId = json['group_id'];
    amountRequested = json['amount_requested'];
    amountPaid = json['amount_paid'];
    payDate = json['pay_date'];
    status = json['status'];
    requestId = json['request_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['group_id'] = this.groupId;
    data['amount_requested'] = this.amountRequested;
    data['amount_paid'] = this.amountPaid;
    data['pay_date'] = this.payDate;
    data['status'] = this.status;
    data['request_id'] = this.requestId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['group_name'] = this.groupName;
    return data;
  }
}