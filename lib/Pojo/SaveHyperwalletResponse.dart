/// status : true
/// message : "Data Update Successfully"

class SaveHyperwalletResponse {
  SaveHyperwalletResponse({
      bool status, 
      String message,}){
    _status = status;
    _message = message;
}

  SaveHyperwalletResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool _status;
  String _message;

  bool get status => _status;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}