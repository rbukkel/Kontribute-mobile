class ResutPush {
  String country;
  String numCode;

  ResutPush({this.country, this.numCode});



  factory ResutPush.fromJson(Map<String, dynamic> parsedJson) {
    return ResutPush(
      country: parsedJson["country"] as String,
      numCode: parsedJson["num_code"] as String,
    );
  }


}






