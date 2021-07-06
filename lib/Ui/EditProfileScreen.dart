import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class EditProfileScreen extends StatefulWidget{
  @override
  EditProfileScreenState createState() => EditProfileScreenState();

}

class EditProfileScreenState extends State<EditProfileScreen>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      "Profile",
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
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 4),
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    "assets/images/userProfile.png",
                    height: 120,
                    width: 120,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *25,
                      top: SizeConfig.blockSizeVertical * 17),
                  alignment: Alignment.bottomRight,
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    "assets/images/editprofile.png",
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3),
                  alignment: Alignment.topCenter,
                  width: SizeConfig.blockSizeHorizontal * 65,
                  child: Text(
                    "Micheal John (Micheal)",
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal *25,
                  height: SizeConfig.blockSizeVertical *5,
                  decoration: BoxDecoration(
                      color: AppColors.yelowbg,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Edit".toUpperCase(),style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular'),),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2),
                        child: Image.asset(
                          "assets/images/edit.png",
                          color: AppColors.whiteColor,
                          width: 15,
                          height: 15,
                        ),
                      )

                    ],
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
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.emailid,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(
                    StringConstant.dummyemail,
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
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.mobileno,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(
                    StringConstant.dummymobileno,
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
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.dateofbirth,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(
                    StringConstant.dummydateofbirth,
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
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
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
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal *60,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.nationality,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(
                    StringConstant.dummynationality,
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
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: Text(
                    StringConstant.currentcompany,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *4),
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Text(
                    StringConstant.dummycountry,
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
        ),
      ),
    );
  }
}