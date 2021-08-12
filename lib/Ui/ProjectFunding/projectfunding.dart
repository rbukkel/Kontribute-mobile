import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/CreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/HistoryProject.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/sendrequestgift/Createpool.dart';
import 'package:kontribute/Ui/sendrequestgift/RequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/SearchbarSendreceived.dart';
import 'package:kontribute/Ui/sendrequestgift/SendIndividaul.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class projectfunding extends StatefulWidget {
  @override
  projectfundingState createState() => projectfundingState();
}

class projectfundingState extends State<projectfunding> {
  String tabvalue = "Ongoing";
  bool ongoing = false;
  bool history = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
      DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: SizeConfig.blockSizeVertical *15,
          title: Container(
            child: Text(
              StringConstant.projectfunding,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins-Regular",
                  color: Colors.white),
            ),
          ),
          //Text("heello", textAlign:TextAlign.center,style: TextStyle(color: Colors.black)),
          flexibleSpace: Image(
            height: SizeConfig.blockSizeVertical * 12,
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            InkWell(
              onTap: ()
              {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SearchbarSendreceived()));
              },
              child: Container(
                margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*4,),
                child:Image.asset("assets/images/search.png",height: 25,width: 25,color: Colors.white,) ,
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: AppColors.theme1color,
            isScrollable: true,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(
                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(StringConstant.ongoingproject.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12,letterSpacing: 1.0))
                      ],
                    )),
              ),
              Tab(
                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(StringConstant.historyproject.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12,letterSpacing: 1.0))
                      ],
                    )),
              ),
            ],
          ),
        ),
          body: Container(
              height: double.infinity,
             color: AppColors.whiteColor,
              child:
              TabBarView(
                children:[
                  OngoingProject(),
                  HistoryProject(),
                ],
              ),
            ) ,
        bottomNavigationBar: bottombar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
        FloatingActionButton(
          //  backgroundColor: AppColors.whiteColor,
          child: new Icon(Icons.add_box),
          backgroundColor: AppColors.themecolor,
          /*  icon: Icon(
            Icons.edit,
            color: AppColors.selectedcolor,
          ),
          label: Text(
            'Create Post',
            style: TextStyle(color: AppColors.selectedcolor),
          ),*/
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreateProjectPost()));
          },
        ),
      ),
    );
  }
  Widget backgroundBGContainer() {
    return Container(
      color: AppColors.whiteColor,
    );
  }

}
