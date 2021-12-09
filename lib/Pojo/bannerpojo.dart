class bannerpojo {
  bool success;
  List<Projectimages> projectimages;
  String message;

  bannerpojo({this.success, this.projectimages, this.message});

  bannerpojo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Projectimages'] != null) {
      projectimages = new List<Projectimages>();
      json['Projectimages'].forEach((v) {
        projectimages.add(new Projectimages.fromJson(v));
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

  Projectimages(
      {this.id,
      this.projectId,
      this.imagePath,
      this.status,
      this.postedDate,
      this.createdAt,
      this.updatedAt});

  Projectimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    imagePath = json['image_path'];
    status = json['status'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}