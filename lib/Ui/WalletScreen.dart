import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class WalletScreen extends StatefulWidget{
  @override
  WalletScreenState createState() => WalletScreenState();
  
}

class WalletScreenState extends State<WalletScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *5),
              child:
              Row(
                children: [
                  titlebarapp(context, "Wallet"),
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