import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Pojo/followstatus.dart';
import 'package:kontribute/Pojo/individualRequestDetailspojo.dart';
import 'package:kontribute/Pojo/paymentlist.dart';
import 'package:kontribute/Pojo/sendmoneypojo.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class viewdetail_sendreceivegift extends StatefulWidget {
  final String data;
  final String coming;

  const viewdetail_sendreceivegift(
      {Key key, @required this.data, @required this.coming})
      : super(key: key);

  @override
  viewdetail_sendreceivegiftState createState() =>
      viewdetail_sendreceivegiftState();
}

class viewdetail_sendreceivegiftState extends State<viewdetail_sendreceivegift> {
  String data1;
  String coming1;
  bool internet = false;
  bool resultvalue = true;
  String val;
  String valfollowstatus;
  String vals;
  var storelist_length;
  String image;
  String Follow = "Follow";
  int a;
  String updateval;
  double totalamount;
  String valcommision;
  var commisionlist_length;
  commisionpojo commission;
  String userid;
  String imageprofile;
  individualRequestDetailspojo senddetailsPojo;
  followstatus followstatusPojo;
  paymentlist paymentlistpojo;
  var productlist_length;
  String reverid;
  bool resultfollowvalue = true;
  var followlist_length;
  FollowinglistPojo followlistpojo;
  String followval;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  sendmoneypojo moneypojo;

