class Projectdetailspojo {
  bool success;
  Commentsdata commentsdata;
  String message;

  Projectdetailspojo({this.success, this.commentsdata, this.message});

  Projectdetailspojo.fromJson(Map<String, dynamic> json) {
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
  String projectName;
  String projectStartdate;
  String projectEnddate;
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
  List<Projectimagesdata> projectimagesdata;
  String fullName;
  String profilePic;

  Commentsdata(
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
        this.projectimagesdata,
        this.fullName,
        this.profilePic});

  Commentsdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    projectStartdate = json['project_startdate'];
    projectEnddate = json['project_enddate'];
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
    totalLike = json['total_like'];
    totalcomments = json['totalcomments'];
    if (json['commentslist'] != null) {
      commentslist = new List<Commentslist>();
      json['commentslist'].forEach((v) {
        commentslist.add(new Commentslist.fromJson(v));
      });
    }
    if (json['projectimagesdata'] != null) {
      projectimagesdata = new List<Projectimagesdata>();
      json['projectimagesdata'].forEach((v) {
        projectimagesdata.add(new Projectimagesdata.fromJson(v));
      });
    }
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
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
    if (this.projectimagesdata != null) {
      data['projectimagesdata'] =
          this.projectimagesdata.map((v) => v.toJson()).toList();
    }
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
class Commentslist {
  int id;
  String projectId;
  String comment;
  String userId;
  String postedDate;
  String createdAt;
  String updatedAt;

  Commentslist(
      {this.id,
        this.projectId,
        this.comment,
        this.userId,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Commentslist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
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
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Projectimagesdata {
  int id;
  String projectId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;

  Projectimagesdata(
      {this.id,
        this.projectId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Projectimagesdata.fromJson(Map<String, dynamic> json) {
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