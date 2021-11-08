import 'dart:io';
import 'package:favorite_button/favorite_button.dart';
import 'package:kontribute/Ui/Tickets/TicketReport.dart';
import 'package:kontribute/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Ui/Tickets/tickets.dart';
import 'package:kontribute/Ui/Tickets/EditTicketPost.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Pojo/TicketDetailsPojo.dart';
import 'package:kontribute/Pojo/TicketCommentPojo.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kontribute/Ui/ProjectFunding/ProductVideoPlayerScreen.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/utils/Network.dart';

class TicketsEventsHistoryProjectDetailsscreen extends StatefulWidget {
  final String data;

  const TicketsEventsHistoryProjectDetailsscreen({Key key, @required this.data})
      : super(key: key);

  @override
  TicketsEventsHistoryProjectDetailsscreenState createState() => TicketsEventsHistoryProjectDetailsscreenState();
}

class TicketsEventsHistoryProjectDetailsscreenState extends State<TicketsEventsHistoryProjectDetailsscreen> {

  Offset _tapDownPosition;
  String data1;
  String userid;
  int a;
  bool internet = false;
  String val;
  String vallike;
  String valPost;
  int amoun;
  var productlist_length;
  var storelist_length;
  var imageslist_length;
  var documentlist_length;
  var videolist_length;
  List<String> imagestore = [];
  TicketDetailsPojo projectdetailspojo;
  projectlike prolike;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;
  String updateval;
  var dio = Dio();
  Future<PermissionStatus> getPermission() async {
    print("getPermission");
    final PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.storage].request();
      return permissionStatus[Permission.storage] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(userid, a);

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




