import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProfileScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/utils/AppColors.dart';

class dashboard extends StatefulWidget{
  @override
  dashboardState createState() => dashboardState();
  
}

class dashboardState extends State<dashboard>{
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context){
    Widget child;
    print("Index: "+_index.toString());
    switch (_index){
      case 0:
        child = ProfileScreen();
        break;
      case 1:
        child = WalletScreen();
        break;
      case 2:
        child = NotificationScreen();
        break;
      case 3:
        child = SettingScreen();
        break;
       default:
        child = HomeScreen();
        break;
    }
    return Scaffold(
      body: SizedBox.expand(child: child),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Home',
        notchedShape: CircularNotchedRectangle(),
        selectedColor: AppColors.selectedcolor,
        onTabSelected: (newIndex) => setState(() => _index = newIndex),
        items: [
          FABBottomAppBarItem(iconData:"assets/images/profileicon.png",text: 'Profile'),
          FABBottomAppBarItem(iconData:"assets/images/walleticon.png",text: 'Wallet'),
          FABBottomAppBarItem(iconData:"assets/images/notificationicon.png",text: 'Notification'),
          FABBottomAppBarItem(iconData:"assets/images/settingicon.png",text: 'Setting'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          _index =4;
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Image.asset("assets/images/homeicon.png"),
        elevation: 3.0,
      ),
    );
  }



  Widget _buildFab(BuildContext context) {
    return  FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      child: Image.asset("assets/images/homeicon.png"),
      elevation: 3.0,
    );
  }

}