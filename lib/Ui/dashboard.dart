import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
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

  void _selectedTab(int index) {
    setState(() {
      if(index==0)
        {
          HomeScreen();
        }else if(index==1)
      {
        WalletScreen();
      }else if(index==2)
      {
        NotificationScreen();
      }else if(index==3)
      {
        SettingScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    Widget child;
    switch (_index){
      case 0:
        child = HomeScreen();
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
    }
    return Scaffold(
      body: SizedBox.expand(child: child),
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
}
