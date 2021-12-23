import 'package:flutter/material.dart';
import 'package:kontribute/Terms.dart';
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

void warningDialog(String text,String coming, var context) {
  showDialog(
    context: context,
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.whiteColor,
      child: new Container(
        margin: EdgeInsets.all(5),
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical *40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              color: AppColors.whiteColor,
              alignment: Alignment.center,
              child: Text(
                'warning'.tr,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical *10,
              width: SizeConfig.blockSizeHorizontal *25,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal *5,
                right: SizeConfig.blockSizeHorizontal *5,
                top: SizeConfig.blockSizeVertical *2,),
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/caution.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical *9,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              color: AppColors.whiteColor,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                callNext(Terms(data: coming), context);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.blockSizeVertical * 5,
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical *3,
                    bottom: SizeConfig.blockSizeVertical * 2,
                    left: SizeConfig.blockSizeHorizontal * 25,
                    right: SizeConfig.blockSizeHorizontal * 25),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/sendbutton.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text('okay'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins-Regular',
                      fontSize: 14,
                    )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
              fontFamily: "Poppins-Regular",
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
              fontFamily: "Poppins-Regular",
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
              fontFamily: "Poppins-Regular",
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
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/homeicon.png",
                    height: 19,
                    width: 19,
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
            padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal *5),
              width: SizeConfig.blockSizeHorizontal *26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/nav_mytranscaton.png",
                height: 19,
                width: 19,
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
          )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NotificationScreen()));
          },
          child: Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *5),
              width: SizeConfig.blockSizeHorizontal *24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/notificationicon.png",
                height: 19,
                width: 19,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/nav_contactus.png",
                    height: 19,
                    width: 19,
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
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
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
                        SizedBox(height: 10),
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
