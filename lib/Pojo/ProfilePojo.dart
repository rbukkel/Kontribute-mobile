class ProfilePojo {
  bool status;
  Data data;
  String message;

  ProfilePojo({this.status, this.data, this.message});

  ProfilePojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String fullName;
  String email;
  String nickName;
  String dob;
  String nationality;
  String facebookId;
  String profilepic;
  String status;
  String mobileToken;
  List<CopleteProjects> copleteProjects;

  Data(
      {this.id,
      this.fullName,
      this.email,
      this.nickName,
      this.dob,
      this.nationality,
      this.facebookId,
      this.profilepic,
      this.status,
      this.mobileToken,
      this.copleteProjects});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    nickName = json['nick_name'];
    dob = json['dob'];
    nationality = json['nationality'];
    facebookId = json['facebook_id'];
    profilepic = json['profilepic'];
    status = json['status'];
    mobileToken = json['mobile_token'];
    if (json['coplete_projects'] != null) {
      copleteProjects = new List<CopleteProjects>();
      json['coplete_projects'].forEach((v) {
        copleteProjects.add(new CopleteProjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['nick_name'] = this.nickName;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['facebook_id'] = this.facebookId;
    data['profilepic'] = this.profilepic;
    data['status'] = this.status;
    data['mobile_token'] = this.mobileToken;
    if (this.copleteProjects != null) {
      data['coplete_projects'] =
          this.copleteProjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CopleteProjects {
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
  String documents;
  String viewType;
  String members;
  String termsAndCondition;
  String postedDate;
  String status;
  String createdAt;
  String updatedAt;

  CopleteProjects(
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
      this.updatedAt});

  CopleteProjects.fromJson(Map<String, dynamic> json) {
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
    documents = json['documents'];
    viewType = json['view_type'];
    members = json['members'];
    termsAndCondition = json['terms_and_condition'];
    postedDate = json['posted_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['documents'] = this.documents;
    data['view_type'] = this.viewType;
    data['members'] = this.members;
    data['terms_and_condition'] = this.termsAndCondition;
    data['posted_date'] = this.postedDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}