import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class NotificationScreen extends StatefulWidget{
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen>{
  int _index;
  bool home = false;
  bool wallet = false;
  bool notification = false;
  bool setting = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _index=2;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                      },
                      child: Container(


                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal *60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      StringConstant.notification, textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
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

            Expanded(
              child: Container(
                child:  SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3, bottom: SizeConfig.blockSizeVertical *3,
                            left: SizeConfig.blockSizeHorizontal *3, right: SizeConfig.blockSizeHorizontal *3),

                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(

                              alignment:Alignment.topLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *2,
                                bottom: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal *4,
                                right: SizeConfig.blockSizeHorizontal *4,
                              ),
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              child: Divider(
                                thickness: 1,
                                color: Colors.black12,
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *10,
                              width: SizeConfig.blockSizeHorizontal *95,
                              alignment:Alignment.topLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *1,
                                bottom: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal *4,
                                right: SizeConfig.blockSizeHorizontal *4,
                              ),
                              child: Text(
                                "No new notifications",
                                maxLines: 4,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black12,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3, bottom: SizeConfig.blockSizeVertical *3,
                            left: SizeConfig.blockSizeHorizontal *3, right: SizeConfig.blockSizeHorizontal *3),
                         padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *1),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment:Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *2,
                                left: SizeConfig.blockSizeHorizontal *4,
                                right: SizeConfig.blockSizeHorizontal *4,
                              ),
                              child: Text(
                                "Earlier",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              child:
                              ListView.builder(
                                  itemCount:4,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return
                                      Container(

                                          child:
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: SizeConfig.blockSizeVertical * 1),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:  CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig.blockSizeHorizontal *55,
                                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2,right: SizeConfig.blockSizeHorizontal *1),
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          StringConstant.dummynotification, textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              decoration: TextDecoration.none,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: "Poppins-Regular",
                                                              color: Colors.black54),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                                            bottom: SizeConfig.blockSizeVertical *1),
                                                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2,right: SizeConfig.blockSizeHorizontal *1),
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          "January 25", textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              decoration: TextDecoration.none,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: "Poppins-Regular",
                                                              color: Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                  ,
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig.blockSizeHorizontal *25,
                                                    height: SizeConfig.blockSizeVertical *5,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig.blockSizeHorizontal*1,
                                                      right: SizeConfig.blockSizeHorizontal*2,),
                                                    child: Text(
                                                      StringConstant.respond, textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: "Poppins-Regular",
                                                          color: AppColors.theme1color),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {

                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      margin: EdgeInsets.only(
                                                        right: SizeConfig.blockSizeHorizontal*3,),
                                                      child: Image.asset("assets/images/cross.png",color:AppColors.redbg,width: 15,height: 15,),
                                                    ),
                                                  ),


                                                ],
                                              )
                                            ],
                                          )

                                      );
                                  }),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
              ,
            ),




          ],
        ),
      ),
      bottomNavigationBar: bottombar(context),
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
                width: SizeConfig.blockSizeHorizontal *15,
                margin:
                EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
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
                width: SizeConfig.blockSizeHorizontal *15,
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
                width: SizeConfig.blockSizeHorizontal *15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/notificationicon.png",
                      height: 20,
                      width: 20,
                      color: AppColors.selectedcolor,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                      child: Text(
                        "Notification",
                        style: TextStyle(color: AppColors.selectedcolor, fontSize: 10),
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
                width: SizeConfig.blockSizeHorizontal *15,
                margin:
                EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
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


  Widget _buildFab(BuildContext context) {
    // final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return  FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));

      },
      child: Image.asset("assets/images/addpost.png"),
      elevation: 3.0,
    );
  }
  void _selectedTab(int index) {
    index =-1;
    setState(() {
      if(index==0)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else if(index==1)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
      }else if(index==2)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
      }else if(index==3)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
      }
    });
  }

}