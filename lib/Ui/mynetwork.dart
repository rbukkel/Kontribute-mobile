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

class mynetwork extends StatefulWidget {
  @override
  _mynetworkState createState() => _mynetworkState();
}

class _mynetworkState extends State<mynetwork> {
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
  num countValue = 2;
  num aspectWidth = 2;
  num aspectHeight = 2;
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
      getdata(userid);
      getFollowing(userid,searchvalue);
    });
  }
  void getdata(String user_id) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'receiver_id': user_id.toString(),
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

  void getFollowing(String user_id,String search) async {
    setState(() {
      followlist_length =null;
    });
    Map data = {
      'receiver_id': user_id.toString(),
      'search': search.toString(),
    };
    print("followlisting: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.followlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      followval = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          followlist_length =null;
          resultfollowvalue = false;
        });

        Fluttertoast.showToast(
            msg: jsonDecode(followval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        followlistpojo = new FollowinglistPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {

            if(followlistpojo.result.isEmpty)
            {
              resultfollowvalue = false;
            }
            else
            {
              resultfollowvalue = true;
              print("SSSS");
              followlist_length = followlistpojo.result;
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: followlistpojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(followval)["message"],
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
        color: AppColors.whiteColor,
        child: Column(
          children: [
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
              getFollowing(userid,value);
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
      child: followlist_length != null ?
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
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: countValue,
            childAspectRatio: (aspectWidth / aspectHeight),
            children: List.generate(followlist_length.length == null ? 0 : followlist_length.length, (ind) {
              return
                Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    child: Card(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: ()
                            {
                              followaccept(userid, followlistpojo.result.elementAt(ind).id, "2");
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(
                                  left: SizeConfig
                                      .blockSizeHorizontal *
                                      1,
                                  right: SizeConfig
                                      .blockSizeHorizontal *
                                      3,
                                  top: SizeConfig
                                      .blockSizeVertical *
                                      1),
                              child: Image.asset(
                                "assets/images/error.png",
                                color: AppColors.black,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              followlistpojo.result.elementAt(ind).facebookId!=null?GestureDetector(
                                onTap: () {
                                  callNext(
                                      viewdetail_profile(
                                          data: followlistpojo.result.elementAt(ind).senderId.toString()
                                      ), context);
                                },
                                child: Container(
                                  height: SizeConfig
                                      .blockSizeVertical *
                                      12,
                                  width: SizeConfig
                                      .blockSizeVertical *
                                      12,
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
                                            followlistpojo.result.elementAt(ind).profilePic,
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              ):
                              GestureDetector(
                                onTap: () {
                                  callNext(
                                      viewdetail_profile(
                                          data: followlistpojo.result.elementAt(ind).senderId.toString()
                                      ), context);
                                },
                                child: Container(
                                  height: SizeConfig
                                      .blockSizeVertical *
                                      12,
                                  width: SizeConfig
                                      .blockSizeVertical *
                                      12,
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
                                            Network.BaseApiprofile+followlistpojo.result.elementAt(ind).profilePic,
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 55,
                            padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              followlistpojo.result.elementAt(ind).fullName,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily:
                                  'Poppins-Regular'),
                            ),
                          ),
                          /*    Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    55,
                                            padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Android Developer",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  55,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  new Icon(
                                                    Icons.all_inclusive,
                                                    color: Colors.black87,
                                                    size: 10.0,
                                                  ),
                                                  Text(
                                                    " 10 mutual connections",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            'Poppins-Regular'),
                                                  ),
                                                ],
                                              ))*/
                        ],
                      ),
                    ));}
            ),
          ),),
      ):
      Container(
        margin: EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        child: resultfollowvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
            child: Container()
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
            getFollowing(userid,searchvalue);
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
