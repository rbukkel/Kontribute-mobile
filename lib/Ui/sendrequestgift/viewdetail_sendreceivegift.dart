import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Pojo/PaymentSendReceivedList.dart';
import 'package:kontribute/Pojo/SenddetailsPojo.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Pojo/individualRequestDetailspojo.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/createpostgift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class viewdetail_sendreceivegift extends StatefulWidget {
  final String data;

  const viewdetail_sendreceivegift({Key key, @required this.data})
      : super(key: key);

  @override
  viewdetail_sendreceivegiftState createState() =>
      viewdetail_sendreceivegiftState();
}

class viewdetail_sendreceivegiftState
    extends State<viewdetail_sendreceivegift> {
  String data1;
  bool internet = false;
  bool resultvalue = true;
  String val;
  String vals;
  var storelist_length;
  String image;
  int a;
  String updateval;
  individualRequestDetailspojo senddetailsPojo;
  var productlist_length;

  @override
  void initState() {
    super.initState();
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;

        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(a);
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

  void getData(int id) async {
    Map data = {
      'id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.send_receive_gifts_contributer, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        senddetailsPojo =
        new individualRequestDetailspojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = senddetailsPojo.result;
            storelist_length = senddetailsPojo.paymentdetails.data;
            if (senddetailsPojo.result.giftPicture != null) {
              setState(() {
                image = senddetailsPojo.result.giftPicture;
              });
            }
          });
        } else {
          Fluttertoast.showToast(
            msg: senddetailsPojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
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
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,
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
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/back.png",
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
                      StringConstant.sendandreceivegift,
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
            productlist_length != null
                ?
            Container(
              child: Stack(
                children: [
                  Container(
                      height: SizeConfig.blockSizeVertical * 19,
                      width: SizeConfig.blockSizeHorizontal * 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: senddetailsPojo.result.giftPicture !=
                              null ||
                              senddetailsPojo.result.giftPicture != ""
                              ? NetworkImage(Network.BaseApiprofile +senddetailsPojo.result.giftPicture)
                              : new AssetImage(
                              "assets/images/viewdetailsbg.png"),
                          fit: BoxFit.fill,
                        ),
                      )),
                  Row(
                    children: [
                      senddetailsPojo.result.receiverProfilePic == null ||
                          senddetailsPojo.result.receiverProfilePic == ""
                          ? Container(
                          height: SizeConfig.blockSizeVertical * 18,
                          width: SizeConfig.blockSizeVertical * 17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 6,
                              bottom:
                              SizeConfig.blockSizeVertical * 1,
                              right:
                              SizeConfig.blockSizeHorizontal * 1,
                              left:
                              SizeConfig.blockSizeHorizontal * 4),
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  "assets/images/account_circle.png"),
                              fit: BoxFit.fill,
                            ),
                          ))
                          : Container(
                        height: SizeConfig.blockSizeVertical * 18,
                        width: SizeConfig.blockSizeVertical * 17,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 6,
                            bottom:
                            SizeConfig.blockSizeVertical * 1,
                            right:
                            SizeConfig.blockSizeHorizontal * 1,
                            left:
                            SizeConfig.blockSizeHorizontal * 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(Network.BaseApiprofile +senddetailsPojo
                                    .result.receiverProfilePic),
                                fit: BoxFit.fill)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width:
                                SizeConfig.blockSizeHorizontal * 46,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                    top:
                                    SizeConfig.blockSizeVertical * 7),
                                child: Text(
                                  senddetailsPojo.result.receiverName == null
                                      ? senddetailsPojo.result.groupName
                                      : senddetailsPojo.result.receiverName,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 8,
                                    left: SizeConfig.blockSizeHorizontal *
                                        1,
                                    right:
                                    SizeConfig.blockSizeHorizontal *
                                        2,
                                  ),
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: AppColors.yelowbg,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 60,
                            margin: EdgeInsets.only(
                                right:
                                SizeConfig.blockSizeHorizontal * 3),
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1,
                                right: SizeConfig.blockSizeHorizontal * 2,
                                top: SizeConfig.blockSizeHorizontal * 1),
                            child: Text(
                              /* StringConstant.totalContribution+"-25 ",*/
                              "",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                          /* Container(
                            width: SizeConfig.blockSizeHorizontal *64,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(
                                left: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                right: SizeConfig
                                    .blockSizeHorizontal *
                                    2,
                                top: SizeConfig
                                    .blockSizeHorizontal *
                                    1),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                              maxLines: 2,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily:
                                  'Poppins-Regular'),
                            ),
                          ),*/
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 60,
                            margin: EdgeInsets.only(
                                right:
                                SizeConfig.blockSizeHorizontal * 3),
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1,
                                right: SizeConfig.blockSizeHorizontal * 2,
                                bottom: SizeConfig.blockSizeVertical * 1,
                                top: SizeConfig.blockSizeHorizontal * 1),
                            child: Text(
                              "Closing Date-" +
                                  senddetailsPojo.result.endDate!=null?senddetailsPojo.result.endDate:"",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 4),
                                child: Text(
                                  "Collection Target- ",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 4),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                ),
                                child: Text(
                                  "\$" +senddetailsPojo.result.price==null?senddetailsPojo.result.collectionTarget:senddetailsPojo.result.price,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.lightBlueAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  right:
                                  SizeConfig.blockSizeHorizontal * 3,
                                ),
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.lightBlueAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              )
                            ],
                          ),
                          /*   Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                            child:  LinearPercentIndicator(
                              width: 140.0,
                              lineHeight: 14.0,
                              percent: 0.6,
                              center: Text("60%"),
                              backgroundColor: AppColors.lightgrey,
                              progressColor:AppColors.themecolor,
                            ),
                          )*/

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width:
                                SizeConfig.blockSizeHorizontal * 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  payamount();
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(
                                      left:
                                      SizeConfig.blockSizeHorizontal *
                                          1,
                                      right:
                                      SizeConfig.blockSizeHorizontal *
                                          2,
                                      top: SizeConfig.blockSizeVertical *
                                          2),
                                  padding: EdgeInsets.only(
                                      right:
                                      SizeConfig.blockSizeHorizontal *
                                          5,
                                      left:
                                      SizeConfig.blockSizeHorizontal *
                                          5,
                                      bottom:
                                      SizeConfig.blockSizeHorizontal *
                                          2,
                                      top:
                                      SizeConfig.blockSizeHorizontal *
                                          2),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkgreen,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    StringConstant.pay.toUpperCase(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: AppColors.whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular'),
                                  ),
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
            )
                : Container(
              child: Center(
                child: internet == true
                    ? CircularProgressIndicator()
                    : SizedBox(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Divider(
                thickness: 1,
                color: Colors.black12,
              ),
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                  // margin: EdgeInsets.only(top: 10, left: 40),
                  child: Text(
                    StringConstant.exportto, textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins-Regular",
                        color: Colors.black),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical *2),
                    child: Image.asset("assets/images/csv.png",width: 80,height: 40,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical *2,right: SizeConfig.blockSizeHorizontal*4,),
                    child: Image.asset("assets/images/pdf.png",width: 80,height: 40,),
                  ),
                ),
              ],
            ),*/
            storelist_length != null
                ? Expanded(
              child: ListView.builder(
                  itemCount: storelist_length.length == null
                      ? 0
                      : storelist_length.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
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
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      senddetailsPojo.paymentdetails.data
                                          .elementAt(index)
                                          .profilePic !=
                                          null
                                          ? Container(
                                        height: SizeConfig
                                            .blockSizeVertical *
                                            8,
                                        width: SizeConfig
                                            .blockSizeVertical *
                                            8,
                                        alignment: Alignment.center,
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
                                                2),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    Network.BaseApiprofile+
                                                        senddetailsPojo
                                                            .paymentdetails
                                                            .data
                                                            .elementAt(
                                                            index)
                                                            .profilePic),
                                                fit: BoxFit.fill)),
                                      )
                                          : Container(
                                          height: SizeConfig
                                              .blockSizeVertical *
                                              8,
                                          width: SizeConfig
                                              .blockSizeVertical *
                                              8,
                                          alignment: Alignment.center,
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
                                                  2),
                                          decoration: BoxDecoration(
                                            image:
                                            new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/account_circle.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
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
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    53,
                                                alignment:
                                                Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      1,
                                                ),
                                                child: Text(
                                                  senddetailsPojo
                                                      .paymentdetails.data
                                                      .elementAt(index)
                                                      .fullName!=null? senddetailsPojo
                                                      .paymentdetails.data
                                                      .elementAt(index)
                                                      .fullName:"",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:
                                                      Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    20,
                                                alignment:
                                                Alignment.topRight,
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      1,
                                                  right: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3,
                                                ),
                                                child: Text(
                                                  "Status",
                                                  textAlign:
                                                  TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:
                                                      AppColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    53,
                                                alignment:
                                                Alignment.topLeft,
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                    right: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3,
                                                    top: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2),
                                                child: Text(
                                                  "Contribute-\$" +
                                                      senddetailsPojo
                                                          .paymentdetails
                                                          .data
                                                          .elementAt(
                                                          index)
                                                          .amountRequested,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:
                                                      Colors.black87,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  senddetailsPojo
                                                      .paymentdetails
                                                      .data
                                                      .elementAt(
                                                      index)
                                                      .status ==
                                                      "1"
                                                      ? payamount()
                                                      : Fluttertoast.showToast(
                                                      msg:
                                                      "Already paid",
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      gravity:
                                                      ToastGravity
                                                          .BOTTOM,
                                                      timeInSecForIosWeb:
                                                      1);
                                                },
                                                child: Container(
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      20,
                                                  alignment:
                                                  Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      bottom: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          20),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .orange)),
                                                  child: Text(
                                                    senddetailsPojo
                                                        .paymentdetails
                                                        .data
                                                        .elementAt(
                                                        index)
                                                        .status ==
                                                        "1"
                                                        ? "Done"
                                                        .toString()
                                                        .toUpperCase()
                                                        : senddetailsPojo
                                                        .paymentdetails
                                                        .data
                                                        .elementAt(
                                                        index)
                                                        .status ==
                                                        "0"
                                                        ? "Pending"
                                                        .toString()
                                                        .toUpperCase()
                                                        : "Pending"
                                                        .toString()
                                                        .toUpperCase(),
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.0,
                                                        color: AppColors
                                                            .orange,
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight
                                                            .normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
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
            )
                : Container(
              child: Center(
                child: internet == true
                    ? CircularProgressIndicator()
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottombar(context),
    );
  }

  Future<void> payamount() async {
    Map data = {
      'id': senddetailsPojo.result.id.toString(),
      'sender_id': senddetailsPojo.result.senderId.toString(),
    };

    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response =
    await http.post(Network.BaseApi + Network.pay_money, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updateval);
      } else {
        if (jsonResponse != null) {
          showToast(updateval);
          // getPymentList(receiverid1);
        } else {
          showToast(updateval);
        }
      }
    } else {
      showToast(updateval);
    }
  }
  void showToast(String updateval) {
    Fluttertoast.showToast(
      msg: jsonDecode(updateval)["message"],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}
