class PaymentdetailPojo {
  PaymentdetailPojo({
      String token, 
      String status, 
      String createdOn, 
      String amount, 
      String currency, 
      String clientPaymentId, 
      String purpose, 
      String expiresOn, 
      String destinationToken, 
      String programToken, 
      List<Links> links,}){
    _token = token;
    _status = status;
    _createdOn = createdOn;
    _amount = amount;
    _currency = currency;
    _clientPaymentId = clientPaymentId;
    _purpose = purpose;
    _expiresOn = expiresOn;
    _destinationToken = destinationToken;
    _programToken = programToken;
    _links = links;
}

  PaymentdetailPojo.fromJson(dynamic json) {
    _token = json['token'];
    _status = json['status'];
    _createdOn = json['createdOn'];
    _amount = json['amount'];
    _currency = json['currency'];
    _clientPaymentId = json['clientPaymentId'];
    _purpose = json['purpose'];
    _expiresOn = json['expiresOn'];
    _destinationToken = json['destinationToken'];
    _programToken = json['programToken'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links.add(Links.fromJson(v));
      });
    }
  }
  String _token;
  String _status;
  String _createdOn;
  String _amount;
  String _currency;
  String _clientPaymentId;
  String _purpose;
  String _expiresOn;
  String _destinationToken;
  String _programToken;
  List<Links> _links;

  String get token => _token;
  String get status => _status;
  String get createdOn => _createdOn;
  String get amount => _amount;
  String get currency => _currency;
  String get clientPaymentId => _clientPaymentId;
  String get purpose => _purpose;
  String get expiresOn => _expiresOn;
  String get destinationToken => _destinationToken;
  String get programToken => _programToken;
  List<Links> get links => _links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['status'] = _status;
    map['createdOn'] = _createdOn;
    map['amount'] = _amount;
    map['currency'] = _currency;
    map['clientPaymentId'] = _clientPaymentId;
    map['purpose'] = _purpose;
    map['expiresOn'] = _expiresOn;
    map['destinationToken'] = _destinationToken;
    map['programToken'] = _programToken;
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