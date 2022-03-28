class myactivitiesgiftpojo {
  bool success;
  String message;
  List<Result> result;

  myactivitiesgiftpojo({this.success, this.message, this.result});

  myactivitiesgiftpojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
  String senderId;
  String receiverId;
  String endDate;
  Object price;
  String minCashByParticipant;
  String collectionTarget;
  String canSee;
  String message;
  String status;
  String giftPicture;
  String notification;
  String acceptTerms;
  String giftStatus;
  String groupId;
  String viewType;
  String postedDate;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  Result(
      {this.id,
      this.senderId,
      this.receiverId,
      this.endDate,
      this.price,
      this.minCashByParticipant,
      this.collectionTarget,
      this.canSee,
      this.message,
      this.status,
      this.giftPicture,
      this.notification,
      this.acceptTerms,
      this.giftStatus,
      this.groupId,
      this.viewType,
      this.postedDate,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.profilePic,
      this.facebookId});

  Result.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else{
      senderId = json['sender_id'];
    }
    if(json['receiver_id'] is int)
    {
      receiverId = json['receiver_id'].toString();
    }
    else{
      receiverId = json['receiver_id'];
    }

    endDate = json['end_date'];

    if(json['price'] is int)
    {
      price = json['price'].toString();
    }
    else{
      price = json['price'];
    }
    if(json['min_cash_by_participant'] is int)
    {
      minCashByParticipant = json['min_cash_by_participant'].toString();
    }
    else{
      minCashByParticipant = json['min_cash_by_participant'];
    }
    if(json['collection_target'] is int)
    {
      collectionTarget = json['collection_target'].toString();
    }
    else{
      collectionTarget = json['collection_target'];
    }

    canSee = json['can_see'];
    message = json['message'];
    status = json['status'];
    giftPicture = json['gift_picture'];
    notification = json['notification'];
    acceptTerms = json['accept_terms'];
    giftStatus = json['gift_status'];

    if(json['group_id'] is int)
    {
      groupId = json['group_id'].toString();
    }
    else{
      groupId = json['group_id'];
    }
    viewType = json['view_type'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['min_cash_by_participant'] = this.minCashByParticipant;
    data['collection_target'] = this.collectionTarget;
    data['can_see'] = this.canSee;
    data['message'] = this.message;
    data['status'] = this.status;
    data['gift_picture'] = this.giftPicture;
    data['notification'] = this.notification;
    data['accept_terms'] = this.acceptTerms;
    data['gift_status'] = this.giftStatus;
    data['group_id'] = this.groupId;
    data['view_type'] = this.viewType;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    return data;
  }
}