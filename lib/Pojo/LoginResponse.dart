class LoginResponse {
  bool success;
  String message;
  ResultPush resultPush;

  LoginResponse({this.success, this.message, this.resultPush});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    resultPush = json['result_push'] != null
        ? new ResultPush.fromJson(json['result_push'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.resultPush != null) {
      data['result_push'] = this.resultPush.toJson();
    }
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
  String countryCode;
  String facebookId;
  String profilePic;
  String usertype;
  String mobileToken;
  String hyperwalletId;
  String addressLine1;
  String city;
  String stateProvince;
  String postalCode;

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
        this.countryCode,
        this.facebookId,
        this.profilePic,
        this.usertype,
        this.mobileToken,
        this.hyperwalletId,
        this.addressLine1,
        this.city,
        this.stateProvince,
        this.postalCode});

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
    countryCode = json['country_code'];
    facebookId = json['facebook_id'];
    profilePic = json['profile_pic'];
    usertype = json['usertype'];
    mobileToken = json['mobile_token'];
    hyperwalletId = json['hyperwallet_id'];
    addressLine1 = json['addressLine1'];
    city = json['city'];
    stateProvince = json['stateProvince'];
    postalCode = json['postalCode'];
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
    data['country_code'] = this.countryCode;
    data['facebook_id'] = this.facebookId;
    data['profile_pic'] = this.profilePic;
    data['usertype'] = this.usertype;
    data['mobile_token'] = this.mobileToken;
    data['hyperwallet_id'] = this.hyperwalletId;
    data['addressLine1'] = this.addressLine1;
    data['city'] = this.city;
    data['stateProvince'] = this.stateProvince;
    data['postalCode'] = this.postalCode;
    return data;
  }
}