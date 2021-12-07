import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/MyConnections/AddContact.dart';
import 'package:kontribute/MyConnections/ReceivedRequest.dart';
import 'package:kontribute/MyConnections/SendRequest.dart';
import 'package:kontribute/Ui/ProjectFunding/CreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/HistoryProject.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/ProjectFunding/SearchbarProject.dart';
import 'package:kontribute/Ui/mynetwork.dart';
import 'package:kontribute/Ui/sendrequestgift/SearchbarSendreceived.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class Connections extends StatefulWidget {
  @override
  ConnectionsState createState() => ConnectionsState();
}

class ConnectionsState extends State<Connections> {
  String tabvalue = "Ongoing";
  bool ongoing = false;
  bool history = false;
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
      body:  DefaultTabController(
        length: 4,
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
               'mynetwork'.tr,
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
            leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ()
                  {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig.blockSizeHorizontal *1),
                    child: Image.asset("assets/images/menu.png",height: 10,width: 10, color: AppColors.whiteColor,),
                  ),
                )
            ),
           /* actions: [
              InkWell(
                onTap: ()
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SearchbarProject()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*4,),
                  child:Image.asset("assets/images/search.png",height: 25,width: 25,color: Colors.white,) ,
                ),
              ),
            ],*/
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
                          Text('myconnections'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 10,letterSpacing: 1.0))
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
                          Text('receiverequest'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 10,letterSpacing: 1.0))
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
                          Text('sendrequest'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 10,letterSpacing: 1.0))
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
                          Text('peopleyoumayknow'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 10,letterSpacing: 1.0))
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
                mynetwork(),
                ReceivedRequest(),
                SendRequest(),
                AddContact(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: AppColors.themecolor,
            height: SizeConfig.blockSizeVertical * 7,
            child:  bottombar(context),
          ),
        )
      )
    );
  }

  Widget backgroundBGContainer() {
    return Container(
      color: AppColors.whiteColor,
    );
  }

}
