import 'dart:convert';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Ui/EditProfileScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userid;
  bool internet = false;
  LoginResponse loginResponse;
  String val;
  String fullname;
  String nickname;
  String email;
  String mobile;
  String countrycode;
  String dob;
  String nationality;
  String country;
  bool imageUrl = false;
  bool _loading = false;
  String image;
  var storelist_length;

  @override
  void initState() {
    super.initState();
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        SharedUtils.readloginId("UserId").then((val) {
          print("UserId: " + val);
          userid = val;
          getData(userid);
          print("Login userid: " + userid.toString());
        });
        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        errorDialog('nointernetconnection'.tr);
      }
    });
  }

  void errorDialog(String text) {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: AppColors.whiteColor,
        child: new Container(
          margin: EdgeInsets.all(5),
          width: 300.0,
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.error,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                color: AppColors.whiteColor,
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    'ok'.tr,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void getData(String id) async {
    Map data = {
      'userid': id.toString(),
    };
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.get_profiledata, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);
      } else {
        loginResponse = new LoginResponse.fromJson(jsonResponse);
        print("Json profile data: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            storelist_length = loginResponse.resultPush;
            if (loginResponse.resultPush.fullName == "") {
              fullname = "";
            } else {
              fullname = loginResponse.resultPush.fullName;
            }

            if (loginResponse.resultPush.nickName == "") {
              nickname = "";
            } else {
              nickname = loginResponse.resultPush.nickName;
            }

            if (loginResponse.resultPush.email == "") {
              email = "";
            } else {
              email = loginResponse.resultPush.email;
            }

            if (loginResponse.resultPush.mobile == "") {
              mobile = "";
            } else {
              mobile = loginResponse.resultPush.mobile;
            }

            if (loginResponse.resultPush.countryCode == "") {
              countrycode = "";
            } else {
              countrycode = loginResponse.resultPush.countryCode;
            }

            if (loginResponse.resultPush.dob == "") {
              dob = "";
            } else {
              dob = loginResponse.resultPush.dob;
            }

            if (loginResponse.resultPush.nationality == "") {
              nationality = "";
            } else {
              nationality = loginResponse.resultPush.nationality;
            }

            if (loginResponse.resultPush.currentCountry == "") {
              country = "";
            } else {
              country = loginResponse.resultPush.currentCountry;
            }

            if (loginResponse.resultPush.profilePic != null ||
                loginResponse.resultPush.profilePic != "") {
              setState(() {
                image = loginResponse.resultPush.profilePic;
                if (image.isNotEmpty) {
                  imageUrl = true;
                  _loading = true;
                }
              });
            }
          });
        } else {
          errorDialog(loginResponse.message);

        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 12,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/appbar.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 6,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/menu.png",
                          color: AppColors.whiteColor,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      'profile'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins-Regular",
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 3,
                        top: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
            ),
            storelist_length != null
                ? Expanded(
                    child: Column(
                    children: [
                      Stack(
                        children: [
                          imageUrl == false
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: 120,
                                  height: 120,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/images/person.png",
                                    height: 120,
                                    width: 120,
                                  )),
                                )
                              : loginResponse.resultPush.facebookId == ""
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2),
                                      child: _loading
                                          ? ClipOval(
                                              child: CachedNetworkImage(
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    Network.BaseApiprofile +
                                                        image,
                                                placeholder: (context, url) => Container(
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    width: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    child: Center(
                                                        child:
                                                            new CircularProgressIndicator())),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            )
                                          : CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.grey),
                                            ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 2),
                                      child: _loading
                                          ? ClipOval(
                                              child: CachedNetworkImage(
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.fill,
                                                imageUrl: image,
                                                placeholder: (context, url) => Container(
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    width: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    child: Center(
                                                        child:
                                                            new CircularProgressIndicator())),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            )
                                          : CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.grey),
                                            ),
                                    ),
                          /* Container(

                  alignment: Alignment.bottomRight,
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    "assets/images/editprofile.png",
                    height: 25,
                    width: 25,
                  ),
                ),*/
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 3),
                            alignment: Alignment.topCenter,
                            width: SizeConfig.blockSizeHorizontal * 65,
                            child: Text(
                              fullname + "(" + nickname + ")",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProfileScreen()));

                              callNext(
                                  EditProfileScreen(data: userid.toString()),
                                  context);
                            },
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 25,
                              height: SizeConfig.blockSizeVertical * 5,
                              decoration: BoxDecoration(
                                color: AppColors.yelowbg,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'edit'.tr,
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal * 2),
                                    child: Image.asset(
                                      "assets/images/edit.png",
                                      color: AppColors.whiteColor,
                                      width: 15,
                                      height: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 2),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            child: Text(
                              'email'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 2),
                            width: SizeConfig.blockSizeHorizontal * 58,
                            child: Text(
                              email,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            child: Text(
                              'mobileno'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 58,
                            child: Text(
                              countrycode+"-"+mobile,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            child: Text(
                              'dateofbirth'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 58,
                            child: Text(
                              dob,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      ),
                      /*  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.companyname,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal *58,
                  child: Text(
                    StringConstant.dummycompanyname,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ],
            ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            child: Text(
                              'nationality'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 58,
                            child: Text(
                              nationality,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            child: Text(
                              'currentcountry'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.blockSizeHorizontal * 58,
                            child: Text(
                              country,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
                : Container(
                    margin: EdgeInsets.only(top: 150),
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
