import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/history_sendpojo.dart';
import 'package:kontribute/Ui/sendrequestgift/viewHistorydetail_sendreceivegift.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class HistorySendReceived extends StatefulWidget {
  @override
  HistorySendReceivedState createState() => HistorySendReceivedState();
}

class HistorySendReceivedState extends State<HistorySendReceived> {
  bool _dialVisible = true;
  bool resultvalue = true;
  Offset _tapDownPosition;
  String userid;
  bool internet = false;
  String val;
  var storelist_length;
  history_sendpojo requestpojo;
  String receivefrom;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState()
  {
    super.initState();
    SharedUtils.readloginId("UserId").then((val)
    {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid);
    });
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
                storelist_length != null ?
                Expanded(
                  child: ListView.builder(
                      itemCount: storelist_length.length == null
                          ? 0
                          : storelist_length.length,
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
                                      bottom:
                                      SizeConfig.blockSizeVertical *
                                          2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig
                                                .blockSizeHorizontal *
                                                72,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.blockSizeHorizontal * 2),
                                            child: Text(
                                              StringConstant.receivegift,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                  'Poppins-Bold',
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.blockSizeHorizontal * 2),
                                            child: Text(
                                              requestpojo.result.data.elementAt(index).postedDate,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                  'Poppins-Regular',
                                                  fontWeight:
                                                  FontWeight.normal,
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
                                          requestpojo.result.data.elementAt(index)
                                              .profilePic == null||requestpojo.result
                                              .data.elementAt(index)
                                              .profilePic==""?
                                          Container(
                                              height: SizeConfig.blockSizeVertical * 12,
                                              width: SizeConfig.blockSizeVertical * 12,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical * 1,
                                                  bottom: SizeConfig.blockSizeVertical * 1,
                                                  right: SizeConfig.blockSizeHorizontal * 1,
                                                  left: SizeConfig
                                                      .blockSizeHorizontal *
                                                      2),
                                              decoration: BoxDecoration(
                                                image: new DecorationImage(
                                                  image: new AssetImage("assets/images/account_circle.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          )
                                              :Container(
                                            height: SizeConfig
                                                .blockSizeVertical * 14,
                                            width: SizeConfig
                                                .blockSizeVertical *
                                                12,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(
                                                SizeConfig
                                                    .blockSizeVertical *
                                                    3),
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                    .blockSizeVertical *
                                                    1,
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
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image:
                                                  NetworkImage(
                                                      Network
                                                          .BaseApiprofile + requestpojo.result
                                                          .data
                                                          .elementAt(
                                                          index)
                                                          .profilePic
                                                  ),
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: SizeConfig.blockSizeHorizontal * 45,
                                                    alignment:
                                                    Alignment.topLeft,
                                                    padding:
                                                    EdgeInsets.only(
                                                      left: SizeConfig
                                                          .blockSizeHorizontal *
                                                          1,
                                                    ),
                                                    child: Text(
                                                      requestpojo.result.data
                                                          .elementAt(
                                                          index)
                                                          .fullName,
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      callNext(
                                                          viewdetail_sendreceivegift(
                                                              data:  requestpojo.result.data.elementAt(index).id.toString()
                                                          ),
                                                          context);
                                                    },
                                                    child: Container(
                                                      alignment: Alignment
                                                          .topLeft,
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
                                                        "View Details",
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color:
                                                            AppColors
                                                                .green,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    70,
                                                alignment:
                                                Alignment.topLeft,
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
                                                  requestpojo.result.data
                                                      .elementAt(index)
                                                      .message,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:
                                                      Colors.black87,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                    Alignment.topLeft,
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
                                                          letterSpacing:
                                                          1.0,
                                                          color: Colors
                                                              .black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .normal,
                                                          fontFamily:
                                                          'Poppins-Regular'),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    padding: EdgeInsets.only(
                                                        right: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3,
                                                        top: SizeConfig
                                                            .blockSizeHorizontal *
                                                            2),
                                                    child: Text(
                                                      "\$" +
                                                          requestpojo.result
                                                              .data
                                                              .elementAt(
                                                              index)
                                                              .price
                                                              .toString(),
                                                      style: TextStyle(
                                                          letterSpacing:
                                                          1.0,
                                                          color: Colors
                                                              .lightBlueAccent,
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
                                              /*  Row(
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
                                            ),*/
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {

                                },
                              )
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
                  ) : Center(
                    child: Image.asset("assets/images/empty.png",
                        height: SizeConfig.blockSizeVertical * 50,
                        width: SizeConfig.blockSizeVertical * 50),
                  ),
                )
              ],
            )),
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
                onTap: () {
                  //getdata(userid, "request");
                  print('FIRST CHILD');
                }),
            SpeedDialChild(
                child: Icon(Icons.people_rounded),
                backgroundColor: AppColors.theme1color,
                label: 'Pool',
                onTap: () {
                  // getdata(userid, "pool");
                  print('SEcond CHILD');
                }),
            SpeedDialChild(
                child: Icon(Icons.send),
                backgroundColor: AppColors.theme1color,
                label: 'Send',
                onTap: () {
                  //  getdata(userid, "send");
                  print('Third CHILD');
                }),
          ],
        )
    );
  }

  /*void getdata(String user_id) async {
    Map data = {
      'user_id': user_id.toString(),
    };
    print("usr: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.individualgiftlist, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        setState(() {
          resultvalue = false;
        });
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        sendindividual = new sendindividualHistory.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            resultvalue = true;
            print("SSSS");
            storelist_length = sendindividual.data;
          });
        } else {
          Fluttertoast.showToast(
            msg: sendindividual.message,
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
  }*/

  void getdata(String user_id) async {
    setState(()
    {
      storelist_length=null;
    });
    Map data = {
      'user_id': user_id.toString(),
    };
    print("usr: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.send_receive_gifts_history, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        setState((){
          resultvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        requestpojo = new history_sendpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(requestpojo.result.data.isEmpty)
              {

                  resultvalue = false;

              }
            else
              {
                resultvalue = true;
                print("SSSS");
                storelist_length = requestpojo.result.data;
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
}
