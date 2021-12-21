import 'dart:convert';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/Notificationpojo.dart';
import 'package:kontribute/Pojo/bannerpojo.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaign.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/Events/OngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/MyActivity/MyActivities.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _totalNotifications;
  Notificationpojo listing;
  String val;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isTypeSwitch = true;
  int currentPageValue = 0;
  int counter = 0;
  String tabvalue = "Project";
  bool project = true;
  bool donation = false;
  bool event = false;
  String valcat;


  final List<Widget> introWidgetsList = <Widget>[
    Image.asset(
      "assets/images/banner1.png",
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 25,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner2.png",
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 25,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner1.png",
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 25,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner2.png",
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 25,
      fit: BoxFit.fitHeight,
    ),
  ];
  bool internet = false;
  bannerpojo imageslisting;
  bool resultcatvalue = true;
  bool resultDonationvalue = true;
  bool resultEventvalue = true;
  var banner_length;
  var bannerDonation_length;
  var bannerEvent_length;

  Widget _renderItem(BuildContext context, int index) {
    return Image(
      image: AssetImage('assets/images/welcome${index + 1}.png'),
    );
  }

  String resultCounter = "0";
  String userid;

  @override
  void initState() {
    _totalNotifications = 0;

    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      setState(() {
        userid = val;
        getSUBdata(userid);
        print("Login userid: " + userid.toString());
      });
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getBanners();
        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        errorDialog('nointernetconnection'.tr);
      }
    });
  }

  void getSUBdata(String user_id) async {
    Map data = {
      'userid': user_id.toString(),
    };
    print("Subuser: " + data.toString());
    var jsonResponse = null;
    print(Network.BaseApi + Network.notificationlisting);
    http.Response response = await http.post(Network.BaseApi + Network.notificationlisting, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {

       // errorDialog(jsonDecode(val)["message"]);
      }  else {
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            _totalNotifications = listing.unreadnotificaiton;
          });
        } else {
         // errorDialog(listing.message);
        }
      }
    } else {
     // errorDialog(jsonDecode(val)["message"]);
    }
  }


  void errorDialog(String text) {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: AppColors.whiteColor,
        child: new Container(
          margin: EdgeInsets.all(5),
          width: 300.0,
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.error,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                color: AppColors.whiteColor,
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    'ok'.tr,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getBanners() async {
    var response = await http.get(Uri.encodeFull(Network.BaseApi + Network.bannerimages));
    var jsonResponse = null;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valcat = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultcatvalue = false;
          resultDonationvalue = false;
          resultEventvalue = false;
        });
      } else {
        imageslisting = new bannerpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (imageslisting.projectimages.isEmpty) {
              resultcatvalue = false;
            } else {
              resultcatvalue = true;
              print("SSSS");
              banner_length = imageslisting.projectimages;
            }

            if (imageslisting.donationimages.isEmpty) {
              resultDonationvalue = false;
            } else {
              resultDonationvalue = true;
              print("SSSS");
              bannerDonation_length = imageslisting.donationimages;
            }

            if (imageslisting.eventimages.isEmpty) {
              resultEventvalue = false;
            } else {
              resultEventvalue = true;
              print("SSSS");
              bannerEvent_length = imageslisting.eventimages;
            }
          });
        } else {
          errorDialog(imageslisting.message);
        }
      }
    } else {
      errorDialog(jsonDecode(valcat)["message"]);
    }
  }

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
        color: AppColors.shadow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 12,
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
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 6,
                        top: SizeConfig.blockSizeVertical * 4),
                    child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/menu.png",
                          color: AppColors.whiteColor,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 45,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    // child: Image.asset("assets/images/appicon_circular.png",width:SizeConfig.blockSizeHorizontal *50,height: SizeConfig.blockSizeVertical *7,),
                  ),
                  // NotificationBadge(totalNotifications: _totalNotifications),
                  new Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NotificationScreen()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 4),
                          // margin: EdgeInsets.only(top: 10, left: 40),
                          child: Image.asset(
                            "assets/images/appicon_circular.png",
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 5,
                          ),
                        ),
                      ),
                      _totalNotifications != 0 ? new Positioned(
                              top: 40,
                              left: 40,
                              /* right: 11,
                                 top: 11,*/
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '$_totalNotifications',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : new Container()
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5,
                    bottom: SizeConfig.blockSizeVertical * 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: ()
                          {
                            setState(() {
                              tabvalue = "Project";
                              project = true;
                              donation = false;
                              event = false;
                            });

                            print("Value: " + tabvalue);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 19,
                            margin:EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                            child: Text(
                              'projects'.tr.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: project ? AppColors.black : AppColors.greyColor,
                                  fontFamily: 'Poppins-Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ),
                       GestureDetector(
                         onTap: ()
                         {
                           setState(() {
                             tabvalue = "Donation";
                             project = false;
                             donation = true;
                             event = false;
                           });

                           print("Value: " + tabvalue);
                         },
                         child:  Container(
                           width: SizeConfig.blockSizeHorizontal * 19,
                           margin:EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2),
                           child: Text(
                             'donations'.tr.toUpperCase(),
                             textAlign: TextAlign.left,
                             style: TextStyle(
                                 color: donation ? AppColors.black : AppColors.greyColor,
                                 fontFamily: 'Poppins-Bold',
                                 fontWeight: FontWeight.w700,
                                 fontSize: 10,
                                 letterSpacing: 1.0),
                           ),
                         ),
                       ),
                        GestureDetector(
                          onTap: ()
                          {
                            setState(() {
                              tabvalue = "Event";
                              project = false;
                              donation = false;
                              event = true;
                            });

                            print("Value: " + tabvalue);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 19,
                            margin:EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                            child: Text(
                              'events'.tr.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: event ? AppColors.black : AppColors.greyColor,
                                  fontFamily: 'Poppins-Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  tabvalue=="Project"?
                  Container(
                    //color: AppColors.themecolor,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeVertical * 1,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 75,
                    height: SizeConfig.blockSizeVertical * 25,
                    child: banner_length != null ?
                    new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            callNext(
                                OngoingProjectDetailsscreen(
                                    data: imageslisting.projectimages
                                        .elementAt(index)
                                        .projectId
                                        .toString(),
                                    coming: "home"),
                                context);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 65,
                            height: SizeConfig.blockSizeVertical * 25,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      Network.BaseApiProject +
                                          imageslisting.projectimages
                                              .elementAt(index)
                                              .imagePath,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                        );
                      },
                      itemCount: banner_length.length == null
                          ? 0
                          : banner_length.length,
                      itemWidth: SizeConfig.blockSizeHorizontal *  65,
                      layout: SwiperLayout.STACK,
                      //pagination: new SwiperPagination(),
                    ) :
                    Container(
                        alignment: Alignment.center,
                        child: resultcatvalue == true
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            :  new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image(
                              image: AssetImage(
                                  'assets/images/homebg${index + 1}.png'),
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: 4,
                          itemWidth: SizeConfig.blockSizeHorizontal * 65,
                          layout: SwiperLayout.STACK,
                          //pagination: new SwiperPagination(),
                        )),

                  ):
                  tabvalue=="Donation"?
                  Container(
                    //color: AppColors.themecolor,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeVertical * 1,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 75,
                    height: SizeConfig.blockSizeVertical * 25,
                    child: bannerDonation_length != null
                        ? new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            callNext(
                                OngoingCampaignDetailsscreen(
                                    data: imageslisting.donationimages
                                        .elementAt(index)
                                        .donationId
                                        .toString(),
                                    coming: "home"),
                                context);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 65,
                            height: SizeConfig.blockSizeVertical * 25,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      Network.BaseApidonation +
                                          imageslisting.donationimages
                                              .elementAt(index)
                                              .imagePath,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                        );
                      },
                      itemCount: bannerDonation_length.length == null
                          ? 0
                          : bannerDonation_length.length,
                      itemWidth: SizeConfig.blockSizeHorizontal *  65,
                      layout: SwiperLayout.STACK,
                      //pagination: new SwiperPagination(),
                    )
                        :   Container(
                        alignment: Alignment.center,
                        child: resultDonationvalue == true
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            :  new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image(
                              image: AssetImage(
                                  'assets/images/homebg${index + 1}.png'),
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: 4,
                          itemWidth: SizeConfig.blockSizeHorizontal * 65,
                          layout: SwiperLayout.STACK,
                          //pagination: new SwiperPagination(),
                        )),
                  ):
                  tabvalue=="Event"?
                  Container(
                    //color: AppColors.themecolor,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeVertical * 1,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 75,
                    height: SizeConfig.blockSizeVertical * 25,
                    child: bannerEvent_length != null
                        ? new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            callNext(
                                OngoingEventsDetailsscreen(
                                    data: imageslisting.eventimages
                                        .elementAt(index)
                                        .eventId
                                        .toString(),
                                    coming: "home"),
                                context);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 65,
                            height: SizeConfig.blockSizeVertical * 25,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      Network.BaseApievent +
                                          imageslisting.eventimages
                                              .elementAt(index)
                                              .imagePath,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                        );
                      },
                      itemCount: bannerEvent_length.length == null
                          ? 0
                          : bannerEvent_length.length,
                      itemWidth: SizeConfig.blockSizeHorizontal *  65,
                      layout: SwiperLayout.STACK,
                      //pagination: new SwiperPagination(),
                    )
                        :  Container(
                        alignment: Alignment.center,
                        child: resultEventvalue == true
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            :  new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image(
                              image: AssetImage(
                                  'assets/images/homebg${index + 1}.png'),
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: 4,
                          itemWidth: SizeConfig.blockSizeHorizontal * 65,
                          layout: SwiperLayout.STACK,
                          //pagination: new SwiperPagination(),
                        )
                    ),

                  ):Container(
                    //color: AppColors.themecolor,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeVertical * 1,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 75,
                    height: SizeConfig.blockSizeVertical * 25,
                    child:new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image(
                          image: AssetImage(
                              'assets/images/homebg${index + 1}.png'),
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 4,
                      itemWidth: SizeConfig.blockSizeHorizontal * 65,
                      layout: SwiperLayout.STACK,
                      //pagination: new SwiperPagination(),
                    ),
                  )
                ],
              ),
            ),
            /*  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _controller.reset(
                        animType:
                        _isTypeSwitch ? AnimType.SWITCH : AnimType.TO_FRONT);
                    _controller.previous();
                  },
                  child: Text("Pre"),
                ),
                RaisedButton(
                  onPressed: () {
                    _changeType(context);
                  },
                  child: Text("Reset"),
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.reset(animType: AnimType.TO_END);
                    _controller.next();
                  },
                  child: Text("Next"),
                ),
              ],
            ),*/
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeHorizontal * 3,
                      bottom: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingSendReceived()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'sendandreceivegift'.tr.toUpperCase(),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingProject()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      "assets/images/projectfunding.png",
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'projectfunding'.tr.toUpperCase(),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingCampaign()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'donations'.tr.toUpperCase(),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingEvents()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      "assets/images/events.png",
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'events'.tr.toUpperCase(),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TicketOngoingEvents()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'tickets'.tr.toUpperCase(),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyActivities()));
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 18,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2),
                            child: Card(
                              elevation: 3.0,
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
                                      "assets/images/invitation.png",
                                      height: SizeConfig.blockSizeVertical * 10,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Text(
                                      'myActivity'.tr.toUpperCase(),
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
            ))
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