  void getData(String id, int projectid) async {
    Map data = {
      'userid': id.toString(),
      'ticket_id': projectid.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketDetails, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        projectdetailspojo = new TicketDetailsPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = projectdetailspojo.commentsdata;
            storelist_length = projectdetailspojo.commentsdata.commentslist;
            imageslist_length = projectdetailspojo.commentsdata.ticketimagesdata;
            documentlist_length = projectdetailspojo.commentsdata.documents;
            videolist_length = projectdetailspojo.commentsdata.videoLink;
            double amount = double.parse(projectdetailspojo.commentsdata.balanceslot.toString()) /
                double.parse(projectdetailspojo.commentsdata.totalslotamount.toString()) * 100;
            amoun = amount.toInt();
            print("Amountval: " + amoun.toString());
          });
        } else {
          Fluttertoast.showToast(
            msg: projectdetailspojo.message,
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


  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),

  ];

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.themecolor : AppColors.lightthemecolor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }


  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      Fluttertoast.showToast(
        msg: "Downloading file "+(received / total * 100).toStringAsFixed(0) + "%",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      if((received / total * 100).toStringAsFixed(0) + "%"=="100%")
      {
        Fluttertoast.showToast(
          msg: "Saved in download folder",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }


  void addlike() async {
    Map data = {
      'userid': userid.toString(),
      'ticket_id': a.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketlikes, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      vallike = response.body; //store response as string
      if (jsonDecode(vallike)["success"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(vallike)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        prolike = new projectlike.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          Fluttertoast.showToast(
            msg: prolike.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          getData(userid, a);
        } else {
          Fluttertoast.showToast(
            msg: prolike.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(vallike)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                height: SizeConfig.blockSizeVertical *12,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/appbar.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,height: 20,
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *2),
                      child:
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => tickets()));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset("assets/images/back.png",color:AppColors.whiteColor,width: 20,height: 20,),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal *60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        StringConstant.historyticket,
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
                      width: 25,height: 25,
                      margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *2),

                    ),
                  ],
                ),
              ),
              productlist_length!=null?
              Expanded(
                child: Container(
                  child:  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            projectdetailspojo.commentsdata.profilePic == null || projectdetailspojo.commentsdata.profilePic == ""
                                ? GestureDetector(
                              onTap: () {
                                callNext(
                                    viewdetail_profile(
                                        data: projectdetailspojo.commentsdata.userId.toString()
                                    ), context);
                              },
                              child: Container(
                                  height:
                                  SizeConfig.blockSizeVertical * 9,
                                  width: SizeConfig.blockSizeVertical * 9,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *
                                          2,
                                      bottom:
                                      SizeConfig.blockSizeVertical *
                                          1,
                                      right:
                                      SizeConfig.blockSizeHorizontal *
                                          1,
                                      left:
                                      SizeConfig.blockSizeHorizontal *
                                          2),
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/images/account_circle.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            )
                                : GestureDetector(
                              onTap: () {
                                callNext(
                                    viewdetail_profile(data: projectdetailspojo.commentsdata.userId.toString()
                                    ), context);
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 9,
                                width: SizeConfig.blockSizeVertical * 9,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 2,
                                    bottom:
                                    SizeConfig.blockSizeVertical * 1,
                                    right:
                                    SizeConfig.blockSizeHorizontal *
                                        1,
                                    left: SizeConfig.blockSizeHorizontal *
                                        2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            projectdetailspojo
                                                .commentsdata.profilePic),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    GestureDetector(
                                      onTap: ()
                                      {
                                        callNext(
                                            viewdetail_profile(
                                                data: projectdetailspojo.commentsdata.userId.toString()
                                            ), context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 2),
                                        width: SizeConfig.blockSizeHorizontal * 39,
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        child: Text(
                                          projectdetailspojo
                                              .commentsdata.fullName,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.themecolor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,
                                        top: SizeConfig.blockSizeVertical *2,
                                        bottom: SizeConfig.blockSizeVertical *1,),

                                      alignment: Alignment.topRight,
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
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: AppColors.purple)
                                      ),
                                      child: Text(
                                        "Completed".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color:AppColors.purple,
                                            fontSize:8,
                                            fontWeight:
                                            FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        projectdetailspojo
                                            .commentsdata.eventName,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *38,
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                        left: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                        right: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        "Event Date- "+ projectdetailspojo
                                            .commentsdata.eventEnddate,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize:8,
                                            fontWeight:
                                            FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        "",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize:8,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *38,
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                        left: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                        right: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        StringConstant.totalContribution+"- "+projectdetailspojo.commentsdata.totalcontributor.toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize:8,
                                            fontWeight:
                                            FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal *27,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig
                                    .blockSizeHorizontal *
                                    3,),
                              child: Text(
                                "No. of Tickets - "+ projectdetailspojo.commentsdata.maximumQtySold.toString(),
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
                            /*Container(
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                3,
                                          ),
                                          child: Text(
                                            listing.projectData.elementAt(index).maximumQtySold.toString(),
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        ),*/
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                              child:  LinearPercentIndicator(
                                width: 70.0,
                                lineHeight: 14.0,
                                percent: amoun/100,
                                center: Text(amoun.toString()+"%",style: TextStyle(fontSize: 8,color: AppColors.whiteColor),),
                                backgroundColor: AppColors.lightgrey,
                                progressColor:AppColors.themecolor,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: SizeConfig.blockSizeHorizontal *27,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                  .blockSizeHorizontal *
                                 5),
                              child: Text(
                                "Available Tickets- "+projectdetailspojo.commentsdata.balanceQtySlot.toString(),
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

                          ],
                        ),
                        imageslist_length != null
                            ? Container(
                          color:Colors.transparent,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          height: SizeConfig.blockSizeVertical * 30,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              PageView.builder(
                                physics: ClampingScrollPhysics(),
                                itemCount:
                                imageslist_length.length == null
                                    ? 0
                                    : imageslist_length.length,
                                onPageChanged: (int page) {
                                  getChangedPageAndMoveBar(page);
                                },
                                controller: PageController(
                                    initialPage: currentPageValue,
                                    keepPage: true,
                                    viewportFraction: 1),
                                itemBuilder: (context, ind) {
                                  return Container(
                                    width:
                                    SizeConfig.blockSizeHorizontal *
                                        80,
                                    height:
                                    SizeConfig.blockSizeVertical * 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              Network.BaseApiticket +
                                                  projectdetailspojo
                                                      .commentsdata
                                                      .ticketimagesdata
                                                      .elementAt(ind)
                                                      .imagePath,
                                            ),
                                            fit: BoxFit.scaleDown)),
                                  );
                                },
                              ),
                              Stack(
                                alignment:
                                AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.blockSizeVertical * 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0; i < imageslist_length.length; i++)
                                          if (i == currentPageValue) ...[
                                            circleBar(true)
                                          ] else
                                            circleBar(false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                            : Container(
                          color: AppColors.themecolor,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          height: SizeConfig.blockSizeVertical * 30,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              PageView.builder(
                                physics: ClampingScrollPhysics(),
                                itemCount: introWidgetsList.length,
                                onPageChanged: (int page) {
                                  getChangedPageAndMoveBar(page);
                                },
                                controller: PageController(
                                    initialPage: currentPageValue,
                                    keepPage: true,
                                    viewportFraction: 1),
                                itemBuilder: (context, index) {
                                  return introWidgetsList[index];
                                },
                              ),
                              Stack(
                                alignment:
                                AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                        SizeConfig.blockSizeVertical *
                                            2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0;
                                        i < introWidgetsList.length;
                                        i++)
                                          if (i == currentPageValue) ...[
                                            circleBar(true)
                                          ] else
                                            circleBar(false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                          child: Row(
                            children: [
                          Container(
                          width: SizeConfig.blockSizeHorizontal*7,
                            margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                            child: FavoriteButton(
                              iconSize:SizeConfig.blockSizeVertical*5,
                              isFavorite: false,
                              // iconDisabledColor: Colors.white,
                              valueChanged: (_isFavorite) {
                                print("LIke");

                                addlike();
                              },
                            ),
                          ),
                              InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal*7,
                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                  // margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.asset("assets/images/message.png",height: 20,width: 20),
                                      ),

                                    ],
                                  ),
                                  //child: Image.asset("assets/images/like.png"),
                                ),
                              ),

                              Spacer(),
                              InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal*15,
                                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Image.asset("assets/images/color_heart.png",color: Colors.black,height: 15,width: 25,)
                                      ),
                                      Container(
                                        child: Text(projectdetailspojo
                                            .commentsdata.totalLike.toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6 ),),
                                      )
                                    ],
                                  ),
                                  //child: Image.asset("assets/images/report.png"),
                                ),
                              ),
                              InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal*15,
                                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Image.asset("assets/images/color_comment.png",color: Colors.black,height: 15,width: 25,)
                                      ),
                                      Container(
                                        child: Text(projectdetailspojo
                                            .commentsdata.totalcomments.toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6  ),),
                                      )
                                    ],
                                  ),
                                  //child: Image.asset("assets/images/save.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal *100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                              top: SizeConfig.blockSizeVertical *1,bottom: SizeConfig.blockSizeVertical *1),
                          child: new Html(
                            data: projectdetailspojo.commentsdata.description,
                            defaultTextStyle: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),
                        projectdetailspojo.commentsdata.termsAndCondition!=null?
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,
                            left: SizeConfig.blockSizeHorizontal *3,
                            right: SizeConfig.blockSizeHorizontal * 3,),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Terms and condition: ",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ):Container(),

                        projectdetailspojo.commentsdata.termsAndCondition!=null?
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                            left: SizeConfig.blockSizeHorizontal *3,
                            right: SizeConfig.blockSizeHorizontal * 3,),
                          alignment: Alignment.topLeft,
                          child: Text(
                            projectdetailspojo.commentsdata.termsAndCondition,
                            maxLines: 3,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ):
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                            left: SizeConfig.blockSizeHorizontal *3,
                            right: SizeConfig.blockSizeHorizontal * 3,),
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
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            "View all " +
                                (projectdetailspojo
                                    .commentsdata.commentslist.length)
                                    .toString() +
                                " comments",
                            maxLines: 2,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black26,
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),
                        storelist_length != null
                            ?
                        Container(

                          child: ListView.builder(
                              itemCount: storelist_length.length == null
                                  ? 0
                                  : storelist_length.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int i) {
                                return
                                  Column(
                                    children: [
                                      Container(

                                        width: SizeConfig.blockSizeHorizontal *
                                            100,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *1,
                                          bottom: SizeConfig.blockSizeVertical *1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              3,
                                          right:
                                          SizeConfig.blockSizeHorizontal *
                                              3,
                                        ),
                                        child: Text(
                                          projectdetailspojo
                                              .commentsdata.commentslist
                                              .elementAt(i)
                                              .comment,
                                          maxLines: 10,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'NotoEmoji'),
                                        ),
                                      ),
                                      Container(
                                        width:SizeConfig.blockSizeHorizontal * 30,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 1),
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.black12,
                                        ),
                                      ),
                                    ],
                                  );
                              }),
                        )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),

                        videolist_length!=null?
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount:  videolist_length.length == null
                                  ? 0
                                  : videolist_length.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int indx) {
                                return Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        left: SizeConfig.blockSizeHorizontal * 3,
                                        right: SizeConfig.blockSizeHorizontal * 1),
                                    child: Stack(
                                      children: [
                                        projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==null
                                            ||projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==""?
                                        Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 45,
                                          width:
                                          SizeConfig.blockSizeHorizontal *
                                              60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/events1.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ):
                                        Container(
                                          color: Colors.black12,
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical * 45,
                                            width: SizeConfig.blockSizeHorizontal * 60,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black12),
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail),
                                                    fit: BoxFit.fill)
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            callNext(
                                                ProductVideoPlayerScreen(data:
                                                projectdetailspojo.commentsdata.videoLink.elementAt(indx)
                                                    .vlink.toString(),
                                                    comesfrom:"Ticket"
                                                ), context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.blockSizeHorizontal * 25,
                                                right: SizeConfig.blockSizeHorizontal * 25),
                                            child: Image.asset(
                                              "assets/images/play.png",
                                              color: Colors.white,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              }
                          ),
                        ):
                        Container(),
                        documentlist_length!=null?
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount:  documentlist_length.length == null ? 0 : documentlist_length.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int inde) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right: SizeConfig.blockSizeHorizontal * 1),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () async {
                                            String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                            //String fullPath = tempDir.path + "/boo2.pdf'";
                                            String fullPath = "$path/"+projectdetailspojo.commentsdata.documents.elementAt(inde).docName;
                                            print('full path ${fullPath}');

                                            download2(dio,projectdetailspojo.commentsdata.documents.elementAt(inde).documentsUrl, fullPath);
                                            // downloadFile(Network.BaseApiProject + projectdetailspojo.commentsdata.documents.elementAt(inde).documents);
                                          },
                                          child: Image.asset(
                                            "assets/images/files.png",
                                            height: SizeConfig.blockSizeVertical * 10,
                                            width: SizeConfig.blockSizeHorizontal * 25,
                                            fit: BoxFit.fitHeight,
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        width: SizeConfig.blockSizeHorizontal * 20,
                                        alignment: Alignment.center,
                                        child: Text(
                                          projectdetailspojo.commentsdata.documents.elementAt(inde).docName.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.black,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: ()
                                        async {
                                          String path =
                                          await ExtStorage.getExternalStoragePublicDirectory(
                                              ExtStorage.DIRECTORY_DOWNLOADS);
                                          //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath = "$path/"+projectdetailspojo.commentsdata.documents.elementAt(inde).docName;
                                          print('full path ${fullPath}');

                                          download2(dio,projectdetailspojo.commentsdata.documents.elementAt(inde).documentsUrl, fullPath);
                                          // downloadFile(Network.BaseApiProject+projectdetailspojo.commentsdata.documents.elementAt(inde).documents);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 1,
                                          ),
                                          width:
                                          SizeConfig.blockSizeHorizontal * 20,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Download",
                                            maxLines: 2,
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                letterSpacing: 1.0,
                                                color: Colors.blue,
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /*   decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/images/files.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),*/
                                );
                              }),
                        )
                            :Container(),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,bottom:SizeConfig.blockSizeVertical *2 ,left: SizeConfig.blockSizeHorizontal *3),
                                  child: Text(
                                    "Ticket Price-",
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
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                      .blockSizeHorizontal *
                                      1,bottom:SizeConfig.blockSizeVertical *2 ,),
                                  alignment: Alignment.topLeft,

                                  child: Text(
                                    "\$"+projectdetailspojo.commentsdata.ticketCost.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.lightBlueAccent,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.normal,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                )
                              ],
                            ),
                           /* GestureDetector(
                              onTap: ()
                              {
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom:SizeConfig.blockSizeVertical *2 ,left:
                                SizeConfig.blockSizeHorizontal *1,
                                    right: SizeConfig.blockSizeHorizontal *3,
                                    top: SizeConfig.blockSizeVertical *2),
                                padding: EdgeInsets.only(
                                    right: SizeConfig
                                        .blockSizeHorizontal *
                                        7,
                                    left: SizeConfig
                                        .blockSizeHorizontal *
                                        7,
                                    bottom: SizeConfig
                                        .blockSizeHorizontal *
                                        3,
                                    top: SizeConfig
                                        .blockSizeHorizontal *
                                        3),
                                decoration: BoxDecoration(
                                  color: AppColors.darkgreen,
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                child: Text(
                                  "BUY",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.whiteColor,
                                      fontSize:12,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      'Poppins-Regular'),
                                ),
                              ),
                            )*/


                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),
                              child: Text(
                                StringConstant.totalticketsold, textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,
                                  top: SizeConfig.blockSizeVertical *2),
                              child: Text(
                                StringConstant.exportto, textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
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
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*1,
                                    top: SizeConfig.blockSizeVertical *2),
                                child: Image.asset("assets/images/csv.png",width: 70,height: 40,),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,
                                  top: SizeConfig.blockSizeVertical *2,right: SizeConfig.blockSizeHorizontal*4,),
                                child: Image.asset("assets/images/pdf.png",width: 70,height: 40,),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                          color: AppColors.purplecolor,
                          height: SizeConfig.blockSizeVertical *7,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *8,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Text(
                                  StringConstant.srno, textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *30,
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal*3,
                                ),
                                child: Text(
                                  StringConstant.names, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *25,
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal*3,
                                ),
                                child: Text(
                                  StringConstant.noofticket, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *25,
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal*3,
                                ),
                                child: Text(
                                  StringConstant.totalamount, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        ),
                    /*    Container(
                          child:
                          ListView.builder(
                              itemCount: 5,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return
                                  Container(

                                      child: Column(

                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig.blockSizeHorizontal *8,
                                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                                child: Text(
                                                  "1", textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "Poppins-Regular",
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig.blockSizeHorizontal *30,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal*3),
                                                child: Text(
                                                  "Kartik Kalyan", textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "Poppins-Regular",
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig.blockSizeHorizontal *25,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal*3),
                                                child: Text(
                                                  "4", textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "Poppins-Regular",
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig.blockSizeHorizontal *25,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal*3),
                                                child: Text(
                                                  "400", textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "Poppins-Regular",
                                                      color: Colors.black),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: ()
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            overflow: Overflow.visible,
                                                            children: <Widget>[
                                                              Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  Container(
                                                                    color:AppColors.headingblue,
                                                                    width: SizeConfig.blockSizeHorizontal *100,
                                                                    height: SizeConfig.blockSizeVertical *6,
                                                                    child:Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width: 20,height: 20,
                                                                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,),
                                                                        ),
                                                                        Container(
                                                                          width: SizeConfig.blockSizeHorizontal *40,
                                                                          alignment: Alignment.center,
                                                                          // margin: EdgeInsets.only(top: 10, left: 40),
                                                                          child: Text(
                                                                            "Ticket Details", textAlign: TextAlign.center,
                                                                            style: TextStyle(
                                                                                decoration: TextDecoration.none,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: "Poppins-Regular",
                                                                                color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap: ()
                                                                          {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: Container(
                                                                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,),
                                                                            child: Image.asset("assets/images/cross.png",color:AppColors.whiteColor,width: 12,height: 12,),
                                                                          ),
                                                                        )

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                                                        width: SizeConfig.blockSizeHorizontal *25,
                                                                        alignment: Alignment.center,
                                                                        // margin: EdgeInsets.only(top: 10, left: 40),
                                                                        child: Text(
                                                                          "QR Code", textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.none,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "Poppins-Regular",
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *25,
                                                                        alignment: Alignment.center,
                                                                        // margin: EdgeInsets.only(top: 10, left: 40),
                                                                        child: Text(
                                                                          "Ticket No.", textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.none,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "Poppins-Regular",
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                    ListView.builder(
                                                                        itemCount:4,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          return
                                                                            Container(

                                                                                child:
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: SizeConfig.blockSizeHorizontal *25,
                                                                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                                                                      alignment: Alignment.center,
                                                                                      child: Container
                                                                                        (
                                                                                        alignment: Alignment.center,
                                                                                        width: SizeConfig.blockSizeHorizontal *10,
                                                                                        height: SizeConfig.blockSizeVertical *7,
                                                                                        decoration: BoxDecoration(
                                                                                          image: new DecorationImage(
                                                                                            image: new AssetImage("assets/images/qrcode.png",),
                                                                                            fit: BoxFit.fill,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      width: SizeConfig.blockSizeHorizontal *25,
                                                                                      margin: EdgeInsets.only(
                                                                                          left: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *1),
                                                                                      child: Text(
                                                                                        "#56864921", textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                            decoration: TextDecoration.none,
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontFamily: "Poppins-Regular",
                                                                                            color: Colors.black),
                                                                                      ),
                                                                                    ),



                                                                                  ],
                                                                                )
                                                                            );
                                                                        }),
                                                                  )
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  width: SizeConfig.blockSizeHorizontal *20,
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.only(
                                                      right: SizeConfig.blockSizeHorizontal *3,
                                                      top: SizeConfig.blockSizeVertical *2),
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2,
                                                      bottom: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.yelowbg,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.whiteColor,
                                                        fontSize:8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.black12,
                                            ),
                                          ),
                                        ],
                                      )
                                  );
                              }),
                        )*/
                      ],
                    ),
                  ),
                )
               ,
              ):Container(
                child: Center(
                  child: internet == true?CircularProgressIndicator():SizedBox(),
                ),
              ),
            ],
          )
         ),
    );
  }
}
