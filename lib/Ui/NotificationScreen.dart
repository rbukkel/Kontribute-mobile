import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/Notificationpojo.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

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
        print("PAge: "+pageNumber.toString());
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
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          if (pageNumber < listing.result.lastPage) {
            pageNumber += 1;
            getdata(userid, pageNumber);
          }
        });
      }
      if (_scrollController.offset <= _scrollController.position.minScrollExtent && !_scrollController.position.outOfRange)
      {
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
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }  else {
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.result.data;
            }
          });
        } else {
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

  void getdata(String user_id, int page) async {
    Map data = {
      'userid': user_id.toString(),
    };
    Dialogs.showLoadingDialog(context, _keyLoader);
    print("user: " + data.toString());
    var jsonResponse = null;
    print(Network.BaseApi + Network.notificationlisting + "?page=" + page.toString());
    http.Response response = await http.post(Network.BaseApi + Network.notificationlisting + "?page=$page", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {
          resultvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.result.data;
            }
          });
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(
              msg: listing.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
    paginationApi();
  }

/*
  @override
  void initState() {
    super.initState();
    setState(() {
      _index=2;
    });

    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());

    });
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getdata(userid);
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
*/

  /*void getdata(String user_id) async {
    setState(() {
      storelist_length =null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.notificationlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        listing = new Notificationpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(listing.result.data.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.result.data;
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
  }*/

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
                      StringConstant.notification,
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
            Container(
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
            ),
            Expanded(
              child: storelist_length != null ?
                ListView.builder(
                    controller: _scrollController,
                    itemCount: storelist_length.length == null
                        ? 0 : storelist_length.length,
                    /*physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,*/
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,
                        right: SizeConfig.blockSizeHorizontal *5),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: SizeConfig
                                        .blockSizeVertical *
                                        1),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  listing.result.data
                                      .elementAt(
                                      index)
                                      .profilePic ==
                                      null ||
                                      listing.result.data
                                          .elementAt(
                                          index)
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
                                        margin: EdgeInsets.only(
                                            top: SizeConfig
                                                .blockSizeVertical *
                                               1,
                                            bottom: SizeConfig
                                                .blockSizeVertical *
                                                1,
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                1),
                                        decoration:
                                        BoxDecoration(
                                          image:
                                          new DecorationImage(
                                            image: new AssetImage(
                                                "assets/images/account_circle.png"),
                                            fit: BoxFit
                                                .fill,
                                          ),
                                        )),
                                  )
                                      : listing.result.data
                                      .elementAt(
                                      index)
                                      .facebookId ==
                                      null ||
                                      listing.result
                                          .data
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
                                      margin: EdgeInsets.only(
                                          top: SizeConfig
                                              .blockSizeVertical *
                                              2,
                                          bottom:
                                          SizeConfig.blockSizeVertical *
                                              1,
                                          right: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1),
                                      decoration: BoxDecoration(
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
                                      margin: EdgeInsets.only(
                                          top: SizeConfig
                                              .blockSizeVertical *
                                              2,
                                          bottom:
                                          SizeConfig.blockSizeVertical *
                                              1,
                                          right: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1),
                                      decoration: BoxDecoration(
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
                                      GestureDetector(
                                        onTap: () {
                                          Widget cancelButton =
                                          FlatButton(
                                            child: Text("No"),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context);
                                            },
                                          );
                                          Widget
                                          continueButton =
                                          FlatButton(
                                            child: Text("Yes"),
                                            onPressed:
                                                () async {
                                              listing.result
                                                  .data
                                                  .elementAt(
                                                  index)
                                                  .price ==
                                                  "0"
                                                  ? Payamount(
                                                  listing
                                                      .result
                                                      .data
                                                      .elementAt(
                                                      index)
                                                      .updateId,
                                                  listing.result.data.elementAt(index).id.toString(),
                                                  userid)
                                                  : Payamount(
                                                  listing
                                                      .result
                                                      .data
                                                      .elementAt(
                                                      index)
                                                      .updateId,
                                                  listing.result.data.elementAt(index).id.toString(),
                                                  userid);
                                            },
                                          );
                                          // set up the AlertDialog
                                          AlertDialog alert =
                                          AlertDialog(
                                            title: Text(
                                                "Pay now.."),
                                            content: Text(
                                                "Are you sure you want to Pay this project?"),
                                            actions: [
                                              cancelButton,
                                              continueButton,
                                            ],
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext
                                            context) {
                                              return alert;
                                            },
                                          );
                                        },
                                        child: Container(
                                          alignment:
                                          Alignment.center,
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
                                            StringConstant.pay,
                                            textAlign: TextAlign
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
                                          deleteItem(listing
                                              .result.data
                                              .elementAt(index)
                                              .id
                                              .toString());
                                        },
                                        child: Container(
                                          color: Colors
                                              .transparent,
                                          margin:
                                          EdgeInsets.only(
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                          ),
                                          child: Image.asset(
                                            "assets/images/cross.png",
                                            color:
                                            AppColors.redbg,
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
                                MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
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
                                        alignment: Alignment
                                            .centerLeft,
                                        child: Text(
                                          listing.result.data
                                              .elementAt(
                                              index)
                                              .fullName !=
                                              null
                                              ? listing
                                              .result.data
                                              .elementAt(
                                              index)
                                              .fullName
                                              : listing
                                              .result.data
                                              .elementAt(
                                              index)
                                              .groupName!=null?listing
                                              .result.data
                                              .elementAt(
                                              index)
                                              .groupName:"",
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
                                              color:
                                              Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            40,
                                        margin: EdgeInsets.only(
                                          top: SizeConfig
                                              .blockSizeVertical *
                                              1,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1),
                                        alignment: Alignment
                                            .centerLeft,
                                        child: Text(
                                          listing.result.data
                                              .elementAt(
                                              index)
                                              .price ==
                                              "0"
                                              ? "Amount: " +
                                              listing.result
                                                  .data
                                                  .elementAt(
                                                  index)
                                                  .minCashByParticipant
                                              : "Amount: " +
                                              listing.result
                                                  .data
                                                  .elementAt(
                                                  index)
                                                  .price,
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
                                              color:
                                              Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            80,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig
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
                                        child: Text(
                                          listing.result.data
                                              .elementAt(index)
                                              .description,
                                          textAlign:
                                          TextAlign.left,
                                          maxLines: 3,
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
                                                  .black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
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
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Text(
                                      "Start date: " +
                                          listing.result.data
                                              .elementAt(index)
                                              .postedDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration
                                              .none,
                                          fontSize: 10,
                                          fontWeight:
                                          FontWeight.normal,
                                          fontFamily:
                                          "Poppins-Regular",
                                          color: Colors.black),
                                    ),
                                  ),
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
                                    child: Text(
                                      "End date: " +
                                          listing.result.data
                                              .elementAt(index)
                                              .postedDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.none,
                                          fontSize: 10,
                                          fontWeight:
                                          FontWeight.normal,
                                          fontFamily:
                                          "Poppins-Regular",
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  height: SizeConfig
                                      .blockSizeVertical *
                                      25,
                                  width: SizeConfig
                                      .blockSizeHorizontal *
                                      100,
                                  alignment: Alignment.center,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
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
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                    placeholder: (context,
                                        url) =>
                                    new Image.asset(
                                        'assets/images/dummyplace.jpg')
                                  )),
                            ],
                          ));
                    })
                  : Container(
                margin: EdgeInsets.only(top: 150),
                alignment: Alignment.center,
                child: resultvalue == true
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Center(
                  child: Image.asset(
                      "assets/images/empty.png",
                      height: SizeConfig
                          .blockSizeVertical *
                          50,
                      width: SizeConfig
                          .blockSizeVertical *
                          50),
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
      bottomNavigationBar: bottombar(context),
    );
  }

  bottombar(context) {
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
                width: SizeConfig.blockSizeHorizontal * 15,
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/homeicon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Home",
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
                    builder: (BuildContext context) => WalletScreen()));
              });

            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/walleticon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Wallet",
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
                width: SizeConfig.blockSizeHorizontal * 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/notificationicon.png",
                      height: 20,
                      width: 20,
                      color: AppColors.selectedcolor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Notification",
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
          builder: (BuildContext context) => SettingScreen()));
    });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                margin:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/settingicon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Setting",
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

  Future<void> Payamount(String id,String notificationid, String userid) async {
    Map data = {
      'id': id.toString(),
      'notificationid': notificationid.toString(),
      'sender_id': userid.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.notification_projectpay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Fluttertoast.showToast(
            msg: jsonDecode(updateval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        if (jsonResponse != null) {
          Fluttertoast.showToast(
              msg: jsonDecode(updateval)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NotificationScreen()));
        } else {
          Fluttertoast.showToast(
              msg: jsonDecode(updateval)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: jsonDecode(updateval)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  Widget _buildFab(BuildContext context) {
    // final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddScreen()));
      },
      child: Image.asset("assets/images/addpost.png"),
      elevation: 3.0,
    );
  }

  void _selectedTab(int index) {
    index = -1;
    setState(() {
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletScreen()));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingScreen()));
      }
    });
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

        Fluttertoast.showToast(
          msg: jsonDecode(deleteval)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            getdata(userid, pageNumber);
          });
          Fluttertoast.showToast(
              msg: jsonDecode(deleteval)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(
            msg: jsonDecode(deleteval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonDecode(deleteval)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
