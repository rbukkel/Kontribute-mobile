import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/MyConnections/Connections.dart';
import 'package:kontribute/Ui/login.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/FAQ%20.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/ProfileScreen.dart';
import 'package:kontribute/Ui/TermsandCondition.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/mynetwork.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class Drawer_Screen extends StatefulWidget {
  @override
  _Drawer_ScreenState createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  bool imageUrl = false;
  bool _loading = false;
  String image;
  String username="";
  String email;
  bool internet = false;
  String userid;
  String val;
  var storelist_length;
  LoginResponse loginResponse;

  @override
  void initState() {
    // TODO: implement initState
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
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });

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
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        loginResponse = new LoginResponse.fromJson(jsonResponse);
        print("Json profile data: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            storelist_length = loginResponse.resultPush;
            if (loginResponse.resultPush.fullName == "") {
              username = "";
            } else {
              username = loginResponse.resultPush.fullName;
            }


            if (loginResponse.resultPush.email == "") {
              email = "";
            } else {
              email = loginResponse.resultPush.email;
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
          Fluttertoast.showToast(
            msg: loginResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        height: double.infinity,
            color: AppColors.themecolor,
            child:  Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/nav_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 10,
                                left: SizeConfig.blockSizeVertical * 2),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                  height: 70,
                                  width: 70,
                                  child: ClipOval(child:  imageUrl?
                                  ClipOval(child:  CachedNetworkImage(
                                    height: 70,width: 70,fit: BoxFit.fill ,
                                    imageUrl:image,
                                    placeholder: (context, url) => Container(
                                        height: SizeConfig.blockSizeVertical * 5, width: SizeConfig.blockSizeVertical * 5,
                                        child: Center(child: new CircularProgressIndicator())),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),)
                                      :Container(
                                      height: SizeConfig.blockSizeVertical * 5, width: SizeConfig.blockSizeVertical * 5,
                                      child: Center(child: new CircularProgressIndicator())),),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 53,
                                  child: Text(
                                    username,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(1,context);

                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_home.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        "home".tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(2,context);

                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical *4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/person.png",
                                      height: 25,
                                      width: 25,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'profile'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(3,context);
                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/network.png",
                                      height: 25,
                                      width: 25,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'mynetwork'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(4,context);
                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_mytranscaton.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'mytransactions'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          /*    InkWell(
                            onTap: () {
                              drawer_function(5,context);
                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/walleticon.png",
                                      color: Colors.white,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'wallet'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),*/
                          InkWell(
                            onTap: () {
                              drawer_function(5,context);

                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_faq.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'faq'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(6,context);
                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_termsconditon.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'termsconditions'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(7,context);

                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_contactus.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'contactus'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(8,context);
                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/nav_share.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'share'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              drawer_function(9,context);

                              // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 4,
                                  bottom: SizeConfig.blockSizeVertical *4,
                                  left: SizeConfig.blockSizeVertical * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/logout.png",
                                      height: 25,
                                      width: 25,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        'logout'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),)

    );
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds:0));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: (){
                signOutGoogle(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> signOutGoogle(BuildContext context) async {
    SharedUtils.readloginData("login",false);
    SharedUtils.writeloginId("UserId", "");
    SharedUtils.writeloginId("Usename", "");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext)=>login()), (route) => false);
    print("User Signed Out");
  }


  void drawer_function(var next_screen, BuildContext context) async {
    Navigator.pop(context);
    switch (next_screen) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
        case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Connections(),),);
        break;

      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => mytranscation(),
          ),
        );
        break;
     /* case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen(),
          ),
        );
        break;*/
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ(),),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TermsandCondition(),
          ),
        );
        break;
        case 7:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactUs(),
          ),
        );
        break;
      case 8:
        Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 9:
        _showDialog();
        break;
    }
  }

  void logout(BuildContext context1) {
   Widget cancelButton = FlatButton
     (
      child: Text("No"),
      onPressed: ()
      {
        Navigator.of(context1,rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        Navigator.of(context1,rootNavigator: true).pop();
        SharedUtils.instance.removeAll();
        Navigator.of(context1).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => login()),
                (Route<dynamic> route) => false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context1,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}
