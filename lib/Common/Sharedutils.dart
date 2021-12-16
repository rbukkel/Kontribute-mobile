import 'dart:convert';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedUtils {
  SharedUtils._privateConstructor();

  static final SharedUtils instance = SharedUtils._privateConstructor();

  static SharedUtils mInstance;
  SharedPreferences sp;

  removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }


  static writeDonorId(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static readDonorId(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }


  static writeloginemail(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static readloginemail(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }


  static writeloginname(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static readloginname(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }



  static readloginData(String key, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  static writeloginData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }


  static writeTerms(String key, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  static readTerms(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }


  static saveImage(String image) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //Map decode_options = jsonDecode(jsonString);
    // String user = jsonEncode(LatLongData.fromJson(decode_options));
    shared_User.setString('image', image);
  }

  static readImage() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    // Map userMap = jsonDecode(shared_User.getString('image'));
    // var user = LatLongData.fromJson(userMap);
    String image = shared_User.getString('image');
    return image;
  }

  static saveToken(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static readToken(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static writeloginId(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static readloginId(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveProfile(String jsonString) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map decode_options = jsonDecode(jsonString);
    var user = jsonEncode(LoginResponse.fromJson(decode_options));
    shared_User.setString('profile', user);
  }

  static readProfile() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(shared_User.getString('profile'));
    var user = LoginResponse.fromJson(userMap);
    return user;
  }

  static saveLangaunage(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  static readLangaunage(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveDate(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  static readDate(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }


  static saveWeek(String key, int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }
  static readWeek(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

}
