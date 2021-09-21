class sendinvitationListingpojo {
  bool status;
  String message;
  List<Inviationdata> inviationdata;

  sendinvitationListingpojo({this.status, this.message, this.inviationdata});

  sendinvitationListingpojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['inviationdata'] != null) {
      inviationdata = new List<Inviationdata>();
      json['inviationdata'].forEach((v) {
        inviationdata.add(new Inviationdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.inviationdata != null) {
      data['inviationdata'] =
          this.inviationdata.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inviationdata {
  int id;
  String name;
  String email;
  String mobile;
  String message;
  String status;
  String senderid;
  String createdAt;
  String updatedAt;

  Inviationdata(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.message,
      this.status,
      this.senderid,
      this.createdAt,
      this.updatedAt});

  Inviationdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    message = json['message'];
    status = json['status'];
    senderid = json['senderid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['message'] = this.message;
    data['status'] = this.status;
    data['senderid'] = this.senderid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}