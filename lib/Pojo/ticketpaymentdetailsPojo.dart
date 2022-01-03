class ticketpaymentdetailsPojo {
  bool status;
  List<TicketQrlisting> ticketQrlisting;
  String message;

  ticketpaymentdetailsPojo({this.status, this.ticketQrlisting, this.message});

  ticketpaymentdetailsPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['ticket_qrlisting'] != null) {
      ticketQrlisting = new List<TicketQrlisting>();
      json['ticket_qrlisting'].forEach((v) {
        ticketQrlisting.add(new TicketQrlisting.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.ticketQrlisting != null) {
      data['ticket_qrlisting'] =
          this.ticketQrlisting.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class TicketQrlisting {
  String ticketId;
  String paymentId;
  String ticketNo;
  String status;
  String imagePath;
  String buyDate;

  TicketQrlisting(
      {this.ticketId,
      this.paymentId,
      this.ticketNo,
      this.status,
      this.imagePath,
      this.buyDate});

  TicketQrlisting.fromJson(Map<String, dynamic> json) {
    if(json['ticket_id'] is int)
    {
      ticketId = json['ticket_id'].toString();
    }
    else{
      ticketId = json['ticket_id'];
    }

    if(json['payment_id'] is int)
    {
      paymentId = json['payment_id'].toString();
    }
    else{
      paymentId = json['payment_id'];
    }

    ticketNo = json['ticket_no'];
    status = json['status'];
    imagePath = json['image_path'];
    buyDate = json['buy_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['payment_id'] = this.paymentId;
    data['ticket_no'] = this.ticketNo;
    data['status'] = this.status;
    data['image_path'] = this.imagePath;
    data['buy_date'] = this.buyDate;
    return data;
  }
}