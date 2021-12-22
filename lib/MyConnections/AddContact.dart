import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/FollowRequestAcceptPojo.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:kontribute/Pojo/follow_Request_updatePojo.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/myinvitation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String userid;
  bool resultvalue = true;
  bool resultfollowvalue = true;
  bool internet = false;
  String val;
  String reverid;
  String requestval;
  String Follow = "Follow";
  String updateval;
  String unfollowval;
  String followval;
  var storelist_length;
  var followlist_length;
  num countValue = 2;
  num aspectWidth = 2;
  num aspectHeight = 2;
  FollowRequestAcceptPojo requestpojo;
  UserlistingPojo followlistpojo;
  follow_Request_updatePojo followupdatepojo;
  String searchvalue = "";
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(
        userid,
      );
      getFollowing(userid, searchvalue);
    });
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

  void getdata(String user_id) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'receiver_id': user_id.toString(),
    };

    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.follow_Request, body: data);
    if (response.statusCode == 200) {
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
            if (requestpojo.result.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = requestpojo.result;
            }
          });
        } else {
          errorDialog(requestpojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }
  }

  void getFollowing(String user_id, String search) async {
    //Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'userid': user_id.toString(),
      'search': search.toString(),
    };
    print("Useridlisting: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.username_listing, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      followval = response.body;
      if (jsonResponse["status"] == false) {
        //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        setState(() {
          followlist_length = null;
          resultfollowvalue = false;
        });
      } else {
        //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        followlistpojo = new UserlistingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (followlistpojo.data.isEmpty) {
              resultfollowvalue = false;
            } else {
              resultfollowvalue = true;
              print("SSSS");
              followlist_length = followlistpojo.data;
            }
          });
        } else {
          errorDialog(followlistpojo.message);
        }
      }
    } else {
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(followval)["message"]);
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
            _createSearchView(),
            Expanded(
              child: followlist_length != null
                  ? Container(
                      margin: EdgeInsets.only(
                          //  bottom: SizeConfig.blockSizeVertical * 4,
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: countValue,
                          childAspectRatio: (aspectWidth / aspectHeight),
                          children: List.generate(
                              followlist_length.length == null
                                  ? 0
                                  : followlist_length.length, (ind) {
                            reverid = followlistpojo.data
                                .elementAt(ind)
                                .id
                                .toString();
                            return Container(
                              child: Card(
                                  child: Container(
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "assets/images/peoplemayknow_bg.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    followlistpojo.data
                                                .elementAt(ind)
                                                .facebookId !=
                                            null
                                        ? GestureDetector(
                                            onTap: () {
                                              callNext(
                                                  viewdetail_profile(
                                                      data: followlistpojo.data
                                                          .elementAt(ind)
                                                          .id
                                                          .toString()),
                                                  context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                bottom: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              decoration: BoxDecoration(
                                                  /*border: Border.all(
                                                width: 1,
                                                color: AppColors
                                                    .themecolor,
                                                style: BorderStyle.solid,
                                              ),*/
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        followlistpojo.data
                                                            .elementAt(ind)
                                                            .profilePic,
                                                      ),
                                                      fit: BoxFit.fill)),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              callNext(
                                                  viewdetail_profile(
                                                      data: followlistpojo.data
                                                          .elementAt(ind)
                                                          .id
                                                          .toString()),
                                                  context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2),
                                              decoration: BoxDecoration(
                                                  /* border: Border.all(
                                                width: 1,
                                                color: AppColors
                                                    .themecolor,
                                                style: BorderStyle.solid,
                                              ),*/
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        Network.BaseApiprofile +
                                                            followlistpojo.data
                                                                .elementAt(ind)
                                                                .profilePic,
                                                      ),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 43,
                                      margin: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                          left: SizeConfig.blockSizeHorizontal *
                                             1),
                                      alignment: Alignment.center,
                                      child: Text(
                                        followlistpojo.data
                                            .elementAt(ind)
                                            .fullName,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    followlistpojo.data
                                                .elementAt(ind)
                                                .followed ==
                                            "yes"
                                        ? GestureDetector(
                                            onTap: () {
                                              Unfollowapi(
                                                  userid,
                                                  followlistpojo.data
                                                      .elementAt(ind)
                                                      .id
                                                      .toString());
                                            },
                                            child: Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  34,
                                              padding: EdgeInsets.only(
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      1),
                                              decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .themecolor)),
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2,
                                                  bottom: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'unfollow'.tr,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.themecolor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                          )
                                        : followlistpojo.data
                                                    .elementAt(ind)
                                                    .followed ==
                                                "pending"
                                            ? Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    34,
                                                padding: EdgeInsets.only(
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2,
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2,
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        1,
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        1),
                                                decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .themecolor)),
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                    bottom: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2,
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'pending'.tr,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:
                                                          AppColors.themecolor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {

                                                  followapi(
                                                      userid,
                                                      followlistpojo.data
                                                          .elementAt(ind)
                                                          .id
                                                          .toString());
                                                },
                                                child: Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      34,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2,
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2,
                                                      bottom: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          1),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .themecolor)),
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          2,
                                                      bottom: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2,
                                                      right: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'connect'.tr,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .themecolor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Poppins-Regular'),
                                                  ),
                                                ),
                                              )
                                  ],
                                ),
                              )),
                            );
                          }),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 150),
                      alignment: Alignment.center,
                      child: resultfollowvalue == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Text('norecordsfound'.tr,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular')),
                            ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
     // height: SizeConfig.blockSizeVertical * 7,
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 1,
          right: SizeConfig.blockSizeHorizontal * 1),
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 20,
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4),

      /*   decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0)
        ),*/
      decoration: BoxDecoration(
          image: new DecorationImage(
        image: new AssetImage("assets/images/searchbar.png"),
        fit: BoxFit.fill,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.start,
            onChanged: (value) {
              setState(() {
                getFollowing(userid, value);
              });
            },
            decoration: new InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                hintText: 'search'.tr),
          )
        ],
      ),
    );
  }

  Future<void> followapi(String useid, String rece) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
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
         Navigator.of(context, rootNavigator: true).pop();
        showToast(updateval);
        setState(() {
          getFollowing(userid, searchvalue);
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();

        if (jsonResponse != null) {
          // showToast(updateval);
          setState(() {
            getFollowing(userid, searchvalue);
          });
        } else {
          showToast(updateval);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();

      showToast(updateval);
    }
  }

  Future<void> Unfollowapi(String useid, String rece) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
    Map data = {
      'senderid': rece.toString(),
      'receiverid': useid.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.unfollow_request, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      unfollowval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
         Navigator.of(context, rootNavigator: true).pop();
        showToast(unfollowval);
        setState(() {
          getFollowing(userid, searchvalue);
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          setState(() {
            getFollowing(userid, searchvalue);
          });
        } else {
          showToast(unfollowval);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      showToast(unfollowval);
    }
  }

  void showToast(String updateval) {
    errorDialog(jsonDecode(updateval)["message"]);
  }

  Future<void> followaccept(String userid, String id, String status) async {
    Map data = {
      'receiver_id': userid.toString(),
      'id': id.toString(),
      'status': status.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.follow_Request_update, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      requestval = response.body;
      if (jsonResponse["success"] == false) {
        errorDialog(jsonDecode(requestval)["message"]);
      } else {
        followupdatepojo = new follow_Request_updatePojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            getdata(userid);
          });
        } else {
          errorDialog(followupdatepojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(requestval)["message"]);
    }
  }
}
