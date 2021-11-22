import 'dart:convert';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/MyActivitiesPojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share/share.dart';

class MyActivities extends StatefulWidget {
  @override
  MyActivitiesState createState() => MyActivitiesState();
}

class MyActivitiesState extends State<MyActivities> {
  Offset _tapDownPosition;
  String userid;
  String reverid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  var storelist_length;
  var imageslist_length;
  var commentlist_length;
  MyActivitiesPojo listing;
  int amount;
  int amoun;
  String vallike;
  projectlike prolike;
  String tabValue = "gift";
  String receivefrom = "gift";
  String updateval;
  String Follow = "Follow";
  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  String _amount;
  String shortsharedlink = '';
  String product_id = '';

  @override
  Future<void> initState() {

    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      setState(() {
        userid = val;
        getsortdata(userid,tabValue);
        print("Login userid: " + userid.toString());
      });
    });
  }


  void getsortdata(String user_id, String sortval) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'user_id': user_id.toString(),
      'sortvalue': sortval.toString(),
    };

    if (sortval.toString() == "ticket") {
      receivefrom = "ticket";
    } else if (sortval.toString() == "event") {
      receivefrom = "event";
    }else if (sortval.toString() == "donation") {
      receivefrom = "donation";
    }else if (sortval.toString() == "project") {
      receivefrom = "project";
    }else if (sortval.toString() == "gift") {
      receivefrom = "gift";
    }

    print("user: " + data.toString());
    var jsonResponse = null;

    http.Response response = await http.post(Network.BaseApi + Network.myactivities, body: data);
    if (response.statusCode == 200) {
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
        listing = new MyActivitiesPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(sortval.toString() == "gift")
              {
                if (listing.result.giftsection.isEmpty) {
                  resultvalue = false;
                }
                else {
                  resultvalue = true;
                  print("gift");
                  storelist_length = listing.result.giftsection;
                }
              }
            else  if(sortval.toString() == "project")
            {
              if (listing.result.projectsection.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("project");
                storelist_length = listing.result.projectsection;
              }
            }
            else  if(sortval.toString() == "donation")
            {
              if (listing.result.donationsection.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("donation");
                storelist_length = listing.result.donationsection;
              }
            }
            else  if(sortval.toString() == "event")
            {
              if (listing.result.eventssection.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("event");
                storelist_length = listing.result.eventssection;
              }
            }
            else  if(sortval.toString() == "ticket")
            {
              if (listing.result.tickettsection.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("ticket");
                storelist_length = listing.result.tickettsection;
              }
            }

          });
        }
        else {
          Fluttertoast.showToast(
              msg: listing.message,
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


/*
  _showEditPopupMenu(int index) async {
    print("INDEX: "+index.toString());
    final RenderBox overlay = Overlay
        .of(context)
        .context
        .findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(_tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,),
      items: [
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("Copy: "+listing.projectData
                      .elementAt(index).id.toString());
                  _createDynamicLink(listing.projectData
                      .elementAt(index).id.toString());
                });
                Navigator.of(context).pop();

              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('Share via', style: TextStyle(fontSize: 14),)
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
                        data: listing.projectData
                            .elementAt(index)
                            .id
                            .toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text('Edit', style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
        */
/* PopupMenuItem(
            value:3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    ProjectReport(
                        data: listing.projectData.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text('Report',style: TextStyle(fontSize: 14),)
                ],
              ),
            )),*//*


      ],
      elevation: 8.0,
    );
  }

  _showPopupMenu(int index) async {
    print("INDEX: "+index.toString());
    final RenderBox overlay = Overlay
        .of(context)
        .context
        .findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(_tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,),
      items: [
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("Copy: "+listing.projectData
                      .elementAt(index).id.toString());
                  _createDynamicLink(listing.projectData
                      .elementAt(index).id.toString());
                });
                Navigator.of(context).pop();

              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('Share via', style: TextStyle(fontSize: 14),)
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
                        data: listing.projectData
                            .elementAt(index)
                            .id
                            .toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text('Report', style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }
*/

  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30, fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
      height: SizeConfig.blockSizeVertical * 30, fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 30, fit: BoxFit.fitHeight,),
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

  bool _dialVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onTap: () {},
                        child: Container(),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      alignment: Alignment.center,
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        StringConstant.notification,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular',
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
              receivefrom == "project"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0 : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listing.result.projectsection
                          .elementAt(index)
                          .projectImages;
                      commentlist_length = listing.result.projectsection
                          .elementAt(index)
                          .comments;
                      double amount = double.parse(listing.result.projectsection
                          .elementAt(index)
                          .totalcollectedamount.toString()) /
                          double.parse(listing.result.projectsection
                              .elementAt(index)
                              .budget) * 100;
                      amoun = amount.toInt();
                      reverid = listing.result.projectsection
                          .elementAt(index)
                          .userId
                          .toString();
                      return
                        Container(
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(bottom: SizeConfig
                                  .blockSizeVertical * 2,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child:
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      _tapDownPosition = details.globalPosition;
                                    },
                                    onTap: () {
                                      setState(() {
                                        print("index: "+index.toString());
                                       // listing.result.projectsection.elementAt(index).userId == userid ? _showEditPopupMenu(index) : _showPopupMenu(index);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(
                                          right: SizeConfig
                                              .blockSizeHorizontal * 2),
                                      child: Image.asset(
                                          "assets/images/menudot.png",
                                          height: 15, width: 20),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      listing.result.projectsection
                                          .elementAt(index)
                                          .profilePic == null ||
                                          listing.result.projectsection
                                              .elementAt(index)
                                              .profilePic == ""
                                          ?
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                          callNext(
                                              viewdetail_profile(
                                                  data: listing.result.projectsection
                                                      .elementAt(index)
                                                      .userId
                                                      .toString()
                                              ), context);
                                        },
                                        child: Container(
                                            height:
                                            SizeConfig.blockSizeVertical * 9,
                                            width: SizeConfig
                                                .blockSizeVertical * 9,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical * 2,
                                                bottom: SizeConfig
                                                    .blockSizeVertical * 1,
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    1,
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    1),
                                            decoration: BoxDecoration(
                                              image: new DecorationImage(
                                                image: new AssetImage(
                                                    "assets/images/account_circle.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      )
                                          :
                                      GestureDetector(
                                        onTap: () {
                                          callNext(
                                              viewdetail_profile(
                                                  data: listing.result.projectsection
                                                      .elementAt(index)
                                                      .userId
                                                      .toString()
                                              ), context);
                                        },
                                        child: Container(
                                          height: SizeConfig.blockSizeVertical *
                                              9,
                                          width: SizeConfig.blockSizeVertical *
                                              9,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              top: SizeConfig
                                                  .blockSizeVertical * 2,
                                              bottom: SizeConfig
                                                  .blockSizeVertical * 1,
                                              right: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      listing.result.projectsection
                                                          .elementAt(index)
                                                          .profilePic),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  callNext(
                                                      viewdetail_profile(
                                                          data: listing
                                                              .result.projectsection
                                                              .elementAt(index)
                                                              .userId
                                                              .toString()
                                                      ), context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                          .blockSizeVertical *
                                                          2),
                                                  width: SizeConfig
                                                      .blockSizeHorizontal * 31,
                                                  padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                        .blockSizeVertical * 1,
                                                  ),
                                                  child: Text(
                                                    listing.result.projectsection
                                                        .elementAt(index)
                                                        .fullName,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .themecolor,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight
                                                            .normal,
                                                        fontFamily: 'Poppins-Regular'),
                                                  ),
                                                ),
                                              ),
                                              listing.result.projectsection
                                                  .elementAt(index)
                                                  .userId
                                                  .toString() == userid ?
                                              Container() :
                                              GestureDetector(
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
                                                        .blockSizeVertical * 1,
                                                  ),
                                                  child: Text(
                                                    Follow,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .darkgreen,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                        .blockSizeVertical * 2,
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
                                                        1,
                                                    bottom: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2,
                                                    top: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2),
                                                decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                    border: Border.all(
                                                        color: AppColors.purple)
                                                ),
                                                child: Text(
                                                  StringConstant.ongoing
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.purple,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),

                                              listing.result.projectsection
                                                  .elementAt(index)
                                                  .userId
                                                  .toString() != userid ?
                                              listing.result.projectsection
                                                  .elementAt(index)
                                                  .status == "pending" ?
                                              GestureDetector(
                                                onTap: () {
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
                                                          listing.result.projectsection
                                                              .elementAt(index)
                                                              .id,
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
                                                          child: new TextFormField(
                                                            autofocus: false,
                                                            focusNode: AmountFocus,
                                                            controller: AmountController,
                                                            textInputAction: TextInputAction
                                                                .next,
                                                            keyboardType: TextInputType
                                                                .number,
                                                            validator: (val) {
                                                              if (val.length ==
                                                                  0)
                                                                return "Please enter payment amount";
                                                              else
                                                                return null;
                                                            },
                                                            onFieldSubmitted: (v) {
                                                              AmountFocus.unfocus();
                                                            },
                                                            onSaved: (val) =>
                                                            _amount = val,
                                                            textAlign: TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                fontWeight: FontWeight
                                                                    .normal,
                                                                fontFamily: 'Poppins-Regular',
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black),
                                                            decoration: InputDecoration(
                                                              // border: InputBorder.none,
                                                              // focusedBorder: InputBorder.none,
                                                              hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey,
                                                                fontWeight: FontWeight
                                                                    .normal,
                                                                fontFamily: 'Poppins-Regular',
                                                                fontSize: 10,
                                                                decoration: TextDecoration
                                                                    .none,
                                                              ),
                                                              hintText: "Enter payment amount",
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
                                                    builder: (
                                                        BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left:
                                                  SizeConfig
                                                      .blockSizeHorizontal * 1,
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
                                                  decoration: BoxDecoration(
                                                    color: AppColors.darkgreen,
                                                    borderRadius: BorderRadius
                                                        .circular(20),

                                                  ),
                                                  child: Text(
                                                    StringConstant.pay
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                              ) : Container() : Container()
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal * 35,
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                      .blockSizeVertical * 1,
                                                ),
                                                child: Text(
                                                  listing.result.projectsection
                                                      .elementAt(index)
                                                      .projectName,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal * 38,
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
                                                  top: SizeConfig
                                                      .blockSizeVertical * 1,
                                                ),
                                                child: Text(
                                                  "Start Date- " +
                                                      listing.result.projectsection
                                                          .elementAt(index)
                                                          .projectStartdate,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal * 35,
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                      .blockSizeVertical * 1,
                                                ),
                                                child: Text(
                                                  //StringConstant.totalContribution+"-20",
                                                  "",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal * 38,
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
                                                  top: SizeConfig
                                                      .blockSizeVertical * 1,
                                                ),
                                                child: Text(
                                                  "End Date- " +
                                                      listing.result.projectsection
                                                          .elementAt(index)
                                                          .projectEnddate,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.black,
                                                      fontSize: 8,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical * 1,
                                                left: SizeConfig
                                                    .blockSizeHorizontal * 2),
                                            child: Text(
                                              StringConstant.collectiontarget +
                                                  "-",
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
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical * 1),
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                              right: SizeConfig
                                                  .blockSizeHorizontal *
                                                  3,
                                            ),
                                            child: Text(
                                              "\$" + listing.result.projectsection
                                                  .elementAt(index)
                                                  .budget,
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.lightBlueAccent,
                                                  fontSize: 8,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                1),
                                        child: LinearPercentIndicator(
                                          width: 70.0,
                                          lineHeight: 14.0,
                                          percent: amoun / 100,
                                          center: Text(amoun.toString() + "%",
                                            style: TextStyle(fontSize: 8,
                                                color: AppColors.whiteColor),),
                                          backgroundColor: AppColors.lightgrey,
                                          progressColor: AppColors.themecolor,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical * 1),
                                            child: Text(
                                              StringConstant.collectedamount +
                                                  "-",
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
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical * 1,
                                                right: SizeConfig
                                                    .blockSizeHorizontal * 4),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\$" + listing.result.projectsection
                                                  .elementAt(index)
                                                  .totalcollectedamount
                                                  .toString(),
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
                                      )

                                    ],
                                  ),
                                  /* Container(
                                      height: SizeConfig.blockSizeVertical*30,
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                      child: Image.asset("assets/images/banner5.png",fit: BoxFit.fitHeight,),
                                    ),*/
                                  imageslist_length != null ?
                                  GestureDetector(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                      callNext(
                                          OngoingProjectDetailsscreen(
                                              data:
                                              listing.result.projectsection
                                                  .elementAt(index)
                                                  .id
                                                  .toString()
                                          ), context);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *
                                              2),
                                      height: SizeConfig.blockSizeVertical * 30,
                                      child: Stack(
                                        alignment: AlignmentDirectional
                                            .bottomCenter,
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
                                                SizeConfig.blockSizeVertical *
                                                    50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .transparent),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Network
                                                              .BaseApiProject +
                                                              listing
                                                                  .result.projectsection
                                                                  .elementAt(
                                                                  index)
                                                                  .projectImages
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
                                                        .blockSizeVertical * 2),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    for (int i = 0; i <
                                                        imageslist_length
                                                            .length; i++)
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
                                  ) :
                                  GestureDetector(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                      callNext(
                                          OngoingProjectDetailsscreen(
                                              data: listing.result.projectsection
                                                  .elementAt(index)
                                                  .id
                                                  .toString()
                                          ), context);
                                    },
                                    child: Container(
                                      color: AppColors.themecolor,
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *
                                              2),
                                      height: SizeConfig.blockSizeVertical * 30,
                                      child: Stack(
                                        alignment: AlignmentDirectional
                                            .bottomCenter,
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
                                                        .blockSizeVertical * 2),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    for (int i = 0; i <
                                                        introWidgetsList
                                                            .length; i++)
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
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal * 3,
                                        right: SizeConfig.blockSizeHorizontal * 3,
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: new Html(
                                      data: listing.result.projectsection.elementAt(index).description,
                                      defaultTextStyle: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black87,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular'),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                    }),
              )
                  : Container(
                margin: EdgeInsets.only(top: 180),
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
              ): receivefrom == "donation"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0
                        : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listing.result.donationsection.elementAt(index).projectImages;
                      commentlist_length = listing.result.donationsection.elementAt(index).comments;
                      double amount = listing.result.donationsection.elementAt(index).totalcollectedamount.toDouble() /
                          double.parse(listing.result.donationsection.elementAt(index).budget) * 100;
                      amoun =amount.toInt();
                      reverid = listing.result.donationsection.elementAt(index).userId.toString();
                      return Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical *2,
                                top: SizeConfig.blockSizeVertical *2),
                            child:
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapDown: (TapDownDetails details){
                                    _tapDownPosition = details.globalPosition;
                                  },
                                  onTap: ()
                                  {
                                   /* listing.result.donationsection.elementAt(index).userId==userid? _showEditPopupMenu(index):
                                    _showPopupMenu(index);*/
                                  },
                                  child:  Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(
                                        right: SizeConfig
                                            .blockSizeHorizontal * 2),
                                    child: Image.asset(
                                        "assets/images/menudot.png",
                                        height: 15, width: 20),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    listing.result.donationsection.elementAt(index).profilePic== null ||
                                        listing.result.donationsection.elementAt(index).profilePic == "" ?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            viewdetail_profile(
                                                data: listing.result.donationsection.elementAt(index).userId.toString()
                                            ), context);
                                      },
                                      child: Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 9,
                                          width: SizeConfig.blockSizeVertical * 9,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *2,
                                              bottom: SizeConfig.blockSizeVertical *1,
                                              right: SizeConfig.blockSizeHorizontal * 1,
                                              left: SizeConfig.blockSizeHorizontal * 1),
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/account_circle.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                    )
                                        :
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            viewdetail_profile(
                                                data: listing.result.donationsection.elementAt(index).userId.toString()
                                            ), context);
                                      },
                                      child: Container(
                                        height: SizeConfig.blockSizeVertical * 9,
                                        width: SizeConfig.blockSizeVertical * 9,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *2,
                                            bottom: SizeConfig.blockSizeVertical *1,
                                            right: SizeConfig.blockSizeHorizontal * 1,
                                            left: SizeConfig.blockSizeHorizontal * 1),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    listing.result.donationsection.elementAt(index).profilePic),
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
                                                        data: listing.result.donationsection.elementAt(index).userId.toString()
                                                    ), context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                width: SizeConfig.blockSizeHorizontal *31,
                                                padding: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                ),
                                                child: Text(
                                                  listing.result.donationsection.elementAt(index).fullName,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.themecolor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ) ,
                                            ),

                                            listing.result.donationsection.elementAt(index).userId.toString()==userid?
                                            Container():
                                            GestureDetector(
                                              onTap: ()
                                              {
                                                followapi(userid, reverid);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2,
                                                    left: SizeConfig.blockSizeHorizontal*2),
                                                padding: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                ),
                                                child: Text(
                                                  Follow,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.darkgreen,
                                                      fontSize:8,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *2,
                                                  left: SizeConfig.blockSizeHorizontal *2),
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.only(
                                                  right: SizeConfig.blockSizeHorizontal * 2,
                                                  left: SizeConfig.blockSizeHorizontal * 2,
                                                  bottom: SizeConfig.blockSizeHorizontal * 2,
                                                  top: SizeConfig
                                                      .blockSizeHorizontal *
                                                      2),
                                              decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: AppColors.purple)
                                              ),
                                              child: Text(
                                                "OnGoing".toUpperCase(),
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
                                            listing.result.donationsection.elementAt(index).userId.toString()!=userid?
                                            listing.result.donationsection.elementAt(index).status=="pending"?
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
                                                    Payamount(listing.result.donationsection.elementAt(index).id,
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
                                                  builder: (BuildContext context)
                                                  {
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal *35,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Text(
                                                listing.result.donationsection.elementAt(index).campaignName,
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
                                                "Start Date- "+listing.result.donationsection.elementAt(index).campaignStartdate,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal *35,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Text(
                                                //StringConstant.totalContribution+"-20",
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
                                                "End Date- "+listing.result.donationsection.elementAt(index).campaignEnddate,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *23,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,left: SizeConfig.blockSizeHorizontal * 2),
                                          child: Text(
                                            "Collection Target- ",
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
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                3,
                                          ),
                                          child: Text(
                                            "\$"+listing.result.donationsection.elementAt(index).budget,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        ),
                                      ],
                                    ),

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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          child: Text(
                                            StringConstant.collectedamount+"-",
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
                                              4),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "\$"+listing.result.donationsection.elementAt(index).totalcollectedamount.toString(),
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
                                    )
                                  ],
                                ),
                                imageslist_length!=null?
                                GestureDetector(
                                  onTap: () {

                                    callNext(
                                        OngoingCampaignDetailsscreen(
                                            data:
                                            listing.result.donationsection.elementAt(index).id.toString()
                                        ), context);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.topCenter,
                                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                    height: SizeConfig.blockSizeVertical*30,
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
                                                        Network.BaseApidonation +
                                                            listing.result.donationsection.elementAt(index).projectImages.elementAt(ind).imagePath,
                                                      ),
                                                      fit: BoxFit.scaleDown)),
                                            );
                                          },
                                        ),
                                        Stack(
                                          alignment: AlignmentDirectional.bottomCenter,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  ),
                                ):
                                GestureDetector(
                                  onTap: () {
                                    callNext(
                                        OngoingCampaignDetailsscreen(
                                            data:
                                            listing.result.donationsection.elementAt(index).id.toString()
                                        ), context);
                                  },
                                  child: Container(
                                    color: AppColors.themecolor,
                                    alignment: Alignment.topCenter,
                                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                    height: SizeConfig.blockSizeVertical*30,
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
                                          alignment: AlignmentDirectional.bottomCenter,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  for (int i = 0; i < introWidgetsList.length; i++)
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
                                ),

                                Container(
                                  width: SizeConfig.blockSizeHorizontal *100,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                      top: SizeConfig.blockSizeVertical *1),
                                  child: new Html(
                                    data: listing.result.donationsection.elementAt(index).description,
                                    defaultTextStyle: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular'),

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
                  : Container(
                margin: EdgeInsets.only(top: 180),
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
              )
                  :Container()

            ],
          )
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: _dialVisible,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: null,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.public),
              backgroundColor: AppColors.theme1color,
              label: 'Tickets',
              onTap: () {
                tabValue = "ticket";
                getsortdata(userid, tabValue);
                print('Fiveth CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.public),
              backgroundColor: AppColors.theme1color,
              label: 'Events',
              onTap: () {
                tabValue = "event";
                getsortdata(userid, tabValue);
                print('Fourth CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.public),
              backgroundColor: AppColors.theme1color,
              label: 'Donations',
              onTap: () {
                tabValue = "donation";
                getsortdata(userid, tabValue);
                print('Third CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.privacy_tip),
              backgroundColor: AppColors.theme1color,
              label: 'Project Funding',
              onTap: () {
                tabValue = "project";
                getsortdata(userid, tabValue);
                print('Second CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.all_inclusive),
              backgroundColor: AppColors.theme1color,
              label: 'Send/Receive Gifts',
              onTap: () {
                tabValue = "gift";
                getsortdata(userid, tabValue);
                print('FIRST CHILD');
              }),
        ],
      ),
    );
  }


  Future<void> addlike(String id) async {
    Map data = {
      'userid': userid.toString(),
      'project_id': id.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(
        Network.BaseApi + Network.projectlikes, body: data);
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
          getsortdata(userid,tabValue);
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


  Future<void> Payamount(String id, String requiredAmount,
      String userid) async {
    Map data = {
      'userid': userid.toString(),
      'project_id': id.toString(),
      'amount': requiredAmount.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(
        Network.BaseApi + Network.project_pay, body: data);
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
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => projectfunding()));
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

  Future<void> _createDynamicLink(String productid) async {
    print("Product: "+productid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://kontribute.page.link',
        link: Uri.parse(Network.sharelin + productid),
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


}
