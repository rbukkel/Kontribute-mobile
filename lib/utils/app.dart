import 'package:flutter/material.dart';
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:get/get.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/screen.dart';
import 'AppColors.dart';

launchScreen(context, String tag, {Object arguments}) {
  if (arguments == null) {
    Navigator.pushNamed(context, tag);
  } else {
    Navigator.pushNamed(context, tag, arguments: arguments);
  }
}

callNext(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

callNext1(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => className), (route) => false);
}

createUpperBar(context, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 6,
            left: SizeConfig.blockSizeHorizontal * 3),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Container(
              color: AppColors.theme1color,
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/back.png",
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Container(
        height: SizeConfig.blockSizeVertical *6,
        width: SizeConfig.blockSizeHorizontal *83,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 6,
            ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Montserrat",
              color: Colors.white),
        ),
      ),
      Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 6,
            right: SizeConfig.blockSizeHorizontal * 1),
      )
    ],
  );
}

titlebar(context, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            color: Colors.transparent,
            child: Image.asset(
              "assets/images/back.png",
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        alignment: Alignment.topCenter,
        // margin: EdgeInsets.only(top: 10, left: 40),
        child: Text(
          text,
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
        margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            width: 25,
            height: 25,
          ),
        ),
      ),
    ],
  );
}

titlebarapp(context, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(color: Colors.transparent, width: 25, height: 25),
        ),
      ),
      Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        alignment: Alignment.topCenter,
        // margin: EdgeInsets.only(top: 10, left: 40),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              fontFamily: "Montserrat",
              color: Colors.black),
        ),
      ),
      Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            width: 25,
            height: 25,
          ),
        ),
      ),
    ],
  );
}

appbar(context, text) {
  return Container(
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
          width: 25,
          height: 25,
          margin: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 3,
              top: SizeConfig.blockSizeVertical * 2),
          child: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Container(
              color: Colors.transparent,
              child: Image.asset(
                "assets/images/menu.png",
                color: AppColors.whiteColor,
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 80,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
          // margin: EdgeInsets.only(top: 10, left: 40),
          child: Text(
            text,
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
  );
}

Widget AppBarData(String TextData) {
  return AppBar(
    backgroundColor: AppColors.green,
    centerTitle: true,
    title: Text(TextData),
  );
}

bottombar(context) {
  return Container(
    height: SizeConfig.blockSizeVertical * 8,
    color: AppColors.whiteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen()));
          },
          child: Container(
              width: SizeConfig.blockSizeHorizontal *24,
              margin:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/homeicon.png",
                    height: 15,
                    width: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                    child: Text(
                      'home'.tr,
                      maxLines: 2,
                      style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                    ),
                  )
                ],
              )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => mytranscation()));
          },
          child: Container(
              width: SizeConfig.blockSizeHorizontal *24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/nav_mytranscaton.png",
                height: 15,
                width: 15,
                color: AppColors.grey,
              ),

              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                child: Text(
                  'mytransactions'.tr,
                  style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                ),
              )
            ],
          )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NotificationScreen()));
          },
          child: Container(
              width: SizeConfig.blockSizeHorizontal *22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/notificationicon.png",
                height: 15,
                width: 15,
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                child: Text(
                  'notification'.tr,
                  style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                ),
              )
            ],
          )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ContactUs()));
          },
          child: Container(
              width: SizeConfig.blockSizeHorizontal *23,
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/nav_contactus.png",
                    height: 15,
                    width: 15,
                    color: AppColors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                    child: Text(
                      'contactus'.tr,
                      style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                    ),
                  )
                ],
              )),
        )
      ],
    ),
  );
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: null,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'loading'.tr,
                          style: TextStyle(color: Color(0xFF009247)),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
