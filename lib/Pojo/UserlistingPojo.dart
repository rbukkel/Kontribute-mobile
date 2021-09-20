class UserlistingPojo {
  bool status;
  List<Data> data;
  String message;

  UserlistingPojo({this.status, this.data, this.message});

  UserlistingPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String fullName;
  String email;
  Null emailVerifiedAt;
  String nickName;
  String mobile;
  String dob;
  String nationality;
  String currentCountry;
  String countryCode;
  String facebookId;
  String profilePic;
  String userType;
  String status;
  String mobileToken;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.fullName,
      this.email,
      this.emailVerifiedAt,
      this.nickName,
      this.mobile,
      this.dob,
      this.nationality,
      this.currentCountry,
      this.countryCode,
      this.facebookId,
      this.profilePic,
      this.userType,
      this.status,
      this.mobileToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nickName = json['nick_name'];
    mobile = json['mobile'];
    dob = json['dob'];
    nationality = json['nationality'];
    currentCountry = json['current_country'];
    countryCode = json['country_code'];
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
    data['country_code'] = this.countryCode;
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