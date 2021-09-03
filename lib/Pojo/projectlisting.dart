class projectlisting {
  bool success;
  int totalrecord;
  String message;
  List<ProjectData> projectData;

  projectlisting(
      {this.success, this.totalrecord, this.message, this.projectData});

  projectlisting.fromJson(Map<String, dynamic> json) {
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
  String projectPath;

  ProjectData(
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
        this.projectPath});

  ProjectData.fromJson(Map<String, dynamic> json) {
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
  String comment;
  String userId;
  String postedDate;
  String createdAt;
  String updatedAt;

  Comments(
      {this.id,
        this.projectId,
        this.comment,
        this.userId,
        this.postedDate,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
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