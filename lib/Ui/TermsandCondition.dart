import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';

class TermsandCondition extends StatefulWidget {
  @override
  TermsandConditionState createState() => TermsandConditionState();
}

class TermsandConditionState extends State<TermsandCondition> {
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
                      "Terms and Condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Montserrat",
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
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *5),
              alignment: Alignment.centerLeft,
              child: Text(
                'Terms and Condition',
                textAlign: TextAlign.start,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Regular",
                    color: Colors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal *90,
              child: Text(
                '© 2016-2021 Dairy Management.All rights reserved.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal *90,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
              child: Text(
                'Dairy and the Dairy management logo are either registered trademarks or trademarks of Dairy in the United States and/or other countries. ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal *90,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
              child: Text(
                'Third Party notices, terms and conditions pertaining to third party software can be found at http://www.adobe.com/go/thirdparty_eula/ and are incorporated by reference. ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal *90,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
              child: Text(
                'Fonts will be sent to your device(s) when you preview on mobile. Please be aware that certain font vendors do not allow for the transfer, display and distribution of their fonts. You are responsible for ensuring that you respect the font license agreement between you and the applicable font vendor.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            Container(
              width: SizeConfig.blockSizeHorizontal *90,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
              child: Text(
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}