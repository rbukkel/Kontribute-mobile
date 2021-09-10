import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Ui/ProjectFunding/CreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class OngoingProject extends StatefulWidget {
  @override
  OngoingProjectState createState() => OngoingProjectState();
}

class OngoingProjectState extends State<OngoingProject> {
  Offset _tapDownPosition;
  String userid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  var storelist_length;
  var imageslist_length;
  var commentlist_length;
  projectlisting listing;
  int amount;
  int amoun;
  String vallike;
  projectlike prolike;
  String tabValue ="1";
  String updateval;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());

    });
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getdata(userid);
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


  void getdata(String user_id) async {
    setState(() {
      storelist_length =null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectListing, body: data);
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
        listing = new projectlisting.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(listing.projectData.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.projectData;
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


  void getsortdata(String user_id,String sortval) async {
    setState(() {
      storelist_length =null;
    });
    Map data = {
      'userid': user_id.toString(),
      'sortby': sortval.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectListing, body: data);
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
        listing = new projectlisting.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(listing.projectData.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.projectData;
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


  _showEditPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB( _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,),
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
                  Text('Copy this post',style: TextStyle(fontSize: 14),)
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
                        data: listing.projectData.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text('Edit',style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
        PopupMenuItem(
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
            )),

      ],
      elevation: 8.0,
    );
  }
  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB( _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,),
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
                  Text('Copy this post',style: TextStyle(fontSize: 14),)
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
            )),

      ],
      elevation: 8.0,
    );
  }


  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
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
          color: isActive ? AppColors.whiteColor : AppColors.lightgrey,
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
              storelist_length != null
                  ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0
                        : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                         imageslist_length = listing.projectData.elementAt(index).projectImages;
                         commentlist_length = listing.projectData.elementAt(index).comments;
                      double amount = double.parse(listing.projectData.elementAt(index).totalcollectedamount) /
                          double.parse(listing.projectData.elementAt(index).budget) * 100;
                      amoun =amount.toInt();
                      return
                        Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child:
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2,top: SizeConfig.blockSizeVertical *2),
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
                                            listing.projectData.elementAt(index).userId==userid? _showEditPopupMenu(index):
                                            _showPopupMenu(index);
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
                                            listing.projectData.elementAt(index).profilePic== null ||
                                                listing.projectData.elementAt(index).profilePic == ""
                                                ?
                                            GestureDetector(
                                              onTap: () {
                                               // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                callNext(
                                                    viewdetail_profile(
                                                        data: listing.projectData.elementAt(index).userId.toString()
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
                                                        data: listing.projectData.elementAt(index).userId.toString()
                                                    ), context);

                                              },
                                              child: Container(
                                                height: SizeConfig.blockSizeVertical * 9,
                                                width: SizeConfig.blockSizeVertical * 9,
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *2,
                                                    bottom: SizeConfig.blockSizeVertical *1,
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
                                                            listing.projectData.elementAt(index).profilePic),
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
                                                                data: listing.projectData.elementAt(index).userId.toString()
                                                            ), context);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                        width: SizeConfig.blockSizeHorizontal *31,
                                                        padding: EdgeInsets.only(
                                                          top: SizeConfig.blockSizeVertical *1,
                                                        ),
                                                        child: Text(
                                                          listing.projectData.elementAt(index).fullName,
                                                          style: TextStyle(
                                                              letterSpacing: 1.0,
                                                              color: AppColors.themecolor,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: 'Poppins-Regular'),
                                                        ),
                                                      ) ,
                                                    ),
                                                    listing.projectData.elementAt(index).userId.toString()==userid?
                                                        Container():
                                                    GestureDetector(
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
                                                          StringConstant.follow,
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
                                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),
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
                                                          borderRadius: BorderRadius.circular(20),
                                                          border: Border.all(color: AppColors.purple)
                                                      ),
                                                      child: Text(
                                                        StringConstant.ongoing.toUpperCase(),
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

                                                    listing.projectData.elementAt(index).userId.toString()!=userid?
                                                    listing.projectData.elementAt(index).status=="pending"?
                                                   GestureDetector(
                                                      onTap: ()
                                                      {
                                                        Widget cancelButton = FlatButton(
                                                          child: Text("No"),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                        Widget continueButton = FlatButton(
                                                          child: Text("Yes"),
                                                          onPressed: () async {
                                                            Payamount(listing.projectData.elementAt(index).id,
                                                                listing.projectData.elementAt(index).requiredAmount,
                                                                userid);
                                                          },
                                                        );
                                                        // set up the AlertDialog
                                                        AlertDialog alert = AlertDialog(
                                                          title: Text("Pay now.."),
                                                          content: Text("Are you sure you want to Pay this project?"),
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig.blockSizeHorizontal *35,
                                                      alignment: Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical *1,
                                                      ),
                                                      child: Text(
                                                        listing.projectData.elementAt(index).projectName,
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
                                                        "Start Date- "+listing.projectData.elementAt(index).projectStartdate,
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
                                                        "End Date- "+listing.projectData.elementAt(index).projectEnddate,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,left: SizeConfig.blockSizeHorizontal * 2),
                                                  child: Text(
                                                    StringConstant.collectiontarget+"-",
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
                                                    "\$"+listing.projectData.elementAt(index).budget,
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
                                                    "\$"+listing.projectData.elementAt(index).totalcollectedamount.toString(),
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
                                        imageslist_length!=null?
                                        GestureDetector(
                                          onTap: () {
                                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                            callNext(
                                                OngoingProjectDetailsscreen(
                                                    data:
                                                    listing.projectData.elementAt(index).id.toString()
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
                                                                Network.BaseApiProject +
                                                                    listing.projectData.elementAt(index).projectImages.elementAt(ind).imagePath,
                                                              ),
                                                              fit: BoxFit.fill)),
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
                                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                            callNext(
                                                OngoingProjectDetailsscreen(
                                                    data: listing.projectData.elementAt(index).id.toString()
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
                                     /*   Container(
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  print("LIke");
                                                  addlike(listing.projectData.elementAt(index).id);
                                                },
                                                child: Container(
                                                  width: SizeConfig.blockSizeHorizontal*7,
                                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Image.asset("assets/images/heart.png",height: 20,width: 20,),
                                                      ),
                                                    ],
                                                  ),
                                                  //child: Image.asset("assets/images/flat.png"),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: ()
                                                {

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
                                          */
                                     /*    InkWell(
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
                                                        child: Text("1,555",style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6 ),),
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
                                                        child: Text("22",style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6  ),),
                                                      )
                                                    ],
                                                  ),
                                                  //child: Image.asset("assets/images/save.png"),
                                                ),
                                              ),*/
                                     /*
                                            ],
                                          ),
                                        ),*/
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *100,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                              top: SizeConfig.blockSizeVertical *1),
                                          child: new Html(
                                              data: listing.projectData.elementAt(index).description,
                                              defaultTextStyle: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Poppins-Regular'),
                                          
                                        ),
                                        ),
                                       /* commentlist_length!=null?
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: ()
                                                  {
                                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                                  },
                                                  child: Container(
                                                    width: SizeConfig.blockSizeHorizontal *100,
                                                    alignment: Alignment.topLeft,
                                                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                                        top: SizeConfig.blockSizeVertical *1),
                                                    child: Text(
                                                     commentlist_length.length.toString(),
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: Colors.black26,
                                                          fontSize: 8,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          fontFamily:
                                                          'Poppins-Regular'),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal *100,
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                                      top: SizeConfig.blockSizeVertical *1),
                                                  child: Text(
                                                    listing.projectData.elementAt(index).comments.elementAt(0).comment,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'NotoEmoji'),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal *100,
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                                      top: SizeConfig.blockSizeVertical *1),
                                                  child: Text(
                                                    "itx_kamie_94🤑🤣🤣",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'NotoEmoji'),
                                                  ),
                                                )
                                              ],
                                            ): Container()*/
                                       /* Container(
                                          width: SizeConfig.blockSizeHorizontal *100,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                              top: SizeConfig.blockSizeVertical *1),
                                          child: Text(
                                            "3 Hours ago".toUpperCase(),
                                            maxLines: 2,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black26,
                                                fontSize: 8,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                        ),
                      );
                    }),
              )
                  : Container(
                margin: EdgeInsets.only(top: 150),
                alignment: Alignment.center,
                child: resultvalue == true
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Center(
                  child: Image.asset("assets/images/empty.png",
                      height: SizeConfig.blockSizeVertical * 50,
                      width: SizeConfig.blockSizeVertical * 50),
                ),
              )
            ],
          )
         ),
      /*floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
        icon: Icon(Icons.edit,color: AppColors.selectedcolor,),
        label: Text(StringConstant.createpost,style: TextStyle(color:AppColors.selectedcolor ),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateProjectPost()));
        },
      ),*/
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
            label: 'Public',

              onTap: () {
                tabValue="1";
                getsortdata(userid, tabValue);
                print('FIRST CHILD');
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.privacy_tip),
            backgroundColor: AppColors.theme1color,
            label: 'Private',
              onTap: () {
                tabValue="2";
                getsortdata(userid, tabValue);
                print('FIRST CHILD');
              }
          ),
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
          getdata(userid);
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



}

