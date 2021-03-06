class TicketOngoingListing {
  bool success;
  int totalrecord;
  String message;
  List<ProjectData> projectData;

  TicketOngoingListing({this.success, this.totalrecord, this.message, this.projectData});

  TicketOngoingListing.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalrecord = json['totalrecord'];
    message = json['message'];
    if (json['project_data'] != null) {
      projectData = new List<ProjectData>();
      json['project_data'].forEach((v) {
        projectData.add(new ProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalrecord'] = this.totalrecord;
    data['message'] = this.message;
    if (this.projectData != null) {
      data['project_data'] = this.projectData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectData {
  String id;
  String ticketName;
  String ticketStartdate;
  String ticketEnddate;
  String ticketStarttime;
  String ticketEndtime;
  String description;
  String conatactNumber;
  String ticketEmail;
  String location;
  String locationDetails;
  String userId;
  String ticketCost;
  String maximumQtySold;
  String timeframeForSale;
  String videoLink;
  String viewType;
  String members;
  String termsAndCondition;
  String postedDate;
  String status;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  List<TicketImages> ticketImages;
  List<Comments> comments;
  int totalslotamount;
  int totalcollectedamount;
  int balanceslot;
  int ticketsold;
  int balanceQtySlot;
  int totalcontributor;
  String eventPath;

  ProjectData(
      {this.id,
        this.ticketName,
        this.ticketStartdate,
        this.ticketEnddate,
        this.ticketStarttime,
        this.ticketEndtime,
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
        this.viewType,
        this.members,
        this.termsAndCondition,
        this.postedDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.profilePic,
        this.ticketImages,
        this.comments,
        this.totalslotamount,
        this.totalcollectedamount,
        this.balanceslot,
        this.ticketsold,
        this.balanceQtySlot,
        this.totalcontributor,
        this.eventPath});

  ProjectData.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    ticketName = json['ticket_name'];
    ticketStartdate = json['ticket_startdate'];
    ticketEnddate = json['ticket_enddate'];
    ticketStarttime = json['ticket_starttime'];
    ticketEndtime = json['ticket_endtime'];
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
    videoLink = json['video_link'];
    viewType = json['view_type'];
    members = json['members'];
    termsAndCondition = json['terms_and_condition'];
    postedDate = json['posted_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    if (json['ticket_images'] != null) {
      ticketImages = new List<TicketImages>();
      json['ticket_images'].forEach((v) {
        ticketImages.add(new TicketImages.fromJson(v));
      });
    }
    if (json['Comments'] != null) {
      comments = new List<Comments>();
      json['Comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    totalslotamount = json['totalslotamount'];
    totalcollectedamount = json['totalcollectedamount'];
    balanceslot = json['balanceslot'];
    ticketsold = json['ticketsold'];
    balanceQtySlot = json['balance_qty_slot'];
    totalcontributor = json['totalcontributor'];
    eventPath = json['event_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_name'] = this.ticketName;
    data['ticket_startdate'] = this.ticketStartdate;
    data['ticket_enddate'] = this.ticketEnddate;
    data['ticket_starttime'] = this.ticketStarttime;
    data['ticket_endtime'] = this.ticketEndtime;
    data['description'] = this.description;
    data['conatact_number'] = this.conatactNumber;
    data['ticket_email'] = this.ticketEmail;
    data['location'] = this.location;
    data['location_details'] = this.locationDetails;
    data['user_id'] = this.userId;
    data['ticket_cost'] = this.ticketCost;
    data['maximum_qty_sold'] = this.maximumQtySold;
    data['timeframe_for_sale'] = this.timeframeForSale;
    data['video_link'] = this.videoLink;
    data['view_type'] = this.viewType;
    data['members'] = this.members;
    data['terms_and_condition'] = this.termsAndCondition;
    data['posted_date'] = this.postedDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    if (this.ticketImages != null) {
      data['ticket_images'] = this.ticketImages.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['totalslotamount'] = this.totalslotamount;
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['balanceslot'] = this.balanceslot;
    data['ticketsold'] = this.ticketsold;
    data['balance_qty_slot'] = this.balanceQtySlot;
    data['totalcontributor'] = this.totalcontributor;
    data['event_path'] = this.eventPath;
    return data;
  }
}

class TicketImages {
  int id;
  String ticketId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  TicketImages(
      {this.id,
        this.ticketId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  TicketImages.fromJson(Map<String, dynamic> json) {
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

class Comments {
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

  Comments(
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

  Comments.fromJson(Map<String, dynamic> json) {
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