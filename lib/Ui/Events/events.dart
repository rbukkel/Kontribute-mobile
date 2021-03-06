import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Pojo/EventCategoryPojo.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/Events/CreateEventPost.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/Events/EventsHistoryProject.dart';
import 'package:kontribute/Ui/Events/SearchbarEvent.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/HistoryProject.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/sendrequestgift/Createpool.dart';
import 'package:kontribute/Ui/sendrequestgift/RequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/SearchbarSendreceived.dart';
import 'package:kontribute/Ui/sendrequestgift/SendIndividaul.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/utils/screen.dart';

class events extends StatefulWidget {
  @override
  eventsState createState() => eventsState();
}

class eventsState extends State<events> {
  String tabvalue = "Ongoing";
  bool ongoing = false;
  bool history = false;
  final List<String> _dropdownEventCategory = [
    "New year",
    "Valentine's Day",
    "Mother's Day",
    "Father's Day",
    "Easter",
    "Thanksgiving",
    "Eid",
    "Diwali",
    "Christmas",
    "Halloween",
    "Anniversary",
    "Bridal Shower",
    "Baby Shower",
    "Bachelor Party",
    "Bachelorette Party",
    "Party",
    "Lunch",
    "Dinner",
    "Graduation",
    "Other"
  ];
  int catid;
  EventCategoryPojo listing;
  String val;
  bool resultvalue = true;
  var storelist_length;
  bool  internet = false;
  String textHolder = "Please Select";

  changeText(String valu) {
    setState(() {
      textHolder = valu;
      Fluttertoast.showToast(
        msg: textHolder,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    });
  }

  void getEventCategory() async {
    var response = await http.get(Uri.encodeFull(Network.BaseApi + Network.categorylisting));
    var jsonResponse = null;
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        setState(() {
          resultvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        listing = new EventCategoryPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(listing.resultPush.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.resultPush;
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: listing.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }


  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: MediaQuery.of(context).size.height * 80,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/images/bg_img.png"),
                  fit: BoxFit.fill,
                )), //could change this to Color(0xFF737373),

                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 5,
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 2),
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: Text(
                              "Event Type",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 3,
                                  bottom: SizeConfig.blockSizeVertical * 3,
                                  right: SizeConfig.blockSizeHorizontal * 5),
                              child: Image.asset(
                                "assets/images/close.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ]),
                    Expanded(
                      child: ListView.builder(
                          itemCount:  storelist_length.length == null
                              ? 0 : storelist_length.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  catid = listing.resultPush
                                      .elementAt(index).catId;
                                  print("categoryid: "+catid.toString());
                                  print("categoryname: "+listing.resultPush
                                      .elementAt(index).categoryName
                                      .toString());
                                  changeText(listing.resultPush
                                      .elementAt(index).categoryName
                                      .toString());
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  padding: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * 3,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 1,
                                    bottom: SizeConfig.blockSizeVertical * 1,
                                    left: SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    listing.resultPush.elementAt(index).categoryName.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Lato-Bold',
                                        color: AppColors.black,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ));
          });
        });
  }

  @override
  void initState() {
    super.initState();

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {

        getEventCategory();

        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
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
              StringConstant.events,
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
          /*  InkWell(
              onTap: () {
                _modalBottomSheetMenu();
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 4,
                ),
                child: Image.asset(
                  "assets/images/categorymenu.png",
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
              ),
            ),*/
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SearchbarEvent()));

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
                        Text(StringConstant.ongoingevents.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12))
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
                        Text(StringConstant.historyevents.toUpperCase(),
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
          child: TabBarView(
            children: [
              OngoingEvents(),
              EventsHistoryProject(),
            ],
          ),
        ),
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
                    builder: (BuildContext context) => CreateEventPost()));
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
