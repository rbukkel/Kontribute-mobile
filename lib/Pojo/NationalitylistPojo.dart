class NationalitylistPojo {
  List<ResultPush> resultPush;
  bool success;
  String message;

  NationalitylistPojo({this.resultPush, this.success, this.message});

  NationalitylistPojo.fromJson(Map<String, dynamic> json) {
    if (json['result_push'] != null) {
      resultPush = new List<ResultPush>();
      json['result_push'].forEach((v) {
        resultPush.add(new ResultPush.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultPush != null) {
      data['result_push'] = this.resultPush.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class ResultPush {
  String nationality;
  String numCode;

  ResultPush({this.nationality, this.numCode});

  ResultPush.fromJson(Map<String, dynamic> json) {
    nationality = json['nationality'];
    numCode = json['num_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nationality'] = this.nationality;
    data['num_code'] = this.numCode;
    return data;
  }
}