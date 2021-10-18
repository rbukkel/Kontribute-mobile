class get_EventCreate {
  bool success;
  EventData eventData;
  Invitationdata invitationdata;
  List<EventImagesdata> eventImagesdata;
  String message;

  get_EventCreate(
      {this.success,
        this.eventData,
        this.invitationdata,
        this.eventImagesdata,
        this.message});

  get_EventCreate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    eventData = json['event_data'] != null
        ? new EventData.fromJson(json['event_data'])
        : null;
    invitationdata = json['invitationdata'] != null
        ? new Invitationdata.fromJson(json['invitationdata'])
        : null;
    if (json['event_imagesdata'] != null) {
      eventImagesdata = new List<EventImagesdata>();
      json['event_imagesdata'].forEach((v) {
        eventImagesdata.add(new EventImagesdata.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.eventData != null) {
      data['event_data'] = this.eventData.toJson();
    }
    if (this.invitationdata != null) {
      data['invitationdata'] = this.invitationdata.toJson();
    }
    if (this.eventImagesdata != null) {
      data['event_imagesdata'] =
          this.eventImagesdata.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class EventData {
  int id;
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
  String categoryName;
  String facebookId;
  String fullName;
  String profilePic;

  EventData(
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
        this.categoryName,
        this.facebookId,
        this.fullName,
        this.profilePic});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    eventStarttime = json['event_starttime'];
    eventStartdate = json['event_startdate'];
    eventEndtime = json['event_endtime'];
    eventEnddate = json['event_enddate'];
    description = json['description'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    entryFee = json['entry_fee'];
    maximumParticipant = json['maximum_participant'];
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
    categoryName = json['category_name'];
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
    data['category_name'] = this.categoryName;
    data['facebook_id'] = this.facebookId;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class EventImagesdata {
  int id;
  String eventId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  EventImagesdata(
      {this.id,
        this.eventId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  EventImagesdata.fromJson(Map<String, dynamic> json) {
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