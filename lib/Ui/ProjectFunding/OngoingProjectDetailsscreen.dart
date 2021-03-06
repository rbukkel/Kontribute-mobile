import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:share/share.dart';
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
import 'package:kontribute/Ui/MyActivity/MyActivities.dart';
import 'package:kontribute/Ui/ProjectFunding/ProductVideoPlayerScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/ProjectFunding/SearchbarProject.dart';
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
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class OngoingProjectDetailsscreen extends StatefulWidget {
  final String data;
  final String coming;

  const OngoingProjectDetailsscreen(
      {Key key, @required this.data, @required this.coming})
      : super(key: key);

  @override
  OngoingProjectDetailsscreenState createState() =>
      OngoingProjectDetailsscreenState();
}

class OngoingProjectDetailsscreenState
    extends State<OngoingProjectDetailsscreen> {
  Offset _tapDownPosition;
  String data1;
  String coming1;
  String userid;
  int a;
  String text = '';
  bool showkeyboard = false;
  bool shiftEnabled = false;
  bool internet = false;
  bool isNumericMode = false;
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
  Timer timer;
  String reverid;
  final AmountFocus = FocusNode();
  String shortsharedlink = '';
  String product_id = '';
  final TextEditingController AmountController = new TextEditingController();
  String _amount;
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();
  String deleteproject;
  String image;
  final _formmainKey = GlobalKey<FormState>();
  String onchangeval = "";
  double totalamount;
  commisionpojo commission;
  String valcommision;
  var commisionlist_length;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

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
      getCommision();
      print("Login userid: " + userid.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        coming1 = widget.coming;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        print("rececome: " + coming1.toString());
        getData(userid, a);

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
    var response = await http
        .get(Uri.encodeFull(Network.BaseApi + Network.admincommission));
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

  void getData(String id, int projectid) async {
    Map data = {
      'userid': id.toString(),
      'project_id': projectid.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.projectDetails, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);
      } else {
        projectdetailspojo = new Projectdetailspojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = projectdetailspojo.commentsdata;
            storelist_length = projectdetailspojo.commentsdata.commentslist;
            imageslist_length =
                projectdetailspojo.commentsdata.projectimagesdata;
            documentlist_length = projectdetailspojo.commentsdata.documents;
            videolist_length = projectdetailspojo.commentsdata.videoLink;
            paymentdetails_length =
                projectdetailspojo.commentsdata.projectpaymentdetails;
            double amount = double.parse(projectdetailspojo
                    .commentsdata.totalcollectedamount
                    .toString()) /
                double.parse(
                    projectdetailspojo.commentsdata.budget.toString()) *
                100;
            amoun = amount.toInt();
            print("Amountval: " + amoun.toString());
            reverid = projectdetailspojo.commentsdata.userId.toString();

            if (!projectdetailspojo.commentsdata.profilePic
                .startsWith("https://")) {
              image = Network.BaseApiprofile +
                  projectdetailspojo.commentsdata.profilePic;
            } else {
              image = projectdetailspojo.commentsdata.profilePic;
            }

            getfollowstatus(userid, reverid);
          });
        } else {
          errorDialog(projectdetailspojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
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

  Future<void> _createDynamicLink(String productid) async {
    print("Product: " + productid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://kontribute.page.link',
        link: Uri.parse(Network.sharelin + productid),
        androidParameters: AndroidParameters(
          packageName: 'com.kont.kontribute',
          minimumVersion: 1,
        ));
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    shortsharedlink = shortUrl.toString();
    print("Shorturl2:-" + shortUrl.toString());
    shareproductlink();
  }

  void shareproductlink() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(shortsharedlink,
        subject: "Kontribute",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

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
                setState(() {
                  print(
                      "Copy: " + projectdetailspojo.commentsdata.id.toString());
                  _createDynamicLink(
                      projectdetailspojo.commentsdata.id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text(
                    'sharevia'.tr,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
        PopupMenuItem(
            value: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    ProjectReport(
                        data: projectdetailspojo.commentsdata.id.toString()),
                    context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text(
                    'report'.tr,
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
                setState(() {
                  print(
                      "Copy: " + projectdetailspojo.commentsdata.id.toString());
                  _createDynamicLink(
                      projectdetailspojo.commentsdata.id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text(
                    'sharevia'.tr,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
        PopupMenuItem(
            value: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    EditCreateProjectPost(
                        data: projectdetailspojo.commentsdata.id.toString()),
                    context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text(
                    'edit'.tr,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
        PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  deleteDialog(projectdetailspojo.commentsdata.id.toString());
                });
                //  Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.delete_forever),
                  ),
                  Text(
                    'delete'.tr,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  void deleteDialog(String id) {
    Widget cancelButton = FlatButton(
      child: Text('no'.tr),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text('yes'.tr),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        deleteProject(id);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('delete'.tr),
      content: Text('areyousureyouwanttodeletethispost'.tr),
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
  }

  Future<void> deleteProject(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.projectdelete, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deleteproject = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(deleteproject)["message"]);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => OngoingProject()));
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deleteproject)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(deleteproject)["message"]);
    }
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      var response = await dio.get(
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
        msg: "Downloading file " +
            (received / total * 100).toStringAsFixed(0) +
            "%",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      if ((received / total * 100).toStringAsFixed(0) + "%" == "100%") {
        errorDialog('savedindownloadfolder'.tr);
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
        } else {
          errorDialog(followstatusPojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(valfollowstatus)["message"]);
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
                          if (coming1.toString() == "myactivity") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyActivities()));
                          } else if (coming1.toString() == "project") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingProject()));
                          } else if (coming1.toString() == "searchproject") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OngoingProject()));
                          } else if (coming1.toString() == "home") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          }
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
                        'projects'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                  ? Expanded(
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
                                  projectdetailspojo.commentsdata.userId
                                              .toString() ==
                                          userid
                                      ? _showEditPopupMenu()
                                      : _showPopupMenu();
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: Image.asset(
                                      "assets/images/menudot.png",
                                      height: 15,
                                      width: 20),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  projectdetailspojo.commentsdata.profilePic ==
                                              null ||
                                          projectdetailspojo
                                                  .commentsdata.profilePic ==
                                              ""
                                      ? GestureDetector(
                                          onTap: () {
                                            callNext(
                                                viewdetail_profile(
                                                    data: projectdetailspojo
                                                        .commentsdata.userId
                                                        .toString()),
                                                context);
                                          },
                                          child: Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      9,
                                              width:
                                                  SizeConfig.blockSizeVertical *
                                                      9,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2,
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
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.themecolor,
                                                  style: BorderStyle.solid,
                                                ),
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
                                                    data: projectdetailspojo
                                                        .commentsdata.userId
                                                        .toString()),
                                                context);
                                          },
                                          child: Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    9,
                                            width:
                                                SizeConfig.blockSizeVertical *
                                                    9,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
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
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.themecolor,
                                                  style: BorderStyle.solid,
                                                ),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(image),
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
                                          GestureDetector(
                                            onTap: () {
                                              callNext(
                                                  viewdetail_profile(
                                                      data: projectdetailspojo
                                                          .commentsdata.userId
                                                          .toString()),
                                                  context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2),
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  32,
                                              padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                              ),
                                              child: Text(
                                                projectdetailspojo
                                                    .commentsdata.fullName,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.themecolor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                          ),
                                          projectdetailspojo.commentsdata.userId
                                                      .toString() ==
                                                  userid
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    followapi(userid, reverid);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            2,
                                                        left: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1),
                                                    padding: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                    ),
                                                    child: Text(
                                                      Follow,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors
                                                              .darkgreen,
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Poppins-Regular'),
                                                    ),
                                                  ),
                                                ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColors.purple)),
                                            child: Text(
                                              projectdetailspojo
                                                  .commentsdata.status
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.purple,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          projectdetailspojo.commentsdata.userId
                                                      .toString() !=
                                                  userid
                                              ? projectdetailspojo.commentsdata
                                                          .status ==
                                                      "pending"
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        SharedUtils.readTerms(
                                                                "Terms")
                                                            .then((result) {
                                                          if (result != null) {
                                                            if (result) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                child: Dialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .whiteColor,
                                                                  child:
                                                                      new Container(
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        80,
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            40,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 10,
                                                                              left: 10,
                                                                              right: 10),
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'confirmation'.tr,
                                                                            style: TextStyle(
                                                                                fontSize: 14.0,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              SizeConfig.blockSizeVertical * 10,
                                                                          width:
                                                                              SizeConfig.blockSizeHorizontal * 25,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                SizeConfig.blockSizeHorizontal * 5,
                                                                            right:
                                                                                SizeConfig.blockSizeHorizontal * 5,
                                                                            top:
                                                                                SizeConfig.blockSizeVertical * 2,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                new DecorationImage(
                                                                              image: new AssetImage("assets/images/caution.png"),
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              SizeConfig.blockSizeVertical * 9,
                                                                          margin: EdgeInsets.only(
                                                                              top: 10,
                                                                              left: 10,
                                                                              right: 10),
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'paymentalert'.tr,
                                                                            style: TextStyle(
                                                                                fontSize: 12.0,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            setState(() {
                                                                              Widget cancelButton = FlatButton(
                                                                                child: Text('cancel'.tr),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                  setState(() {
                                                                                    AmountController.text = "";
                                                                                  });
                                                                                },
                                                                              );
                                                                              Widget continueButton = FlatButton(
                                                                                child: Text('continue'.tr),
                                                                                onPressed: () async {
                                                                                  if (_formmainKey.currentState.validate()) {
                                                                                    setState(() {
                                                                                      Payamount(projectdetailspojo.commentsdata.id.toString(), AmountController.text, totalamount, userid);
                                                                                    });
                                                                                  }
                                                                                },
                                                                              );
                                                                              // set up the AlertDialog
                                                                              AlertDialog alert = AlertDialog(
                                                                                title: Text('paynow'.tr),
                                                                                // content: Text("Are you sure you want to Pay this project?"),
                                                                                content: new Container(
                                                                                    width: SizeConfig.blockSizeHorizontal * 80,
                                                                                    height: SizeConfig.blockSizeVertical * 15,
                                                                                    child: new Form(
                                                                                        key: _formmainKey,
                                                                                        child: Column(
                                                                                          children: [
                                                                                            TextFormField(
                                                                                              autofocus: false,
                                                                                              focusNode: AmountFocus,
                                                                                              controller: AmountController,
                                                                                              textInputAction: TextInputAction.next,
                                                                                              keyboardType: TextInputType.number,
                                                                                              onChanged: (text) {
                                                                                                setState(() {
                                                                                                  onchangeval = text;

                                                                                                  if (onchangeval == projectdetailspojo.commentsdata.requiredAmount.toString()) {
                                                                                                    double tectString = double.parse(onchangeval) * (commission.commisiondata.senderCommision / 100);
                                                                                                    totalamount = double.parse(onchangeval) + tectString;
                                                                                                    print("PrintUpdated: " + totalamount.toString());
                                                                                                    print("PrintActual: " + onchangeval.toString());
                                                                                                  } else {
                                                                                                    double tectString = double.parse(onchangeval) * (commission.commisiondata.senderCommision / 100);
                                                                                                    totalamount = double.parse(onchangeval) - tectString;
                                                                                                    print("PrintUpdated: " + totalamount.toString());
                                                                                                    print("PrintActual: " + onchangeval.toString());
                                                                                                  }
                                                                                                });
                                                                                                print("value_1 : " + onchangeval);
                                                                                              },
                                                                                              validator: (val) {
                                                                                                if (val.length == 0)
                                                                                                  return 'pleaseenterpaymentamount'.tr;
                                                                                                else
                                                                                                  return null;
                                                                                              },
                                                                                              onFieldSubmitted: (v) {
                                                                                                AmountFocus.unfocus();
                                                                                              },
                                                                                              onSaved: (val) => _amount = val,
                                                                                              textAlign: TextAlign.left,
                                                                                              style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular', fontSize: 12, color: Colors.black),
                                                                                              decoration: InputDecoration(
                                                                                                // border: InputBorder.none,
                                                                                                // focusedBorder: InputBorder.none,
                                                                                                hintStyle: TextStyle(
                                                                                                  color: Colors.grey,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontFamily: 'Poppins-Regular',
                                                                                                  fontSize: 12,
                                                                                                  decoration: TextDecoration.none,
                                                                                                ),
                                                                                                hintText: 'enterpaymentamount'.tr,
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                                                                                                alignment: Alignment.centerLeft,
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'extracharges'.tr,
                                                                                                      style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.normal, fontFamily: 'Poppins-Regular', fontSize: 10, color: Colors.black),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      " " + commission.commisiondata.senderCommision.toString() + "%",
                                                                                                      style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.normal, fontFamily: 'Poppins-Regular', fontSize: 10, color: Colors.black),
                                                                                                    ),
                                                                                                  ],
                                                                                                ))
                                                                                          ],
                                                                                        ))),
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
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                SizeConfig.blockSizeVertical * 5,
                                                                            margin: EdgeInsets.only(
                                                                                top: SizeConfig.blockSizeVertical * 3,
                                                                                bottom: SizeConfig.blockSizeVertical * 3,
                                                                                left: SizeConfig.blockSizeHorizontal * 25,
                                                                                right: SizeConfig.blockSizeHorizontal * 25),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: new DecorationImage(
                                                                                image: new AssetImage("assets/images/sendbutton.png"),
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                            child: Text('okay'.tr,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
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
                                                            } else {
                                                              print(
                                                                  "falseValue");
                                                              warningDialog(
                                                                  'pleasereadthetermsandconditionscarefullybeforepaying'
                                                                      .tr,
                                                                  "Project",
                                                                  context);
                                                            }
                                                          } else {
                                                            print("falseValue");
                                                            warningDialog(
                                                                'pleasereadthetermsandconditionscarefullybeforepaying'
                                                                    .tr,
                                                                "Project",
                                                                context);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                2,
                                                            top: SizeConfig
                                                                    .blockSizeVertical *
                                                                2),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .darkgreen,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          'pay'.tr,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  'Poppins-Regular'),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                              : Container()
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    37,
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            child: Text(
                                              projectdetailspojo
                                                  .commentsdata.projectName,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    39,
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                            ),
                                            margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'startdate'.tr,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                                Text(
                                                  " " +
                                                      projectdetailspojo
                                                          .commentsdata
                                                          .projectStartdate,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                              ],
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
                                                SizeConfig.blockSizeHorizontal *
                                                    37,
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            child: Text(
                                              // StringConstant.totalContribution + "-20",
                                              "",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    39,
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                            ),
                                            margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'enddate'.tr,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                                Text(
                                                  " " +
                                                      projectdetailspojo
                                                          .commentsdata
                                                          .projectEnddate,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                              ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 36,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'collectiontarget'.tr,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                          Text(
                                            " \$" +
                                                projectdetailspojo
                                                    .commentsdata.budget
                                                    .toString(),
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: LinearPercentIndicator(
                                      width: 58.0,
                                      lineHeight: 14.0,
                                      percent: amoun / 100,
                                      center: Text(
                                        amoun.toString() + "%",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.whiteColor),
                                      ),
                                      backgroundColor: AppColors.lightgrey,
                                      progressColor: AppColors.themecolor,
                                    ),
                                  ),
                                  Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 36,
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'collectedamount'.tr,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                          Text(
                                            " \$" +
                                                projectdetailspojo.commentsdata
                                                    .totalcollectedamount
                                                    .toString(),
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              imageslist_length != null
                                  ? Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 2),
                                      height: SizeConfig.blockSizeVertical * 30,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
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
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    80,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Network.BaseApiProject +
                                                              projectdetailspojo
                                                                  .commentsdata
                                                                  .projectimagesdata
                                                                  .elementAt(
                                                                      ind)
                                                                  .imagePath,
                                                        ),
                                                        fit: BoxFit.scaleDown)),
                                              );
                                            },
                                          ),
                                          Stack(
                                            alignment: AlignmentDirectional
                                                .bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        2),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    for (int i = 0;
                                                        i <
                                                            imageslist_length
                                                                .length;
                                                        i++)
                                                      if (i ==
                                                          currentPageValue) ...[
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
                                          top:
                                              SizeConfig.blockSizeVertical * 2),
                                      height: SizeConfig.blockSizeVertical * 30,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
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
                                            alignment: AlignmentDirectional
                                                .bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        2),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    for (int i = 0;
                                                        i <
                                                            introWidgetsList
                                                                .length;
                                                        i++)
                                                      if (i ==
                                                          currentPageValue) ...[
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
                                      width: SizeConfig.blockSizeHorizontal * 7,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: FavoriteButton(
                                        iconSize:
                                            SizeConfig.blockSizeVertical * 5,
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 7,
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 15,
                                        margin: EdgeInsets.only(
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
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
                                                    fontFamily:
                                                        'Montserrat-Bold',
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 15,
                                        margin: EdgeInsets.only(
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
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
                                                    fontFamily:
                                                        'Montserrat-Bold',
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
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
                                  data: projectdetailspojo
                                      .commentsdata.description,
                                  defaultTextStyle: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                              projectdetailspojo
                                          .commentsdata.termsAndCondition !=
                                      null
                                  ? Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 90,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'termsandcondition'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    )
                                  : Container(),
                              projectdetailspojo
                                          .commentsdata.termsAndCondition !=
                                      null
                                  ? Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 90,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        projectdetailspojo
                                            .commentsdata.termsAndCondition,
                                        maxLines: 40,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    )
                                  : Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 90,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "",
                                        maxLines: 3,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                              Container(
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'viewall'.tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black26,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                      Text(
                                        " " +
                                            (projectdetailspojo.commentsdata
                                                    .commentslist.length)
                                                .toString() +
                                            " ",
                                        maxLines: 2,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black26,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                      Text(
                                        'comments'.tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black26,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ],
                                  )),
                              storelist_length != null
                                  ? Container(
                                      child: ListView.builder(
                                          itemCount:
                                              storelist_length.length == null
                                                  ? 0
                                                  : storelist_length.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Column(
                                              children: [
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      100,
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        1,
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        1,
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3,
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3,
                                                  ),
                                                  child: Text(
                                                    projectdetailspojo
                                                        .commentsdata
                                                        .commentslist
                                                        .elementAt(i)
                                                        .comment,
                                                    maxLines: 10,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'NotoEmoji'),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      30,
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          1),
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
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
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
                              projectdetailspojo.commentsdata.userId
                                          .toString() ==
                                      userid
                                  ? Container()
                                  : Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            onTap: () => setState(() {
                                              showkeyboard = true;
                                            }),
                                            enableInteractiveSelection: true,
                                            toolbarOptions: ToolbarOptions(
                                              copy: true,
                                              cut: true,
                                              paste: true,
                                              selectAll: true,
                                            ),
                                            autofocus: false,
                                            readOnly: true,
                                            focusNode: CommentFocus,
                                            controller: CommentController,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            maxLines: 10,
                                            validator: (val) {
                                              if (val.length == 0)
                                                return 'pleaseentercomment'.tr;
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
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 12,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // prefixIcon: Icon(Icons.tag_faces),
                                              focusedBorder: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 12,
                                                decoration: TextDecoration.none,
                                              ),
                                              hintText: 'addacomment'.tr,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            maintainState: true,
                                            child: Container()),
                                        showkeyboard == true
                                            ? Container(
                                                color: Colors.white54,
                                                child: VirtualKeyboard(
                                                    height: 250,
                                                    textColor: Colors.black,
                                                    textController:
                                                        CommentController,
                                                    defaultLayouts: [
                                                      VirtualKeyboardDefaultLayouts
                                                          .English,
                                                      VirtualKeyboardDefaultLayouts
                                                          .Arabic
                                                    ],
                                                    //reverseLayout :true,
                                                    type: isNumericMode
                                                        ? VirtualKeyboardType
                                                            .Numeric
                                                        : VirtualKeyboardType
                                                            .Alphanumeric,
                                                    onKeyPress: _onKeyPress),
                                              )
                                            : Container(),
                                        GestureDetector(
                                          onTap: () {
                                            addPost(CommentController.text);
                                            print("clikc");
                                            showkeyboard = false;
                                          },
                                          child: Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    100,
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1),
                                            child: Text(
                                              'post'.tr,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.themecolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ],
                                    ),
                              videolist_length == null ||
                                      projectdetailspojo
                                          .commentsdata.videoLink.isEmpty
                                  ? Container()
                                  : Container(
                                      height: SizeConfig.blockSizeVertical * 25,
                                      child: ListView.builder(
                                          itemCount:
                                              videolist_length.length == null
                                                  ? 0
                                                  : videolist_length.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, int indx) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3,
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1),
                                                child: Stack(
                                                  children: [
                                                    projectdetailspojo
                                                                    .commentsdata
                                                                    .videoLink
                                                                    .elementAt(
                                                                        indx)
                                                                    .videoThumbnail ==
                                                                null ||
                                                            projectdetailspojo
                                                                    .commentsdata
                                                                    .videoLink
                                                                    .elementAt(
                                                                        indx)
                                                                    .videoThumbnail ==
                                                                ""
                                                        ? Container(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                45,
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                60,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  new DecorationImage(
                                                                image: new AssetImage(
                                                                    "assets/images/events1.png"),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            color:
                                                                Colors.black12,
                                                            child: Container(
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  45,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  60,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black12),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(projectdetailspojo
                                                                          .commentsdata
                                                                          .videoLink
                                                                          .elementAt(
                                                                              indx)
                                                                          .videoThumbnail),
                                                                      fit: BoxFit
                                                                          .fill)),
                                                            ),
                                                          ),
                                                    InkWell(
                                                      onTap: () {
                                                        callNext(
                                                            ProductVideoPlayerScreen(
                                                                data: projectdetailspojo
                                                                    .commentsdata
                                                                    .videoLink
                                                                    .elementAt(
                                                                        indx)
                                                                    .vlink
                                                                    .toString(),
                                                                comesfrom:
                                                                    "Project"),
                                                            context);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                25,
                                                            right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                25),
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
                                    ),
                              documentlist_length == null ||
                                      projectdetailspojo
                                          .commentsdata.documents.isEmpty
                                  ? Container()
                                  : Container(
                                      height: SizeConfig.blockSizeVertical * 25,
                                      child: ListView.builder(
                                          itemCount:
                                              documentlist_length.length == null
                                                  ? 0
                                                  : documentlist_length.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, int inde) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      3,
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      2,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () async {
                                                        String path = await ExtStorage
                                                            .getExternalStoragePublicDirectory(
                                                                ExtStorage
                                                                    .DIRECTORY_DOWNLOADS);
                                                        //String fullPath = tempDir.path + "/boo2.pdf'";
                                                        String fullPath =
                                                            "$path/" +
                                                                projectdetailspojo
                                                                    .commentsdata
                                                                    .documents
                                                                    .elementAt(
                                                                        inde)
                                                                    .docName;
                                                        print(
                                                            'full path ${fullPath}');

                                                        download2(
                                                            dio,
                                                            projectdetailspojo
                                                                .commentsdata
                                                                .documents
                                                                .elementAt(inde)
                                                                .documentsUrl,
                                                            fullPath);
                                                        // downloadFile(Network.BaseApiProject+projectdetailspojo.commentsdata.documents.elementAt(inde).documents);
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/files.png",
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            10,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            25,
                                                        fit: BoxFit.fitHeight,
                                                      )),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                    ),
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        20,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      projectdetailspojo
                                                          .commentsdata
                                                          .documents
                                                          .elementAt(inde)
                                                          .docName
                                                          .toString(),
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Poppins-Regular'),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String path = await ExtStorage
                                                          .getExternalStoragePublicDirectory(
                                                              ExtStorage
                                                                  .DIRECTORY_DOWNLOADS);
                                                      //String fullPath = tempDir.path + "/boo2.pdf'";
                                                      String fullPath =
                                                          "$path/" +
                                                              projectdetailspojo
                                                                  .commentsdata
                                                                  .documents
                                                                  .elementAt(
                                                                      inde)
                                                                  .docName;
                                                      print(
                                                          'full path ${fullPath}');

                                                      download2(
                                                          dio,
                                                          projectdetailspojo
                                                              .commentsdata
                                                              .documents
                                                              .elementAt(inde)
                                                              .documentsUrl,
                                                          fullPath);
                                                      // downloadFile(Network.BaseApiProject+projectdetailspojo.commentsdata.documents.elementAt(inde).documents);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                      ),
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          20,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'download'.tr,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            letterSpacing: 1.0,
                                                            color: Colors.blue,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                'Poppins-Regular'),
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
                                    ),
                              projectdetailspojo.commentsdata
                                      .projectpaymentdetails.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 2),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                              projectdetailspojo.commentsdata
                                      .projectpaymentdetails.isEmpty
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      2,
                                              bottom:
                                                  SizeConfig.blockSizeVertical *
                                                      2,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            'contributors'.tr,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins-Regular",
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                              paymentdetails_length != null
                                  ? Container(
                                      child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          itemCount: paymentdetails_length
                                                      .length ==
                                                  null
                                              ? 0
                                              : paymentdetails_length.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext context, int idex) {
                                            return Container(
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              projectdetailspojo
                                                                          .commentsdata
                                                                          .projectpaymentdetails
                                                                          .elementAt(
                                                                              idex)
                                                                          .facebookId ==
                                                                      null
                                                                  ? projectdetailspojo
                                                                              .commentsdata
                                                                              .projectpaymentdetails
                                                                              .elementAt(idex)
                                                                              .profilePic ==
                                                                          null
                                                                      ? GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            callNext(viewdetail_profile(data: projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).senderId.toString()),
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                SizeConfig.blockSizeVertical * 8,
                                                                            width:
                                                                                SizeConfig.blockSizeVertical * 8,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            margin: EdgeInsets.only(
                                                                                top: SizeConfig.blockSizeVertical * 1,
                                                                                bottom: SizeConfig.blockSizeVertical * 1,
                                                                                right: SizeConfig.blockSizeHorizontal * 1,
                                                                                left: SizeConfig.blockSizeHorizontal * 2),
                                                                            child: ClipOval(
                                                                                child: Image.asset(
                                                                              "assets/images/userProfile.png",
                                                                              height: SizeConfig.blockSizeVertical * 8,
                                                                              width: SizeConfig.blockSizeVertical * 8,
                                                                            )),
                                                                          ),
                                                                        )
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            callNext(viewdetail_profile(data: projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).senderId.toString()),
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                SizeConfig.blockSizeVertical * 8,
                                                                            width:
                                                                                SizeConfig.blockSizeVertical * 8,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            margin: EdgeInsets.only(
                                                                                top: SizeConfig.blockSizeVertical * 1,
                                                                                bottom: SizeConfig.blockSizeVertical * 1,
                                                                                right: SizeConfig.blockSizeHorizontal * 1,
                                                                                left: SizeConfig.blockSizeHorizontal * 2),
                                                                            decoration:
                                                                                BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(Network.BaseApiprofile + projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).profilePic), fit: BoxFit.fill)),
                                                                          ),
                                                                        )
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        callNext(
                                                                            viewdetail_profile(data: projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).senderId.toString()),
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            SizeConfig.blockSizeVertical *
                                                                                8,
                                                                        width:
                                                                            SizeConfig.blockSizeVertical *
                                                                                8,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin: EdgeInsets.only(
                                                                            top: SizeConfig.blockSizeVertical *
                                                                                1,
                                                                            bottom: SizeConfig.blockSizeVertical *
                                                                                1,
                                                                            right: SizeConfig.blockSizeHorizontal *
                                                                                1,
                                                                            left:
                                                                                SizeConfig.blockSizeHorizontal * 2),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            image: DecorationImage(image: NetworkImage(projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).profilePic), fit: BoxFit.fill)),
                                                                      ),
                                                                    ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *
                                                                            54,
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).fullName != null
                                                                              ? projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).fullName
                                                                              : "",
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: Colors.black87,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Poppins-Regular'),
                                                                        ),
                                                                      ),


                                                                      projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status == "0" ?



                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *
                                                                            20,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                          right:
                                                                              SizeConfig.blockSizeHorizontal * 1,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          ''
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: AppColors.black,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Poppins-Regular'),
                                                                        ),
                                                                      ) :    Container(
                                                                        width: SizeConfig.blockSizeHorizontal *
                                                                            20,
                                                                        alignment:
                                                                        Alignment.center,
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                          left: SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                          right:
                                                                          SizeConfig.blockSizeHorizontal * 1,
                                                                        ),
                                                                        child:
                                                                        Text(
                                                                          'status'
                                                                              .tr,
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: AppColors.black,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Poppins-Regular'),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: SizeConfig.blockSizeHorizontal *
                                                                              54,
                                                                          alignment: Alignment
                                                                              .topLeft,
                                                                          padding: EdgeInsets.only(
                                                                              left: SizeConfig.blockSizeHorizontal * 1,
                                                                              right: SizeConfig.blockSizeHorizontal * 3,
                                                                              top: SizeConfig.blockSizeHorizontal * 2),
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                'contribute'.tr,
                                                                                style: TextStyle(letterSpacing: 1.0, color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
                                                                              ),
                                                                              Text(
                                                                                " -\$" + projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).amount.toStringAsFixed(2),
                                                                                style: TextStyle(letterSpacing: 1.0, color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
                                                                              ),
                                                                            ],
                                                                          )),



                                                                      projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status ==
                                                                              "0"
                                                                          ? Container(
                                                                              /*width: SizeConfig.blockSizeHorizontal * 20,
                                                                              alignment: Alignment.topRight,
                                                                              padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2, left: SizeConfig.blockSizeHorizontal * 2, bottom: SizeConfig.blockSizeHorizontal * 2, top: SizeConfig.blockSizeHorizontal * 2),
                                                                              decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.orange)),
                                                                              child: Text(
                                                                                'pendinguppercase'.tr,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(letterSpacing: 1.0, color: AppColors.orange, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
                                                                              ),*/
                                                                            )
                                                                          : projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status == "1"
                                                                              ? Container(
                                                                                  width: SizeConfig.blockSizeHorizontal * 20,
                                                                                  alignment: Alignment.center,
                                                                                  padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2, left: SizeConfig.blockSizeHorizontal * 2, bottom: SizeConfig.blockSizeHorizontal * 2, top: SizeConfig.blockSizeHorizontal * 2),
                                                                                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.orange)),
                                                                                  child: Text(
                                                                                    'done'.tr,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(letterSpacing: 1.0, color: AppColors.orange, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: SizeConfig.blockSizeHorizontal * 20,
                                                                                  alignment: Alignment.topRight,
                                                                                  padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2, left: SizeConfig.blockSizeHorizontal * 2, bottom: SizeConfig.blockSizeHorizontal * 2, top: SizeConfig.blockSizeHorizontal * 2),
                                                                                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.orange)),
                                                                                  child: Text(
                                                                                    'pendinguppercase'.tr,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(letterSpacing: 1.0, color: AppColors.orange, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
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
                                    ))
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: internet == true
                            ? CircularProgressIndicator()
                            : SizedBox(),
                      ),
                    ),
            ],
          )),
    );
  }

  Future<void> Payamount(String id, String requiredAmount, double updatedAmount,
      String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
    double actualamount = double.parse(requiredAmount);
    double originalamount;
    double commisionamount;

    if (actualamount < updatedAmount) {
      originalamount = actualamount;
      commisionamount = updatedAmount;
    } else {
      originalamount = updatedAmount;
      commisionamount = actualamount;
    }

    Map data = {
      'userid': userid.toString(),
      'project_id': id.toString(),
      'amount': originalamount.toString(),
      'updated_amount': commisionamount.toString(),
    };

    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.project_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(updateval)["message"]);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          AmountController.text = "";
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1), () {
            callNext(
                payment(
                    data: jsonDecode(updateval)["data"]["id"].toString(),
                    amount: commisionamount.toString(),
                    coming: "pjt",
                    backto: "Project"),
                context);
          });
          /* showDialog(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => OngoingProject()));
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

        } else {
          errorDialog(jsonDecode(updateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(updateval)["message"]);
    }
  }

  void addlike() async {
    Map data = {
      'userid': userid.toString(),
      'project_id': a.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.projectlikes, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      vallike = response.body; //store response as string
      if (jsonDecode(vallike)["success"] == false) {
        errorDialog(jsonDecode(vallike)["message"]);
      } else {
        prolike = new projectlike.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          getData(userid, a);
        } else {
          errorDialog(prolike.message);
        }
      }
    } else {
      errorDialog(jsonDecode(vallike)["message"]);
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
    http.Response response =
        await http.post(Network.BaseApi + Network.postComments, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valPost = response.body; //store response as string
      if (jsonDecode(valPost)["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonDecode(valPost)["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        postcom = new PostcommentPojo.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          setState(() {
            CommentController.text = "";
          });

          getData(userid, a);
        } else {
          errorDialog(postcom.message);
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(valPost)["message"]);
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

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabled ? key.capsText : key.text);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    // Update the screen
  }

  void showToast(String updateval) {
    errorDialog(jsonDecode(updateval)["message"]);
  }

  bottomsh() {
    return Future.delayed(Duration.zero, () async {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          context: context,
          builder: (builder) {
            return StatefulBuilder(builder: (context, setState) {
              return Container(
                  height: MediaQuery.of(context).size.height * 50,
                  child: Container(
                    color: Colors.white54,
                    child: VirtualKeyboard(
                        height: 250,
                        //width: 500,
                        textColor: Colors.black,
                        textController: CommentController,
                        //customLayoutKeys: _customLayoutKeys,
                        defaultLayouts: [
                          VirtualKeyboardDefaultLayouts.Arabic,
                          VirtualKeyboardDefaultLayouts.English
                        ],
                        //reverseLayout :true,
                        type: isNumericMode
                            ? VirtualKeyboardType.Numeric
                            : VirtualKeyboardType.Alphanumeric,
                        onKeyPress: _onKeyPress),
                  ));
            });
          });
    });
  }
}
