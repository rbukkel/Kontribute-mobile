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