class get_create_group {
  bool success;
  String message;
  Data data;

  get_create_group({this.success, this.message, this.data});

  get_create_group.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String senderId;
  String receiverId;
  String endDate;
  String price;
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
  String groupAdmin;
  String adminProfilePic;
  String groupName;
  String groupPic;
  String specialTerms;
  String groupAdminId;
  String groupCreatedDate;

  Data(
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
      this.groupAdmin,
      this.adminProfilePic,
      this.groupName,
      this.groupPic,
      this.specialTerms,
      this.groupAdminId,
      this.groupCreatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    endDate = json['end_date'];
    price = json['price'];
    minCashByParticipant = json['min_cash_by_participant'];
    collectionTarget = json['collection_target'];
    canSee = json['can_see'];
    message = json['message'];
    status = json['status'];
    giftPicture = json['gift_picture'];
    notification = json['notification'];
    acceptTerms = json['accept_terms'];
    giftStatus = json['gift_status'];
    groupId = json['group_id'];
    viewType = json['view_type'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupAdmin = json['group_admin'];
    adminProfilePic = json['admin_profile_pic'];
    groupName = json['group_name'];
    groupPic = json['group_pic'];
    specialTerms = json['special_terms'];
    groupAdminId = json['group_admin_id'];
    groupCreatedDate = json['group_created_date'];
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
    data['group_admin'] = this.groupAdmin;
    data['admin_profile_pic'] = this.adminProfilePic;
    data['group_name'] = this.groupName;
    data['group_pic'] = this.groupPic;
    data['special_terms'] = this.specialTerms;
    data['group_admin_id'] = this.groupAdminId;
    data['group_created_date'] = this.groupCreatedDate;
    return data;
  }
}