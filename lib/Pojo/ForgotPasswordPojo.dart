class ForgotPasswordPojo {
  String message;
  bool status;

  ForgotPasswordPojo({this.message, this.status});

  ForgotPasswordPojo.fromJson(Map<String, dynamic> json)
  {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

