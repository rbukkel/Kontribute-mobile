/// success : true
/// message : "Bank Details get Successfully."
/// data : [{"id":5,"user_id":118,"bankName":"WELLS FARGO BANK","userToken":"usr-829aaae5-e770-4b34-bd14-7c69a7d80b66","token":"trm-5a59169e-4ab3-4bfa-9ade-5cfe6a180c55","profileType":"INDIVIDUAL","transferMethodCountry":"US","transferMethodCurrency":"USD","type":"BANK_ACCOUNT","branchId":"101089292","bankAccountId":"123456787","bankAccountPurpose":"SAVINGS","country":"IN","links":"https://api.sandbox.hyperwallet.com/rest/v3/users/usr-829aaae5-e770-4b34-bd14-7c69a7d80b66/bank-accounts/trm-5a59169e-4ab3-4bfa-9ade-5cfe6a180c55","status":"ACTIVATED","created_at":"2022-03-25 10:36:57","updated_at":null}]

class GetBankDeatilsPojo {
  GetBankDeatilsPojo({
      bool success, 
      String message, 
      List<Data> data,}){
    _success = success;
    _message = message;
    _data = data;
}

  GetBankDeatilsPojo.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  bool _success;
  String _message;
  List<Data> _data;

  bool get success => _success;
  String get message => _message;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 5
/// user_id : 118
/// bankName : "WELLS FARGO BANK"
/// userToken : "usr-829aaae5-e770-4b34-bd14-7c69a7d80b66"
/// token : "trm-5a59169e-4ab3-4bfa-9ade-5cfe6a180c55"
/// profileType : "INDIVIDUAL"
/// transferMethodCountry : "US"
/// transferMethodCurrency : "USD"
/// type : "BANK_ACCOUNT"
/// branchId : "101089292"
/// bankAccountId : "123456787"
/// bankAccountPurpose : "SAVINGS"
/// country : "IN"
/// links : "https://api.sandbox.hyperwallet.com/rest/v3/users/usr-829aaae5-e770-4b34-bd14-7c69a7d80b66/bank-accounts/trm-5a59169e-4ab3-4bfa-9ade-5cfe6a180c55"
/// status : "ACTIVATED"
/// created_at : "2022-03-25 10:36:57"
/// updated_at : null

class Data {
  Data({
      int id, 
      int userId, 
      String bankName, 
      String userToken, 
      String token, 
      String profileType, 
      String transferMethodCountry, 
      String transferMethodCurrency, 
      String type, 
      String branchId, 
      String bankAccountId, 
      String bankAccountPurpose, 
      String country, 
      String links, 
      String status, 
      String createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _userId = userId;
    _bankName = bankName;
    _userToken = userToken;
    _token = token;
    _profileType = profileType;
    _transferMethodCountry = transferMethodCountry;
    _transferMethodCurrency = transferMethodCurrency;
    _type = type;
    _branchId = branchId;
    _bankAccountId = bankAccountId;
    _bankAccountPurpose = bankAccountPurpose;
    _country = country;
    _links = links;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bankName = json['bankName'];
    _userToken = json['userToken'];
    _token = json['token'];
    _profileType = json['profileType'];
    _transferMethodCountry = json['transferMethodCountry'];
    _transferMethodCurrency = json['transferMethodCurrency'];
    _type = json['type'];
    _branchId = json['branchId'];
    _bankAccountId = json['bankAccountId'];
    _bankAccountPurpose = json['bankAccountPurpose'];
    _country = json['country'];
    _links = json['links'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int _id;
  int _userId;
  String _bankName;
  String _userToken;
  String _token;
  String _profileType;
  String _transferMethodCountry;
  String _transferMethodCurrency;
  String _type;
  String _branchId;
  String _bankAccountId;
  String _bankAccountPurpose;
  String _country;
  String _links;
  String _status;
  String _createdAt;
  dynamic _updatedAt;

  int get id => _id;
  int get userId => _userId;
  String get bankName => _bankName;
  String get userToken => _userToken;
  String get token => _token;
  String get profileType => _profileType;
  String get transferMethodCountry => _transferMethodCountry;
  String get transferMethodCurrency => _transferMethodCurrency;
  String get type => _type;
  String get branchId => _branchId;
  String get bankAccountId => _bankAccountId;
  String get bankAccountPurpose => _bankAccountPurpose;
  String get country => _country;
  String get links => _links;
  String get status => _status;
  String get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bankName'] = _bankName;
    map['userToken'] = _userToken;
    map['token'] = _token;
    map['profileType'] = _profileType;
    map['transferMethodCountry'] = _transferMethodCountry;
    map['transferMethodCurrency'] = _transferMethodCurrency;
    map['type'] = _type;
    map['branchId'] = _branchId;
    map['bankAccountId'] = _bankAccountId;
    map['bankAccountPurpose'] = _bankAccountPurpose;
    map['country'] = _country;
    map['links'] = _links;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}