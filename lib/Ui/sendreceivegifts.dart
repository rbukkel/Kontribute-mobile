import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class sendreceivegifts extends StatefulWidget{
  @override
  sendreceivegiftsState createState() => sendreceivegiftsState();
  
}

class sendreceivegiftsState extends State<sendreceivegifts>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                      StringConstant.sendandreceivegift, textAlign: TextAlign.center,
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
        selectedColor: AppColors.selectedcolor,
        onTabSelected: _selectedTab,
        // onTabSelected: (newIndex) => setState(() => _index = newIndex),
        items: [
          FABBottomAppBarItem(iconData:"assets/images/homeicon.png",text: 'Home'),
          FABBottomAppBarItem(iconData:"assets/images/walleticon.png",text: 'Wallet'),
          FABBottomAppBarItem(iconData:"assets/images/notificationicon.png",text: 'Notificaton'),
          FABBottomAppBarItem(iconData:"assets/images/settingicon.png",text: 'Setting'),
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