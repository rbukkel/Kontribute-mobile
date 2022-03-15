
class GethyperwalletPojo {
  GethyperwalletPojo({
      bool status, 
      String message, 
      Data data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GethyperwalletPojo.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _status;
  String _message;
  Data _data;

  bool get status => _status;
  String get message => _message;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}



class Data {
  Data({
      int userId, 
      String hyperwalletId, 
      String bankStatus,}){
    _userId = userId;
    _hyperwalletId = hyperwalletId;
    _bankStatus = bankStatus;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _hyperwalletId = json['hyperwallet_id'];
    _bankStatus = json['bank_status'];
  }
  int _userId;
  String _hyperwalletId;
  String _bankStatus;

  int get userId => _userId;
  String get hyperwalletId => _hyperwalletId;
  String get bankStatus => _bankStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['hyperwallet_id'] = _hyperwalletId;
    map['bank_status'] = _bankStatus;
    return map;
  }

}