class Notificationpojo {
  bool status;
  Result result;
  String message;

  Notificationpojo({this.status, this.result, this.message});

  Notificationpojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Result {
  int currentPage;
  List<Datum> data;
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Datum>();
      json['data'].forEach((v) {
        data.add(new Datum.fromJson(v));
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

class Datum {
  String id;
  String senderId;
  String groupId;
  String receiverId;
  String description;
  String seen;
  String price;
  String minCashByParticipant;
  String collectionTarget;
  String giftPicture;
  String updateId;
  String endDate;
  String postedDate;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;
  String groupName;

  Datum(
      {this.id,
        this.senderId,
        this.groupId,
        this.receiverId,
        this.description,
        this.seen,
        this.price,
        this.minCashByParticipant,
        this.collectionTarget,
        this.giftPicture,
        this.updateId,
        this.endDate,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId,
        this.groupName});

  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    groupId = json['group_id'];
    receiverId = json['receiver_id'];
    description = json['description'];
    seen = json['seen'];
    price = json['price'];
    minCashByParticipant = json['min_cash_by_participant'];
    collectionTarget = json['collection_target'];
    giftPicture = json['gift_picture'];
    updateId = json['update_id'];
    endDate = json['end_date'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['group_id'] = this.groupId;
    data['receiver_id'] = this.receiverId;
    data['description'] = this.description;
    data['seen'] = this.seen;
    data['price'] = this.price;
    data['min_cash_by_participant'] = this.minCashByParticipant;
    data['collection_target'] = this.collectionTarget;
    data['gift_picture'] = this.giftPicture;
    data['update_id'] = this.updateId;
    data['end_date'] = this.endDate;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    data['group_name'] = this.groupName;
    return data;
  }
}