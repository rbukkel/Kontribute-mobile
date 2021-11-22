import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/FollowRequestAcceptPojo.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/follow_Request_updatePojo.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/myinvitation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class ReceivedRequest extends StatefulWidget {
  @override
  _ReceivedRequestState createState() => _ReceivedRequestState();
}

class _ReceivedRequestState extends State<ReceivedRequest> {
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
  String searchvalue="";

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid,searchvalue);

    });
  }
  void getdata(String user_id,String search) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'receiver_id': user_id.toString(),
      'search': search.toString(),
    };

    print("follow_Request: " + data.toString());
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
     /* key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),*/
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
           /* Container(
              height: SizeConfig.blockSizeVertical * 12,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/appbar.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      "My Network",
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
            ),*/

            _createSearchView(),
            SearchView()

          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,
            right: SizeConfig.blockSizeHorizontal *2),
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *20,
            left: SizeConfig.blockSizeHorizontal*5,
            right: SizeConfig.blockSizeHorizontal*5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0)
        ),
        child: new
        TextField(
          onChanged: (value){
            setState(() {
              getdata(userid,value);
            });
          },
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black), hintText: 'Search...'),
        )
    );
  }

  SearchView() {
    return Expanded(
      child: storelist_length != null ?
      Container(
        alignment: Alignment.centerLeft,
        //height: SizeConfig.blockSizeVertical * 30,
        margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 4,
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 2,
            right: SizeConfig.blockSizeHorizontal * 2),
        child:  MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child:
            ListView.builder(
                itemCount:  storelist_length.length == null ? 0 : storelist_length.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
                      child: Row(
                        children: [
                          requestpojo.result.elementAt(index).facebookId!=null?
                          GestureDetector(
                            onTap: () {
                              callNext(viewdetail_profile(data: requestpojo.result.elementAt(index).senderId.toString()), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
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
                          requestpojo.result.elementAt(index).profilePic!=null?GestureDetector(
                            onTap: ()
                            {
                              callNext(
                                  viewdetail_profile(
                                      data: requestpojo.result.elementAt(index).senderId.toString()
                                  ), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.blockSizeVertical *
                                      1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
                                      5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        Network.BaseApiprofile+requestpojo.result.elementAt(index).profilePic,
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                          ):
                          GestureDetector(
                            onTap: ()
                            {
                              callNext(
                                  viewdetail_profile(
                                      data: requestpojo.result.elementAt(index).senderId.toString()
                                  ), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.blockSizeVertical *
                                      1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
                                      5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: new AssetImage("assets/images/account_circle.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),),
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
                                        45,
                                    padding: EdgeInsets.only(
                                      top: SizeConfig
                                          .blockSizeVertical *
                                          1,
                                    ),
                                    child: Text(
                                      requestpojo.result.elementAt(index).fullName!=null?requestpojo.result.elementAt(index).fullName:"",
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
                                onTap:()
                                {
                                  followaccept(userid, requestpojo.result.elementAt(index).id, "2");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                      right: SizeConfig.blockSizeHorizontal *3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Image.asset(
                                    "assets/images/error.png",
                                    color: AppColors.black,
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap:(){
                                  followaccept(userid, requestpojo.result.elementAt(index).id, "1");
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
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              )

                            ],
                          )
                        ],
                      ));
                }),),
      ):
      Container(
        margin: EdgeInsets.only(top: 60),
        alignment: Alignment.center,
        child: resultvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text("No Records Found",style: TextStyle(
              letterSpacing: 1.0,
              color: AppColors.black,
              fontSize: 16,
              fontWeight:
              FontWeight.normal,
              fontFamily:
              'Poppins-Regular')),
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

    print("follow_Request_update: " + data.toString());
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
            getdata(userid,searchvalue);
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
