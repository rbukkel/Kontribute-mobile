class bannerpojo {
  bool success;
  List<Projectimages> projectimages;
  List<Donationimages> donationimages;
  List<Eventimages> eventimages;
  List<Ticketimages> ticketimages;
  String message;

  bannerpojo(
      {this.success,
        this.projectimages,
        this.donationimages,
        this.eventimages,
        this.ticketimages,
        this.message});

  bannerpojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Projectimages'] != null) {
      projectimages = new List<Projectimages>();
      json['Projectimages'].forEach((v) {
        projectimages.add(new Projectimages.fromJson(v));
      });
    }
    if (json['Donationimages'] != null) {
      donationimages = new List<Donationimages>();
      json['Donationimages'].forEach((v) {
        donationimages.add(new Donationimages.fromJson(v));
      });
    }
    if (json['Eventimages'] != null) {
      eventimages = new List<Eventimages>();
      json['Eventimages'].forEach((v) {
        eventimages.add(new Eventimages.fromJson(v));
      });
    }
    if (json['Ticketimages'] != null) {
      ticketimages = new List<Ticketimages>();
      json['Ticketimages'].forEach((v) {
        ticketimages.add(new Ticketimages.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.projectimages != null) {
      data['Projectimages'] =
          this.projectimages.map((v) => v.toJson()).toList();
    }
    if (this.donationimages != null) {
      data['Donationimages'] =
          this.donationimages.map((v) => v.toJson()).toList();
    }
    if (this.eventimages != null) {
      data['Eventimages'] = this.eventimages.map((v) => v.toJson()).toList();
    }
    if (this.ticketimages != null) {
      data['Ticketimages'] = this.ticketimages.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Projectimages {
  String id;
  String projectId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;
  String projectName;

  Projectimages(
      {this.id,
        this.projectId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.projectName});

  Projectimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project_name'] = this.projectName;
    return data;
  }
}

class Donationimages {
  String id;
  String donationId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;
  String campaignName;

  Donationimages(
      {this.id,
        this.donationId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.campaignName});

  Donationimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donationId = json['donation_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignName = json['campaign_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['donation_id'] = this.donationId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['campaign_name'] = this.campaignName;
    return data;
  }
}

class Eventimages {
  String id;
  String eventId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;
  String eventName;

  Eventimages(
      {this.id,
        this.eventId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.eventName});

  Eventimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event_name'] = this.eventName;
    return data;
  }
}

class Ticketimages {
  String id;
  String ticketId;
  String imagePath;
  String status;
  String postedDate;
  String createdAt;
  String updatedAt;
  String eventName;

  Ticketimages(
      {this.id,
        this.ticketId,
        this.imagePath,
        this.status,
        this.postedDate,
        this.createdAt,
        this.updatedAt,
        this.eventName});

  Ticketimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event_name'] = this.eventName;
    return data;
  }
}