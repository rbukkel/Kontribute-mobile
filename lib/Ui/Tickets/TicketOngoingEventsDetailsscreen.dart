import 'dart:io';
import 'package:favorite_button/favorite_button.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/MyActivity/MyActivities.dart';
import 'package:kontribute/Ui/Tickets/TicketReport.dart';
import 'package:kontribute/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/Ui/Tickets/ScanQR.dart';
import 'package:kontribute/Ui/Tickets/EditTicketPost.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Pojo/TicketDetailsPojo.dart';
import 'package:kontribute/Pojo/TicketCommentPojo.dart';
import 'package:kontribute/Pojo/ticketpaymentdetailsPojo.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kontribute/Ui/ProjectFunding/ProductVideoPlayerScreen.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class TicketOngoingEventsDetailsscreen extends StatefulWidget {
  final String data;
  final String coming;

  const TicketOngoingEventsDetailsscreen({Key key, @required this.data, @required this.coming})
      : super(key: key);
  @override
  TicketOngoingEventsDetailsscreenState createState() => TicketOngoingEventsDetailsscreenState();
}

class TicketOngoingEventsDetailsscreenState extends State<TicketOngoingEventsDetailsscreen> {
  Offset _tapDownPosition;
  String data1;
  String coming1;
  String userid;
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();
  String deleteproject;
  int a;
  bool internet = false;
  String val;
  String ticketval;
  String vallike;
  String valPost;
  int amoun;
  var productlist_length;
  var ticketpaymentlist_length;
  var storelist_length;
  var imageslist_length;
  var documentlist_length;
  var Ticketlist_length;
  var TicketUserDetails_length;
  var videolist_length;
  String shortsharedlink = '';
  String product_id = '';
  List<String> imagestore = [];
  TicketDetailsPojo projectdetailspojo;
  ticketpaymentdetailsPojo ticketpayment;
  projectlike prolike;
  TicketCommentPojo postcom;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;
  String updateval;
  String onchangeval = "";
  double totalamount;
  String valcommision;
  commisionpojo commission;
  var commisionlist_length;
  var dio = Dio();
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  final _formmainKey = GlobalKey<FormState>();
  String textHolder="0";
  int mutliply;
  String image;
  String _amount;
  String text = '';
  bool showkeyboard = false;
  bool shiftEnabled = false;
  bool isNumericMode = false;
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
        coming1 = widget.coming;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        print("receing: " + coming1.toString());
        getData(userid, a);
        getCommision();
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
      'ticket_id': projectid.toString(),
    };
    print("receiver: " + data.toString());

    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketDetails, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {

       errorDialog(jsonDecode(val)["message"]);
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
            Ticketlist_length = projectdetailspojo.commentsdata.ticketpayemtndetails;
            TicketUserDetails_length = projectdetailspojo.commentsdata.ticketdetailUser;
            videolist_length = projectdetailspojo.commentsdata.videoLink;
            double amount = double.parse(projectdetailspojo.commentsdata.ticketsold.toString()) /
                double.parse(projectdetailspojo.commentsdata.maximumQtySold.toString()) * 100;
            amoun = amount.toInt();
            print("Amountval: " + amoun.toString());

            if (!projectdetailspojo.commentsdata.profilePic.startsWith("https://"))
            {
              image=Network.BaseApiprofile+projectdetailspojo.commentsdata.profilePic;

            }
            else
            {
              image=projectdetailspojo.commentsdata.profilePic;
            }
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
                  print("Copy: "+projectdetailspojo.commentsdata.id.toString());
                  _createDynamicLink(projectdetailspojo.commentsdata.id.toString());
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
            value:2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    TicketReport(
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

  Future<void> _createDynamicLink(String productid) async {
    print("Product: "+productid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://kontribu.page.link',
        link: Uri.parse(Network.sharelinticket + productid),
        androidParameters: AndroidParameters(
          packageName: 'com.kont.kontribute',
          minimumVersion: 1,
        )
    );
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
        sharePositionOrigin:
        box.localToGlobal(Offset.zero) &
        box.size);
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
                  print("Copy: "+projectdetailspojo.commentsdata.id.toString());
                  _createDynamicLink(projectdetailspojo.commentsdata.id.toString());
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
            )
        ),
        PopupMenuItem(
            value: 2,
            child:
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    EditTicketPost(
                        data:  projectdetailspojo.commentsdata.id.toString()
                    ), context);
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
            )
        ),
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
            ))
      ],
      elevation: 8.0,
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
    http.Response response = await http.post(Network.BaseApi + Network.ticketdelete, body: data);
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => TicketOngoingEvents()),
                    (route) => false);
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


  void deleteDialog(String id) {
    Widget cancelButton = FlatButton
      (
      child: Text('no'.tr),
      onPressed: ()
      {
        Navigator.of(context,rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text('yes'.tr),
      onPressed: () async {
        Navigator.of(context,rootNavigator: true).pop();
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

  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;

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

                          if(coming1.toString()=="myactivity")
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyActivities()));
                          }
                          else if(coming1.toString()=="ticket")
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TicketOngoingEvents()));
                          }
                          else if(coming1.toString()=="searchticket")
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TicketOngoingEvents()));
                          }else if (coming1.toString() == "home") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          }
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
                        'tickets'.tr, textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            projectdetailspojo.commentsdata.userId.toString()!=userid?
                            projectdetailspojo.commentsdata.status=="pending"?
                            GestureDetector(
                              onTap: ()
                              {

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
                                                        fontWeight: FontWeight.bold),
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
                                                      Widget cancelButton = FlatButton(
                                                        child: Text('cancel'.tr),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            AmountController.text="";
                                                          });
                                                        },
                                                      );
                                                      Widget continueButton = FlatButton(
                                                        child: Text('continue'.tr),
                                                        onPressed: () async {

                                                          setState(() {
                                                            if (_formmainKey.currentState.validate()){
                                                              Payamount(
                                                                  projectdetailspojo.commentsdata.id,
                                                                  mutliply.toString(),
                                                                  totalamount.toString(),
                                                                  AmountController.text,
                                                                  userid);


                                                            }
                                                          });
                                                        },
                                                      );
                                                      // set up the AlertDialog
                                                      AlertDialog alert = AlertDialog(
                                                        title: Text('buyticket'.tr,
                                                          textAlign: TextAlign.center,
                                                          style:
                                                          TextStyle(
                                                              letterSpacing: 1.0,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Poppins-Regular',
                                                              fontSize: 16,
                                                              color: Colors.black),),
                                                        // content: Text("Are you sure you want to Pay this project?"),
                                                        content:
                                                        StatefulBuilder(builder: (BuildContext context, StateSetter setState)
                                                        {
                                                          return new Container(
                                                            width: SizeConfig.blockSizeHorizontal * 80,
                                                            height: SizeConfig.blockSizeVertical *25,
                                                            child:
                                                            new Column(
                                                              children: [
                                                                Container(
                                                                  // margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Row(
                                                                      children: [
                                                                        Text('ticketprice'.tr,style: TextStyle(
                                                                            letterSpacing: 1.0,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontFamily: 'Poppins-Regular',
                                                                            fontSize: 14,
                                                                            color: Colors.black),),
                                                                        Text(" \$"+projectdetailspojo.commentsdata.ticketCost.toString(),style: TextStyle(
                                                                            letterSpacing: 1.0,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontFamily: 'Poppins-Regular',
                                                                            fontSize: 14,
                                                                            color: Colors.black),),
                                                                      ],
                                                                    )
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
                                                                    margin: EdgeInsets.only(
                                                                        top: SizeConfig.blockSizeVertical *2,
                                                                        bottom: SizeConfig.blockSizeVertical *1),
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Row(
                                                                      children: [
                                                                        Text('totalticketprice'.tr,
                                                                            style: TextStyle(
                                                                                letterSpacing: 1.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'Poppins-Regular',
                                                                                fontSize: 14,
                                                                                color: Colors.black)),
                                                                        Text(" \$"+'$textHolder',
                                                                            style: TextStyle(
                                                                                letterSpacing: 1.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'Poppins-Regular',
                                                                                fontSize: 14,
                                                                                color: Colors.black)),
                                                                      ],
                                                                    )
                                                                ),
                                                                Form(
                                                                  key:_formmainKey,
                                                                  child: new TextFormField(
                                                                    autofocus: false,
                                                                    focusNode: AmountFocus,
                                                                    controller: AmountController,

                                                                    onChanged: (text) {
                                                                      setState(() {
                                                                        onchangeval = text;
                                                                        mutliply = int.parse(projectdetailspojo.commentsdata.ticketCost) * int.parse(onchangeval);
                                                                        print("Multi: "+mutliply.toString());


                                                                        double tectString = double.parse(mutliply.toString())*(commission.commisiondata.senderCommision/100);
                                                                        totalamount = double.parse(mutliply.toString()) + tectString;
                                                                        setState(() {
                                                                          textHolder = totalamount.toString();
                                                                        });
                                                                        //  UpdateText(totalamount.toString());
                                                                        print("PrintSring: "+totalamount.toString());
                                                                        print("PrintSringpers: "+tectString.toString());



                                                                      });
                                                                      print("value_1 : "+onchangeval);
                                                                    },
                                                                    textInputAction: TextInputAction.next,
                                                                    keyboardType: TextInputType.number,
                                                                    validator: (val) {
                                                                      if (val.length == 0)
                                                                        return 'pleaseenterticketqty'.tr;
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
                                                                        fontWeight: FontWeight.bold,
                                                                        fontFamily: 'Poppins-Regular',
                                                                        fontSize: 12,
                                                                        color: Colors.black),
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
                                                                      hintText:'enterticketqty'.tr,
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          );
                                                        }),



                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );

                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context)
                                                        {
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
                                                        bottom: SizeConfig.blockSizeVertical * 3,
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




                                    }else{
                                      print("falseValue");
                                      warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Ticket", context);
                                    }
                                  }else{
                                    print("falseValue");
                                    warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Ticket", context);
                                  }
                                });

                              },
                              child:Container(
                                margin: EdgeInsets.only(
                                    top:SizeConfig.blockSizeVertical *1,
                                    right: SizeConfig
                                        .blockSizeHorizontal * 2),
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
                                  'buy'.tr,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.whiteColor,
                                      fontSize:12,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      'Poppins-Regular'),
                                ),
                              ),
                            ): Container()
                                : Container(),
                            GestureDetector(
                              onTapDown: (TapDownDetails details){
                                _tapDownPosition = details.globalPosition;
                              },
                              onTap: ()
                              {
                                projectdetailspojo.commentsdata.userId.toString()==userid?
                                _showEditPopupMenu(): _showPopupMenu();
                              },
                              child:  Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    top:SizeConfig.blockSizeVertical *1,
                                    right: SizeConfig
                                        .blockSizeHorizontal * 2),
                                child: Image.asset(
                                    "assets/images/menudot.png",
                                    height: 15, width: 20),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            projectdetailspojo.commentsdata.profilePic == null ||
                                projectdetailspojo.commentsdata.profilePic == ""
                                ? GestureDetector(
                              onTap: ()
                              {
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
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors
                                          .themecolor,
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
                                    right: SizeConfig.blockSizeHorizontal *
                                        1,
                                    left: SizeConfig.blockSizeHorizontal *
                                        2),
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
                                          projectdetailspojo.commentsdata.fullName,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.themecolor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                    ),
                                   /* GestureDetector(
                                      onTap: ()
                                      {
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2,
                                            left: SizeConfig.blockSizeHorizontal*1),
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *1,
                                        ),
                                        child: Text(
                                          "@park plaza",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.black,
                                              fontSize:8,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily:
                                              'Poppins-Regular'),
                                        ),
                                      ),
                                    ),*/
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
                                        projectdetailspojo.commentsdata.eventName,
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
                                        left: SizeConfig.blockSizeHorizontal * 1,
                                        right: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(
                                              'startdate'.tr,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize:9,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                            Text(
                                              " - "+projectdetailspojo.commentsdata.eventStartdate,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize:9,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ]
                                      )

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
                                      child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text(
                                        'soldtickets'.tr,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize:9,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                      Text(
                                        " - "+projectdetailspojo.commentsdata.ticketsold.toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.black,
                                            fontSize:9,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ]
                                )
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *38,
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal * 1,
                                        right: SizeConfig
                                            .blockSizeHorizontal *
                                            1,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(
                                              'enddate'.tr,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize:9,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                            Text(
                                              " - "+projectdetailspojo.commentsdata.eventEnddate,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize:9,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ]
                                      )

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
                              width: SizeConfig.blockSizeHorizontal *36,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig
                                    .blockSizeHorizontal *
                                    3,),
                              child: Row(
                                children: [
                                  Text(
                                    'nooftickets'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                  Text(
                                    " - "+ projectdetailspojo.commentsdata.maximumQtySold.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                ],
                              )
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
                                                fontSize: 9,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        ),*/
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                              child:  LinearPercentIndicator(
                                width: 60.0,
                                lineHeight: 14.0,
                                percent: amoun/100,
                                center: Text(amoun.toString()+"%",style: TextStyle(fontSize: 8,color: AppColors.whiteColor),),
                                backgroundColor: AppColors.lightgrey,
                                progressColor:AppColors.themecolor,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: SizeConfig.blockSizeHorizontal *36,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                  .blockSizeHorizontal *
                                  6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'availabletickets'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                  Text(
                                    " - "+ projectdetailspojo.commentsdata.balanceQtySlot.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                ],
                              )
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
                                    width: SizeConfig.blockSizeHorizontal * 80,
                                    height: SizeConfig.blockSizeVertical * 50,
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
                                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,left:SizeConfig.blockSizeHorizontal*2),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Image.asset("assets/images/color_heart.png",color: Colors.black,height: 15,width: 25,)
                                      ),
                                      Container(
                                        child: Text(projectdetailspojo
                                            .commentsdata.totalLike
                                            .toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6 ),),
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
                                            .commentsdata.totalcomments
                                            .toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6  ),),
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
                              top: SizeConfig.blockSizeVertical *1),
                          child: new Html(
                            data: projectdetailspojo.commentsdata.description,
                            defaultTextStyle: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 12,
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
                            'termsandcondition'.tr,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ):Container(),
                        projectdetailspojo.commentsdata.termsAndCondition!=null?
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                            left: SizeConfig.blockSizeHorizontal *3,
                            right: SizeConfig.blockSizeHorizontal * 3),
                          alignment: Alignment.topLeft,
                          child: Text(
                            projectdetailspojo.commentsdata.termsAndCondition,
                            maxLines: 40,
                            style: TextStyle(letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 12,
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
                              top: SizeConfig.blockSizeVertical * 1),
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
                                  " " + (projectdetailspojo.commentsdata.commentslist.length)
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
                                Text('comments'.tr,
                                  maxLines: 2,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black26,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ],
                          )
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
                                        width: SizeConfig.blockSizeHorizontal * 100,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *1,
                                          bottom: SizeConfig.blockSizeVertical *1,
                                          left: SizeConfig.blockSizeHorizontal * 3,
                                          right: SizeConfig.blockSizeHorizontal * 3,
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
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
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
                        projectdetailspojo.commentsdata.userId.toString()==userid?Container():
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2,
                                right: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                onTap: () =>
                                    setState(() {
                                      showkeyboard = true;
                                    }),
                                autofocus: false,
                                readOnly: true,
                                focusNode: CommentFocus,
                                controller: CommentController,
                                textInputAction: TextInputAction.done,
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
                            showkeyboard == true? Container(
                              color: Colors.white54,
                              child: VirtualKeyboard(
                                  height: 250,
                                  textColor: Colors.black,
                                  textController: CommentController,
                                  defaultLayouts: [
                                    VirtualKeyboardDefaultLayouts.Arabic,
                                    VirtualKeyboardDefaultLayouts.English
                                  ],
                                  //reverseLayout :true,
                                  type: isNumericMode
                                      ? VirtualKeyboardType.Numeric
                                      : VirtualKeyboardType.Alphanumeric,
                                  onKeyPress: _onKeyPress),
                            ):Container(),
                            GestureDetector(
                              onTap: () {
                                addPost(CommentController.text);
                                print("clikc");
                                showkeyboard = false;
                              },
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 100,
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3,
                                    right: SizeConfig.blockSizeHorizontal * 5,
                                    top: SizeConfig.blockSizeVertical * 1),
                                child: Text(
                                  'post'.tr,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.themecolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                        videolist_length==null || projectdetailspojo.commentsdata.videoLink.isEmpty?
                        Container(): Container(
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
                                            callNext(ProductVideoPlayerScreen(
                                                data: projectdetailspojo.commentsdata.videoLink.elementAt(indx).vlink.toString(),
                                                comesfrom:"Ticket"), context);
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
                        ),
                        documentlist_length==null || projectdetailspojo.commentsdata.documents.isEmpty?
                        Container():Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount: documentlist_length.length == null
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
                                          onTap: ()async {
                                            String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
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
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: ()
                                        async {
                                          String path = await ExtStorage.getExternalStoragePublicDirectory(
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
                                            'download'.tr,
                                            maxLines: 2,
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                letterSpacing: 1.0,
                                                color: Colors.blue,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
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
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal *100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                              top: SizeConfig.blockSizeVertical *2),
                          child: Row(
                            children: [
                              Text(
                                'noofpersonsjoined'.tr,
                                maxLines: 2,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black26,
                                    fontSize: 9,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily:
                                    'Poppins-Regular'),
                              ),
                              Text(
                                " - "+projectdetailspojo.commentsdata.totalcontributor.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black26,
                                    fontSize: 9,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily:
                                    'Poppins-Regular'),
                              ),
                            ],
                          )
                        ),
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
                                    'ticketprice'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 9,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical *1,
                                    right: SizeConfig.blockSizeHorizontal * 1,
                                    bottom:SizeConfig.blockSizeVertical *2 ,),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "  \$"+projectdetailspojo.commentsdata.ticketCost.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.lightBlueAccent,
                                        fontSize: 9,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                )
                              ],
                            ),
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
                        userid == projectdetailspojo.commentsdata.userId.toString()?
                            Column(
                              children:
                              [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  userid == projectdetailspojo.commentsdata.userId.toString()?
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      callNext(ScanQR(data: projectdetailspojo.commentsdata.userId.toString()), context);
                                    },
                                    child: Container(
                                      width: SizeConfig.blockSizeHorizontal *30,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *3,
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
                                        'validateticket'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.whiteColor,
                                            fontSize:10,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                  ):Container()
                                ],
                              ),
                              projectdetailspojo.commentsdata.ticketpayemtndetails.isEmpty?Container():
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),
                                    child: Text(
                                      'totalticketssold'.tr, textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal*5,
                                        top: SizeConfig.blockSizeVertical *2),
                                    child: Text(
                                      'exportto'.tr, textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                                          left: SizeConfig.blockSizeHorizontal*1,
                                          top: SizeConfig.blockSizeVertical *2),
                                      child: Image.asset("assets/images/csv.png",width: 70,height: 40,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()
                                    {
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
                              projectdetailspojo.commentsdata.ticketpayemtndetails.isEmpty?Container():
                              Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                color: AppColors.purplecolor,
                                height: SizeConfig.blockSizeVertical *7,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /*Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *8,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Text(
                                  StringConstant.srno, textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),*/
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal *38,
                                      margin:
                                      EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal*3),
                                      child: Text(
                                        'name'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
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
                                        'nooftickets'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
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
                                        'totalamount'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins-Regular",
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Ticketlist_length!=null?
                              Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical*2),
                                child:
                                ListView.builder(
                                    itemCount: Ticketlist_length.length == null
                                        ? 0
                                        : Ticketlist_length.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int ix) {
                                      return
                                        Container(

                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.center,
                                                      width: SizeConfig.blockSizeHorizontal *38,
                                                      margin: EdgeInsets.only(
                                                          left: SizeConfig.blockSizeHorizontal*3),
                                                      child: Text(
                                                        projectdetailspojo.commentsdata.ticketpayemtndetails.elementAt(ix).fullName,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            decoration: TextDecoration.none,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
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
                                                        projectdetailspojo.commentsdata.ticketpayemtndetails.elementAt(ix).qty.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            decoration: TextDecoration.none,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
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
                                                        projectdetailspojo.commentsdata.ticketpayemtndetails.elementAt(ix).amount.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            decoration: TextDecoration.none,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
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
                                                        TicketDetails(projectdetailspojo.commentsdata.ticketpayemtndetails.elementAt(ix).id);
                                                      },
                                                      child:
                                                      Container(
                                                        width: SizeConfig.blockSizeHorizontal *20,
                                                        alignment: Alignment.bottomRight,
                                                        margin: EdgeInsets.only(
                                                            right: SizeConfig.blockSizeHorizontal *3,
                                                            top: SizeConfig.blockSizeVertical *2),
                                                        padding: EdgeInsets.only(
                                                            right: SizeConfig.blockSizeHorizontal * 2,
                                                            left: SizeConfig.blockSizeHorizontal * 2,
                                                            bottom: SizeConfig.blockSizeHorizontal * 3,
                                                            top: SizeConfig.blockSizeHorizontal * 3),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.yelowbg,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: Text(
                                                          'viewdetails'.tr,
                                                          style: TextStyle(
                                                              letterSpacing: 1.0,
                                                              color: AppColors.whiteColor,
                                                              fontSize:8,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontFamily:
                                                              'Poppins-Regular'),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig.blockSizeVertical * 2,
                                                      bottom: SizeConfig.blockSizeVertical * 2),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                              ],
                                            )
                                        );
                                    }),
                              ):Container(),
                            ],
                            ):
                        Column(
                          children:
                          [

                            projectdetailspojo.commentsdata.ticketdetailUser.isEmpty?Container():
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),
                                  child: Text(
                                    'totalticketssold'.tr, textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins-Regular",
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal*5,
                                      top: SizeConfig.blockSizeVertical *2),
                                  child: Text(
                                    'exportto'.tr, textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
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
                                        left: SizeConfig.blockSizeHorizontal*1,
                                        top: SizeConfig.blockSizeVertical *2),
                                    child: Image.asset("assets/images/csv.png",width: 70,height: 40,),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()
                                  {
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
                            projectdetailspojo.commentsdata.ticketdetailUser.isEmpty?Container():
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                              color: AppColors.purplecolor,
                              height: SizeConfig.blockSizeVertical *7,
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /*Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *8,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Text(
                                  StringConstant.srno, textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),*/
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal *38,
                                    margin:
                                    EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal*3),
                                    child: Text(
                                     'name'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                                     'nooftickets'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                                      'totalamount'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TicketUserDetails_length!=null?
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical*2),
                              child:
                              ListView.builder(
                                  itemCount: TicketUserDetails_length.length == null
                                      ? 0
                                      : TicketUserDetails_length.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int ix) {
                                    return
                                      Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  /* Container(
                                              alignment: Alignment.center,
                                              width: SizeConfig.blockSizeHorizontal *8,
                                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                              child: Text(
                                                projectdetailspojo.commentsdata.ticketpayemtndetails.elementAt(ix).toString(), textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins-Regular",
                                                    color: Colors.black),
                                              ),
                                            ),*/
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig.blockSizeHorizontal *38,
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.blockSizeHorizontal*3),
                                                    child: Text(
                                                      projectdetailspojo.commentsdata.ticketdetailUser.elementAt(ix).fullName,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
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
                                                      projectdetailspojo.commentsdata.ticketdetailUser.elementAt(ix).qty.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
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
                                                      projectdetailspojo.commentsdata.ticketdetailUser.elementAt(ix).amount.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
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
                                                      TicketDetails(projectdetailspojo.commentsdata.ticketdetailUser.elementAt(ix).id);
                                                    },
                                                    child:
                                                    Container(
                                                      width: SizeConfig.blockSizeHorizontal *20,
                                                      alignment: Alignment.bottomRight,
                                                      margin: EdgeInsets.only(
                                                          right: SizeConfig.blockSizeHorizontal *3,
                                                          top: SizeConfig.blockSizeVertical *2),
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig.blockSizeHorizontal * 2,
                                                          left: SizeConfig.blockSizeHorizontal * 2,
                                                          bottom: SizeConfig.blockSizeHorizontal * 3,
                                                          top: SizeConfig.blockSizeHorizontal * 3),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.yelowbg,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: Text(
                                                        'viewdetails'.tr,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color: AppColors.whiteColor,
                                                            fontSize:8,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical * 2,
                                                    bottom: SizeConfig.blockSizeVertical * 2),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                  }),
                            ):Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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

  void addlike() async {
    Map data = {
      'userid': userid.toString(),
      'ticket_id': a.toString(),
    };
    print("projectlikes: "+data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketlikes, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      vallike = response.body; //store response as string
      if (jsonDecode(vallike)["success"] == false)
      {
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
      'ticket_id': a.toString(),
      'comment': post.toString(),
    };
    Dialogs.showLoadingDialog(context, _keyLoader);
    print("projectPOst: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketComments, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valPost = response.body; //store response as string
      if (jsonDecode(valPost)["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonDecode(valPost)["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        postcom = new TicketCommentPojo.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          setState(() {
            CommentController.text ="";
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
        msg: "Downloading file "+(received / total * 100).toStringAsFixed(0) + "%",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      if((received / total * 100).toStringAsFixed(0) + "%"=="100%")
      {
        errorDialog('savedindownloadfolder'.tr);
      }
    }
  }

  Future<void> Payamount(String id,String cost, String requiredAmount,String qtyval, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'userid': userid.toString(),
      'ticket_id': id.toString(),
      'amount': cost.toString(),
      'updated_amount': requiredAmount.toString(),
      'qty': qtyval.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticket_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(updateval)["message"]);
      }
      else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          AmountController.text ="";
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: jsonDecode(updateval)["data"]["id"].toString(),
                    amount:totalamount.toString(),
                    coming:"tkt",
                    backto:"Ticket"
                ), context);
          });
          /*showDialog(
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
                                builder: (BuildContext context) => TicketOngoingEvents()));
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
          errorDialog(jsonDecode(updateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(updateval)["message"]);
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


  void TicketDetails(String id) async {
      Map data = {
        'payment_id': id.toString(),
      };
      Dialogs.showLoadingDialog(context, _keyLoader);
      print("Payment Ticket: " + data.toString());
      var jsonResponse = null;
      http.Response response = await http.post(Network.BaseApi + Network.ticketQrlising_byid, body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        ticketval = response.body; //store response as string
        if (jsonDecode(ticketval)["status"] == false) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
         errorDialog(jsonDecode(ticketval)["message"]);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          ticketpayment = new ticketpaymentdetailsPojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              ticketpaymentlist_length = ticketpayment.ticketQrlisting;
            });
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
                                      'ticketdetails'.tr, textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
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
                                    'qrcode'.tr, textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins-Regular",
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal *25,
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.only(top: 10, left: 40),
                                  child: Text(
                                    'ticketno'.tr, textAlign: TextAlign.center,
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
                            ticketpaymentlist_length!=null?
                            Expanded(
                              child:
                              ListView.builder(
                                  itemCount: ticketpaymentlist_length.length == null
                                      ? 0
                                      : ticketpaymentlist_length.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int iex) {
                                    return Container(
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,
                                            bottom: SizeConfig.blockSizeVertical *2),
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
                                                  width: SizeConfig.blockSizeHorizontal *12,
                                                  height: SizeConfig.blockSizeVertical *7,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            ticketpayment.ticketQrlisting.elementAt(iex).imagePath,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig.blockSizeHorizontal *25,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *1),
                                                child: Text(
                                                  ticketpayment.ticketQrlisting.elementAt(iex).ticketNo.toString(), textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Poppins-Regular",
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                  }),
                            ):Container()
                          ],
                        ),

                      ],
                    ),
                  );
                });
          } else {
            errorDialog(ticketpayment.message);
          }
        }
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
       errorDialog(jsonDecode(ticketval)["message"]);
      }
  }



}
