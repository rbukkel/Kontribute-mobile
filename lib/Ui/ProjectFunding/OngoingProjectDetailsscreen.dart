import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/PostcommentPojo.dart';
import 'package:kontribute/Pojo/Projectdetailspojo.dart';
import 'package:kontribute/Pojo/followstatus.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/ProductVideoPlayerScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ext_storage/ext_storage.dart';
import 'dart:io';

class OngoingProjectDetailsscreen extends StatefulWidget {
  final String data;

  const OngoingProjectDetailsscreen({Key key, @required this.data})
      : super(key: key);

  @override
  OngoingProjectDetailsscreenState createState() =>
      OngoingProjectDetailsscreenState();
}

class OngoingProjectDetailsscreenState
    extends State<OngoingProjectDetailsscreen> {
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
  var paymentdetails_length;
  List<String> imagestore = [];
  Projectdetailspojo projectdetailspojo;
  projectlike prolike;
  PostcommentPojo postcom;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  String valfollowstatus;
  String Follow = "Follow";
  followstatus followstatusPojo;
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;
  String updateval;
  var dio = Dio();
  String reverid;
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  String _amount;

  /* Future<void> downloadFile(String imgUrl) async {
    Dio dio = Dio();
    bool checkPermission1 =
    await SimplePermissions.checkPermission(permission1);
    // print(checkPermission1);
    if (checkPermission1 == false) {
      await SimplePermissions.requestPermission(permission1);
      checkPermission1 = await SimplePermissions.checkPermission(permission1);
    }
    if (checkPermission1 == true) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      var randid = random.nextInt(10000);

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(imgUrl, dirloc + randid.toString() + ".jpg",
            onReceiveProgress: (receivedBytes, totalBytes) {
              setState(() {
                downloading = true;
                progress =
                    ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });
            });
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = dirloc + randid.toString() + ".jpg";
      });
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(imgUrl);
        };
      });
    }
  }
*/
 /* void getPermission() async
  {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }*/

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
      'project_id': projectid.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectDetails, body: data);
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
        projectdetailspojo = new Projectdetailspojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = projectdetailspojo.commentsdata;
            storelist_length = projectdetailspojo.commentsdata.commentslist;
            imageslist_length = projectdetailspojo.commentsdata.projectimagesdata;
            documentlist_length = projectdetailspojo.commentsdata.documents;
            videolist_length = projectdetailspojo.commentsdata.videoLink;
            paymentdetails_length = projectdetailspojo.commentsdata.projectpaymentdetails;
            double amount = double.parse(projectdetailspojo.commentsdata.totalcollectedamount) /
                    double.parse(projectdetailspojo.commentsdata.budget) *
                    100;
            amoun = amount.toInt();
            print("Amountval: " + amoun.toString());
            reverid = projectdetailspojo.commentsdata.userId.toString();
            getfollowstatus(userid, reverid);
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
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset(
      "assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner2.png",
      height: SizeConfig.blockSizeVertical * 30,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 30,
      fit: BoxFit.fitHeight,
    ),
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

  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;

  _showPopupMenu() async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,
      ),
      items: [
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text(
                    'Copy this post',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
        PopupMenuItem(
            value:2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    ProjectReport(
                        data: projectdetailspojo.commentsdata.id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text(
                    'Report',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  _showEditPopupMenu() async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,
      ),
      items: [
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text(
                    'Copy this post',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
        PopupMenuItem(
            value: 2,
            child:
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(EditCreateProjectPost(data:  projectdetailspojo.commentsdata.id.toString()), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )
        ),
      /*  PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    ProjectReport(
                        data: projectdetailspojo.commentsdata.id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text(
                    'Report',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),*/
      ],
      elevation: 8.0,
    );
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
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
        /* Fluttertoast.showToast(
          msg: jsonDecode(valfollowstatus)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );*/
      } else {
        followstatusPojo = new followstatus.fromJson(jsonResponse);
        print("Json status: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            Follow = "";
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      projectfunding()));
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
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        StringConstant.ongoingproject,
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
              productlist_length!=null?
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _tapDownPosition = details.globalPosition;
                          },
                          onTap: () {
                            projectdetailspojo.commentsdata.userId==userid?
                            _showEditPopupMenu(): _showPopupMenu();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1,
                                right: SizeConfig.blockSizeHorizontal * 2),
                            child: Image.asset("assets/images/menudot.png",
                                height: 15, width: 20),
                          ),
                        ),
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
                                          viewdetail_profile(
                                              data: projectdetailspojo.commentsdata.userId.toString()
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
                                        width: SizeConfig.blockSizeHorizontal * 32,
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
                                    projectdetailspojo
                                        .commentsdata.userId.toString()==userid?Container():
                                    GestureDetector(
                                      onTap: () {
                                        followapi(userid, reverid);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 2,
                                            left: SizeConfig.blockSizeHorizontal * 1),
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        child: Text(
                                          Follow,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.darkgreen,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2,
                                          left: SizeConfig.blockSizeHorizontal * 3),
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                          right: SizeConfig.blockSizeHorizontal * 2,
                                          left: SizeConfig.blockSizeHorizontal * 2,
                                          bottom: SizeConfig.blockSizeHorizontal * 2,
                                          top: SizeConfig.blockSizeHorizontal * 2),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: AppColors.purple)),
                                      child: Text(
                                        StringConstant.ongoing.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.purple,
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    projectdetailspojo.commentsdata.userId.toString()!=userid?
                                    projectdetailspojo.commentsdata.status=="pending"?
                                    GestureDetector(
                                      onTap: ()
                                      {
                                        Widget cancelButton = FlatButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = FlatButton(
                                          child: Text("Continue"),
                                          onPressed: () async {
                                            Payamount(
                                                projectdetailspojo.commentsdata.id,
                                                AmountController.text,
                                                userid);
                                          },
                                        );
                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Pay now.."),
                                          // content: Text("Are you sure you want to Pay this project?"),
                                          content: new Row(
                                            children: <Widget>[
                                              new Expanded(
                                                child: new  TextFormField(
                                                  autofocus: false,
                                                  focusNode: AmountFocus,
                                                  controller: AmountController,
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.number,
                                                  validator: (val) {
                                                    if (val.length == 0)
                                                      return "Please enter payment amount";
                                                    else
                                                      return null;
                                                  },
                                                  onFieldSubmitted: (v) {
                                                    AmountFocus.unfocus();
                                                  },
                                                  onSaved: (val) => _amount = val,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular',
                                                      fontSize: 10,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    // border: InputBorder.none,
                                                    // focusedBorder: InputBorder.none,
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular',
                                                      fontSize: 10,
                                                      decoration: TextDecoration.none,
                                                    ),
                                                    hintText:"Enter payment amount",
                                                  ),
                                                ),
                                              )
                                            ],
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
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left:
                                        SizeConfig.blockSizeHorizontal *1,
                                            right: SizeConfig.blockSizeHorizontal *2,
                                            top: SizeConfig.blockSizeVertical *2),
                                        padding: EdgeInsets.only(
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                3,
                                            left: SizeConfig
                                                .blockSizeHorizontal *
                                                3,
                                            bottom: SizeConfig
                                                .blockSizeHorizontal *
                                                1,
                                            top: SizeConfig
                                                .blockSizeHorizontal *
                                                1),
                                        decoration: BoxDecoration(
                                          color: AppColors.darkgreen,
                                          borderRadius: BorderRadius.circular(20),

                                        ),
                                        child: Text(
                                          StringConstant.pay.toUpperCase(),
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
                                    ): Container(): Container()


                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 37,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      child: Text(
                                        projectdetailspojo
                                            .commentsdata.projectName,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 41,
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      child: Text(
                                        "Start Date- " +
                                            projectdetailspojo
                                                .commentsdata.projectStartdate,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 38,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      child: Text(
                                        // StringConstant.totalContribution + "-20",
                                        "",
                                        textAlign: TextAlign.right,
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
                                          SizeConfig.blockSizeHorizontal * 40,
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      child: Text(
                                        "End Date- " +
                                            projectdetailspojo
                                                .commentsdata.projectEnddate,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 23,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1,
                                  left: SizeConfig.blockSizeHorizontal * 2),
                              child: Text(
                                StringConstant.collectiontarget + "- ",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black87,
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "\$" + projectdetailspojo.commentsdata.budget,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.lightBlueAccent,
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              child: LinearPercentIndicator(
                                width: 100.0,
                                lineHeight: 14.0,
                                percent: amoun / 100,
                                center: Text(
                                  amoun.toString() + "%",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppColors.whiteColor),
                                ),
                                backgroundColor: AppColors.lightgrey,
                                progressColor: AppColors.themecolor,
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 24,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              child: Text(
                                StringConstant.collectedamount + "- ",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black87,
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1,
                                  right: SizeConfig.blockSizeHorizontal * 4),
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              child: Text(
                                "\$" +
                                    projectdetailspojo
                                        .commentsdata.totalcollectedamount,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.lightBlueAccent,
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            )
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
                                                    Network.BaseApiProject +
                                                        projectdetailspojo
                                                            .commentsdata
                                                            .projectimagesdata
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
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
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
                                onTap: () {},
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 7,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  // margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            "assets/images/message.png",
                                            height: 20,
                                            width: 20),
                                      ),
                                    ],
                                  ),
                                  //child: Image.asset("assets/images/like.png"),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Image.asset(
                                        "assets/images/color_heart.png",
                                        color: Colors.black,
                                        height: 15,
                                        width: 25,
                                      )),
                                      Container(
                                        child: Text(
                                          projectdetailspojo
                                              .commentsdata.totalLike
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Montserrat-Bold',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.6),
                                        ),
                                      )
                                    ],
                                  ),
                                  //child: Image.asset("assets/images/report.png"),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  margin: EdgeInsets.only(
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Image.asset(
                                        "assets/images/color_comment.png",
                                        color: Colors.black,
                                        height: 15,
                                        width: 25,
                                      )),
                                      Container(
                                        child: Text(
                                          projectdetailspojo
                                              .commentsdata.totalcomments
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Montserrat-Bold',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.6),
                                        ),
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
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 1),
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
                        /*Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed....",
                            maxLines: 8,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),*/

                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
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
                        /*   Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            "3 Hours ago".toUpperCase(),
                            maxLines: 2,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black26,
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),*/
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        projectdetailspojo.commentsdata.userId==userid?Container():
                         Column(
                           children: [
                             Container(
                               padding: EdgeInsets.only(
                                 left: SizeConfig.blockSizeHorizontal * 2,
                                 right: SizeConfig.blockSizeHorizontal * 2,
                               ),
                               alignment: Alignment.centerLeft,
                               child: TextFormField(
                                 autofocus: false,
                                 focusNode: CommentFocus,
                                 controller: CommentController,
                                 textInputAction: TextInputAction.done,
                                 keyboardType: TextInputType.text,
                                 maxLines: 10,
                                 validator: (val) {
                                   if (val.length == 0)
                                     return "Please enter comment";
                                   else
                                     return null;
                                 },
                                 onFieldSubmitted: (v) {
                                   CommentFocus.unfocus();
                                 },
                                 onSaved: (val) => _Comment = val,
                                 textAlign: TextAlign.left,
                                 style: TextStyle(
                                     letterSpacing: 1.0,
                                     fontWeight: FontWeight.normal,
                                     fontFamily: 'Poppins-Regular',
                                     fontSize: 12,
                                     color: Colors.black),
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   // prefixIcon: Icon(Icons.tag_faces),
                                   focusedBorder: InputBorder.none,
                                   hintStyle: TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.normal,
                                     fontFamily: 'Poppins-Regular',
                                     fontSize: 12,
                                     decoration: TextDecoration.none,
                                   ),
                                   hintText: "Add a comment...",
                                 ),
                               ),
                             ),
                             GestureDetector(
                               onTap: ()
                               {

                                 addPost(CommentController.text);
                               },
                               child: Container(
                                 width: SizeConfig.blockSizeHorizontal * 100,
                                 alignment: Alignment.topRight,
                                 margin: EdgeInsets.only(
                                     left: SizeConfig.blockSizeHorizontal * 3,
                                     right: SizeConfig.blockSizeHorizontal * 5,
                                     top: SizeConfig.blockSizeVertical * 1),
                                 child: Text(
                                   "Post",

                                   style: TextStyle(
                                       letterSpacing: 1.0,
                                       color: AppColors.themecolor,
                                       fontSize: 16,
                                       fontWeight: FontWeight.normal,
                                       fontFamily: 'Poppins-Regular'),
                                 ),
                               ),
                             ),
                             Container(
                               margin: EdgeInsets.only(
                                   top: SizeConfig.blockSizeVertical * 2),
                               child: Divider(
                                 thickness: 1,
                                 color: Colors.black12,
                               ),
                             ),
                           ],
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
                                        projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==null||projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==""?
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
                                                height:
                                                SizeConfig.blockSizeVertical * 45,
                                                width:
                                                SizeConfig.blockSizeHorizontal *
                                                    60,
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
                                                ProductVideoPlayerScreen(
                                                    data: projectdetailspojo.commentsdata.videoLink.elementAt(indx).vlink.toString(),
                                                    comesfrom:"Project"), context);
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
                              }),
                        ):Container(),
                        documentlist_length!=null?
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount:   documentlist_length.length == null
                                  ? 0
                                  : documentlist_length.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int inde) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 1),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () async {
                                        String path =
                                        await ExtStorage.getExternalStoragePublicDirectory(
                                            ExtStorage.DIRECTORY_DOWNLOADS);
                                        //String fullPath = tempDir.path + "/boo2.pdf'";
                                        String fullPath = "$path/"+projectdetailspojo.commentsdata.documents.elementAt(inde).docName;
                                        print('full path ${fullPath}');

                                        download2(dio,projectdetailspojo.commentsdata.documents.elementAt(inde).documentsUrl, fullPath);
                                        // downloadFile(Network.BaseApiProject+projectdetailspojo.commentsdata.documents.elementAt(inde).documents);
                                      },
                                      child:  Image.asset(
                                        "assets/images/files.png",
                                        height:
                                        SizeConfig.blockSizeVertical * 10,
                                        width:
                                        SizeConfig.blockSizeHorizontal * 25,
                                        fit: BoxFit.fitHeight,
                                      )),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        width:
                                            SizeConfig.blockSizeHorizontal * 20,
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
                        ):Container(),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        paymentdetails_length!=null?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  left: SizeConfig.blockSizeHorizontal * 3),
                              child: Text(
                                StringConstant.contribution,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.black),
                              ),
                            ),
                          /*  Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                StringConstant.exportto,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
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
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1,
                                    top: SizeConfig.blockSizeVertical * 2),
                                child: Image.asset(
                                  "assets/images/csv.png",
                                  width: 80,
                                  height: 40,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 2,
                                  top: SizeConfig.blockSizeVertical * 2,
                                  right: SizeConfig.blockSizeHorizontal * 4,
                                ),
                                child: Image.asset(
                                  "assets/images/pdf.png",
                                  width: 80,
                                  height: 40,
                                ),
                              ),
                            ),*/
                          ],
                        ):Container(),
                        paymentdetails_length!=null?
                        Container(
                          child: ListView.builder(
                              itemCount:  paymentdetails_length.length == null
                                  ? 0
                                  : paymentdetails_length.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int idex) {
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
                                                  projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).facebookId==null?
                                                      GestureDetector(
                                                        onTap: ()
                                                        {
                                                          callNext(
                                                              viewdetail_profile(
                                                                  data:  projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).senderId.toString()
                                                              ), context);
                                                        },
                                                        child: Container(
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
                                                              bottom: SizeConfig.blockSizeVertical * 1,
                                                              right: SizeConfig.blockSizeHorizontal * 1,
                                                              left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      Network.BaseApiprofile+projectdetailspojo
                                                                          .commentsdata.projectpaymentdetails.elementAt(idex).profilePic),
                                                                  fit: BoxFit.fill)),
                                                        ),
                                                      ) :
                                                      GestureDetector(
                                                        onTap: ()
                                                        {
                                                          callNext(
                                                              viewdetail_profile(
                                                                  data:  projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).senderId.toString()
                                                              ), context);
                                                        },
                                                        child:  Container(
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
                                                              bottom: SizeConfig.blockSizeVertical * 1,
                                                              right: SizeConfig.blockSizeHorizontal * 1,
                                                              left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      projectdetailspojo
                                                                          .commentsdata.projectpaymentdetails.elementAt(idex).profilePic),
                                                                  fit: BoxFit.fill)),
                                                        ),
                                                      ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                55,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                            child: Text(
                                                              projectdetailspojo
                                                                  .commentsdata.projectpaymentdetails.elementAt(idex).fullName,
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                20,
                                                            alignment: Alignment
                                                                .topRight,
                                                            padding:
                                                                EdgeInsets.only(
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
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color:
                                                                      AppColors
                                                                          .black,
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
                                                                55,
                                                            alignment: Alignment
                                                                .topLeft,
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
                                                              "Contribute-\$"+projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).amount.toString(),
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status=="0"?
                                                          Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                20,
                                                            alignment: Alignment
                                                                .topRight,
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
                                                              "Pending".toUpperCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                          ):projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status=="1"?
                                                          Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                20,
                                                            alignment: Alignment
                                                                .center,
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
                                                            "Done".toUpperCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                          ):
                                                          Container(
                                                            width: SizeConfig
                                                                .blockSizeHorizontal *
                                                                20,
                                                            alignment: Alignment
                                                                .topRight,
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
                                                              "Pending".toUpperCase(),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
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
                        ):Container()
                      ],
                    ),
                  ),
                ),
              )
                  :Container(
                child: Center(
                  child: internet == true?CircularProgressIndicator():SizedBox(),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> Payamount(String id, String requiredAmount, String userid) async {
    Map data = {
      'userid': userid.toString(),
      'project_id': id.toString(),
      'amount': requiredAmount.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.project_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Fluttertoast.showToast(
            msg: jsonDecode(updateval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
      else {
        if (jsonResponse != null) {
          Fluttertoast.showToast(
              msg: jsonDecode(updateval)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => projectfunding()));
          // getpaymentlist(a);
        } else {
          Fluttertoast.showToast(
              msg: jsonDecode(updateval)["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: jsonDecode(updateval)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }


  void addlike() async {
    Map data = {
      'userid': userid.toString(),
      'project_id': a.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectlikes, body: data);
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

  Future<void> addPost(String post) async {
    Map data = {
      'userid': userid.toString(),
      'project_id': a.toString(),
      'comment': post.toString(),
    };
    Dialogs.showLoadingDialog(context, _keyLoader);
    print("projectPOst: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.postComments, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valPost = response.body; //store response as string
      if (jsonDecode(valPost)["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonDecode(valPost)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        postcom = new PostcommentPojo.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          Fluttertoast.showToast(
            msg: postcom.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          setState(() {
            CommentController.text ="";
          });

          getData(userid, a);
        } else {
          Fluttertoast.showToast(
            msg: postcom.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonDecode(valPost)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
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
  void showToast(String updateval) {
    Fluttertoast.showToast(
      msg: jsonDecode(updateval)["message"],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}