  @override
  void initState() {
    super.initState();
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        coming1 = widget.coming;
        a = int.parse(data1);
        print("receiverComing: " + coming1.toString());
        print("Coming: " + a.toString());
        SharedUtils.readloginId("UserId").then((val) {
          print("UserId: " + val);
          userid = val;
          getData(a, userid);
          getCommision();
          print("Login userid: " + userid.toString());
        });
        // getpaymentlist(a);
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


  void getCommision() async {
    var jsonResponse = null;
    var response = await http.get(Uri.encodeFull(Network.BaseApi + Network.admincommission));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valcommision = response.body;
      if (jsonResponse["success"] == false) {
        errorDialog(jsonDecode(valcommision)["message"]);
      } else {
        commission = new commisionpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            commisionlist_length = commission.commisiondata;
          });
        } else {
          errorDialog(commission.message);
        }
      }
    } else {
      errorDialog(jsonDecode(valcommision)["message"]);
    }
  }


  void getfollowstatus(String userid, String rec) async {
    Map data = {
      'receiver_id': rec.toString(),
      'userid': userid.toString(),
    };
    print("follow: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.checkfollow_status, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valfollowstatus = response.body; //store response as string
      if (jsonDecode(valfollowstatus)["status"] == false) {
        setState(() {
          Follow = "Follow";
        });
       // errorDialog(jsonDecode(valfollowstatus)["message"]);
      } else {
        followstatusPojo = new followstatus.fromJson(jsonResponse);
        print("Json status: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            Follow = "";
          });

        } else {
          errorDialog(followstatusPojo.message);

        }
      }
    } else {
     errorDialog(jsonDecode(valfollowstatus)["message"]);
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
                  child: Text('okay'.tr,
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


  void getData(int id, String userid) async {
    setState(() {
      productlist_length=null;
    });
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.send_receive_gifts_contributer, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);
      } else {
        senddetailsPojo = new individualRequestDetailspojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = senddetailsPojo.result;
            storelist_length = senddetailsPojo.memberlist;
            if (senddetailsPojo.result.senderId == null) {
              reverid = senddetailsPojo.result.groupAdmin.toString();
              print("TRue" + reverid);
              getfollowstatus(userid, reverid);
            } else {
              reverid = senddetailsPojo.result.senderId.toString();
              print("false" + reverid);
              getfollowstatus(userid, reverid);
            }
            if (senddetailsPojo.result.receiverProfilePic == "") {
              setState(() {
                image = senddetailsPojo.result.adminProfilePic;
              });
            }
            else{
              setState(() {
                image = senddetailsPojo.result.receiverProfilePic;
              });
            }

            if (!senddetailsPojo.result.profilePic.startsWith("https://"))
            {
              image=Network.BaseApiprofile+senddetailsPojo.result.profilePic;

            }
            else
            {
              image=senddetailsPojo.result.profilePic;
            }


          });
        } else {
          errorDialog(senddetailsPojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
  }

  /*void getpaymentlist(int gift_id) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'gift_id': gift_id.toString(),
    };
    print("Gift id: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.pay_money_listing, body: data);
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
        paymentlistpojo = new paymentlist.fromJson(jsonResponse);
        print("Payment List" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(paymentlistpojo.paymentdetails.data.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = paymentlistpojo.paymentdetails.data;
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: paymentlistpojo.message,
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
                      'sendandreceivegift'.tr,
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
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  productlist_length != null
                      ? Column(
                          children: [
                            Container(
                              // color: Colors.black12,
                              child: Stack(
                                children: [

                                  Container
                                    (
                                    color: Colors.black12,
                                    child:  Container(
                                        height: SizeConfig.blockSizeVertical * 19,
                                        width:
                                        SizeConfig.blockSizeHorizontal * 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: senddetailsPojo
                                                .result.giftPicture !=
                                                null ||
                                                senddetailsPojo
                                                    .result.giftPicture !=
                                                    ""
                                                ? NetworkImage(
                                                Network.BaseApigift +
                                                    senddetailsPojo
                                                        .result.giftPicture)
                                                : new AssetImage(
                                                "assets/images/viewdetailsbg.png"),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                  ),

                                  Row(
                                    children: [
                                      senddetailsPojo.result.profilePic == null || senddetailsPojo.result.profilePic == "" ?
                                      Container(
                                              height: SizeConfig.blockSizeVertical * 12,
                                              width: SizeConfig.blockSizeVertical * 12,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                     12,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4),
                                              decoration: BoxDecoration(
                                                image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "assets/images/account_circle.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              )) :
                                      Container(
                                        height:
                                        SizeConfig.blockSizeVertical *
                                            12,
                                        width:
                                        SizeConfig.blockSizeVertical *
                                            12,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      12,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors
                                                        .themecolor,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(image),
                                                      fit: BoxFit.fill)),
                                            ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    43,
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        7),
                                                child: Text(
                                                 "",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                              ),
                                              coming1 == "Ongoing"
                                                  ?
                                              GestureDetector(
                                                      onTap: () {
                                                        followapi(
                                                            userid, reverid);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: SizeConfig
                                                                  .blockSizeVertical *
                                                              8,
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              2,
                                                        ),
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              color: AppColors
                                                                  .yelowbg,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Poppins-Regular'),
                                                        ),
                                                      ),
                                                    ): coming1 == "Search"
                                                  ?

                                              GestureDetector(
                                                onTap: () {
                                                  followapi(
                                                      userid, reverid);
                                                },
                                                child: Container(
                                                  padding:
                                                  EdgeInsets.only(
                                                    top: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                    right: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2,
                                                  ),
                                                  child: Text(
                                                    "",
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.0,
                                                        color: AppColors
                                                            .yelowbg,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                              )
                                                  : Container()
                                            ],
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    60,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3),
                                            alignment: Alignment.topRight,
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
                                              /* StringConstant.totalContribution+"-25 ",*/
                                              "",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily:
                                                      'Poppins-Regular'),
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
                                                right: SizeConfig.blockSizeHorizontal * 3),
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                bottom: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                                top: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                       2),
                                                child: Text(
                                                  senddetailsPojo.result.message,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                            ],
                                          ),

                                          /*Row(
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
                                      bottom:
                                      SizeConfig.blockSizeVertical *
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
                          ),*/

                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          62,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        left: SizeConfig
                                            .blockSizeHorizontal *
                                            3,
                                        top: SizeConfig
                                            .blockSizeVertical *
                                            1,
                                      ),
                                      child: Text(
                                        senddetailsPojo.result.fullName == null ||
                                            senddetailsPojo.result.fullName == ""
                                            ? "" : senddetailsPojo.result.fullName,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                    coming1 == "Ongoing"
                                        ?
                                    GestureDetector(
                                      onTap: () {
                                        followapi(userid, reverid);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: SizeConfig.blockSizeHorizontal * 3),
                                        alignment: Alignment.topRight,
                                        padding:
                                        EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                          left: SizeConfig.blockSizeHorizontal * 1,
                                          right: SizeConfig.blockSizeHorizontal * 2,
                                        ),
                                        child: Text(
                                          Follow,
                                          style: TextStyle(
                                              letterSpacing:
                                              1.0,
                                              color: AppColors
                                                  .themecolor,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontFamily:
                                              'Poppins-Regular'),
                                        ),
                                      ),
                                    ): coming1 == "Search"
                                        ?

                                    GestureDetector(
                                      onTap: () {
                                        followapi(
                                            userid, reverid);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: SizeConfig.blockSizeHorizontal * 3),
                                        alignment: Alignment.topRight,
                                        padding:
                                        EdgeInsets.only(
                                          top: SizeConfig
                                              .blockSizeVertical *
                                              1,
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                          right: SizeConfig
                                              .blockSizeHorizontal *
                                              2,
                                        ),
                                        child: Text(
                                          Follow,
                                          style: TextStyle(
                                              letterSpacing:
                                              1.0,
                                              color: AppColors
                                                  .themecolor,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontFamily:
                                              'Poppins-Regular'),
                                        ),
                                      ),
                                    )
                                        : Container()
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width:
                                      SizeConfig.blockSizeHorizontal *
                                         50,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              3),
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        /* StringConstant.totalContribution+"-25 ",*/
                                        "",
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                    senddetailsPojo.result.endDate != null ?
                                    Container (
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                          bottom: SizeConfig
                                              .blockSizeVertical *
                                              1,
                                          top: SizeConfig
                                              .blockSizeHorizontal *
                                              1),
                                      child: Text(
                                         'closingdate'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ):Container(),

                                    Container (
                                      margin: EdgeInsets.only(
                                          right: SizeConfig.blockSizeHorizontal * 3),
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                          right: SizeConfig
                                              .blockSizeHorizontal *
                                              2,
                                          bottom: SizeConfig
                                              .blockSizeVertical *
                                              1,
                                          top: SizeConfig
                                              .blockSizeHorizontal *
                                              1),
                                      child: Text(
                                        senddetailsPojo.result.endDate != null ? "  "+senddetailsPojo.result.endDate
                                            : "",
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal * 3),
                                      child: Text(
                                        'collectiontarget'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 10,
                                            fontWeight:
                                            FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                        right: SizeConfig
                                            .blockSizeHorizontal *
                                            3,
                                      ),
                                      child: Text(" "+
                                        senddetailsPojo.result.price != null
                                            ? "  \$" +
                                            senddetailsPojo.result.price.toString()
                                            : "  \$" +
                                            senddetailsPojo.result
                                                .collectionTarget
                                                .toString(),
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors
                                                .lightBlueAccent,
                                            fontSize: 10,
                                            fontWeight:
                                            FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    )
                                  ],
                                ),
                                /*Row(
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
                                      bottom:
                                      SizeConfig.blockSizeVertical *
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
                          ),*/
                                Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig
                                          .blockSizeVertical *
                                          2),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                              ],
                            ),

                           /* Container(
                              width: SizeConfig.blockSizeHorizontal * 90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1,
                                left: SizeConfig.blockSizeHorizontal * 2,
                                right: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                senddetailsPojo.result.message,
                                maxLines: 3,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black87,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),*/

                            senddetailsPojo.result.specialTerms != null
                                ? Container(
                                    width: SizeConfig.blockSizeHorizontal * 90,
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2,
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'termsandcondition'.tr,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black87,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins-Regular'),
                                    ),
                                  )
                                : Container(),
                            senddetailsPojo.result.specialTerms != null
                                ? Container(
                                    width: SizeConfig.blockSizeHorizontal * 90,
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      senddetailsPojo.result.specialTerms,
                                      maxLines: 3,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black87,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular'),
                                    ),
                                  )
                                : Container(
                                    width: SizeConfig.blockSizeHorizontal * 90,
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "",
                                      maxLines: 3,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black87,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular'),
                                    ),
                                  )
                          ],
                        )
                      : Container(
                          child: Center(
                            child: internet == true
                                ? CircularProgressIndicator()
                                : SizedBox(),
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
                  Container(
                    child: storelist_length != null
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                                                senddetailsPojo.memberlist.elementAt(index).memberProfilePic == null ||senddetailsPojo.memberlist.elementAt(index).memberProfilePic ==""
                                                    ?  Container(
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    width: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    alignment:
                                                    Alignment.center,
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
                                                    decoration:
                                                    BoxDecoration(
                                                      image:
                                                      new DecorationImage(
                                                        image: new AssetImage(
                                                            "assets/images/account_circle.png"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )):

                                                Container(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            8,
                                                        width: SizeConfig
                                                                .blockSizeVertical *
                                                            8,
                                                        alignment:
                                                            Alignment.center,
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
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(senddetailsPojo
                                                                    .memberlist
                                                                    .elementAt(
                                                                        index)
                                                                    .memberProfilePic),
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig.blockSizeHorizontal * 53,
                                                          alignment: Alignment.topLeft,
                                                          padding: EdgeInsets.only(
                                                            left: SizeConfig.blockSizeHorizontal * 1,
                                                          ),
                                                          child: Text(
                                                                  senddetailsPojo.memberlist.elementAt(index).memberName != null ?
                                                                  senddetailsPojo.memberlist.elementAt(index).memberName : "",
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color: Colors.black87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Poppins-Regular'),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: SizeConfig.blockSizeHorizontal * 20,
                                                          alignment: Alignment.topRight,
                                                          padding: EdgeInsets.only(
                                                            left: SizeConfig.blockSizeHorizontal * 1,
                                                            right: SizeConfig.blockSizeHorizontal * 3,
                                                          ),
                                                          child: Text(
                                                            senddetailsPojo.memberlist.elementAt(index).paymentStatus==0?'pending'.tr:
                                                            senddetailsPojo.memberlist.elementAt(index).paymentStatus==1?'done'.tr:'pending'.tr,
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color: AppColors.black,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.normal,
                                                                fontFamily: 'Poppins-Regular'),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: SizeConfig.blockSizeHorizontal * 53,
                                                          alignment: Alignment.topLeft,
                                                          padding:
                                                          EdgeInsets.only(
                                                            left: SizeConfig.blockSizeHorizontal * 1,
                                                            top: SizeConfig.blockSizeVertical * 2,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'contribute'.tr,
                                                                style: TextStyle(
                                                                    letterSpacing: 1.0,
                                                                    color: Colors.black87,
                                                                    fontSize: 10,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                    fontFamily: 'Poppins-Regular'),
                                                              ),
                                                              Container(
                                                                alignment: Alignment.topLeft,
                                                                /*padding: EdgeInsets.only(
                                                                    left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        1,
                                                                    right: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        3,
                                                                    top: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        2),*/
                                                                child: Text(
                                                                  "- \$"+senddetailsPojo.memberlist.elementAt(index).amountPaid.toString(),
                                                                  style: TextStyle(
                                                                      letterSpacing: 1.0,
                                                                      color: Colors.black87,
                                                                      fontSize: 10,
                                                                      fontWeight: FontWeight.normal,
                                                                      fontFamily: 'Poppins-Regular'),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        senddetailsPojo.memberlist.elementAt(index).id == userid ?
                                                        senddetailsPojo.memberlist.elementAt(index).paymentStatus==0?
                                                        GestureDetector(
                                                                onTap: () {
                                                                  if(senddetailsPojo.result.price != null)
                                                                    {
                                                                      double tectString = double.parse(senddetailsPojo.result.price)*(commission.commisiondata.senderCommision/100);
                                                                      totalamount = double.parse(senddetailsPojo.result.price) + tectString;
                                                                      print("PrintSring: "+totalamount.toString());
                                                                      print("PrintSringpers: "+tectString.toString());
                                                                    }
                                                                  else
                                                                    {
                                                                      double tectString = double.parse(senddetailsPojo.result.collectionTarget)*(commission.commisiondata.senderCommision/100);
                                                                      totalamount = double.parse(senddetailsPojo.result.collectionTarget) + tectString;
                                                                      print("PrintSring: "+totalamount.toString());
                                                                      print("PrintSringpers: "+tectString.toString());
                                                                    }

                                                                  SharedUtils.readTerms("Terms").then((result){
                                                                    if(result!=null){
                                                                      if(result){
                                                                        showDialog(
                                                                          context: context,
                                                                          child: Dialog(
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            backgroundColor: AppColors.whiteColor,
                                                                            child: new Container(
                                                                              margin: EdgeInsets.all(5),
                                                                              width: SizeConfig.blockSizeHorizontal * 80,
                                                                              height: SizeConfig.blockSizeVertical *40,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                                                                    color: AppColors.whiteColor,
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      'confirmation'.tr,
                                                                                      style: TextStyle(
                                                                                          fontSize: 14.0,
                                                                                          color: Colors.black,
                                                                                          fontWeight: FontWeight.normal),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    height: SizeConfig.blockSizeVertical *10,
                                                                                    width: SizeConfig.blockSizeHorizontal *25,
                                                                                    margin: EdgeInsets.only(
                                                                                      left: SizeConfig.blockSizeHorizontal *5,
                                                                                      right: SizeConfig.blockSizeHorizontal *5,
                                                                                      top: SizeConfig.blockSizeVertical *2,),
                                                                                    decoration: BoxDecoration(
                                                                                      image: new DecorationImage(
                                                                                        image: new AssetImage("assets/images/caution.png"),
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    height: SizeConfig.blockSizeVertical *9,
                                                                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                                                                    color: AppColors.whiteColor,
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      'paymentalert'.tr,
                                                                                      style: TextStyle(
                                                                                          fontSize: 12.0,
                                                                                          color: Colors.black,
                                                                                          fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.of(context).pop();
                                                                                      setState(() {
                                                                                        Widget cancelButton =
                                                                                        FlatButton(
                                                                                          child:
                                                                                          Text('cancel'.tr),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        );
                                                                                        Widget continueButton =
                                                                                        FlatButton(
                                                                                          child: Text('continue'.tr),
                                                                                          onPressed: () async {
                                                                                            payamount();
                                                                                          },
                                                                                        );
                                                                                        // set up the AlertDialog
                                                                                        AlertDialog alert =
                                                                                        AlertDialog(
                                                                                          title: Text('paynow'.tr),
                                                                                          content:
                                                                                          //Text('areyousureyouwanttoPay'.tr),
                                                                                          Container(
                                                                                            width: SizeConfig.blockSizeHorizontal * 80,
                                                                                            height: SizeConfig.blockSizeVertical *15,
                                                                                            child:
                                                                                            new Column(
                                                                                              children: [
                                                                                              /*  new Text('areyousureyouwanttoPay'.tr,
                                                                                                    style: TextStyle(
                                                                                                        letterSpacing: 1.0,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: 'Poppins-Regular',
                                                                                                        fontSize: 14,
                                                                                                        color: Colors.black)),*/
                                                                                                senddetailsPojo.result.price != null?
                                                                                                Container(
                                                                                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text("Pay Amount  \$"+senddetailsPojo.result.price.toString(),
                                                                                                      style: TextStyle(
                                                                                                          letterSpacing: 1.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontFamily: 'Poppins-Regular',
                                                                                                          fontSize: 14,
                                                                                                          color: Colors.black))
                                                                                                ):
                                                                                                Container(
                                                                                                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                                    alignment: Alignment.centerLeft,
                                                                                                    child: new Text("Pay Amount  \$"+senddetailsPojo.result.collectionTarget.toString(),
                                                                                                        style: TextStyle(
                                                                                                            letterSpacing: 1.0,
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontFamily: 'Poppins-Regular',
                                                                                                            fontSize: 14,
                                                                                                            color: Colors.black))
                                                                                                ),
                                                                                                Container(
                                                                                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Row(
                                                                                                    children: [
                                                                                                      Text('extracharges'.tr,
                                                                                                        style: TextStyle(
                                                                                                            letterSpacing: 1.0,
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontFamily: 'Poppins-Regular',
                                                                                                            fontSize: 14,
                                                                                                            color: Colors.black),
                                                                                                      ),
                                                                                                      Text(" "+commission.commisiondata.senderCommision.toString()+"%",
                                                                                                        style: TextStyle(
                                                                                                            letterSpacing: 1.0,
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontFamily: 'Poppins-Regular',
                                                                                                            fontSize: 14,
                                                                                                            color: Colors.black),
                                                                                                      ),
                                                                                                    ],
                                                                                                  )
                                                                                                ),
                                                                                                Container(
                                                                                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text("Total Pay   \$"+totalamount.toString(),
                                                                                                      style: TextStyle(
                                                                                                          letterSpacing: 1.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontFamily: 'Poppins-Regular',
                                                                                                          fontSize: 14,
                                                                                                          color: Colors.black)),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
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
                                                                                      margin: EdgeInsets.only(
                                                                                          top: SizeConfig.blockSizeVertical * 3,
                                                                                          bottom: SizeConfig.blockSizeVertical * 2,
                                                                                          left: SizeConfig.blockSizeHorizontal * 25,
                                                                                          right: SizeConfig.blockSizeHorizontal * 25),
                                                                                      decoration: BoxDecoration(
                                                                                        image: new DecorationImage(
                                                                                          image: new AssetImage(
                                                                                              "assets/images/sendbutton.png"),
                                                                                          fit: BoxFit.fill,
                                                                                        ),
                                                                                      ),
                                                                                      child: Text('okay'.tr,
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
                                                                      }
                                                                      else{
                                                                        print("falseValue");
                                                                        warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Gift", context);
                                                                      }
                                                                    }
                                                                    else{
                                                                      print("falseValue");
                                                                      warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Gift", context);
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                Container(
                                                                  width: SizeConfig.blockSizeHorizontal * 20,
                                                                  alignment: Alignment.center,
                                                                  margin: EdgeInsets.only(
                                                                    left: SizeConfig.blockSizeHorizontal * 1,
                                                                    top: SizeConfig.blockSizeVertical * 2,
                                                                    right: SizeConfig.blockSizeHorizontal * 3,
                                                                  ),
                                                                  padding: EdgeInsets.only(
                                                                      right: SizeConfig.blockSizeHorizontal * 2,
                                                                      left: SizeConfig.blockSizeHorizontal * 2,
                                                                      bottom: SizeConfig.blockSizeHorizontal * 2,
                                                                      top: SizeConfig.blockSizeHorizontal * 2),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors.whiteColor,
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      border: Border.all(color
                                                                          : AppColors.orange)
                                                                  ),
                                                                  child: Text(
                                                                    'pay'.tr,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        letterSpacing: 1.0,
                                                                        color: AppColors.orange,
                                                                        fontSize: 10,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontFamily: 'Poppins-Regular'),
                                                                  ),
                                                                ),
                                                              )
                                                            :Container()
                                                            : Container()
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
                            })
                        : Container(
                            alignment: Alignment.center,
                            child: internet == true
                                ? Center(
                                    child: Text('loading..'.tr),
                                  )
                                : Center(child: Text("")),
                          ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: bottombar(context),
    );
  }

  Future<void> payamount() async {
    String price;
    if(senddetailsPojo.result.price != null)
      {
        price =senddetailsPojo.result.price.toString();
      }
    else
      {
        price = senddetailsPojo.result.collectionTarget.toString();
      }
    print("Price: "+price.toString());


    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'id': senddetailsPojo.result.id.toString(),
      'sender_id': userid.toString(),
      'price_money': price.toString(),
      'updated_price': totalamount.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.pay_money, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        showToast(updateval);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        moneypojo = new sendmoneypojo.fromJson(jsonResponse);

        if (jsonResponse != null) {
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: moneypojo.paymentId.toString(),
                    amount:moneypojo.paypalAmount.toString(),
                    coming:"gift",
                    backto:"GIFT"
                ), context);
          });
         /*
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
                        jsonDecode(updateval)["message"],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingSendReceived()), (route) => false);
                        });
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
          );*/
          // getpaymentlist(a);
        } else {
          showToast(updateval);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      showToast(updateval);
    }
  }

  void showToast(String updateval) {
    errorDialog(jsonDecode(updateval)["message"]);
  }

  Future<void> followapi(String useid, String rece) async {
    Map data = {
      'sender_id': useid.toString(),
      'receiver_id': rece.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.follow, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updateval);
      } else {
        if (jsonResponse != null) {
          setState(() {
            Follow = "";
          });
        } else {
          showToast(updateval);
        }
      }
    } else {
      showToast(updateval);
    }
  }
}
