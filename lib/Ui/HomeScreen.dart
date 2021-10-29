import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Ui/Donation/donation.dart';
import 'package:kontribute/Ui/Events/events.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/Tickets/tickets.dart';
import 'package:kontribute/Ui/sendrequestgift/sendreceivedgifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentPageValue = 0;
   final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner1.png",
      width: SizeConfig.blockSizeHorizontal *100,
      height: SizeConfig.blockSizeVertical * 25,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
      width: SizeConfig.blockSizeHorizontal *100,
      height: SizeConfig.blockSizeVertical * 25,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner1.png",
      width: SizeConfig.blockSizeHorizontal *100,
      height: SizeConfig.blockSizeVertical * 25,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
      width: SizeConfig.blockSizeHorizontal *100,
      height: SizeConfig.blockSizeVertical * 25,fit: BoxFit.fitHeight,),
  ];


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
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *4),
                child:
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/images/menu.png",color:AppColors.whiteColor,width: 20,height: 20,),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 45,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4),
                // margin: EdgeInsets.only(top: 10, left: 40),
              // child: Image.asset("assets/images/appicon_circular.png",width:SizeConfig.blockSizeHorizontal *50,height: SizeConfig.blockSizeVertical *7,),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4),
                // margin: EdgeInsets.only(top: 10, left: 40),
                child: Image.asset("assets/images/appicon_circular.png",
                  width:SizeConfig.blockSizeHorizontal *20,
                  height: SizeConfig.blockSizeVertical *5,),
              ),
            ],
          ),
        ),
            Container(
              color: AppColors.themecolor,
              alignment: Alignment.topCenter,
              width: SizeConfig.blockSizeHorizontal *100,
              height: SizeConfig.blockSizeVertical * 25,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: introWidgetsList.length,
                    onPageChanged: (int page) {
                      getChangedPageAndMoveBar(page);
                    },
                    controller: PageController(
                        initialPage: currentPageValue,
                        keepPage: true,
                        viewportFraction: 1),
                    itemBuilder: (context, index) {
                      return introWidgetsList[index];
                    },
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < introWidgetsList.length; i++)
                              if (i == currentPageValue) ...[
                                circleBar(true)
                              ] else
                                circleBar(false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
                child: SingleChildScrollView(
                  child:  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 3,bottom: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => sendreceivedgifts()));
                              },
                              child:  Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          "assets/images/sendreceivegift.png",
                                          height: SizeConfig.blockSizeVertical *10,
                                          width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.sendandreceivegift.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => projectfunding()));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/images/projectfunding.png", height: SizeConfig.blockSizeVertical *10, width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.projectfunding.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => donation()));
                              },
                              child:  Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          "assets/images/donation.png",
                                          height: SizeConfig.blockSizeVertical *10,
                                          width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.donations.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => events()));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/images/events.png", height: SizeConfig.blockSizeVertical *10, width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.events.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => tickets()));
                              },
                              child:  Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          "assets/images/tickets.png",
                                          height: SizeConfig.blockSizeVertical *10,
                                          width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.tickets.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationScreen()));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 18,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/images/invitation.png", height: SizeConfig.blockSizeVertical *10, width: SizeConfig.blockSizeHorizontal * 15,
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: SizeConfig.blockSizeHorizontal *40,
                                        child: Text(
                                          StringConstant.notification.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins-Bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                )

            )
          ],
        ),
      ),
    );
  }
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.whiteColor : AppColors.lightgrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }
}