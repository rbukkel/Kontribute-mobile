class MyTransactionsPojo {
  bool status;
  List<TransactionsReceived> transactionsReceived;
  List<PaidTransaction> paidTransaction;
  String message;

  MyTransactionsPojo(
      {this.status,
      this.transactionsReceived,
      this.paidTransaction,
      this.message});

  MyTransactionsPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['transactions_received'] != null) {
      transactionsReceived = new List<TransactionsReceived>();
      json['transactions_received'].forEach((v) {
        transactionsReceived.add(new TransactionsReceived.fromJson(v));
      });
    }
    if (json['paid_transaction'] != null) {
      paidTransaction = new List<PaidTransaction>();
      json['paid_transaction'].forEach((v) {
        paidTransaction.add(new PaidTransaction.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transactionsReceived != null) {
      data['transactions_received'] =
          this.transactionsReceived.map((v) => v.toJson()).toList();
    }
    if (this.paidTransaction != null) {
      data['paid_transaction'] =
          this.paidTransaction.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class TransactionsReceived {
  String id;
  String amount;
  String paiddate;
  String paidfor;

  TransactionsReceived({this.id, this.amount, this.paiddate, this.paidfor});

  TransactionsReceived.fromJson(Map<String, dynamic> json) {

    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['amount'] is int)
    {
      amount = json['amount'].toString();
    }
    else{
      amount = json['amount'];
    }

    paiddate = json['paiddate'];
    paidfor = json['paidfor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['paiddate'] = this.paiddate;
    data['paidfor'] = this.paidfor;
    return data;
  }
}

class PaidTransaction {
  String id;
  String amount;
  String paiddate;
  String paidfor;

  PaidTransaction({this.id, this.amount, this.paiddate, this.paidfor});

  PaidTransaction.fromJson(Map<String, dynamic> json) {
    if(json['id'] is int)
    {
      id = json['id'].toString();
    }
    else{
      id = json['id'];
    }
    if(json['amount'] is int)
    {
      amount = json['amount'].toString();
    }
    else{
      amount = json['amount'];
    }
    paiddate = json['paiddate'];
    paidfor = json['paidfor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['paiddate'] = this.paiddate;
    data['paidfor'] = this.paidfor;
    return data;
  }
}