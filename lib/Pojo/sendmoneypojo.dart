class sendmoneypojo {
  bool success;
  String message;
  String paypalAmount;
  int paymentId;
  Paymentdetails paymentdetails;

  sendmoneypojo(
      {this.success,
      this.message,
      this.paypalAmount,
      this.paymentId,
      this.paymentdetails});

  sendmoneypojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    paypalAmount = json['paypal_amount'];
    paymentId = json['payment_id'];
    paymentdetails = json['paymentdetails'] != null
        ? new Paymentdetails.fromJson(json['paymentdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['paypal_amount'] = this.paypalAmount;
    data['payment_id'] = this.paymentId;
    if (this.paymentdetails != null) {
      data['paymentdetails'] = this.paymentdetails.toJson();
    }
    return data;
  }
}

class Paymentdetails {
  String senderId;
  int receiverId;
  int amountRequested;
  double amountPaid;
  String groupId;
  String payDate;
  String status;
  String requestId;
  String updatedAt;
  String createdAt;
  int id;

  Paymentdetails(
      {this.senderId,
      this.receiverId,
      this.amountRequested,
      this.amountPaid,
      this.groupId,
      this.payDate,
      this.status,
      this.requestId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Paymentdetails.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    amountRequested = json['amount_requested'];
    if(json['amount_paid'] is int)
    {
      amountPaid = double.parse(json['amount_paid']);
    }
    else
    {
      amountPaid = json['amount_paid'];
    }

    groupId = json['group_id'];
    payDate = json['pay_date'];
    status = json['status'];
    requestId = json['request_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['amount_requested'] = this.amountRequested;
    data['amount_paid'] = this.amountPaid;
    data['group_id'] = this.groupId;
    data['pay_date'] = this.payDate;
    data['status'] = this.status;
    data['request_id'] = this.requestId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}