import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/Notificationpojo.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  int _index;
  bool home = false;
  bool wallet = false;
  bool notification = false;
  bool setting = false;
  String userid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  String updateval;
  var storelist_length;
  Notificationpojo listing;
  String deleteval;
  String markasreadval;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  static ScrollController _scrollController;

  void function() {
    print("scrolling");
  }

  @override
  Future<void> initState() {
    _scrollController = new ScrollController()..addListener(function);
    super.initState();
    _loadID();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadID() async {
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      setState(() {
        userid = val;
        print("PAge: " + pageNumber.toString());
        getdata(userid, pageNumber);
        print("Login userid: " + userid.toString());
        paginationApi();
      });
    });
  }

  /*  super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          _future = getData(page,userid);
        });
      }
    });
  }*/

  void paginationApi() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          if (pageNumber < listing.result.lastPage) {
            pageNumber += 1;
            getdata(userid, pageNumber);
          }
        });
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          if (pageNumber >= 1) {
            pageNumber = pageNumber - 1;
            print('ggggggg' + pageNumber.toString());
            if (pageNumber < listing.result.lastPage) {
              getSUBdata(userid, pageNumber);
            }
          } else {
            getSUBdata(userid, pageNumber);
            print("Last page");
          }
        });
      }
    });
  }

  void getSUBdata(String user_id, int page) async {
    Map data = {
      'userid': user_id.toString(),
    };
    print("Subuser: " + data.toString());
    var jsonResponse = null;
    print(Network.BaseApi +
        Network.notificationlisting +
        "?page=" +
        page.toString());
    http.Response response = await http.post(
        Network.BaseApi + Network.notificationlisting + "?page=$page",
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            SharedUtils.writenoficationcounter(
                "Counternot", listing.unreadnotificaiton);
            if (listing.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.result.data;
            }
          });
        } else {
          errorDialog(listing.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
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
                    'okay'.tr,
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

  void getdata(String user_id, int page) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    // Dialogs.showLoadingDialog(context, _keyLoader);
    print("user: " + data.toString());
    var jsonResponse = null;
    print(Network.BaseApi +
        Network.notificationlisting +
        "?page=" +
        page.toString());
    http.Response response = await http.post(
        Network.BaseApi + Network.notificationlisting + "?page=$page",
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            SharedUtils.writenoficationcounter(
                "Counternot", listing.unreadnotificaiton);
            if (listing.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.result.data;
            }
          });
        } else {
          //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(listing.message);
        }
      }
    } else {
      // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(val)["message"]);
    }
    paginationApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
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
                        top: SizeConfig.blockSizeVertical * 2),
                    child: InkWell(
                      onTap: () {},
                      child: Container(),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      'notification'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 3,
                        top: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
            ),
            /* Container(
              alignment: Alignment.centerLeft,
              margin:
              EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2,left: SizeConfig.blockSizeHorizontal * 5),
              // margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                "Earlier",
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Regular',
                    color: Colors.black),
              ),
            ),*/
            Expanded(
                child: storelist_length != null
                    ? ListView.builder(
                        controller: _scrollController,
                        itemCount: storelist_length.length == null
                            ? 0
                            : storelist_length.length,
                        /*physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,*/

                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 2),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2,
                                          left: SizeConfig.blockSizeHorizontal *
                                              5,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              listing.result.data
                                                              .elementAt(index)
                                                              .profilePic ==
                                                          null ||
                                                      listing.result.data
                                                              .elementAt(index)
                                                              .profilePic ==
                                                          ""
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                      },
                                                      child: Container(
                                                          height: SizeConfig
                                                                  .blockSizeVertical *
                                                              9,
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              9,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin:
                                                              EdgeInsets.only(
                                                            bottom: SizeConfig
                                                                    .blockSizeVertical *
                                                                1,
                                                            right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .themecolor,
                                                              style: BorderStyle
                                                                  .solid,
                                                            ),
                                                            image:
                                                                new DecorationImage(
                                                              image: new AssetImage(
                                                                  "assets/images/account_circle.png"),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )),
                                                    )
                                                  : listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .facebookId ==
                                                              null ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .facebookId ==
                                                              ""
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                          },
                                                          child: Container(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                9,
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                9,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom: SizeConfig
                                                                      .blockSizeVertical *
                                                                  1,
                                                              right: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .themecolor,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(Network.BaseApiprofile +
                                                                            listing.result.data.elementAt(index).profilePic),
                                                                        fit: BoxFit.fill)),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                          },
                                                          child: Container(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                9,
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                9,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom: SizeConfig
                                                                      .blockSizeVertical *
                                                                  1,
                                                              right: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .themecolor,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(listing
                                                                            .result
                                                                            .data
                                                                            .elementAt(
                                                                                index)
                                                                            .profilePic),
                                                                        fit: BoxFit
                                                                            .fill)),
                                                          ),
                                                        ),
                                              Row(
                                                children: [
                                                  listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "like" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "comment" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "follow_request" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "donation" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "project" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "payment"
                                                      ? Container()
                                                      : GestureDetector(
                                                          onTap: () {
                                                            SharedUtils
                                                                    .readTerms(
                                                                        "Terms")
                                                                .then((result) {
                                                              if (result !=
                                                                  null) {
                                                                if (result) {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    child:
                                                                        Dialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .whiteColor,
                                                                      child:
                                                                          new Container(
                                                                        margin:
                                                                            EdgeInsets.all(5),
                                                                        width: SizeConfig.blockSizeHorizontal *
                                                                            80,
                                                                        height:
                                                                            SizeConfig.blockSizeVertical *
                                                                                40,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                                                              color: AppColors.whiteColor,
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                'confirmation'.tr,
                                                                                style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: SizeConfig.blockSizeVertical * 10,
                                                                              width: SizeConfig.blockSizeHorizontal * 25,
                                                                              margin: EdgeInsets.only(
                                                                                left: SizeConfig.blockSizeHorizontal * 5,
                                                                                right: SizeConfig.blockSizeHorizontal * 5,
                                                                                top: SizeConfig.blockSizeVertical * 2,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                image: new DecorationImage(
                                                                                  image: new AssetImage("assets/images/caution.png"),
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: SizeConfig.blockSizeVertical * 9,
                                                                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                                                              color: AppColors.whiteColor,
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                'paymentalert'.tr,
                                                                                style: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                                setState(() {
                                                                                  Widget cancelButton = FlatButton(
                                                                                    child: Text('no'.tr),
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  );
                                                                                  Widget continueButton = FlatButton(
                                                                                    child: Text('yes'.tr),
                                                                                    onPressed: () async {
                                                                                      listing.result.data.elementAt(index).price == "0" ? Payamount(listing.result.data.elementAt(index).updateId, listing.result.data.elementAt(index).id.toString(), userid) : Payamount(listing.result.data.elementAt(index).updateId, listing.result.data.elementAt(index).id.toString(), userid);
                                                                                    },
                                                                                  );
                                                                                  // set up the AlertDialog
                                                                                  AlertDialog alert = AlertDialog(
                                                                                    title: Text('paynow'.tr),
                                                                                    content: Text('areyousureyouwanttoPaythisproject'.tr),
                                                                                    actions: [
                                                                                      cancelButton,
                                                                                      continueButton,
                                                                                    ],
                                                                                  );
                                                                                  // show the dialog
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return alert;
                                                                                    },
                                                                                  );
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                height: SizeConfig.blockSizeVertical * 5,
                                                                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, bottom: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeHorizontal * 25, right: SizeConfig.blockSizeHorizontal * 25),
                                                                                decoration: BoxDecoration(
                                                                                  image: new DecorationImage(
                                                                                    image: new AssetImage("assets/images/sendbutton.png"),
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                                child: Text('okay'.tr,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'Poppins-Regular',
                                                                                      fontSize: 14,
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  print(
                                                                      "falseValue");
                                                                  warningDialog(
                                                                      'pleasereadthetermsandconditionscarefullybeforepaying'
                                                                          .tr,
                                                                      "Notification",
                                                                      context);
                                                                }
                                                              } else {
                                                                print(
                                                                    "falseValue");
                                                                warningDialog(
                                                                    'pleasereadthetermsandconditionscarefullybeforepaying'
                                                                        .tr,
                                                                    "Notification",
                                                                    context);
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                25,
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                5,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              right: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  4,
                                                            ),
                                                            child: Text(
                                                              'pay'.tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      "Poppins-Regular",
                                                                  color: AppColors
                                                                      .theme1color),
                                                            ),
                                                          ),
                                                        ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Widget cancelButton =
                                                          FlatButton(
                                                        child: Text('no'.tr),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                      Widget continueButton =
                                                          FlatButton(
                                                        child: Text('yes'.tr),
                                                        onPressed: () async {
                                                          setState(() {
                                                            deleteItem(listing
                                                                .result.data
                                                                .elementAt(
                                                                    index)
                                                                .id
                                                                .toString());
                                                          });
                                                        },
                                                      );
                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title:
                                                            Text('delete'.tr),
                                                        content: Text(
                                                            'areyousureyouwanttodeletethisnotification'
                                                                .tr),
                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );
                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      margin: EdgeInsets.only(
                                                        right: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1,
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/cross.png",
                                                        color: AppColors.redbg,
                                                        width: 15,
                                                        height: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        80,
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                        bottom: SizeConfig
                                                                .blockSizeVertical *
                                                            1),
                                                    padding: EdgeInsets.only(
                                                        left: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1,
                                                        right: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .fullName !=
                                                              null
                                                          ? listing.result.data
                                                              .elementAt(index)
                                                              .fullName
                                                          : listing.result.data
                                                                      .elementAt(
                                                                          index)
                                                                      .groupName !=
                                                                  null
                                                              ? listing
                                                                  .result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .groupName
                                                              : "",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  listing.result.data.elementAt(index).notifyFrom == "like" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "comment" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "follow_request" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "donation" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "project" ||
                                                          listing.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notifyFrom ==
                                                              "payment"
                                                      ? Container()
                                                      : Container(
                                                          width: SizeConfig.blockSizeHorizontal *
                                                              40,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: SizeConfig
                                                                    .blockSizeVertical *
                                                                1,
                                                          ),
                                                          padding: EdgeInsets.only(
                                                              left: SizeConfig.blockSizeHorizontal * 1,
                                                              right: SizeConfig.blockSizeHorizontal * 1),
                                                          alignment: Alignment.centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'amount'.tr,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontFamily:
                                                                        "Poppins-Regular",
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                listing.result
                                                                            .data
                                                                            .elementAt(
                                                                                index)
                                                                            .price ==
                                                                        "0"
                                                                    ? listing
                                                                        .result
                                                                        .data
                                                                        .elementAt(
                                                                            index)
                                                                        .minCashByParticipant
                                                                    : listing
                                                                        .result
                                                                        .data
                                                                        .elementAt(
                                                                            index)
                                                                        .price,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontFamily:
                                                                        "Poppins-Regular",
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          )),
                                                  Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        80,
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                        bottom: SizeConfig
                                                                .blockSizeVertical *
                                                            1),
                                                    padding: EdgeInsets.only(
                                                        left: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1,
                                                        right: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      listing.result.data
                                                          .elementAt(index)
                                                          .description,
                                                      textAlign: TextAlign.left,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "like" ||
                                                  listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "comment" ||
                                                  listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "follow_request" ||
                                                  listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "donation" ||
                                                  listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "project" ||
                                                  listing.result.data
                                                          .elementAt(index)
                                                          .notifyFrom ==
                                                      "payment"
                                              ? Container()
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            40,
                                                        margin: EdgeInsets.only(
                                                            top: SizeConfig
                                                                    .blockSizeVertical *
                                                                1,
                                                            bottom: SizeConfig
                                                                    .blockSizeVertical *
                                                                1),
                                                        padding: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'startdate'.tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      "Poppins-Regular",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              " :  " +
                                                                  listing.result
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .postedDate,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      "Poppins-Regular",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        )),
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          40,
                                                      margin: EdgeInsets.only(
                                                          top: SizeConfig
                                                                  .blockSizeVertical *
                                                              1,
                                                          bottom: SizeConfig
                                                                  .blockSizeVertical *
                                                              1),
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'enddate'.tr,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontFamily:
                                                                    "Poppins-Regular",
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            " :  " +
                                                                listing
                                                                    .result.data
                                                                    .elementAt(
                                                                        index)
                                                                    .postedDate,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontFamily:
                                                                    "Poppins-Regular",
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          listing.result.data
                                                      .elementAt(index)
                                                      .giftPicture ==
                                                  ''
                                              ? Container()
                                              : Container(
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      25,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      100,
                                                  alignment: Alignment.center,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.scaleDown,
                                                      imageUrl: Network
                                                              .BaseApigift +
                                                          listing.result.data
                                                              .elementAt(index)
                                                              .giftPicture,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                25,
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .scaleDown),
                                                            ),
                                                          ),
                                                      placeholder: (context,
                                                              url) =>
                                                          new Image.asset(
                                                              'assets/images/dummyplace.jpg'))),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                markasreadItem(listing
                                                    .result.data
                                                    .elementAt(index)
                                                    .id
                                                    .toString());
                                              });
                                            },
                                            child: Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    5,
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        1,
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        2),
                                                decoration: BoxDecoration(
                                                  image: new DecorationImage(
                                                    image: new AssetImage(
                                                        "assets/images/sendbutton.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text('markasread'.tr,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            'Poppins-Regular'))),
                                          )
                                        ],
                                      ))));
                        })
                    : Container(
                        margin: EdgeInsets.only(top: 150),
                        alignment: Alignment.center,
                        child: resultvalue == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Text('norecordsfound'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular')),
                              ),
                      )
                /*  Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

             Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3, bottom: SizeConfig.blockSizeVertical *3,
                            left: SizeConfig.blockSizeHorizontal *3, right: SizeConfig.blockSizeHorizontal *3),

                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(

                              alignment:Alignment.topLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *2,
                                bottom: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal *4,
                                right: SizeConfig.blockSizeHorizontal *4,
                              ),
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              child: Divider(
                                thickness: 1,
                                color: Colors.black12,
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *10,
                              width: SizeConfig.blockSizeHorizontal *95,
                              alignment:Alignment.topLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *1,
                                bottom: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal *4,
                                right: SizeConfig.blockSizeHorizontal *4,
                              ),
                              child: Text(
                                "No new notifications",
                                maxLines: 4,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black12,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 3,
                            bottom: SizeConfig.blockSizeVertical * 3,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3),
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 1),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                left: SizeConfig.blockSizeHorizontal * 4,
                                right: SizeConfig.blockSizeHorizontal * 4,
                              ),
                              child: Text(
                                "Earlier",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

              ),*/
                ),
          ],
        ),
      ),
      bottomNavigationBar: bottombar(
          context, storelist_length != null ? listing.unreadnotificaiton : 0),
    );
  }

  bottombar(context, int unreadnotificaiton) {
    return Container(
      height: SizeConfig.blockSizeVertical * 8,
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 24,
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/homeicon.png",
                      height: 19,
                      width: 19,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'home'.tr,
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => mytranscation()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_mytranscaton.png",
                      height: 19,
                      width: 19,
                      color: AppColors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'mytransactions'.tr,
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NotificationScreen()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/notificationicon.png",
                          height: 19,
                          width: 19,
                          color: AppColors.selectedcolor,
                        ),
                     /*   new Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 10,
                              minHeight: 10,
                            ),
                            child: new Text(
                              '$unreadnotificaiton',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )*/
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'notification'.tr,
                        style: TextStyle(
                            color: AppColors.selectedcolor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ContactUs()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 23,
                margin:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_contactus.png",
                      height: 19,
                      width: 19,
                      color: AppColors.greyColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'contactus'.tr,
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Future<void> Payamount(
      String id, String notificationid, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'id': id.toString(),
      'notificationid': notificationid.toString(),
      'sender_id': userid.toString(),
    };

    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.notification_projectpay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(updateval)["message"]);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NotificationScreen()));
        } else {
          errorDialog(jsonDecode(updateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(updateval)["message"]);
    }
  }

  Future<void> deleteItem(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'id': id.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.delete_notification, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deleteval = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonDecode(deleteval)["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NotificationScreen()));
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonDecode(deleteval)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(deleteval)["message"]);
    }
  }

  Future<void> markasreadItem(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'id': id.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.update_notifications, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      markasreadval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonDecode(markasreadval)["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item mark Successfully");
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NotificationScreen()));
          });
        } else {
          print("if Item is not mark Successfully");
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonDecode(markasreadval)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(markasreadval)["message"]);
    }
  }
}
