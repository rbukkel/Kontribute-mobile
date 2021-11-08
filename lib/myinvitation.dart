import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/FollowRequestAcceptPojo.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/follow_Request_updatePojo.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class myinvitation extends StatefulWidget {
  @override
  _myinvitationState createState() => _myinvitationState();
}

class _myinvitationState extends State<myinvitation> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userid;
  bool resultvalue = true;
  bool resultfollowvalue = true;
  bool internet = false;
  String val;
  String requestval;
  String followval;
  var storelist_length;
  var followlist_length;
  FollowRequestAcceptPojo requestpojo;
  FollowinglistPojo followlistpojo;
  follow_Request_updatePojo followupdatepojo;

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid);

    });
  }
  void getdata(String user_id) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'receiver_id': user_id.toString(),
    };

    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.follow_Request, body: data);
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
        requestpojo = new FollowRequestAcceptPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {

            if(requestpojo.result.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = requestpojo.result;
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: requestpojo.message,
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
                      StringConstant.Invitations,
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

                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    color: AppColors.whiteColor,
                    // height: SizeConfig.blockSizeVertical *8,
                    child: Card(
                        child: Column(
                      children: [
                        storelist_length != null ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Invitations",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: AppColors.theme1color),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Image.asset(
                                "assets/images/next.png",
                                color: AppColors.black,
                                width: 15,
                                height: 15,
                              ),
                            )
                          ],
                        ):Container(),
                        storelist_length != null ?
                        Container(
                          child: ListView.builder(
                              itemCount:  storelist_length.length == null
                                  ? 0
                                  : storelist_length.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    child: Row(
                                  children: [
                                    requestpojo.result.elementAt(index).facebookId!=null?
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                      },
                                      child: Container(
                                        height: SizeConfig
                                            .blockSizeVertical *
                                            10,
                                        width: SizeConfig
                                            .blockSizeVertical *
                                            10,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            bottom: SizeConfig
                                                .blockSizeVertical *
                                                1,
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  requestpojo.result.elementAt(index).profilePic,
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                    ):

                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                      },
                                      child: Container(
                                        height: SizeConfig
                                            .blockSizeVertical *
                                            10,
                                        width: SizeConfig
                                            .blockSizeVertical *
                                            10,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            bottom: SizeConfig
                                                .blockSizeVertical *
                                                1,
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  Network.BaseApiprofile+requestpojo.result.elementAt(index).profilePic,
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  43,
                                              padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                              ),
                                              child: Text(
                                                requestpojo.result.elementAt(index).fullName,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.themecolor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap:(){

                                           followaccept(userid,
                                               requestpojo.result.elementAt(index).id,
                                           "2");

                                           },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.blockSizeHorizontal * 1,
                                                right: SizeConfig.blockSizeHorizontal *3,
                                                top: SizeConfig.blockSizeVertical * 1),
                                            child: Image.asset(
                                              "assets/images/error.png",
                                              color: AppColors.black,
                                              width: 38,
                                              height: 38,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap:(){

                                            followaccept(userid,
                                                requestpojo.result.elementAt(index).id,
                                                "1");

                                          },
                                          child:   Container(
                                            margin: EdgeInsets.only(
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    5,
                                                top:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                            child: Image.asset(
                                              "assets/images/check.png",
                                              color: AppColors.theme1color,
                                              width: 38,
                                              height: 38,
                                            ),
                                          ),
                                        )

                                      ],
                                    )
                                  ],
                                ));
                              }),
                        ): Container(
                          alignment: Alignment.center,
                          child: resultvalue == true
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : Center(
                            child: Container()
                          ),
                        ),

                      ],
                    )),
                  ),

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> followaccept(String userid, String id, String status) async {
    Map data = {
      'receiver_id': userid.toString(),
      'id': id.toString(),
      'status': status.toString(),
    };

    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.follow_Request_update, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      requestval = response.body;
      if (jsonResponse["success"] == false) {
        Fluttertoast.showToast(
            msg: jsonDecode(requestval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        followupdatepojo = new follow_Request_updatePojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          Fluttertoast.showToast(
              msg: followupdatepojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
          setState(() {
            getdata(userid);
          });
        }
        else {
          Fluttertoast.showToast(
              msg: followupdatepojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(requestval)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
