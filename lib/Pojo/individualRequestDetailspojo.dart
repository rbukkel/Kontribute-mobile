
class individualRequestDetailspojo {
  bool success;
  String message;
  Result result;
  List<Memberlist> memberlist;
  Paymentdetails paymentdetails;

  individualRequestDetailspojo(
      {this.success,
        this.message,
        this.result,
        this.memberlist,
        this.paymentdetails});

  individualRequestDetailspojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    if (json['memberlist'] != null) {
      memberlist = new List<Memberlist>();
      json['memberlist'].forEach((v) {
        memberlist.add(new Memberlist.fromJson(v));
      });
    }
    paymentdetails = json['paymentdetails'] != null
        ? new Paymentdetails.fromJson(json['paymentdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    if (this.memberlist != null) {
      data['memberlist'] = this.memberlist.map((v) => v.toJson()).toList();
    }
    if (this.paymentdetails != null) {
      data['paymentdetails'] = this.paymentdetails.toJson();
    }
    return data;
  }
}

class Result {
  String id;
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
  String fullName;
  String profilePic;
  String facebookId;
  String groupName;
  String groupAdmin;
  String groupMembers;
  String specialTerms;
  String receiverName;
  String receiverProfilePic;
  String adminProfilePic;
  String groupAdminName;

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
        this.facebookId,
        this.groupName,
        this.groupAdmin,
        this.groupMembers,
        this.specialTerms,
        this.receiverName,
        this.receiverProfilePic,
        this.adminProfilePic,
        this.groupAdminName});

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
    groupName = json['group_name'];
    groupAdmin = json['group_admin'];
    groupMembers = json['group_members'];
    specialTerms = json['special_terms'];
    receiverName = json['receiver_name'];
    receiverProfilePic = json['receiver_profile_pic'];
    adminProfilePic = json['admin_profile_pic'];
    groupAdminName = json['group_admin_name'];
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
    data['group_name'] = this.groupName;
    data['group_admin'] = this.groupAdmin;
    data['group_members'] = this.groupMembers;
    data['special_terms'] = this.specialTerms;
    data['receiver_name'] = this.receiverName;
    data['receiver_profile_pic'] = this.receiverProfilePic;
    data['admin_profile_pic'] = this.adminProfilePic;
    data['group_admin_name'] = this.groupAdminName;
    return data;
  }
}

class Memberlist {
  String id;
  String memberName;
  String memberProfilePic;
  int minCashByParticipant;
  int amountPaid;
  int paymentStatus;

  Memberlist(
      {this.id,
        this.memberName,
        this.memberProfilePic,
        this.minCashByParticipant,
        this.amountPaid,
        this.paymentStatus});

  Memberlist.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    memberName = json['member_name'];
    memberProfilePic = json['member_profile_pic'];
    minCashByParticipant = json['min_cash_by_participant'];
    amountPaid = json['amount_paid'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_name'] = this.memberName;
    data['member_profile_pic'] = this.memberProfilePic;
    data['min_cash_by_participant'] = this.minCashByParticipant;
    data['amount_paid'] = this.amountPaid;
    data['payment_status'] = this.paymentStatus;
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
    if(json['group_id'] is int)
    {
      groupId = json['group_id'].toString();
    }
    else{
      groupId = json['group_id'];
    }
    amountRequested = json['amount_requested'];
    amountPaid = json['amount_paid'];
    payDate = json['pay_date'];
    status = json['status'];
    if(json['request_id'] is int)
    {
      requestId = json['request_id'].toString();
    }
    else{
      requestId = json['request_id'];
    }
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