class EventCategoryPojo {
  String message;
  bool status;
  List<ResultPush> resultPush;

  EventCategoryPojo({this.message, this.status, this.resultPush});

  EventCategoryPojo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['result_push'] != null) {
      resultPush = new List<ResultPush>();
      json['result_push'].forEach((v) {
        resultPush.add(new ResultPush.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.resultPush != null) {
      data['result_push'] = this.resultPush.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultPush {
  int catId;
  String categoryName;
  String categoryPic;

  ResultPush({this.catId, this.categoryName, this.categoryPic});

  ResultPush.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    categoryName = json['category_name'];
    categoryPic = json['category_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['category_name'] = this.categoryName;
    data['category_pic'] = this.categoryPic;
    return data;
  }
}