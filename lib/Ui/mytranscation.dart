import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class mytranscation extends StatefulWidget{
  @override
  mytranscationState createState() => mytranscationState();
}

class mytranscationState extends State<mytranscation>{
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
              height: SizeConfig.blockSizeVertical *12,
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
                    width: 20,height: 20,
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *2),
                    child:
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset("assets/images/menu.png",color:AppColors.whiteColor,width: 20,height: 20,),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal *60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      "My Transcation", textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Montserrat",
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 25,height: 25,
                    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *2),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *6,top: SizeConfig.blockSizeVertical *2),
                    child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal *40,
                          height: SizeConfig.blockSizeVertical *5,
                          child: Text(StringConstant.amountpaid),
                        )
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal *6,top: SizeConfig.blockSizeVertical *2),
                  child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.blockSizeHorizontal *40,
                        height: SizeConfig.blockSizeVertical *5,
                        child: Text(StringConstant.amountreceive),
                      )
                  )
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
    