import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/TicketOngoingListing.dart';
import 'package:kontribute/Ui/Tickets/EditTicketPost.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/Tickets/TicketReport.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';


class TicketOngoingEvents extends StatefulWidget {
  @override
  TicketOngoingEventsState createState() => TicketOngoingEventsState();
}

class TicketOngoingEventsState extends State<TicketOngoingEvents> {
  bool internet = false;
  String val;
  var storelist_length;
  var imageslist_length;
  var commentlist_length;
  Offset _tapDownPosition;
  bool resultvalue = true;
  String userid;
  String updateval;
  String updatefollowval;
  String Follow = "Follow";
  TicketOngoingListing listing;
  int amoun;
  String reverid;
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  String _amount;
  String tabValue ="1";

  @override
  void initState() {
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


  bool _dialVisible = true;


  void getdata(String user_id) async {
    setState(() {
      storelist_length =null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketListing, body: data);
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
        listing = new TicketOngoingListing.fromJson(jsonResponse);
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
      updatefollowval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updatefollowval);
      } else {
        if (jsonResponse != null) {
          showToast(updatefollowval);
          setState(() {
            Follow = "";
          });
        } else {
          showToast(updatefollowval);
        }
      }
    } else {
      showToast(updatefollowval);
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
    http.Response response = await http.post(Network.BaseApi + Network.ticketListing, body: data);
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
        listing = new TicketOngoingListing.fromJson(jsonResponse);
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
                    EditTicketPost(
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

      ],
      elevation: 8.0,
    );
  }
  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB( _tapDownPosition.dx, _tapDownPosition.dy, overlay.size.width - _tapDownPosition.dx,
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
                    TicketReport(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            children: [
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null ? 0 : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listing.projectData.elementAt(index).ticketImages;
                      commentlist_length = listing.projectData.elementAt(index).comments;
                      double amount = listing.projectData.elementAt(index).balanceQtySlot.toDouble() /
                          double.parse(listing.projectData.elementAt(index).maximumQtySold) * 100;
                      amoun =amount.toInt();
                      reverid = listing.projectData.elementAt(index).userId.toString();
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [


                                        listing.projectData.elementAt(index).userId.toString()!=userid?
                                        listing.projectData.elementAt(index).status=="pending"?
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
                                                /*Payamount(listing.projectData.elementAt(index).id,
                                                    AmountController.text,
                                                    userid);*/
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
                                          child:  Container(
                                            margin: EdgeInsets.only(left:
                                            SizeConfig.blockSizeHorizontal *1,
                                              right: SizeConfig.blockSizeHorizontal *3,
                                            ),
                                            padding: EdgeInsets.only(
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    7,
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    7,
                                                bottom: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2,
                                                top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
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
                                        ): Container(): Container(),


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
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        listing.projectData.elementAt(index).profilePic== null ||
                                            listing.projectData.elementAt(index).profilePic == "" ?
                                        GestureDetector(
                                          onTap: () {
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
                                                right: SizeConfig.blockSizeHorizontal * 1,
                                                left: SizeConfig.blockSizeHorizontal * 1),
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
                                                    width: SizeConfig.blockSizeHorizontal *37,
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
                                                    listing.projectData.elementAt(index).ticketName,
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
                                                    "Start Date- "+listing.projectData.elementAt(index).ticketStartdate,
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
                                                    "End Date- "+listing.projectData.elementAt(index).ticketEnddate,
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
                                              left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig
                                                .blockSizeHorizontal *
                                                3,),
                                          child: Text(
                                            "No. of Tickets - "+ listing.projectData.elementAt(index).maximumQtySold.toString(),
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
                                              3),
                                          child: Text(
                                            "Available Tickets- "+listing.projectData.elementAt(index).balanceQtySlot.toString(),
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
                                      /*  Container(
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                              .blockSizeHorizontal *
                                              3),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            listing.projectData.elementAt(index).balanceQtySlot.toString(),
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        )*/
                                      ],
                                    ),
                                    imageslist_length!=null?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            TicketOngoingEventsDetailsscreen(
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
                                                            Network.BaseApiticket +
                                                                listing.projectData.elementAt(index).ticketImages.elementAt(ind).imagePath,
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
                                        callNext(
                                            TicketOngoingEventsDetailsscreen(
                                                data:
                                                listing.projectData.elementAt(index).id.toString()
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
                                          top: SizeConfig.blockSizeVertical *1,bottom: SizeConfig.blockSizeVertical *1),
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
                                  /*  GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TicketOngoingEventsDetailsscreen()));
                                      },
                                      child: Container(
                                        width: SizeConfig.blockSizeHorizontal *100,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                            top: SizeConfig.blockSizeVertical *1),
                                        child: Text(
                                          "View all 29 comments",
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
                                        "thekratos carry killed it🤑🤑🤣",
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
                                    ),
                                    Container(
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
                                    ),

                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *100,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                          top: SizeConfig.blockSizeVertical *1),
                                      child: Text(
                                        "No. of Persons joined- 80",
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1, left: SizeConfig.blockSizeHorizontal *3),
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
                                                1),
                                            alignment: Alignment.topLeft,

                                            child: Text(
                                              "\$"+listing.projectData.elementAt(index).ticketCost.toString(),
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
                                      ],
                                    )
                                  ],
                                ),
                              ),


                        ),
                      );
                    }),
              )  : Container(
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
        heroTag: 'speed-dial-hero-tag',
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
          SpeedDialChild(
              child: Icon(Icons.all_inclusive),
              backgroundColor: AppColors.theme1color,
              label: 'All',
              onTap: () {
                tabValue="0";
                getsortdata(userid, tabValue);
                print('Third CHILD');
              }),
        ],
      ),
    );
  }
}
