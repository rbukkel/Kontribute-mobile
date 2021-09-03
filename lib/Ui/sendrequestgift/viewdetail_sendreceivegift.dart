import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/followstatus.dart';
import 'package:kontribute/Pojo/individualRequestDetailspojo.dart';
import 'package:kontribute/Pojo/paymentlist.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class viewdetail_sendreceivegift extends StatefulWidget {
  final String data;
  final String coming;

  const viewdetail_sendreceivegift({Key key, @required this.data,@required this.coming})
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
  String Follow="Follow";
  int a;
  String updateval;
  String userid;
  individualRequestDetailspojo senddetailsPojo;
  followstatus followstatusPojo;
  paymentlist paymentlistpojo;
  var productlist_length;
  String reverid;
  bool resultfollowvalue = true;
  var followlist_length;
  FollowinglistPojo followlistpojo;
  String followval;


  @override
  void initState() {
    super.initState();
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        coming1 = widget.coming;
        a = int.parse(data1);
        print("receiverComing: "+ coming1.toString());
        print("Coming: "+ a.toString());
        SharedUtils.readloginId("UserId").then((val) {
          print("UserId: " + val);
          userid = val;
          getData(a,userid);
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
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }



  void getfollowstatus(String userid,String rec) async {
    Map data = {
      'receiver_id': rec.toString(),
      'userid': userid.toString(),
    };
    print("follow: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.checkfollow_status, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valfollowstatus = response.body; //store response as string
      if (jsonDecode(valfollowstatus)["status"] == false) {
        setState(() {
          Follow="Follow";
        });

        Fluttertoast.showToast(
          msg: jsonDecode(valfollowstatus)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        followstatusPojo = new followstatus.fromJson(jsonResponse);
        print("Json status: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            Follow="";
          });

          Fluttertoast.showToast(
              msg: jsonDecode(valfollowstatus)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
    );
        } else {
          Fluttertoast.showToast(
            msg: followstatusPojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(valfollowstatus)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }



  void getData(int id,String userid) async {
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
      if (jsonDecode(val)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        senddetailsPojo = new individualRequestDetailspojo.fromJson(jsonResponse);
        print("Json User: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = senddetailsPojo.result;
            storelist_length = senddetailsPojo.memberlist;
            if(senddetailsPojo.result.receiverId==null)
            {
              reverid = senddetailsPojo.result.groupAdmin.toString();
              print("TRue"+reverid);
              getfollowstatus(userid,reverid);
            }
            else {
              reverid = senddetailsPojo.result.receiverId.toString();
              print("false"+reverid);
              getfollowstatus(userid,reverid);
            }
            if (senddetailsPojo.result.giftPicture != null)
            {
              setState(()
              {
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
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        productlist_length != null ?
                        Container(
                          // color: Colors.black12,
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
                                          ? NetworkImage(Network.BaseApigift +senddetailsPojo.result.giftPicture)
                                          : new AssetImage("assets/images/viewdetailsbg.png"),
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
                                          top: SizeConfig.blockSizeVertical * 1,
                                          bottom: SizeConfig.blockSizeVertical * 1,
                                          right: SizeConfig.blockSizeHorizontal * 1,
                                          left: SizeConfig.blockSizeHorizontal * 4),
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
                                        top: SizeConfig.blockSizeVertical * 1,
                                        bottom:
                                        SizeConfig.blockSizeVertical * 1,
                                        right:
                                        SizeConfig.blockSizeHorizontal * 1,
                                        left:
                                        SizeConfig.blockSizeHorizontal * 4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(Network.BaseApiprofile+senddetailsPojo
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
                                            SizeConfig.blockSizeHorizontal * 43,
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                                top:
                                                SizeConfig.blockSizeVertical * 7),
                                            child: Text(
                                              senddetailsPojo.result.receiverName == null||senddetailsPojo.result.receiverName==""?
                                              senddetailsPojo.result.groupName:senddetailsPojo.result.receiverName,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins-Regular'),
                                            ),
                                          ),
                                          coming1=="Ongoing"?
                                          GestureDetector(
                                            onTap: () {
                                              followapi(userid,reverid);
                                            },
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
                                                Follow,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.yelowbg,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins-Regular'),
                                              ),
                                            ),
                                          ):Container()
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
                                          senddetailsPojo.result.endDate!=null?"Closing Date-"+senddetailsPojo.result.endDate:"",
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
                                              senddetailsPojo.result.price!=null?"\$"+senddetailsPojo.result.price.toString():"\$"+senddetailsPojo.result.collectionTarget.toString(),
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
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 62,
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1, right: SizeConfig.blockSizeHorizontal * 2,),
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
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                                        child: Divider(
                                          thickness: 1,
                                          color: Colors.black12,
                                        ),
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
                         child: storelist_length != null ?
                         ListView.builder(
                             physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: storelist_length.length == null ? 0 : storelist_length.length,
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
                                                 senddetailsPojo.memberlist
                                                     .elementAt(index)
                                                     .memberProfilePic !=
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

                                                               senddetailsPojo.memberlist
                                                                   .elementAt(index)
                                                                   .memberProfilePic ),
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
                                                             senddetailsPojo.memberlist
                                                                 .elementAt(index).memberName!=null?senddetailsPojo.memberlist
                                                                 .elementAt(index).memberName:"",
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
                                                                 senddetailsPojo.memberlist
                                                                     .elementAt(index).minCashByParticipant.toString(),
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
                                           senddetailsPojo.memberlist
                                               .elementAt(index).id==userid?
                                                         GestureDetector(
                                                           onTap: () {
                                                             payamount();
                                                             /* paymentlistpojo
                                                                    .paymentdetails
                                                                    .data
                                                                    .elementAt(
                                                                    index)
                                                                    .status ==
                                                                    "0"
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
                                                                    1);*/
                                                           },
                                                           child: Container(
                                                             width: SizeConfig
                                                                 .blockSizeHorizontal *
                                                                 20,
                                                             alignment:
                                                             Alignment.center,
                                                             margin: EdgeInsets.only
                                                               (top: SizeConfig
                                                                 .blockSizeHorizontal *
                                                                 2),
                                                             padding: EdgeInsets.only(
                                                                 right: SizeConfig.blockSizeHorizontal * 2,
                                                                 left: SizeConfig.blockSizeHorizontal * 2,
                                                                 bottom: SizeConfig.blockSizeHorizontal * 2,
                                                                 top: SizeConfig.blockSizeHorizontal * 2),
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
                                                               "Pay",
                                                               textAlign:
                                                               TextAlign.center,
                                                               style: TextStyle(
                                                                   letterSpacing: 1.0,
                                                                   color: AppColors.orange,
                                                                   fontSize: 10,
                                                                   fontWeight: FontWeight.normal,
                                                                   fontFamily: 'Poppins-Regular'),
                                                             ),
                                                           ),
                                                         ):Container()
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
                               );}
                             ) :
                         Container(
                           alignment: Alignment.center,
                           child: internet == true
                               ? Center(
                             child: Text("No Payment"),
                           )
                               : Center(
                               child: Text("")
                           ),
                         ),
                       )
                      ],
                    ),
                  )
              )
            ],
          ),
      ),
      bottomNavigationBar: bottombar(context),
    );
  }

  Future<void> payamount() async {
    Map data = {
      'id': senddetailsPojo.result.id.toString(),
      'sender_id': userid.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.pay_money, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updateval);
      }
      else {
        if (jsonResponse != null) {
          showToast(updateval);
         // getpaymentlist(a);
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

  Future<void>  followapi(String useid,String rece) async {
    Map data = {
      'sender_id': useid.toString(),
      'receiver_id': rece.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.follow, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updateval);
      }
      else {
        if (jsonResponse != null) {
          showToast(updateval);
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
