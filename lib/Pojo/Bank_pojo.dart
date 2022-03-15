class BankPojo {
  BankPojo({
      String token, 
      String type, 
      String status, 
      String verificationStatus, 
      String createdOn, 
      String transferMethodCountry, 
      String transferMethodCurrency, 
      String bankName, 
      String branchId, 
      String bankAccountId, 
      String bankAccountPurpose, 
      String userToken, 
      String profileType, 
      String firstName, 
      String lastName, 
      String addressLine1, 
      String city, 
      String stateProvince, 
      String country, 
      String postalCode, 
      List<Links> links,}){
    _token = token;
    _type = type;
    _status = status;
    _verificationStatus = verificationStatus;
    _createdOn = createdOn;
    _transferMethodCountry = transferMethodCountry;
    _transferMethodCurrency = transferMethodCurrency;
    _bankName = bankName;
    _branchId = branchId;
    _bankAccountId = bankAccountId;
    _bankAccountPurpose = bankAccountPurpose;
    _userToken = userToken;
    _profileType = profileType;
    _firstName = firstName;
    _lastName = lastName;
    _addressLine1 = addressLine1;
    _city = city;
    _stateProvince = stateProvince;
    _country = country;
    _postalCode = postalCode;
    _links = links;
}

  BankPojo.fromJson(dynamic json) {
    _token = json['token'];
    _type = json['type'];
    _status = json['status'];
    _verificationStatus = json['verificationStatus'];
    _createdOn = json['createdOn'];
    _transferMethodCountry = json['transferMethodCountry'];
    _transferMethodCurrency = json['transferMethodCurrency'];
    _bankName = json['bankName'];
    _branchId = json['branchId'];
    _bankAccountId = json['bankAccountId'];
    _bankAccountPurpose = json['bankAccountPurpose'];
    _userToken = json['userToken'];
    _profileType = json['profileType'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _addressLine1 = json['addressLine1'];
    _city = json['city'];
    _stateProvince = json['stateProvince'];
    _country = json['country'];
    _postalCode = json['postalCode'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links.add(Links.fromJson(v));
      });
    }
  }
  String _token;
  String _type;
  String _status;
  String _verificationStatus;
  String _createdOn;
  String _transferMethodCountry;
  String _transferMethodCurrency;
  String _bankName;
  String _branchId;
  String _bankAccountId;
  String _bankAccountPurpose;
  String _userToken;
  String _profileType;
  String _firstName;
  String _lastName;
  String _addressLine1;
  String _city;
  String _stateProvince;
  String _country;
  String _postalCode;
  List<Links> _links;

  String get token => _token;
  String get type => _type;
  String get status => _status;
  String get verificationStatus => _verificationStatus;
  String get createdOn => _createdOn;
  String get transferMethodCountry => _transferMethodCountry;
  String get transferMethodCurrency => _transferMethodCurrency;
  String get bankName => _bankName;
  String get branchId => _branchId;
  String get bankAccountId => _bankAccountId;
  String get bankAccountPurpose => _bankAccountPurpose;
  String get userToken => _userToken;
  String get profileType => _profileType;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get addressLine1 => _addressLine1;
  String get city => _city;
  String get stateProvince => _stateProvince;
  String get country => _country;
  String get postalCode => _postalCode;
  List<Links> get links => _links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['type'] = _type;
    map['status'] = _status;
    map['verificationStatus'] = _verificationStatus;
    map['createdOn'] = _createdOn;
    map['transferMethodCountry'] = _transferMethodCountry;
    map['transferMethodCurrency'] = _transferMethodCurrency;
    map['bankName'] = _bankName;
    map['branchId'] = _branchId;
    map['bankAccountId'] = _bankAccountId;
    map['bankAccountPurpose'] = _bankAccountPurpose;
    map['userToken'] = _userToken;
    map['profileType'] = _profileType;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['addressLine1'] = _addressLine1;
    map['city'] = _city;
    map['stateProvince'] = _stateProvince;
    map['country'] = _country;
    map['postalCode'] = _postalCode;
    if (_links != null) {
      map['links'] = _links.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Links {
  Links({
      Params params, 
      String href,}){
    _params = params;
    _href = href;
}

  Links.fromJson(dynamic json) {
    _params = json['params'] != null ? Params.fromJson(json['params']) : null;
    _href = json['href'];
  }
  Params _params;
  String _href;

  Params get params => _params;
  String get href => _href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_params != null) {
      map['params'] = _params.toJson();
    }
    map['href'] = _href;
    return map;
  }

}

class Params {
  Params({
      String rel,}){
    _rel = rel;
}

  Params.fromJson(dynamic json) {
    _rel = json['rel'];
  }
  String _rel;

  String get rel => _rel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rel'] = _rel;
    return map;
  }

}