class MyActivitiesPojo {
  bool success;
  String message;
  Result result;

  MyActivitiesPojo({this.success, this.message, this.result});

  MyActivitiesPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<Giftsection> giftsection;
  List<Projectsection> projectsection;
  List<Donationsection> donationsection;
  List<Eventssection> eventssection;
  List<Tickettsection> tickettsection;

  Result(
      {this.giftsection,
      this.projectsection,
      this.donationsection,
      this.eventssection,
      this.tickettsection});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['giftsection'] != null) {
      giftsection = new List<Giftsection>();
      json['giftsection'].forEach((v) {
        giftsection.add(new Giftsection.fromJson(v));
      });
    }

    if (json['projectsection'] != null) {
      projectsection = new List<Projectsection>();
      json['projectsection'].forEach((v) {
        projectsection.add(new Projectsection.fromJson(v));
      });
    }

    if (json['donationsection'] != null) {
      donationsection = new List<Donationsection>();
      json['donationsection'].forEach((v) {
        donationsection.add(new Donationsection.fromJson(v));
      });
    }

    if (json['eventssection'] != null) {
      eventssection = new List<Eventssection>();
      json['eventssection'].forEach((v) {
        eventssection.add(new Eventssection.fromJson(v));
      });
    }

    if (json['tickettsection'] != null) {
      tickettsection = new List<Tickettsection>();
      json['tickettsection'].forEach((v) {
        tickettsection.add(new Tickettsection.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giftsection != null) {
      data['giftsection'] = this.giftsection.map((v) => v.toJson()).toList();
    }
    if (this.projectsection != null) {
      data['projectsection'] =
          this.projectsection.map((v) => v.toJson()).toList();
    }
    if (this.donationsection != null) {
      data['donationsection'] =
          this.donationsection.map((v) => v.toJson()).toList();
    }
    if (this.eventssection != null) {
      data['eventssection'] =
          this.eventssection.map((v) => v.toJson()).toList();
    }
    if (this.tickettsection != null) {
      data['tickettsection'] =
          this.tickettsection.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Giftsection {
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
  Null viewType;
  String postedDate;
  String createdAt;
  String updatedAt;
  String fullName;
  String profilePic;
  String facebookId;

  Giftsection(
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

  Giftsection.fromJson(Map<String, dynamic> json) {
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

class Projectsection {
  String id;
  String projectName;
  String projectStartdate;
  String projectEnddate;
  String description;
  String tags;
  String userId;
  String budget;
  String requiredAmount;
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
  List<ProjectImages> projectImages;
  List<Comments> comments;
  int totalcollectedamount;
  String projectPath;

  Projectsection(
      {this.id,
      this.projectName,
      this.projectStartdate,
      this.projectEnddate,
      this.description,
      this.tags,
      this.userId,
      this.budget,
      this.requiredAmount,
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
      this.projectImages,
      this.comments,
      this.totalcollectedamount,
      this.projectPath});

  Projectsection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    projectStartdate = json['project_startdate'];
    projectEnddate = json['project_enddate'];
    description = json['description'];
    tags = json['tags'];
    userId = json['user_id'];
    budget = json['budget'];
    requiredAmount = json['required_amount'];
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
    if (json['project_images'] != null) {
      projectImages = new List<ProjectImages>();
      json['project_images'].forEach((v) {
        projectImages.add(new ProjectImages.fromJson(v));
      });
    }
    if (json['Comments'] != null) {
      comments = new List<Comments>();
      json['Comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    totalcollectedamount = json['totalcollectedamount'];
    projectPath = json['project_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_name'] = this.projectName;
    data['project_startdate'] = this.projectStartdate;
    data['project_enddate'] = this.projectEnddate;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['user_id'] = this.userId;
    data['budget'] = this.budget;
    data['required_amount'] = this.requiredAmount;
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
    if (this.projectImages != null) {
      data['project_images'] =
          this.projectImages.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['project_path'] = this.projectPath;
    return data;
  }
}

class ProjectImages {
  int id;
  String projectId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  ProjectImages(
      {this.id,
      this.projectId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  ProjectImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
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
    projectId = json['project_id'];
    donationId = json['donation_id'];
    eventId = json['event_id'];
    ticketId = json['ticket_id'];
    comment = json['comment'];
    userId = json['user_id'];
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

class Donationsection {
  String id;
  String campaignName;
  String campaignStartdate;
  String campaignEnddate;
  String description;
  String tags;
  String userId;
  String budget;
  String requiredAmount;
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
  List<DonationImages> projectImages;
  List<Comments> comments;
  int totalcollectedamount;
  String donationPath;

  Donationsection(
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
      this.viewType,
      this.members,
      this.termsAndCondition,
      this.postedDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.profilePic,
      this.projectImages,
      this.comments,
      this.totalcollectedamount,
      this.donationPath});

  Donationsection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    campaignStartdate = json['campaign_startdate'];
    campaignEnddate = json['campaign_enddate'];
    description = json['description'];
    tags = json['tags'];
    userId = json['user_id'];
    budget = json['budget'];
    requiredAmount = json['required_amount'];
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
    if (json['project_images'] != null) {
      projectImages = new List<DonationImages>();
      json['project_images'].forEach((v) {
        projectImages.add(new DonationImages.fromJson(v));
      });
    }
    if (json['Comments'] != null) {
      comments = new List<Comments>();
      json['Comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    totalcollectedamount = json['totalcollectedamount'];
    donationPath = json['donation_path'];
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
    if (this.projectImages != null) {
      data['project_images'] =
          this.projectImages.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['donation_path'] = this.donationPath;
    return data;
  }
}

class DonationImages {
  int id;
  String donationId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  DonationImages(
      {this.id,
      this.donationId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  DonationImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donationId = json['donation_id'];
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

class Eventssection {
  String id;
  String eventName;
  String eventStartdate;
  String eventEnddate;
  String eventStarttime;
  String eventEndtime;
  String description;
  String categoryId;
  String userId;
  String entryFee;
  String maximumParticipant;
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
  List<EventImages> projectImages;
  List<Comments> comments;
  int totalslotamount;
  int totalcollectedamount;
  int balanceslot;
  String eventPath;

  Eventssection(
      {this.id,
      this.eventName,
      this.eventStartdate,
      this.eventEnddate,
      this.eventStarttime,
      this.eventEndtime,
      this.description,
      this.categoryId,
      this.userId,
      this.entryFee,
      this.maximumParticipant,
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
      this.projectImages,
      this.comments,
      this.totalslotamount,
      this.totalcollectedamount,
      this.balanceslot,
      this.eventPath});

  Eventssection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    eventStartdate = json['event_startdate'];
    eventEnddate = json['event_enddate'];
    eventStarttime = json['event_starttime'];
    eventEndtime = json['event_endtime'];
    description = json['description'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    entryFee = json['entry_fee'];
    maximumParticipant = json['maximum_participant'];
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
    if (json['project_images'] != null) {
      projectImages = new List<EventImages>();
      json['project_images'].forEach((v) {
        projectImages.add(new EventImages.fromJson(v));
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
    eventPath = json['event_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['event_startdate'] = this.eventStartdate;
    data['event_enddate'] = this.eventEnddate;
    data['event_starttime'] = this.eventStarttime;
    data['event_endtime'] = this.eventEndtime;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['entry_fee'] = this.entryFee;
    data['maximum_participant'] = this.maximumParticipant;
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
    if (this.projectImages != null) {
      data['project_images'] =
          this.projectImages.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['totalslotamount'] = this.totalslotamount;
    data['totalcollectedamount'] = this.totalcollectedamount;
    data['balanceslot'] = this.balanceslot;
    data['event_path'] = this.eventPath;
    return data;
  }
}

class EventImages {
  int id;
  String eventId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  EventImages(
      {this.id,
      this.eventId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  EventImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
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

class Tickettsection {
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

  Tickettsection(
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

  Tickettsection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    userId = json['user_id'];
    ticketCost = json['ticket_cost'];
    maximumQtySold = json['maximum_qty_sold'];
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