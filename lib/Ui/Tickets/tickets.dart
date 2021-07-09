import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/Events/EventsHistoryProject.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/HistoryProject.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/Tickets/CreateTicketPost.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/Ui/Tickets/TicketsEventsHistoryProject.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/sendrequestgift/Createpool.dart';
import 'package:kontribute/Ui/sendrequestgift/RequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/SendIndividaul.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class tickets extends StatefulWidget {
  @override
  ticketsState createState() => ticketsState();
}

class ticketsState extends State<tickets> {
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
          backgroundColor: Colors.transparent,
          title: Container(
            child: Text(
              StringConstant.tickets,
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
            height: SizeConfig.blockSizeVertical * 22,
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(

                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(StringConstant.ongoingevents.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    )),
              ),
              Tab(
                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(StringConstant.historyevents.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12))
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
                  TicketOngoingEvents(),
                  TicketsEventsHistoryProject(),
                ],
              ),

            ) ,
        bottomNavigationBar: bottombar(context),
      ),
    );
  }
  Widget backgroundBGContainer() {
    return Container(
      color: AppColors.whiteColor,
    );
  }

}
