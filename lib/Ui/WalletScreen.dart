import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class WalletScreen extends StatefulWidget{
  @override
  WalletScreenState createState() => WalletScreenState();
  
}

class WalletScreenState extends State<WalletScreen>{
  int _index= 0;
  bool home = false;
  bool wallet = false;
  bool notification = false;
  bool setting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,
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
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset("assets/images/back.png",color:AppColors.whiteColor,width: 20,height: 20,),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal *60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      StringConstant.wallet, textAlign: TextAlign.center,
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
            Container(
              child:Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *8),
                    height: SizeConfig.blockSizeVertical * 20,
                    width: SizeConfig.blockSizeHorizontal * 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/wallet_bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4,left: SizeConfig.blockSizeHorizontal *25,
                        right: SizeConfig.blockSizeHorizontal *10),
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.blockSizeHorizontal * 50,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/walletbalace_bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Current Balance",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "\$",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "16,756.00",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  ),
                ],
              ) ,
            ),
            Expanded(
              child:
              ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [

                                  Row(
                                    children: [
                                      Container(
                                        height:
                                        SizeConfig.blockSizeVertical *
                                            10,
                                        width:
                                        SizeConfig.blockSizeVertical *
                                            10,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *1,
                                            bottom: SizeConfig.blockSizeVertical *1,
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                2),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:new AssetImage("assets/images/walletlisticon.png"),
                                              fit: BoxFit.fill,)),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: SizeConfig.blockSizeHorizontal *55,
                                                alignment: Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      1,
                                                ),
                                                child: Text(
                                                  "Card **** **** ****5678",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig.blockSizeHorizontal *15,
                                                alignment: Alignment.topRight,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      1,
                                                  right: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3,
                                                ),
                                                child: Text(
                                                  "-2220",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.redbg,
                                                      fontSize:12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              )

                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Container(
                                                width: SizeConfig.blockSizeHorizontal *55,
                                                alignment: Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                    right: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3,
                                                    top: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2),
                                                child: Text(
                                                  "5March, 18:33",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig.blockSizeHorizontal *15,
                                                alignment: Alignment.topRight,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      2,
                                                  top: SizeConfig
                                                      .blockSizeHorizontal *
                                                      2,
                                                  right: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3,
                                                ),
                                                child: Text(
                                                  "USD",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black26,
                                                      fontSize:12,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              )

                                            ],
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {

                            },
                          )
                      ),
                    );
                  }),
            )

          ],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Add Post',
        notchedShape: CircularNotchedRectangle(),

          onTabSelected: (newIndex) => setState((){
            _index = newIndex;
            print("Index: "+newIndex.toString());
            if(newIndex==0)
            {
              home = true;
              wallet =false;
              notification =false;
              setting =false;
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }else if(newIndex==1)
            {
            home = false;
            wallet =true;
            notification =false;
            setting =false;

              Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
            }else if(newIndex==2)
            {
              home = false;
              wallet =false;
              notification =true;
              setting =false;
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            }else if(newIndex==3)
            {
              home = false;
              wallet =false;
              notification =false;
              setting =true;
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
            }

    }),
        items: [
          FABBottomAppBarItem(iconData:"assets/images/homeicon.png",text: 'Home',color: home ? AppColors.selectedcolor : AppColors.light_grey,),
          FABBottomAppBarItem(iconData:"assets/images/walleticon.png",text: 'Wallet',color: wallet ? AppColors.selectedcolor : AppColors.light_grey),
          FABBottomAppBarItem(iconData:"assets/images/notificationicon.png",text: 'Notificaton',color: notification ? AppColors.selectedcolor : AppColors.light_grey),
          FABBottomAppBarItem(iconData:"assets/images/settingicon.png",text: 'Setting',color: setting ? AppColors.selectedcolor : AppColors.light_grey),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
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