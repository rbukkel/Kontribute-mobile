class donationDetails {
  bool success;
  Commentsdata commentsdata;
  String message;

  donationDetails({this.success, this.commentsdata, this.message});

  donationDetails.fromJson(Map<String, dynamic> json) {
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
  String campaignName;
  String campaignStartdate;
  String campaignEnddate;
  String description;
  String tags;
  String userId;
  String budget;
  String requiredAmount;
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
  List<Donationimagesdata> donationimagesdata;
  List<Donationpaymentdetails> donationpaymentdetails;
  String totalcollectedamount;
  String fullName;
  String profilePic;

  Commentsdata(
      {this.id,
      this.campaignName,
      this.campaignStartdate,
      this.campaignEnddate,
      this.description,
      this.tags,
      this.userId,
      this.budget,
      this.requiredAmount,
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
      this.donationimagesdata,
      this.donationpaymentdetails,
      this.totalcollectedamount,
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
    campaignName = json['campaign_name'];
    campaignStartdate = json['campaign_startdate'];
    campaignEnddate = json['campaign_enddate'];
    description = json['description'];
    tags = json['tags'];

    if(json['user_id'] is int)
    {
      userId = json['user_id'].toString();
    }
    else{
      userId = json['user_id'];
    }

    if(json['budget'] is int)
    {
      budget = json['budget'].toString();
    }
    else{
      budget = json['budget'];
    }

    if(json['required_amount'] is int)
    {
      requiredAmount = json['required_amount'].toString();
    }
    else{
      requiredAmount = json['required_amount'];
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
    if (json['donationimagesdata'] != null) {
      donationimagesdata = new List<Donationimagesdata>();
      json['donationimagesdata'].forEach((v) {
        donationimagesdata.add(new Donationimagesdata.fromJson(v));
      });
    }
    if (json['donationpaymentdetails'] != null) {
      donationpaymentdetails = new List<Donationpaymentdetails>();
      json['donationpaymentdetails'].forEach((v) {
        donationpaymentdetails.add(new Donationpaymentdetails.fromJson(v));
      });
    }
    if(json['totalcollectedamount'] is int)
    {
      totalcollectedamount = json['totalcollectedamount'].toString();
    }
    else
    {
      totalcollectedamount = json['totalcollectedamount'];
    }


    fullName = json['full_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campaign_name'] = this.campaignName;
    data['campaign_startdate'] = this.campaignStartdate;
    data['campaign_enddate'] = this.campaignEnddate;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['user_id'] = this.userId;
    data['budget'] = this.budget;
    data['required_amount'] = this.requiredAmount;
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
    if (this.donationimagesdata != null) {
      data['donationimagesdata'] =
          this.donationimagesdata.map((v) => v.toJson()).toList();
    }
    if (this.donationpaymentdetails != null) {
      data['donationpaymentdetails'] =
          this.donationpaymentdetails.map((v) => v.toJson()).toList();
    }
    data['totalcollectedamount'] = this.totalcollectedamount;
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
class Commentslist {
  int id;
  String projectId;
  int donationId;
  int eventId;
  int ticketId;
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
    else
    {
      projectId = json['project_id'];
    }
    donationId = json['donation_id'];
    eventId = json['event_id'];
    ticketId = json['ticket_id'];
    comment = json['comment'];
    if(json['user_id'] is int)
    {
      userId = json['user_id'].toString();
    }
    else
    {
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

class Donationpaymentdetails {
  String id;
  String donationId;
  String senderId;
  double amount;
  String status;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  Donationpaymentdetails(
      {this.id,
        this.donationId,
        this.senderId,
        this.amount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.facebookId});

  Donationpaymentdetails.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else
    {
      id = json['id'];
    }

    if(json['donation_id'] is int)
    {
      donationId = json['donation_id'].toString();
    }
    else
    {
      donationId = json['donation_id'];
    }

    if(json['sender_id'] is int)
    {
      senderId = json['sender_id'].toString();
    }
    else
    {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['donation_id'] = this.donationId;
    data['sender_id'] = this.senderId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    return data;
  }
}

class Donationimagesdata {
  int id;
  String donationId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  Donationimagesdata(
      {this.id,
      this.donationId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  Donationimagesdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if(json['donation_id'] is int)
    {
      donationId = json['donation_id'].toString();
    }
    else
    {
      donationId = json['donation_id'];
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
    data['donation_id'] = this.donationId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}