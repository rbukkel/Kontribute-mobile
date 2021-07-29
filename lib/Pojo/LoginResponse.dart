class LoginResponse {
  ResultPush resultPush;
  bool success;
  String message;

  LoginResponse({this.resultPush, this.success, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    resultPush = json['result_push'] != null
        ? new ResultPush.fromJson(json['result_push'])
        : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultPush != null) {
      data['result_push'] = this.resultPush.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class ResultPush {
  int userId;
  String nickName;
  String fullName;
  String email;
  String password;
  String mobile;
  String dob;
  String nationality;
  String currentCountry;
  String profilePic;
  String usertype;
  String mobileToken;

  ResultPush(
      {this.userId,
      this.nickName,
      this.fullName,
      this.email,
      this.password,
      this.mobile,
      this.dob,
      this.nationality,
      this.currentCountry,
      this.profilePic,
      this.usertype,
      this.mobileToken});

  ResultPush.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nickName = json['nick_name'];
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    dob = json['dob'];
    nationality = json['nationality'];
    currentCountry = json['current_country'];
    profilePic = json['profile_pic'];
    usertype = json['usertype'];
    mobileToken = json['mobile_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['nick_name'] = this.nickName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['current_country'] = this.currentCountry;
    data['profile_pic'] = this.profilePic;
    data['usertype'] = this.usertype;
    data['mobile_token'] = this.mobileToken;
    return data;
  }
}