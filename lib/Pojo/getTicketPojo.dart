class getTicketPojo {
  bool success;
  TicketData ticketData;
  Invitationdata invitationdata;
  List<TicketImagesdata> ticketImagesdata;
  String message;

  getTicketPojo(
      {this.success,
      this.ticketData,
      this.invitationdata,
      this.ticketImagesdata,
      this.message});

  getTicketPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    ticketData = json['ticket_data'] != null
        ? new TicketData.fromJson(json['ticket_data'])
        : null;
    invitationdata = json['invitationdata'] != null
        ? new Invitationdata.fromJson(json['invitationdata'])
        : null;
    if (json['ticket_imagesdata'] != null) {
      ticketImagesdata = new List<TicketImagesdata>();
      json['ticket_imagesdata'].forEach((v) {
        ticketImagesdata.add(new TicketImagesdata.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.ticketData != null) {
      data['ticket_data'] = this.ticketData.toJson();
    }
    if (this.invitationdata != null) {
      data['invitationdata'] = this.invitationdata.toJson();
    }
    if (this.ticketImagesdata != null) {
      data['ticket_imagesdata'] =
          this.ticketImagesdata.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class TicketData {
  int id;
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
  String facebookId;
  String fullName;
  String profilePic;

  TicketData(
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
      this.facebookId,
      this.fullName,
      this.profilePic});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    userId = json['user_id'];
    ticketCost = json['ticket_cost'];
    maximumQtySold = json['maximum_qty_sold'];
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
    facebookId = json['facebook_id'];
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
    data['facebook_id'] = this.facebookId;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class VideoLink {
  String vlink;

  VideoLink({this.vlink});

  VideoLink.fromJson(Map<String, dynamic> json) {
    vlink = json['vlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vlink'] = this.vlink;
    return data;
  }
}

class Documents {
  String documents;

  Documents({this.documents});

  Documents.fromJson(Map<String, dynamic> json) {
    documents = json['documents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documents'] = this.documents;
    return data;
  }
}

class Invitationdata {
  int id;
  String name;
  String email;
  String mobile;
  String message;
  String status;
  String senderid;
  String projectId;
  String donationId;
  String eventId;
  Null ticketId;
  String createdAt;
  String updatedAt;

  Invitationdata(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.message,
      this.status,
      this.senderid,
      this.projectId,
      this.donationId,
      this.eventId,
      this.ticketId,
      this.createdAt,
      this.updatedAt});

  Invitationdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    message = json['message'];
    status = json['status'];
    senderid = json['senderid'];
    projectId = json['project_id'];
    donationId = json['donation_id'];
    eventId = json['event_id'];
    ticketId = json['ticket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['message'] = this.message;
    data['status'] = this.status;
    data['senderid'] = this.senderid;
    data['project_id'] = this.projectId;
    data['donation_id'] = this.donationId;
    data['event_id'] = this.eventId;
    data['ticket_id'] = this.ticketId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TicketImagesdata {
  int id;
  String ticketId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  TicketImagesdata(
      {this.id,
      this.ticketId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  TicketImagesdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
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