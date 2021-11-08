import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/MyTransactionsPojo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mytranscation extends StatefulWidget {
  @override
  mytranscationState createState() => mytranscationState();
}

class mytranscationState extends State<mytranscation> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String tabvalue = "Paid";
  bool paid = true;
  bool receive = false;
  bool internet = false;
  String val;
  String userid;
  MyTransactionsPojo listing;
  var transactions_received;
  var paid_transaction;
  bool resultvalue = true;
  bool resultpaidvalue = true;

  @override
  void initState() {
    super.initState();
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

  void getdata(String user_id) async {
    setState(() {
      transactions_received = null;
    });
    Map data = {
      'user_id': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.transactions, body: data);
    if (response.statusCode == 200) {
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
        listing = new MyTransactionsPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.transactionsReceived.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              transactions_received = listing.transactionsReceived;
            }

            if (listing.paidTransaction.isEmpty) {
              resultpaidvalue = false;
            } else {
              resultpaidvalue = true;
              print("SSSS");
              paid_transaction = listing.paidTransaction;
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
                    width: SizeConfig.blockSizeHorizontal * 60,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      "My Transcation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins-Regular",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      tabvalue = "Paid";
                      paid = true;
                      receive = false;
                    });

                    print("Value: " + tabvalue);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 6,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Card(
                        color:
                            paid ? AppColors.light_grey : AppColors.whiteColor,
                        child: Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          height: SizeConfig.blockSizeVertical * 5,
                          child: Text(StringConstant.amountpaid),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      tabvalue = "Received";
                      paid = false;
                      receive = true;
                    });

                    print("Value: " + tabvalue);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 6,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Card(
                          color: receive
                              ? AppColors.light_grey
                              : AppColors.whiteColor,
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(StringConstant.amountreceive),
                          ))),
                ),
              ],
            ),
            tabvalue == "Received" ?  transactions_received != null
                ? Expanded(
              child: ListView.builder(
                  itemCount: transactions_received.length == null
                      ? 0
                      : transactions_received.length,
                  itemBuilder: (BuildContext context, int idex) {
                    return Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *
                                                        1),
                                                width:
                                                SizeConfig.blockSizeHorizontal * 68,
                                                alignment: Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal *
                                                      1,
                                                ),
                                                child: Text(
                                                  listing.transactionsReceived.elementAt(idex).paidfor,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *
                                                        1),
                                                alignment: Alignment.topRight,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal *
                                                      1,
                                                  right:
                                                  SizeConfig.blockSizeHorizontal *
                                                      3,
                                                ),
                                                child: Text(
                                                  "Amount Received",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *
                                                        1),
                                                width:
                                                SizeConfig.blockSizeHorizontal * 68,
                                                alignment: Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal *
                                                      1,
                                                ),
                                                child: Text(
                                                  listing.transactionsReceived.elementAt(idex).paiddate,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                SizeConfig.blockSizeHorizontal * 22,
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *
                                                        1),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    right:
                                                    SizeConfig.blockSizeHorizontal *
                                                        2,
                                                    left:
                                                    SizeConfig.blockSizeHorizontal *
                                                        2,
                                                    bottom:
                                                    SizeConfig.blockSizeHorizontal *
                                                        1,
                                                    top:
                                                    SizeConfig.blockSizeHorizontal *
                                                        1),
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                    border: Border.all(width: 1.0)),
                                                child: Text(
                                                  "\$"+listing.transactionsReceived.elementAt(idex).amount.toString(),
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          )),
                    );
                  }),
            ) : Container(
              margin: EdgeInsets.only(top: 150),
              alignment: Alignment.center,
              child: resultvalue == true
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Center(
                child: Image.asset("assets/images/empty.png",
                    height: SizeConfig.blockSizeVertical * 50,
                    width: SizeConfig.blockSizeVertical * 50),
              ),
            ) :   paid_transaction != null
                ? Expanded(
                child: ListView.builder(
                    itemCount: paid_transaction.length == null
                        ? 0
                        : paid_transaction.length,
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
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeVertical *
                                                          1),
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      68,
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),
                                                  child: Text(
                                                    listing.paidTransaction.elementAt(index).paidfor,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeVertical *
                                                          1),
                                                  alignment: Alignment.topRight,
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                    right: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3,
                                                  ),
                                                  child: Text(
                                                    "Amount Received",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeVertical *
                                                          1),
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      68,
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),
                                                  child: Text(
                                                    listing.paidTransaction.elementAt(index).paiddate,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      22,
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeVertical *
                                                          1),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      bottom: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.black,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                      border: Border.all(
                                                          width: 1.0)),
                                                  child: Text(
                                                    "\$"+listing.paidTransaction.elementAt(index).amount.toString(),
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            )),
                      );
                    }))
                : Container(
              margin: EdgeInsets.only(top: 150),
              alignment: Alignment.center,
              child: resultvalue == true
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Center(
                child: Image.asset("assets/images/empty.png",
                    height: SizeConfig.blockSizeVertical * 50,
                    width: SizeConfig.blockSizeVertical * 50),
              ),
            )
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
                width: SizeConfig.blockSizeHorizontal * 13,
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
                    builder: (BuildContext context) => mytranscation()));
              });

            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal *24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_mytranscaton.png",
                      height: 20,
                      width: 20,
                      color: AppColors.selectedcolor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "My Transactions",
                        style:
                        TextStyle(color: AppColors.selectedcolor, fontSize: 10),
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
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Notification",
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 10),
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
                width: SizeConfig.blockSizeHorizontal * 15,
                margin:
                EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_contactus.png",
                      height: 20,
                      width: 20,
                      color: AppColors.greyColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Contact Us",
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
}
