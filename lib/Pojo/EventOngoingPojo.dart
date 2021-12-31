class EventOngoingPojo {
  bool success;
  int totalrecord;
  String message;
  List<ProjectData> projectData;

  EventOngoingPojo(
      {this.success, this.totalrecord, this.message, this.projectData});

  EventOngoingPojo.fromJson(Map<String, dynamic> json) {
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
  List<ProjectImages> projectImages;
  List<Comments> comments;
  int totalslotamount;
  int totalcollectedamount;
  int balanceslot;
  String eventPath;

  ProjectData(
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

  ProjectData.fromJson(Map<String, dynamic> json) {

    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    eventName = json['event_name'];
    eventStartdate = json['event_startdate'];
    eventEnddate = json['event_enddate'];
    eventStarttime = json['event_starttime'];
    eventEndtime = json['event_endtime'];
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
    else
    {
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
class Comments {
  int id;
  String projectId;
  String donationId;
  int eventId;
  int ticketId;
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
    eventId = json['event_id'];
    ticketId = json['ticket_id'];
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
class ProjectImages {
  int id;
  String eventId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  ProjectImages(
      {this.id,
      this.eventId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  ProjectImages.fromJson(Map<String, dynamic> json) {
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