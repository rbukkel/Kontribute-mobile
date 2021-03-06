import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/FollowRequestAcceptPojo.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:kontribute/Pojo/follow_Request_updatePojo.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/myinvitation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class PeopleYouMay extends StatefulWidget {
  @override
  _PeopleYouMayState createState() => _PeopleYouMayState();
}

class _PeopleYouMayState extends State<PeopleYouMay> {
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
  String followval;
  var storelist_length;
  var followlist_length;
  FollowRequestAcceptPojo requestpojo;
  UserlistingPojo followlistpojo;
  num countValue = 2;
  String unfollowval;
  num aspectWidth = 2;
  num aspectHeight = 2;
  follow_Request_updatePojo followupdatepojo;
  String searchvalue="";
  final GlobalKey _globalKey = GlobalKey();
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid,);
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

    print("user data : " + data.toString());
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
       // showToast(unfollowval);
        setState(() {
          getFollowing(userid,searchvalue);
        });
      }
      else
        {
          Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
         // showToast(unfollowval);
          setState(() {
            getFollowing(userid,searchvalue);
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

  void getFollowing(String user_id,String search) async {
    Map data = {
      'userid': user_id.toString(),
      'search': search.toString(),
    };
    print("Useridlisting: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.username_listing, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      followval = response.body;
      if (jsonResponse["status"] == false)
      {
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
        followlistpojo = new UserlistingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(followlistpojo.data.isEmpty)
            {
              resultfollowvalue = false;
            }
            else
            {
              resultfollowvalue = true;
              print("SSSS");
              followlist_length = followlistpojo.data;
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
      key: _globalKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: (Text('People You May Know',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                letterSpacing: 1.0)
        )
        ),
        actions: [
          GestureDetector(
          onTap: (){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => selectlangauge()), (route) => false);
    },
        child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal *4,),
            child: Text("Skip",
                textAlign:TextAlign.right,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    letterSpacing: 1.0)
            )
        ),)
        ],
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 12,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
      ),
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
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 1,
            right: SizeConfig.blockSizeHorizontal * 1),
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),

        decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/searchbar.png"),
              fit: BoxFit.fill,
            )),
        child: new
        TextField(
          onChanged: (value){
            setState(() {
              getFollowing(userid,value);
            });
          },
          decoration: new InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.black),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black, fontSize: 12),
              hintText: 'Search'),
        )
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
          getFollowing(userid,searchvalue);
        });

      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
        //  showToast(updateval);
          setState(() {
            getFollowing(userid,searchvalue);
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

  void showToast(String updateval) {
    Fluttertoast.showToast(
      msg: jsonDecode(updateval)["message"],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
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
        child: Container(
               height: SizeConfig.blockSizeVertical * 80,
               child:  MediaQuery.removePadding(
                 context: context,
                 removeTop: true,
                 child:   GridView.count(
                   shrinkWrap: true,
                   crossAxisCount: countValue,
                   childAspectRatio: (aspectWidth / aspectHeight),
                   children: List.generate(followlist_length.length == null ? 0 :
                   followlist_length.length, (ind) {
                     reverid =followlistpojo.data.elementAt(ind).id.toString();
                     return
                       Container(
                           width: SizeConfig.blockSizeHorizontal * 60,
                           child: Container(
                           height: SizeConfig.blockSizeVertical * 80,
                           child:
                           Card(
                             child:
                                 Container(
                                   decoration: BoxDecoration(
                                     image: new DecorationImage(
                                       image: new AssetImage("assets/images/peoplemayknow_bg.png"),
                                       fit: BoxFit.fill,
                                     ),
                                   ),
                                   child: Column(
                                     mainAxisAlignment:
                                     MainAxisAlignment.start,
                                     children: [
                                       followlistpojo.data.elementAt(ind).facebookId!=null?
                                       GestureDetector(
                                         onTap: () {
                                           callNext(
                                               viewdetail_profile(
                                                   data: followlistpojo.data.elementAt(ind).id.toString()
                                               ), context);
                                         },
                                         child:
                                         Container(
                                           padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,
                                               bottom:  SizeConfig.blockSizeVertical *1),
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
                                             top: SizeConfig
                                                 .blockSizeVertical *
                                                 2,
                                           ),
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               image: DecorationImage(
                                                   image: NetworkImage(
                                                     followlistpojo.data.elementAt(ind).profilePic,
                                                   ),
                                                   fit: BoxFit.fill)),
                                         ),
                                       ):
                                       GestureDetector(
                                         onTap: () {
                                           callNext(
                                               viewdetail_profile(
                                                   data: followlistpojo.data.elementAt(ind).id.toString()
                                               ), context);
                                         },
                                         child: Container(
                                           padding: EdgeInsets.only(
                                               top: SizeConfig.blockSizeVertical *2,
                                               bottom:  SizeConfig.blockSizeVertical *1),
                                           height: SizeConfig
                                               .blockSizeVertical *
                                               10,
                                           width: SizeConfig
                                               .blockSizeVertical *
                                               10,
                                           alignment: Alignment.center,
                                           margin: EdgeInsets.only(
                                             bottom: SizeConfig.blockSizeVertical * 1,
                                             top: SizeConfig.blockSizeVertical * 2,
                                           ),
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               image: DecorationImage(
                                                   image: NetworkImage(
                                                     Network.BaseApiprofile + followlistpojo.data.elementAt(ind).profilePic,
                                                   ),
                                                   fit: BoxFit.fill)),
                                         ),
                                       ),
                                       Container(
                                         width: SizeConfig.blockSizeHorizontal * 43,
                                         margin: EdgeInsets.only(
                                             right: SizeConfig.blockSizeHorizontal * 1,
                                             left: SizeConfig.blockSizeHorizontal * 1),
                                         alignment: Alignment.center,
                                         child: Text(
                                           followlistpojo.data.elementAt(ind).fullName.toUpperCase(),
                                           style: TextStyle(
                                               letterSpacing: 1.0,
                                               color: AppColors.black,
                                               fontSize: 10,
                                               fontWeight: FontWeight.bold,
                                               fontFamily:
                                               'Poppins-Regular'),
                                         ),
                                       ),
                                       followlistpojo.data.elementAt(ind).followed=="yes"?
                                       GestureDetector(
                                         onTap:()
                                         {
                                           Unfollowapi(userid, followlistpojo.data.elementAt(ind).id.toString());
                                         },
                                         child:  Container(
                                           width: SizeConfig.blockSizeHorizontal * 34,
                                           padding: EdgeInsets.only(
                                               right: SizeConfig.blockSizeHorizontal * 2,
                                               left: SizeConfig.blockSizeHorizontal * 2,
                                               bottom: SizeConfig.blockSizeVertical * 1,
                                               top: SizeConfig.blockSizeVertical * 1),
                                           decoration: BoxDecoration(
                                               color: AppColors.whiteColor,
                                               borderRadius: BorderRadius.circular(20),
                                               border: Border.all(color: AppColors.themecolor)
                                           ),
                                           margin: EdgeInsets.only(
                                               top: SizeConfig.blockSizeVertical * 2,
                                               bottom: SizeConfig.blockSizeHorizontal * 2,
                                               right: SizeConfig.blockSizeHorizontal * 1,
                                               left: SizeConfig.blockSizeHorizontal * 1),
                                           alignment:Alignment.center,
                                           child: Text(
                                             "UnFollow",
                                             style: TextStyle(
                                                 letterSpacing: 1.0,
                                                 color: AppColors.themecolor,
                                                 fontSize: 12,
                                                 fontWeight: FontWeight.bold,
                                                 fontFamily:
                                                 'Poppins-Regular'),
                                           ),
                                         ),
                                       ):
                                       followlistpojo.data.elementAt(ind).followed=="pending"?
                                       Container(
                                         width: SizeConfig.blockSizeHorizontal * 34,
                                         padding: EdgeInsets.only(
                                             right: SizeConfig.blockSizeHorizontal * 2,
                                             left: SizeConfig.blockSizeHorizontal * 2,
                                             bottom: SizeConfig.blockSizeVertical * 1,
                                             top: SizeConfig.blockSizeVertical * 1),
                                         decoration: BoxDecoration(
                                             color: AppColors.whiteColor,
                                             borderRadius: BorderRadius.circular(20),
                                             border: Border.all(color: AppColors.themecolor)
                                         ),
                                         margin: EdgeInsets.only(
                                             top: SizeConfig.blockSizeVertical * 2,
                                             bottom: SizeConfig.blockSizeHorizontal * 2,
                                             right: SizeConfig.blockSizeHorizontal * 1,
                                             left: SizeConfig.blockSizeHorizontal * 1),
                                         alignment:Alignment.center,
                                         child: Text(
                                           "Pending",
                                           style: TextStyle(
                                               letterSpacing: 1.0,
                                               color: AppColors.themecolor,
                                               fontSize: 12,
                                               fontWeight: FontWeight.bold,
                                               fontFamily:
                                               'Poppins-Regular'),
                                         ),
                                       ):
                                       GestureDetector(
                                         onTap: ()
                                         {
                                           print('recieverid'+followlistpojo.data.elementAt(ind).id.toString());
                                           followapi(userid, followlistpojo.data.elementAt(ind).id.toString());
                                         },
                                         child:
                                         Container(
                                           alignment: Alignment.center,
                                           width: SizeConfig.blockSizeHorizontal * 34,
                                           padding: EdgeInsets.only(
                                               right: SizeConfig.blockSizeHorizontal * 2,
                                               left: SizeConfig.blockSizeHorizontal * 2,
                                               bottom: SizeConfig.blockSizeVertical * 1,
                                               top: SizeConfig.blockSizeVertical * 1),
                                           decoration: BoxDecoration(
                                               color: AppColors.whiteColor,
                                               borderRadius: BorderRadius.circular(20),
                                               border: Border.all(color: AppColors.themecolor)
                                           ),
                                           margin: EdgeInsets.only(
                                               right: SizeConfig.blockSizeHorizontal * 1,
                                               top: SizeConfig.blockSizeVertical * 2,
                                               bottom: SizeConfig.blockSizeVertical * 2,
                                               left: SizeConfig.blockSizeHorizontal * 1),
                                           child: Text(
                                             'Connect',
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
                                     ],
                                   ),
                                 ),
                           ))
                       );
                     }
                   ),
                 ),
               ),
             )

      ):
      Container(
        margin: EdgeInsets.only(top: 150),
        alignment: Alignment.center,
        child: resultfollowvalue == true
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
}
