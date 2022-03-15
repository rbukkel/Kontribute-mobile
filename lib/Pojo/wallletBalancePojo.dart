class wallletBalancePojo {
  bool success;
  String message;
  String currentBalance;
  List<Withdrawlisting> withdrawlisting;

  wallletBalancePojo(
      {this.success, this.message, this.currentBalance, this.withdrawlisting});

  wallletBalancePojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    currentBalance = json['current_balance'];
    if (json['withdrawlisting'] != null) {
      withdrawlisting = new List<Withdrawlisting>();
      json['withdrawlisting'].forEach((v) {
        withdrawlisting.add(new Withdrawlisting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['current_balance'] = this.currentBalance;
    if (this.withdrawlisting != null) {
      data['withdrawlisting'] =
          this.withdrawlisting.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Withdrawlisting {
  int id;
  int userId;
  Object amount;
  String currency;
  String clientPaymentId;
  String purpose;
  String destinationToken;
  String programToken;
  String expiresOn;
  String createdOn;
  String status;
  String links;
  String createdAt;
  Null updatedAt;

  Withdrawlisting(
      {this.id,
        this.userId,
        this.amount,
        this.currency,
        this.clientPaymentId,
        this.purpose,
        this.destinationToken,
        this.programToken,
        this.expiresOn,
        this.createdOn,
        this.status,
        this.links,
        this.createdAt,
        this.updatedAt});

  Withdrawlisting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    currency = json['currency'];
    clientPaymentId = json['clientPaymentId'];
    purpose = json['purpose'];
    destinationToken = json['destinationToken'];
    programToken = json['programToken'];
    expiresOn = json['expiresOn'];
    createdOn = json['createdOn'];
    status = json['status'];
    links = json['links'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['clientPaymentId'] = this.clientPaymentId;
    data['purpose'] = this.purpose;
    data['destinationToken'] = this.destinationToken;
    data['programToken'] = this.programToken;
    data['expiresOn'] = this.expiresOn;
    data['createdOn'] = this.createdOn;
    data['status'] = this.status;
    data['links'] = this.links;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}