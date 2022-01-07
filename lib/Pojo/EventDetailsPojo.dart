class EventDetailsPojo {
  bool success;
  Eventsdata eventsdata;
  String message;

  EventDetailsPojo({this.success, this.eventsdata, this.message});

  EventDetailsPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    eventsdata = json['eventsdata'] != null
        ? new Eventsdata.fromJson(json['eventsdata'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.eventsdata != null) {
      data['eventsdata'] = this.eventsdata.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Eventsdata {
  String id;
  String eventName;
  String eventStarttime;
  String eventStartdate;
  String eventEndtime;
  String eventEnddate;
  String description;
  String categoryId;
  String userId;
  String entryFee;
  String maximumParticipant;
  List<VideoLink> videoLink;
  List<Documents> documents;
  String viewType;
  String members;
  String termsAndCondition;
  String postedDate;
  String status;
  String createdAt;
  String updatedAt;
  int totalLike;
  int totalcomments;
  List<Commentslist> commentslist;
  List<Eventimagesdata> eventimagesdata;
  int totalslotamount;
  int totalcollectedamount;
  int balanceslot;
  int totalcontribute;
  List<ContributerList> contributerList;
  String fullName;
  String profilePic;

  Eventsdata(
      {this.id,
        this.eventName,
        this.eventStarttime,
        this.eventStartdate,
        this.eventEndtime,
        this.eventEnddate,
        this.description,
        this.categoryId,
        this.userId,
        this.entryFee,
        this.maximumParticipant,
        this.videoLink,
        this.documents,
        this.viewType,
        this.members,
        this.termsAndCondition,
        this.postedDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.totalLike,
        this.totalcomments,
        this.commentslist,
        this.eventimagesdata,
        this.totalslotamount,
        this.totalcollectedamount,
        this.balanceslot,
        this.totalcontribute,
        this.contributerList,
        this.fullName,
        this.profilePic});

  Eventsdata.fromJson(Map<String, dynamic> json) {

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

    if(json['category_id'] is int)
    {
      categoryId = json['category_id'].toString();
    }
    else{
      categoryId = json['category_id'];
    }

    if(json['user_id'] is int)
    {
      userId = json['user_id'].toString();
    }
    else{
      userId = json['user_id'];
    }

    if(json['entry_fee'] is int)
    {
      entryFee = json['entry_fee'].toString();
    }
    else{
      entryFee = json['entry_fee'];
    }

    if(json['maximum_participant'] is int)
    {
      maximumParticipant = json['maximum_participant'].toString();
    }
    else{
      maximumParticipant = json['maximum_participant'];
    }

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
    totalLike = json['total_like'];
    totalcomments = json['totalcomments'];
    if (json['commentslist'] != null) {
      commentslist = new List<Commentslist>();
      json['commentslist'].forEach((v) {
        commentslist.add(new Commentslist.fromJson(v));
      });
    }
    if (json['eventimagesdata'] != null) {
      eventimagesdata = new List<Eventimagesdata>();
      json['eventimagesdata'].forEach((v) {
        eventimagesdata.add(new Eventimagesdata.fromJson(v));
      });
    }
    totalslotamount = json['totalslotamount'];
    totalcollectedamount = json['totalcollectedamount'];
    balanceslot = json['balanceslot'];
    totalcontribute = json['totalcontribute'];
    if (json['contributer_list'] != null) {
      contributerList = new List<ContributerList>();
      json['contributer_list'].forEach((v) {
        contributerList.add(new ContributerList.fromJson(v));
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
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['entry_fee'] = this.entryFee;
    data['maximum_participant'] = this.maximumParticipant;
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
    data['total_like'] = this.totalLike;
    data['totalcomments'] = this.totalcomments;
    if (this.commentslist != null) {
      data['commentslist'] = this.commentslist.map((v) => v.toJson()).toList();
    }
    if (this.eventimagesdata != null) {
      data['eventimagesdata'] =
          this.eventimagesdata.map((v) => v.toJson()).toList();
    }
    data['totalslotamount'] = this.totalslotamount;
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['balanceslot'] = this.balanceslot;
    data['totalcontribute'] = this.totalcontribute;
    if (this.contributerList != null) {
      data['contributer_list'] =
          this.contributerList.map((v) => v.toJson()).toList();
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

class Eventimagesdata {
  int id;
  String eventId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  Eventimagesdata(
      {this.id,
        this.eventId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Eventimagesdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if(json['event_id'] is int)
    {
      eventId = json['event_id'].toString();
    }
    else{
      eventId = json['event_id'];
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
    data['event_id'] = this.eventId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ContributerList {
  String id;
  String eventId;
  String senderId;
  double amount;
  String status;
  String paymentfor;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  ContributerList(
      {this.id,
        this.eventId,
        this.senderId,
        this.amount,
        this.status,
        this.paymentfor,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId});

  ContributerList.fromJson(Map<String, dynamic> json) {

    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }

    if(json['event_id'] is int)
    {
      eventId = json['event_id'].toString();
    }
    else{
      eventId = json['event_id'];
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
    data['event_id'] = this.eventId;
    data['sender_id'] = this.senderId;
    data['amount'] = this.amount;
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