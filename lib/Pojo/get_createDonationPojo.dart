class get_createDonationPojo {
  bool success;
  ProjectData projectData;
  List<ProjectImagesdata> projectImagesdata;
  String message;

  get_createDonationPojo(
      {this.success, this.projectData, this.projectImagesdata, this.message});

  get_createDonationPojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    projectData = json['project_data'] != null
        ? new ProjectData.fromJson(json['project_data'])
        : null;
    if (json['project_imagesdata'] != null) {
      projectImagesdata = new List<ProjectImagesdata>();
      json['project_imagesdata'].forEach((v) {
        projectImagesdata.add(new ProjectImagesdata.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.projectData != null) {
      data['project_data'] = this.projectData.toJson();
    }
    if (this.projectImagesdata != null) {
      data['project_imagesdata'] =
          this.projectImagesdata.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProjectData {
  int id;
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
  Null facebookId;
  String fullName;
  String profilePic;

  ProjectData(
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
      this.facebookId,
      this.fullName,
      this.profilePic});

  ProjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    campaignStartdate = json['campaign_startdate'];
    campaignEnddate = json['campaign_enddate'];
    description = json['description'];
    tags = json['tags'];
    userId = json['user_id'];
    budget = json['budget'];
    requiredAmount = json['required_amount'];
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

class ProjectImagesdata {
  int id;
  String donationId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  ProjectImagesdata(
      {this.id,
      this.donationId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  ProjectImagesdata.fromJson(Map<String, dynamic> json) {
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