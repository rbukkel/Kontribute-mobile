
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kontribute/Ui/sendrequestgift/viewHistorydetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';


class HistorySendReceived extends StatefulWidget {
  @override
  HistorySendReceivedState createState() => HistorySendReceivedState();
}

class HistorySendReceivedState extends State<HistorySendReceived> {
  bool _dialVisible = true;
  Offset _tapDownPosition;

  @override
  void initState() {
    super.initState();
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
                                       /* GestureDetector(
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
                                        )*/
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
                child: Icon(Icons.request_page),
                backgroundColor: AppColors.theme1color,
                label: 'Request',

                onTap: () => print('FIRST CHILD')
            ),
            SpeedDialChild(
              child: Icon(Icons.people_rounded),
              backgroundColor: AppColors.theme1color,
              label: 'Pool',

              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.send),
              backgroundColor: AppColors.theme1color,
              label: 'Send',

              onTap: () => print('SECOND CHILD'),
            ),
          ],
        )
    );
  }
}
