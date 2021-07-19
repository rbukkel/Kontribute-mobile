import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/Tickets/CreateTicketPost.dart';
import 'package:kontribute/Ui/createpostgift.dart';
import 'package:kontribute/Ui/sendrequestgift/viewHistorydetail_sendreceivegift.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class HistorySendReceived extends StatefulWidget {
  @override
  HistorySendReceivedState createState() => HistorySendReceivedState();
}

class HistorySendReceivedState extends State<HistorySendReceived> {

  Offset _tapDownPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  _showPopupMenu() async {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             /* Container(
                height: SizeConfig.blockSizeVertical *7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Text(
                        "Sort by: ",
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Text(
                        "Request",
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular'),
                      ),
                    )
                  ],
                ),
              ),*/
              Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 2),
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
                                margin: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width:
                                          SizeConfig.blockSizeHorizontal * 72,
                                          margin: EdgeInsets.only(
                                              left:
                                              SizeConfig.blockSizeHorizontal *
                                                  2),
                                          child: Text(
                                            StringConstant.receivegift,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins-Bold',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              right:
                                              SizeConfig.blockSizeHorizontal *
                                                  2),
                                          child: Text(
                                            "01-01-2020",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins-Regular',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 8),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTapDown: (TapDownDetails details) {
                                            _tapDownPosition =
                                                details.globalPosition;
                                          },
                                          onTap: () {
                                            _showPopupMenu();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
                                            child: Image.asset(
                                                "assets/images/menudot.png",
                                                height: 15,
                                                width: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 12,
                                          width:
                                          SizeConfig.blockSizeVertical * 12,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *
                                                  1,
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
                                              image: DecorationImage(
                                                image: new AssetImage(
                                                    "assets/images/userProfile.png"),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      45,
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),
                                                  child: Text(
                                                    "Sam Miller",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                            context) =>
                                                                viewHistorydetail_sendreceivegift()));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1,
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3,
                                                    ),
                                                    child: Text(
                                                      "View Details",
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.green,
                                                          fontSize: 12,
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
                                              width:
                                              SizeConfig.blockSizeHorizontal *
                                                  70,
                                              alignment: Alignment.topLeft,
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
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black87,
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily:
                                                    'Poppins-Regular'),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  child: Text(
                                                    "Amount- ",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  child: Text(
                                                    "\$100",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  child: Text(
                                                    "Collection Target- ",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3,
                                                      top: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2),
                                                  child: Text(
                                                    "\$1000",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 12,
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
                                  ],
                                ),
                              ),
                              onTap: () {},
                            )),
                      );
                    }),
              )
            ],
          )
      ),

    );
  }
}
