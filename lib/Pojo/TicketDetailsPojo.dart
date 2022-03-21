class TicketDetailsPojo {
  bool success;
  Commentsdata commentsdata;
  String message;

  TicketDetailsPojo({this.success, this.commentsdata, this.message});

  TicketDetailsPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    commentsdata = json['commentsdata'] != null
        ? new Commentsdata.fromJson(json['commentsdata'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.commentsdata != null) {
      data['commentsdata'] = this.commentsdata.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Commentsdata {
  String id;
  String eventName;
  String eventStarttime;
  String eventStartdate;
  String eventEndtime;
  String eventEnddate;
  String description;
  String conatactNumber;
  String ticketEmail;
  String location;
  String locationDetails;
  String userId;
  String ticketCost;
  String maximumQtySold;
  String timeframeForSale;
  List<VideoLink> videoLink;
  List<Documents> documents;
  String viewType;
  String members;
  String termsAndCondition;
  String postedDate;
  String status;
  String createdAt;
  String updatedAt;
  int totalcontributor;
  int totalLike;
  int totalcomments;
  List<Commentslist> commentslist;
  List<Ticketimagesdata> ticketimagesdata;
  int totalslotamount;
  int totalcollectedamount;
  int balanceslot;
  int ticketsold;
  int balanceQtySlot;
  List<TicketdetailUser> ticketdetailUser;
  List<Ticketpayemtndetails> ticketpayemtndetails;
  String fullName;
  String profilePic;

  Commentsdata(
      {this.id,
        this.eventName,
        this.eventStarttime,
        this.eventStartdate,
        this.eventEndtime,
        this.eventEnddate,
        this.description,
        this.conatactNumber,
        this.ticketEmail,
        this.location,
        this.locationDetails,
        this.userId,
        this.ticketCost,
        this.maximumQtySold,
        this.timeframeForSale,
        this.videoLink,
        this.documents,
        this.viewType,
        this.members,
        this.termsAndCondition,
        this.postedDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.totalcontributor,
        this.totalLike,
        this.totalcomments,
        this.commentslist,
        this.ticketimagesdata,
        this.totalslotamount,
        this.totalcollectedamount,
        this.balanceslot,
        this.ticketsold,
        this.balanceQtySlot,
        this.ticketdetailUser,
        this.ticketpayemtndetails,
        this.fullName,
        this.profilePic});

  Commentsdata.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    eventName = json['event_name'];
    eventStarttime = json['event_starttime'];
    eventStartdate = json['event_startdate'];
    eventEndtime = json['event_endtime'];
    eventEnddate = json['event_enddate'];
    description = json['description'];
    conatactNumber = json['conatact_number'];
    ticketEmail = json['ticket_email'];
    location = json['location'];
    locationDetails = json['location_details'];
    if(json['user_id'] is int)
    {
      userId = json['user_id'].toString();
    }
    else{
      userId = json['user_id'];
    }
    if(json['ticket_cost'] is int)
    {
      ticketCost = json['ticket_cost'].toString();
    }
    else{
      ticketCost = json['ticket_cost'];
    }
    if(json['maximum_qty_sold'] is int)
    {
      maximumQtySold = json['maximum_qty_sold'].toString();
    }
    else{
      maximumQtySold = json['maximum_qty_sold'];
    }


    timeframeForSale = json['timeframe_for_sale'];
    if (json['video_link'] != null) {
      videoLink = new List<VideoLink>();
      json['video_link'].forEach((v) {
        videoLink.add(new VideoLink.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    viewType = json['view_type'];
    members = json['members'];
    termsAndCondition = json['terms_and_condition'];
    postedDate = json['posted_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalcontributor = json['totalcontributor'];
    totalLike = json['total_like'];
    totalcomments = json['totalcomments'];
    if (json['commentslist'] != null) {
      commentslist = new List<Commentslist>();
      json['commentslist'].forEach((v) {
        commentslist.add(new Commentslist.fromJson(v));
      });
    }
    if (json['ticketimagesdata'] != null) {
      ticketimagesdata = new List<Ticketimagesdata>();
      json['ticketimagesdata'].forEach((v) {
        ticketimagesdata.add(new Ticketimagesdata.fromJson(v));
      });
    }
    totalslotamount = json['totalslotamount'];
    totalcollectedamount = json['totalcollectedamount'];
    balanceslot = json['balanceslot'];
    ticketsold = json['ticketsold'];
    balanceQtySlot = json['balance_qty_slot'];
    if (json['ticketdetail_user'] != null) {
      ticketdetailUser = new List<TicketdetailUser>();
      json['ticketdetail_user'].forEach((v) {
        ticketdetailUser.add(new TicketdetailUser.fromJson(v));
      });
    }
    if (json['ticketpayemtndetails'] != null) {
      ticketpayemtndetails = new List<Ticketpayemtndetails>();
      json['ticketpayemtndetails'].forEach((v) {
        ticketpayemtndetails.add(new Ticketpayemtndetails.fromJson(v));
      });
    }
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['event_starttime'] = this.eventStarttime;
    data['event_startdate'] = this.eventStartdate;
    data['event_endtime'] = this.eventEndtime;
    data['event_enddate'] = this.eventEnddate;
    data['description'] = this.description;
    data['conatact_number'] = this.conatactNumber;
    data['ticket_email'] = this.ticketEmail;
    data['location'] = this.location;
    data['location_details'] = this.locationDetails;
    data['user_id'] = this.userId;
    data['ticket_cost'] = this.ticketCost;
    data['maximum_qty_sold'] = this.maximumQtySold;
    data['timeframe_for_sale'] = this.timeframeForSale;
    if (this.videoLink != null) {
      data['video_link'] = this.videoLink.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['view_type'] = this.viewType;
    data['members'] = this.members;
    data['terms_and_condition'] = this.termsAndCondition;
    data['posted_date'] = this.postedDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['totalcontributor'] = this.totalcontributor;
    data['total_like'] = this.totalLike;
    data['totalcomments'] = this.totalcomments;
    if (this.commentslist != null) {
      data['commentslist'] = this.commentslist.map((v) => v.toJson()).toList();
    }
    if (this.ticketimagesdata != null) {
      data['ticketimagesdata'] =
          this.ticketimagesdata.map((v) => v.toJson()).toList();
    }
    data['totalslotamount'] = this.totalslotamount;
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['balanceslot'] = this.balanceslot;
    data['ticketsold'] = this.ticketsold;
    data['balance_qty_slot'] = this.balanceQtySlot;
    if (this.ticketdetailUser != null) {
      data['ticketdetail_user'] =
          this.ticketdetailUser.map((v) => v.toJson()).toList();
    }
    if (this.ticketpayemtndetails != null) {
      data['ticketpayemtndetails'] =
          this.ticketpayemtndetails.map((v) => v.toJson()).toList();
    }
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class VideoLink {
  String vlink;
  String videoThumbnail;

  VideoLink({this.vlink, this.videoThumbnail});

  VideoLink.fromJson(Map<String, dynamic> json) {
    vlink = json['vlink'];
    videoThumbnail = json['video_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vlink'] = this.vlink;
    data['video_thumbnail'] = this.videoThumbnail;
    return data;
  }
}

class Documents {
  String documentsUrl;
  String docName;

  Documents({this.documentsUrl, this.docName});

  Documents.fromJson(Map<String, dynamic> json) {
    documentsUrl = json['documents_url'];
    docName = json['doc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documents_url'] = this.documentsUrl;
    data['doc_name'] = this.docName;
    return data;
  }
}

class Commentslist {
  int id;
  String projectId;
  String donationId;
  String eventId;
  String ticketId;
  String comment;
  String userId;
  String postedDate;
  String createdAt;
  String updatedAt;

  Commentslist(
      {this.id,
        this.projectId,
        this.donationId,
        this.eventId,
        this.ticketId,
        this.comment,
        this.userId,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Commentslist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['project_id'] is int)
    {
      projectId = json['project_id'].toString();
    }
    else{
      projectId = json['project_id'];
    }

    if(json['donation_id'] is int)
    {
      donationId = json['donation_id'].toString();
    }
    else{
      donationId = json['donation_id'];
    }

    if(json['event_id'] is int)
    {
      eventId = json['event_id'].toString();
    }
    else{
      eventId = json['event_id'];
    }
    if(json['ticket_id'] is int)
    {
      ticketId = json['ticket_id'].toString();
    }
    else{
      ticketId = json['ticket_id'];
    }

    comment = json['comment'];

    if(json['user_id'] is int)
    {
      userId = json['user_id'].toString();
    }
    else{
      userId = json['user_id'];
    }
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['donation_id'] = this.donationId;
    data['event_id'] = this.eventId;
    data['ticket_id'] = this.ticketId;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Ticketimagesdata {
  int id;
  String ticketId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  Ticketimagesdata(
      {this.id,
        this.ticketId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Ticketimagesdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['ticket_id'] is int)
    {
      ticketId = json['ticket_id'].toString();
    }
    else{
      ticketId = json['ticket_id'];
    }
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class TicketdetailUser {
  String id;
  String ticketId;
  String senderId;
  double amount;
  String qty;
  String status;
  String paymentfor;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  TicketdetailUser(
      {this.id,
        this.ticketId,
        this.senderId,
        this.amount,
        this.qty,
        this.status,
        this.paymentfor,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId});

  TicketdetailUser.fromJson(Map<String, dynamic> json) {


    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['ticket_id'] is int)
    {
      ticketId = json['ticket_id'].toString();
    }
    else{
      ticketId = json['ticket_id'];
    }
    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else{
      senderId = json['sender_id'];
    }
    if(json['amount'] is int)
    {
      amount = double.parse(json['amount'].toString());
    }
    else{
      amount = json['amount'];
    }

    if(json['qty'] is int)
    {
      qty = json['qty'].toString();
    }
    else{
      qty = json['qty'];
    }

    status = json['status'];
    paymentfor = json['paymentfor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['sender_id'] = this.senderId;
    data['amount'] = this.amount;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['paymentfor'] = this.paymentfor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    return data;
  }
}
class Ticketpayemtndetails {
  String id;
  String ticketId;
  String senderId;
  Object amount;
  String qty;
  String status;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  Ticketpayemtndetails(
      {this.id,
        this.ticketId,
        this.senderId,
        this.amount,
        this.qty,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId});

  Ticketpayemtndetails.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['ticket_id'] is int)
    {
      ticketId = json['ticket_id'].toString();
    }
    else{
      ticketId = json['ticket_id'];
    }
    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else{
      senderId = json['sender_id'];
    }
    if(json['amount'] is int)
    {
      amount = json['amount'].toString();
    }
    else{
      amount = json['amount'];
    }
    if(json['qty'] is int)
    {
      qty = json['qty'].toString();
    }
    else{
      qty = json['qty'];
    }

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['sender_id'] = this.senderId;
    data['amount'] = this.amount;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    return data;
  }
}