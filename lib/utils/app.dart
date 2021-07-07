import 'package:flutter/material.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
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
    crossAxisAlignment: CrossAxisAlignment.start,
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
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/back.png",
                  width: 25,
                  height: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 6,
            left: SizeConfig.blockSizeHorizontal * 23),
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
              width: 25,
              height: 25,
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
              margin:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/homeicon.png",
                    height: 20,
                    width: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                    child: Text(
                      "Home",
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
                builder: (BuildContext context) => WalletScreen()));
          },
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/walleticon.png",
                height: 20,
                width: 20,
              ),

              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                child: Text(
                  "Wallet",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                ),
              )
            ],
          )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NotificationScreen()));
          },
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/notificationicon.png",
                height: 20,
                width: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                child: Text(
                  "Notification",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 10),
                ),
              )
            ],
          )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingScreen()));
          },
          child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/settingicon.png",
                    height: 20,
                    width: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                    child: Text(
                      "Setting",
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
                          "Loading....",
                          style: TextStyle(color: Color(0xFF009247)),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
