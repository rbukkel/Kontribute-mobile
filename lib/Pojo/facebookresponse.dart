class facebookresponse {
  String message;
  bool status;
  Result result;

  facebookresponse({this.message, this.status, this.result});

  facebookresponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  String fullName;
  String email;
  Null emailVerifiedAt;
  Null nickName;
  Null mobile;
  Null dob;
  Null nationality;
  Null currentCountry;
  String facebookId;
  String profilePic;
  String userType;
  String status;
  Null mobileToken;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
      this.fullName,
      this.email,
      this.emailVerifiedAt,
      this.nickName,
      this.mobile,
      this.dob,
      this.nationality,
      this.currentCountry,
      this.facebookId,
      this.profilePic,
      this.userType,
      this.status,
      this.mobileToken,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nickName = json['nick_name'];
    mobile = json['mobile'];
    dob = json['dob'];
    nationality = json['nationality'];
    currentCountry = json['current_country'];
    facebookId = json['facebook_id'];
    profilePic = json['profile_pic'];
    userType = json['user_type'];
    status = json['status'];
    mobileToken = json['mobile_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['nick_name'] = this.nickName;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['current_country'] = this.currentCountry;
    data['facebook_id'] = this.facebookId;
    data['profile_pic'] = this.profilePic;
    data['user_type'] = this.userType;
    data['status'] = this.status;
    data['mobile_token'] = this.mobileToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}