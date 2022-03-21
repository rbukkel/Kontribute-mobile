/// success : true
/// message : "Gift Send Successfully"
/// data : {"sender_id":"48","receiver_id":"118","message":"hi","price":"100","gift_picture":"20220317091007.png","notification":"on","posted_date":"2022-03-17","status":"sent","can_see":"0","accept_terms":"0","updated_at":"2022-03-17T09:10:07.000000Z","created_at":"2022-03-17T09:10:07.000000Z","id":434}

class SendIndividualPojo {
  SendIndividualPojo({
      bool success, 
      String message, 
      Data data,}){
    _success = success;
    _message = message;
    _data = data;
}

  SendIndividualPojo.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _success;
  String _message;
  Data _data;

  bool get success => _success;
  String get message => _message;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// sender_id : "48"
/// receiver_id : "118"
/// message : "hi"
/// price : "100"
/// gift_picture : "20220317091007.png"
/// notification : "on"
/// posted_date : "2022-03-17"
/// status : "sent"
/// can_see : "0"
/// accept_terms : "0"
/// updated_at : "2022-03-17T09:10:07.000000Z"
/// created_at : "2022-03-17T09:10:07.000000Z"
/// id : 434

class Data {
  Data({
      String senderId, 
      String receiverId, 
      String message, 
      String price, 
      String giftPicture, 
      String notification, 
      String postedDate, 
      String status, 
      String canSee, 
      String acceptTerms, 
      String updatedAt, 
      String createdAt, 
      int id,}){
    _senderId = senderId;
    _receiverId = receiverId;
    _message = message;
    _price = price;
    _giftPicture = giftPicture;
    _notification = notification;
    _postedDate = postedDate;
    _status = status;
    _canSee = canSee;
    _acceptTerms = acceptTerms;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _senderId = json['sender_id'];
    _receiverId = json['receiver_id'];
    _message = json['message'];
    _price = json['price'];
    _giftPicture = json['gift_picture'];
    _notification = json['notification'];
    _postedDate = json['posted_date'];
    _status = json['status'];
    _canSee = json['can_see'];
    _acceptTerms = json['accept_terms'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String _senderId;
  String _receiverId;
  String _message;
  String _price;
  String _giftPicture;
  String _notification;
  String _postedDate;
  String _status;
  String _canSee;
  String _acceptTerms;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get senderId => _senderId;
  String get receiverId => _receiverId;
  String get message => _message;
  String get price => _price;
  String get giftPicture => _giftPicture;
  String get notification => _notification;
  String get postedDate => _postedDate;
  String get status => _status;
  String get canSee => _canSee;
  String get acceptTerms => _acceptTerms;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_id'] = _senderId;
    map['receiver_id'] = _receiverId;
    map['message'] = _message;
    map['price'] = _price;
    map['gift_picture'] = _giftPicture;
    map['notification'] = _notification;
    map['posted_date'] = _postedDate;
    map['status'] = _status;
    map['can_see'] = _canSee;
    map['accept_terms'] = _acceptTerms;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}