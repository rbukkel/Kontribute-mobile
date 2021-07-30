import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Ui/login.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/FAQ%20.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/ProfileScreen.dart';
import 'package:kontribute/Ui/TermsandCondition.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';

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
  int userid;
  LoginResponse loginres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedUtils.readProfile().then((response) {
      if (response != null) {
        loginres = response;
        userid = loginres.resultPush.userId;
        if (loginres.resultPush.fullName != null || loginres.resultPush.fullName  != "") {
          username = loginres.resultPush.fullName ;
          print("user name: " + username.toString());
        }
        else {
          username = "" ;
          print("user name: " + username.toString());
        }

        if(loginres.resultPush.profilePic !=null){
          setState(() {
            image = loginres.resultPush.profilePic;
            print("pic: "+image.toString());
            if(image.isNotEmpty){
              imageUrl = true;
            }
          });
        }

      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/nav_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Stack(
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
                                :Image.asset("assets/images/userProfile.png", height: 70,
                              width: 70),),
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
                                  fontSize: 16,
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
                                  "Home",
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
                                  "Profile",
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
                                  "My Transactions",
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
                                  "Wallet",
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
                                  "FAQ",
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
                                  "Terms & Conditions",
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
                                  "Contact Us",
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
                                  "Share",
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
                                  "Logout",
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
            ))
          ],
        ),
      ),
    );
  }

  void drawer_function(var next_screen, BuildContext context) async {
    Navigator.pop(context);
    switch (next_screen) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mytranscation(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletScreen(),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FAQ(),
          ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;
      case 9:
        logout(context);

        break;
    }
  }

  void logout(BuildContext context1) {
   Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
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
