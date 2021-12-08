import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/request_sendpojo.dart';
import 'package:kontribute/Ui/createpostgift.dart';
import 'package:kontribute/Ui/sendrequestgift/EditCreatepool.dart';
import 'package:kontribute/Ui/sendrequestgift/EditRequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/EditSendIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/MyForm.dart';
import 'package:kontribute/Ui/sendrequestgift/SearchbarSendreceived.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class OngoingSendReceived extends StatefulWidget {
  @override
  OngoingSendReceivedState createState() => OngoingSendReceivedState();
}

class OngoingSendReceivedState extends State<OngoingSendReceived>
    with TickerProviderStateMixin {
  Offset _tapDownPosition;
  bool _dialVisible = true;
  String userid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  var storelist_length;

  // String receivefrom ="all";
  String receivefrom = "all";

//  String tabValue ="all";
  String tabValue = "all";
  request_sendpojo requestpojo;
  String headline;

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid, tabValue);
    });
  }

  void getdata(String user_id, String poolvalue) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'user_id': user_id.toString(),
      'sortby': poolvalue.toString(),
    };
    if (poolvalue.toString() == "request") {
      receivefrom = "request";
    } else if (poolvalue.toString() == "pool") {
      receivefrom = "pool";
    }
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.send_receive_gifts, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        requestpojo = new request_sendpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (requestpojo.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = requestpojo.result.data;
            }
          });
        } else {
          errorDialog(requestpojo.message);
        }
      }
    } else {
     errorDialog(jsonDecode(val)["message"]);
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
                    'ok'.tr,
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


  /*
  void getdata(String user_id, String poolvalue) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'user_id': user_id.toString(),
      'sortby': poolvalue.toString(),
    };

    if (poolvalue.toString() == "request")
    {
      receivefrom = "request";
    } else if (poolvalue.toString() == "pool")
    {
      receivefrom = "pool";
    }
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.send_receive_gifts, body: data);
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
        requestpojo = new request_sendpojo.fromJson(jsonResponse);
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
*/

  _showPopupMenu(int index, String valu) async {
    print("Index: " + index.toString());
    print("VALues: " + valu.toString());
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
                //Navigator.of(context).pop();
                if (valu == "request") {
                  callNext(
                      EditRequestIndividaul(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "pool") {
                  callNext(
                      EditCreatepool(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "send") {
                  callNext(
                      EditSendIndividaul(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                }
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
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: SizeConfig.blockSizeVertical * 8,
          title: Container(
            child: Text(
              'sendandreceivegift'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins-Regular",
                  color: Colors.white),
            ),
          ),
          //Text("heello", textAlign:TextAlign.center,style: TextStyle(color: Colors.black)),
          flexibleSpace: Image(
            height: SizeConfig.blockSizeVertical * 12,
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchbarSendreceived()));
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 4,
                ),
                child: Image.asset(
                  "assets/images/search.png",
                  height: 25,
                  width: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              receivefrom == "all"
                  ? storelist_length != null
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: storelist_length.length == null
                                  ? 0
                                  : storelist_length.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeConfig.blockSizeVertical * 2),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      2),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig.blockSizeHorizontal * 72,
                                                        margin: EdgeInsets.only(
                                                            left: SizeConfig.blockSizeHorizontal * 2),
                                                        child: Text(
                                                          requestpojo.result.data.elementAt(index).status == "request" ? 'requestreceivedfrom'.tr
                                                              : requestpojo.result.data.elementAt(index).status == "sent" ? 'sendto'.tr
                                                                  : requestpojo.result.data.elementAt(index).status == "group" ? 'grouprequest'.tr
                                                                      : "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins-Bold',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                2),
                                                        child: Text(
                                                          requestpojo
                                                              .result.data
                                                              .elementAt(index)
                                                              .postedDate
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins-Regular',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 8),
                                                        ),
                                                      ),

                                                      userid == requestpojo.result.data.elementAt(index).senderId?
                                                      GestureDetector(
                                                        onTapDown:
                                                            (TapDownDetails
                                                                details) {
                                                          _tapDownPosition =
                                                              details
                                                                  .globalPosition;
                                                        },
                                                        onTap: () {
                                                          if (requestpojo
                                                                  .result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .status ==
                                                              "request") {
                                                            _showPopupMenu(
                                                                index,
                                                                "request");
                                                          } else if (requestpojo
                                                                  .result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .status ==
                                                              "group") {
                                                            _showPopupMenu(
                                                                index, "pool");
                                                          }
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
                                                      ): Container()
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Colors.black12,
                                                  ),
                                                  Row(
                                                    children: [
                                                      requestpojo.result.data.elementAt(index).facebookId == null ?
                                                      requestpojo.result.data.elementAt(index).profilePic != null ||
                                                                  requestpojo.result.data.elementAt(index).profilePic != ""
                                                              ? Container(
                                                                  height: SizeConfig.blockSizeVertical * 10,
                                                                  width: SizeConfig.blockSizeVertical * 10,
                                                                  alignment: Alignment.center,
                                                                  margin: EdgeInsets.only(
                                                                      top: SizeConfig.blockSizeVertical * 1,
                                                                      bottom: SizeConfig.blockSizeVertical * 1,
                                                                      right: SizeConfig.blockSizeHorizontal * 1,
                                                                      left: SizeConfig.blockSizeHorizontal * 2),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            Network.BaseApiprofile +
                                                                                requestpojo.result.data.elementAt(index).profilePic,
                                                                          ),
                                                                          fit: BoxFit.fill)),
                                                                )
                                                              : Container(
                                                                  height:
                                                                      SizeConfig.blockSizeVertical *
                                                                          10,
                                                                  width: SizeConfig
                                                                          .blockSizeVertical *
                                                                      10,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  margin: EdgeInsets.only(
                                                                      top: SizeConfig.blockSizeVertical * 1,
                                                                      bottom: SizeConfig.blockSizeVertical * 1,
                                                                      right: SizeConfig.blockSizeHorizontal * 1,
                                                                      left: SizeConfig.blockSizeHorizontal * 2),
                                                                  decoration: BoxDecoration(
                                                                    image:
                                                                        new DecorationImage(
                                                                      image: new AssetImage(
                                                                          "assets/images/account_circle.png"),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ))
                                                          :

                                                      Container(
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  10,
                                                              width: SizeConfig
                                                                      .blockSizeVertical *
                                                                  10,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
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
                                                                      image: NetworkImage(
                                                                        requestpojo
                                                                            .result
                                                                            .data
                                                                            .elementAt(index)
                                                                            .profilePic,
                                                                      ),
                                                                      fit: BoxFit.fill)),
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
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    45,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),
                                                                child: Text(
                                                                  requestpojo.result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .groupName !=
                                                                          null
                                                                      ? requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .groupName
                                                                      : requestpojo.result.data.elementAt(index).fullName !=
                                                                              null
                                                                          ? requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(index)
                                                                              .fullName
                                                                          : "",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          14,
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
                                                                          data: requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .id
                                                                              .toString(),
                                                                          coming:
                                                                              "Ongoing"),
                                                                      context);
                                                                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyForm()));
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        1,
                                                                    right: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        3,
                                                                  ),
                                                                  child: Text(
                                                                    'viewdetails'.tr,
                                                                    style: TextStyle(
                                                                        letterSpacing:
                                                                            1.0,
                                                                        color: AppColors
                                                                            .green,
                                                                        fontSize:
                                                                            12,
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
                                                              requestpojo
                                                                  .result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .message
                                                                  .toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
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
                                                                    Alignment
                                                                        .topLeft,
                                                                padding: EdgeInsets.only(
                                                                    left: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        1,
                                                                    top: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2),
                                                                child: Text(
                                                                  'amount'.tr,
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          'Poppins-Regular'),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding: EdgeInsets.only(
                                                                    right: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        3,
                                                                    top: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2),
                                                                child: Text(
                                                                  requestpojo.result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .price !=
                                                                          null
                                                                      ? "\$" +
                                                                          requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .price
                                                                      : requestpojo.result.data.elementAt(index).minCashByParticipant !=
                                                                              null
                                                                          ? "\$" +
                                                                              requestpojo.result.data.elementAt(index).minCashByParticipant
                                                                          : "",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      fontSize:
                                                                          12,
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
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding: EdgeInsets.only(
                                                                    left: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        1,
                                                                    top: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2),
                                                                child: Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          'Poppins-Regular'),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding: EdgeInsets.only(
                                                                    right: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        3,
                                                                    top: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2),
                                                                child: Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      fontSize:
                                                                          12,
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
                                    )
                                  ],
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
                                  child: Text('norecordsfound'.tr,style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      'Poppins-Regular')),
                                ),
                        )
                  : receivefrom == "request"
                      ? storelist_length != null
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: storelist_length.length == null
                                      ? 0
                                      : storelist_length.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
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
                                                  padding: EdgeInsets.all(5.0),
                                                  margin: EdgeInsets.only(
                                                      bottom: SizeConfig
                                                              .blockSizeVertical *
                                                          2),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                72,
                                                            margin: EdgeInsets.only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2),
                                                            child: Text(
                                                              requestpojo.result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .status ==
                                                                      "request"
                                                                  ? 'requestreceivedfrom'.tr
                                                                  : requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .status ==
                                                                          "sent"
                                                                      ? 'sendto'.tr
                                                                      : requestpojo.result.data.elementAt(index).status ==
                                                                              "group"
                                                                          ? 'grouprequest'.tr
                                                                          : "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Poppins-Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin: EdgeInsets.only(
                                                                right: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2),
                                                            child: Text(
                                                              requestpojo
                                                                  .result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .postedDate
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Poppins-Regular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 8),
                                                            ),
                                                          ),
                                                          userid == requestpojo.result.data.elementAt(index).senderId?
                                                          GestureDetector(
                                                            onTapDown:
                                                                (TapDownDetails
                                                                    details) {
                                                              _tapDownPosition = details.globalPosition;
                                                            },
                                                            onTap: () {
                                                              _showPopupMenu(
                                                                  index,
                                                                  "request");
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
                                                          ):Container()
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      Row(
                                                        children: [
                                                          requestpojo.result.data
                                                                      .elementAt(
                                                                          index)
                                                                      .facebookId ==
                                                                  null
                                                              ? requestpojo.result.data.elementAt(index).profilePic !=
                                                                          null ||
                                                                      requestpojo.result.data.elementAt(index).profilePic !=
                                                                          ""
                                                                  ? Container(
                                                                      height:
                                                                          SizeConfig.blockSizeVertical *
                                                                              10,
                                                                      width:
                                                                          SizeConfig.blockSizeVertical *
                                                                              10,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      margin: EdgeInsets.only(
                                                                          top: SizeConfig.blockSizeVertical *
                                                                              1,
                                                                          bottom: SizeConfig.blockSizeVertical *
                                                                              1,
                                                                          right: SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                          left: SizeConfig.blockSizeHorizontal *
                                                                              2),
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          border: Border.all(
                                                                            width: 1,
                                                                            color: AppColors
                                                                                .themecolor,
                                                                            style: BorderStyle.solid,
                                                                          ),
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(
                                                                                Network.BaseApiprofile + requestpojo.result.data.elementAt(index).profilePic,
                                                                              ),
                                                                              fit: BoxFit.fill)),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          SizeConfig.blockSizeVertical *
                                                                              10,
                                                                      width: SizeConfig.blockSizeVertical *
                                                                          10,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      margin: EdgeInsets.only(
                                                                          top: SizeConfig.blockSizeVertical *
                                                                              1,
                                                                          bottom: SizeConfig.blockSizeVertical *
                                                                              1,
                                                                          right: SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                          left: SizeConfig.blockSizeHorizontal *
                                                                              2),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                            border: Border.all(
                                                                              width: 1,
                                                                              color: AppColors
                                                                                  .themecolor,
                                                                              style: BorderStyle.solid,
                                                                            ),
                                                                        image:
                                                                            new DecorationImage(
                                                                          image:
                                                                              new AssetImage("assets/images/account_circle.png"),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ))
                                                              : Container(
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
                                                                      10,
                                                                  width: SizeConfig
                                                                          .blockSizeVertical *
                                                                      10,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  margin: EdgeInsets.only(
                                                                      top: SizeConfig
                                                                              .blockSizeVertical *
                                                                          1,
                                                                      bottom:
                                                                          SizeConfig.blockSizeVertical *
                                                                              1,
                                                                      right:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                      left: SizeConfig
                                                                              .blockSizeHorizontal *
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
                                                                          image: NetworkImage(
                                                                            requestpojo.result.data.elementAt(index).profilePic,
                                                                          ),
                                                                          fit: BoxFit.fill)),
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
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        45,
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),
                                                                    child: Text(
                                                                      requestpojo.result.data.elementAt(index).fullName,
                                                                      style: TextStyle(
                                                                          letterSpacing: 1.0,
                                                                          color: Colors.black87,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                          'Poppins-Regular'),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      callNext(
                                                                          viewdetail_sendreceivegift(
                                                                              data: requestpojo.result.data.elementAt(index).id.toString(),
                                                                              coming: "Ongoing"),
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                            top : SizeConfig.blockSizeVertical *
                                                                            1,
                                                                            bottom : SizeConfig.blockSizeVertical *
                                                                                1,
                                                                        left: SizeConfig.blockSizeHorizontal *
                                                                            1,
                                                                        right:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                3,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'viewdetails'.tr,
                                                                        style: TextStyle(
                                                                            letterSpacing:
                                                                                1.0,
                                                                            color: AppColors
                                                                                .green,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontFamily: 'Poppins-Regular'),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Container(
                                                                width: SizeConfig.blockSizeHorizontal * 70,
                                                                alignment:
                                                                    Alignment
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
                                                                  requestpojo
                                                                      .result
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .message
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          8,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    padding: EdgeInsets.only(
                                                                        left: SizeConfig.blockSizeHorizontal *
                                                                            1,
                                                                        top: SizeConfig.blockSizeHorizontal *
                                                                            2),
                                                                    child: Text(
                                                                      'amount'.tr,
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1.0,
                                                                          color: Colors
                                                                              .black87,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontFamily:
                                                                              'Poppins-Regular'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                3,
                                                                        top: SizeConfig.blockSizeHorizontal *
                                                                            2),
                                                                    child: Text(
                                                                      "\$" +
                                                                          requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(index)
                                                                              .price,
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1.0,
                                                                          color: Colors
                                                                              .lightBlueAccent,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
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
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    padding: EdgeInsets.only(
                                                                        left: SizeConfig.blockSizeHorizontal *
                                                                            1,
                                                                        top: SizeConfig.blockSizeHorizontal *
                                                                            2),
                                                                    child: Text(
                                                                      "",
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1.0,
                                                                          color: Colors
                                                                              .black87,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontFamily:
                                                                              'Poppins-Regular'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                3,
                                                                        top: SizeConfig.blockSizeHorizontal *
                                                                            2),
                                                                    child: Text(
                                                                      "",
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1.0,
                                                                          color: Colors
                                                                              .lightBlueAccent,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
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
                                        )
                                      ],
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
                                      child: Text('norecordsfound'.tr,style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.normal,
                                          fontFamily:
                                          'Poppins-Regular')),
                                    ),
                            )
                      : Container()
              /* receivefrom == "send"
                  ?storelist_length != null
                  ?
              Expanded(
                child: ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0
                        : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                bottom:
                                SizeConfig.blockSizeVertical * 2),
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
                                        bottom: SizeConfig
                                            .blockSizeVertical *
                                            2),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal * 72,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal * 2),
                                              child: Text(
                                                StringConstant.receivegift,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                    'Poppins-Bold',
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Container(
                                              alignment:
                                              Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: SizeConfig
                                                      .blockSizeHorizontal *
                                                      2),
                                              child: Text(
                                                requestpojo.result.data
                                                    .elementAt(index)
                                                    .postedDate
                                                    .toString(),
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                    Colors.black,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                    fontWeight:
                                                    FontWeight
                                                        .normal,
                                                    fontSize: 8),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTapDown:
                                                  (TapDownDetails
                                              details) {
                                                _tapDownPosition =
                                                    details
                                                        .globalPosition;
                                              },
                                              onTap: () {
                                                _showPopupMenu(index,"send");
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
                                            requestpojo.result.data
                                                .elementAt(
                                                index)
                                                .profilePic ==
                                                null ||
                                                requestpojo.result.data
                                                    .elementAt(
                                                    index)
                                                    .profilePic ==
                                                    ""
                                                ? Container(
                                                height: SizeConfig
                                                    .blockSizeVertical *
                                                    12,
                                                width: SizeConfig
                                                    .blockSizeVertical *
                                                    12,
                                                alignment:
                                                Alignment
                                                    .center,
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
                                                  image: new DecorationImage(
                                                    image: new AssetImage("assets/images/account_circle.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                            )
                                                : Container(
                                              height: SizeConfig
                                                  .blockSizeVertical *
                                                  14,
                                              width: SizeConfig
                                                  .blockSizeVertical *
                                                  12,
                                              alignment:
                                              Alignment
                                                  .center,
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
                                                      image: NetworkImage(
                                                        Network.BaseApiprofile+requestpojo.result.data.elementAt(index).profilePic,
                                                      ),
                                                      fit: BoxFit.fill)),
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
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          45,
                                                      alignment:
                                                      Alignment
                                                          .topLeft,
                                                      padding:
                                                      EdgeInsets
                                                          .only(
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
                                                            fontSize:
                                                            14,
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
                                                                data:  requestpojo.result.data
                                                                    .elementAt(index)
                                                                    .id
                                                                    .toString()
                                                            ),
                                                            context);
                                                      },
                                                      child:
                                                      Container(
                                                        alignment:
                                                        Alignment
                                                            .topLeft,
                                                        padding:
                                                        EdgeInsets
                                                            .only(
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
                                                              color: AppColors
                                                                  .green,
                                                              fontSize:
                                                              12,
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
                                                    requestpojo.result.data
                                                        .elementAt(
                                                        index)
                                                        .message
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.0,
                                                        color: Colors
                                                            .black87,
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
                                                      Alignment
                                                          .topLeft,
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
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .topLeft,
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              3,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      child: Text(
                                                        "\$" +
                                                            requestpojo.result.data
                                                                .elementAt(
                                                                index)
                                                                .price
                                                                .toString(),
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            fontSize:
                                                            12,
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
                                                      alignment:
                                                      Alignment
                                                          .topLeft,
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              1,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: Colors
                                                                .black87,
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .topLeft,
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              3,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            fontSize:
                                                            12,
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
                          )
                        ],
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
              ): Container()*/
            ],
          )),
      /* floatingActionButton: SpeedDial(
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
                tabValue="request";
                getdata(userid, tabValue);
                print('FIRST CHILD');
              }),
          SpeedDialChild(
              child: Icon(Icons.people_rounded),
              backgroundColor: AppColors.theme1color,
              label: 'Pool',
              onTap: () {
                tabValue="pool";
                getdata(userid, tabValue);
                print('SEcond CHILD');
              }),
          SpeedDialChild(
              child: Icon(Icons.all_inclusive),
              backgroundColor: AppColors.theme1color,
              label: 'All',
              onTap: () {
                tabValue="all";
                getdata(userid, tabValue);
                print('Third CHILD');
              }),
        ],
      ),*/
        bottomNavigationBar: bottombar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(left:15.0,right:15.0,bottom: 20.0,top: 15.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  createpostgift()));
                    },
                    child: new Icon(Icons.add_box),
                    backgroundColor: AppColors.themecolor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:45.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SpeedDial(
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
                            child: Icon(Icons.request_page),
                            backgroundColor: AppColors.theme1color,
                            label: 'request'.tr,
                            onTap: () {
                              tabValue="request";
                              getdata(userid, tabValue);
                              print('FIRST CHILD');
                            }),
                        /*      SpeedDialChild(
                            child: Icon(Icons.people_rounded),
                            backgroundColor: AppColors.theme1color,
                            label: 'Pool',
                            onTap: () {
                              tabValue="pool";
                              getdata(userid, tabValue);
                              print('SEcond CHILD');
                            }),*/
                        SpeedDialChild(
                            child: Icon(Icons.all_inclusive),
                            backgroundColor: AppColors.theme1color,
                            label: 'all'.tr,
                            onTap: () {
                              tabValue="all";
                              getdata(userid, tabValue);
                              print('Third CHILD');
                            }),
                      ],
                    ),
                  ),)

              ],
            ))
    );
  }
}
