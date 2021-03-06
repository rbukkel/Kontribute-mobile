import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Terms.dart';
import 'package:kontribute/Ui/ProjectFunding/CreateProjectPost.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Ui/ProjectFunding/SearchbarProject.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';

class OngoingProject extends StatefulWidget {
  @override
  OngoingProjectState createState() => OngoingProjectState();
}

class OngoingProjectState extends State<OngoingProject> {
  Offset _tapDownPosition;
  String userid;
  int counter;
  String reverid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  String image;
  String valcommision;
  var storelist_length;
  var commisionlist_length;
  var imageslist_length;
  var commentlist_length;
  projectlisting listing;
  int amount;
  int amoun;
  String vallike;
  projectlike prolike;
  String tabValue = "1";
  String updateval;
  String Follow = "Follow";
  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  static ScrollController _scrollController;
  final AmountFocus = FocusNode();
  String onchangeval = "";
  double totalamount;
  final TextEditingController AmountController = new TextEditingController();
  String _amount;
  String shortsharedlink = '';
  String product_id = '';
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();
  String deleteproject;
  final _formmainKey = GlobalKey<FormState>();
  commisionpojo commission;

  //double percent=(prod_old_price - prod_price)/prod_old_price*100;

  //double.tryParse(data[numberdata].toString())*(5/100).toString()

  void function() {
    print("scrolling");
  }

  @override
  Future<void> initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(function);
    _loadID();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _loadID() async {
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      setState(() {
        userid = val;
        print("PAge: " + pageNumber.toString());
        getdata(userid, pageNumber);
        print("Login userid: " + userid.toString());
        paginationApi();
        getCommision();
      });
    });
  }

  /*  super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          _future = getData(page,userid);
        });
      }
    });
  }*/

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


  void paginationApi() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        setState(() {
          if (pageNumber < listing.lastPage) {
            pageNumber += 1;
            getdata(userid, pageNumber);
          }
        });
      }
      if (_scrollController.offset <= _scrollController.position.minScrollExtent && !_scrollController.position.outOfRange) {
        setState(() {
          if (pageNumber >= 1) {
            pageNumber = pageNumber - 1;
            print('ggggggg' + pageNumber.toString());
            if (pageNumber < listing.lastPage) {
              getSUBdata(userid, pageNumber);
            }
          } else {
            getSUBdata(userid, pageNumber);
            print("Last page");
          }
        });
      }
    });
  }


  void errorDialog(String text) {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.whiteColor,
        child: new Container(
          color: AppColors.whiteColor,
          margin: EdgeInsets.all(5),
          width: 320.0,
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top:10, left: 10, right: 10),
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
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10,top: 20,),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  child: Text(
                    'okay'.tr,
                    style: TextStyle(
                        fontSize: 16.0,
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

  void getSUBdata(String user_id, int page) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    print("Sub link: " +
        Network.BaseApi +
        Network.projectListing +
        "?page=$page");
    http.Response response = await http.post(
        Network.BaseApi + Network.projectListing + "?page=$page",
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        listing = new projectlisting.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.projectData.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.projectData;
            }
          });
        } else {

          errorDialog(listing.message);

        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
  }

  void getdata(String user_id, int page) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'userid': user_id.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    print("Add link: " +
        Network.BaseApi +
        Network.projectListing +
        "?page=$page");
    http.Response response = await http.post(
        Network.BaseApi + Network.projectListing + "?page=$page",
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        listing = new projectlisting.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.projectData.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.projectData;
            }
          });
        } else {
          errorDialog(listing.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }
  }

  void getsortdata(String user_id, String sortval) async {
    setState(() {
      storelist_length = null;
    });
    Map data = {
      'userid': user_id.toString(),
      'sortby': sortval.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.projectListing, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        listing = new projectlisting.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.projectData.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.projectData;
            }
          });
        } else {
          errorDialog(listing.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }
  }

  _showEditPopupMenu(int index) async {
    print("INDEX: " + index.toString());
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
                  print("Copy: " +listing.projectData.elementAt(index).id.toString());
                  _createDynamicLink(
                      listing.projectData.elementAt(index).id.toString());
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
                        data:
                            listing.projectData.elementAt(index).id.toString()),
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
                  deleteDialog(listing.projectData.elementAt(index).id.toString());
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


  Future<void> deleteProject(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectdelete, body: data);
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
            getdata(userid, pageNumber);
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deleteproject)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
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


  _showPopupMenu(int index) async {
    print("INDEX: " + index.toString());
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
                  print("Copy: " +
                      listing.projectData.elementAt(index).id.toString());
                  _createDynamicLink(
                      listing.projectData.elementAt(index).id.toString());
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
                        data:
                            listing.projectData.elementAt(index).id.toString()),
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

  bool _dialVisible = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: SizeConfig.blockSizeVertical * 12,
          title: Container(
            child: Text(
              'projectfunding'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins-Regular",
                  color: Colors.white),
            ),
          ),
          //Text("heello", textAlign:TextAlign.center,style: TextStyle(color: Colors.black)),
          flexibleSpace: Image(
            height: SizeConfig.blockSizeVertical * 15,
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchbarProject()));
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
            color: AppColors.shadow,
            child: Column(
              children: [
                storelist_length != null
                    ? Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: storelist_length.length == null
                                ? 0
                                : storelist_length.length,
                            itemBuilder: (BuildContext context, int index) {
                              imageslist_length = listing.projectData.elementAt(index).projectImages;
                              commentlist_length = listing.projectData.elementAt(index).comments;
                              double amount = double.parse(listing.projectData.elementAt(index).totalcollectedamount.toString()) /
                                  double.parse(listing.projectData.elementAt(index).budget.toString()) * 100;
                              amoun = amount.toInt();
                              reverid = listing.projectData
                                  .elementAt(index)
                                  .userId
                                  .toString();
                              if (!listing.projectData.elementAt(index).profilePic.startsWith("https://"))
                                {
                                  image=Network.BaseApiprofile+listing.projectData.elementAt(index).profilePic;

                                }
                              else
                                {
                                  image=listing.projectData.elementAt(index).profilePic;
                                }

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
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.only(
                                        bottom:
                                            SizeConfig.blockSizeVertical * 2,
                                        top: SizeConfig.blockSizeVertical * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTapDown: (TapDownDetails details) {
                                            _tapDownPosition =
                                                details.globalPosition;
                                          },
                                          onTap: () {
                                            setState(() {
                                              print(
                                                  "index: " + index.toString());
                                              listing.projectData
                                                          .elementAt(index)
                                                          .userId.toString() ==
                                                      userid
                                                  ? _showEditPopupMenu(index)
                                                  : _showPopupMenu(index);
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2),
                                            child: Image.asset(
                                                "assets/images/menudot.png",
                                                height: 15,
                                                width: 20),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            listing.projectData.elementAt(index).profilePic == null ||
                                                    listing.projectData
                                                            .elementAt(index)
                                                            .profilePic ==
                                                        ""
                                                ?
                                            GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                      callNext(
                                                          viewdetail_profile(
                                                              data: listing
                                                                  .projectData
                                                                  .elementAt(
                                                                      index)
                                                                  .userId
                                                                  .toString()),
                                                          context);
                                                    },
                                                    child: Container(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            9,
                                                        width: SizeConfig
                                                                .blockSizeVertical *
                                                            9,
                                                        alignment:
                                                            Alignment.center,
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
                                                                1),
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
                                                              data: listing
                                                                  .projectData
                                                                  .elementAt(
                                                                      index)
                                                                  .userId
                                                                  .toString()),
                                                          context);
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          9,
                                                      width: SizeConfig
                                                              .blockSizeVertical *
                                                          9,
                                                      alignment:
                                                          Alignment.center,
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
                                                              1),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        callNext(
                                                            viewdetail_profile(
                                                                data: listing
                                                                    .projectData
                                                                    .elementAt(
                                                                        index)
                                                                    .userId
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
                                                            31,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: SizeConfig
                                                                  .blockSizeVertical *
                                                              1,
                                                        ),
                                                        child: Text(
                                                          listing.projectData
                                                              .elementAt(index)
                                                              .fullName,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              color: AppColors
                                                                  .themecolor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Poppins-Regular'),
                                                        ),
                                                      ),
                                                    ),
                                                    listing.projectData
                                                                .elementAt(
                                                                    index)
                                                                .userId
                                                                .toString() ==
                                                            userid
                                                        ? Container()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              followapi(userid,
                                                                  reverid);
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.only(
                                                                  top: SizeConfig
                                                                          .blockSizeVertical *
                                                                      2,
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: SizeConfig
                                                                        .blockSizeVertical *
                                                                    1,
                                                              ),
                                                              child: Text(
                                                                Follow,
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                        1.0,
                                                                    color: AppColors
                                                                        .darkgreen,
                                                                    fontSize: 9,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                      alignment:
                                                          Alignment.topRight,
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
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .purple)),
                                                      child: Text(
                                                        listing.projectData.elementAt(index).status.toUpperCase(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color: AppColors
                                                                .purple,
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontFamily:
                                                                'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    listing.projectData.elementAt(index).userId.toString() != userid
                                                        ? listing.projectData
                                                                    .elementAt(
                                                                        index)
                                                                    .status == "pending"? GestureDetector(
                                                                onTap: () {

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
                                                                                        Widget
                                                                                        cancelButton =
                                                                                        FlatButton(
                                                                                          child: Text('cancel'.tr),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                            setState(() {
                                                                                              AmountController.text ="";
                                                                                            });
                                                                                          },
                                                                                        );
                                                                                        Widget continueButton =
                                                                                        FlatButton(
                                                                                          child: Text('continue'.tr),
                                                                                          onPressed: () async {
                                                                                            if (_formmainKey.currentState.validate()){
                                                                                              setState(() {

                                                                                                Payamount(
                                                                                                    listing
                                                                                                        .projectData
                                                                                                        .elementAt(index)
                                                                                                        .id.toString(),
                                                                                                    AmountController.text,
                                                                                                    totalamount,
                                                                                                    userid);
                                                                                              });
                                                                                            }
                                                                                          },
                                                                                        );
                                                                                        // set up the AlertDialog
                                                                                        AlertDialog alert = AlertDialog(
                                                                                          title: Text('paynow'.tr),
                                                                                          // content: Text("Are you sure you want to Pay this project?"),
                                                                                          content:
                                                                                          new Container(
                                                                                              width: SizeConfig.blockSizeHorizontal * 80,
                                                                                              height: SizeConfig.blockSizeVertical *15,
                                                                                           child:
                                                                                           new Form(
                                                                                                    key: _formmainKey,
                                                                                                    child:
                                                                                                        Column(
                                                                                                          children: [
                                                                                                            TextFormField(
                                                                                                              autofocus:
                                                                                                              false,
                                                                                                              focusNode:
                                                                                                              AmountFocus,
                                                                                                              controller:
                                                                                                              AmountController,
                                                                                                              textInputAction:
                                                                                                              TextInputAction.next,
                                                                                                              keyboardType:
                                                                                                              TextInputType.number,
                                                                                                              onChanged: (text) {
                                                                                                                setState(() {
                                                                                                                  onchangeval = text;
                                                                                                                  if(onchangeval == listing.projectData.elementAt(index).requiredAmount.toString())
                                                                                                                    {
                                                                                                                      double tectString = double.parse(onchangeval)*(commission.commisiondata.senderCommision/100);
                                                                                                                      totalamount = double.parse(onchangeval) + tectString;
                                                                                                                      print("PrintUpdated: "+totalamount.toString());
                                                                                                                      print("PrintActual: "+onchangeval.toString());
                                                                                                                    }
                                                                                                                  else
                                                                                                                    {
                                                                                                                      double tectString = double.parse(onchangeval)*(commission.commisiondata.senderCommision/100);
                                                                                                                      totalamount = double.parse(onchangeval) - tectString;
                                                                                                                      print("PrintUpdated: "+totalamount.toString());
                                                                                                                      print("PrintActual: "+onchangeval.toString());
                                                                                                                    }

                                                                                                                });
                                                                                                                print("value_1 : "+onchangeval);
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
                                                                                                              onSaved: (val) =>
                                                                                                              _amount = val,
                                                                                                              textAlign: TextAlign.left,
                                                                                                              style: TextStyle(
                                                                                                                  letterSpacing: 1.0,
                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                  fontFamily: 'Poppins-Regular',
                                                                                                                  fontSize: 12,
                                                                                                                  color: Colors.black),
                                                                                                              decoration:
                                                                                                              InputDecoration(
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
                                                                                                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                                              alignment: Alignment.centerLeft,
                                                                                                              child:Row(
                                                                                                                children: [
                                                                                                                  Text('extracharges'.tr,
                                                                                                                    style: TextStyle(
                                                                                                                        letterSpacing: 1.0,
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontFamily: 'Poppins-Regular',
                                                                                                                        fontSize: 10,
                                                                                                                        color: Colors.black),
                                                                                                                  ),
                                                                                                                  Text(" "+commission.commisiondata.senderCommision.toString()+"%",
                                                                                                                    style: TextStyle(
                                                                                                                        letterSpacing: 1.0,
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontFamily: 'Poppins-Regular',
                                                                                                                        fontSize: 10,
                                                                                                                        color: Colors.black),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              )
                                                                                                            )

                                                                                                          ],
                                                                                                        )

                                                                                                  )


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
                                                                                      });
                                                                                    },
                                                                                    child:
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: SizeConfig.blockSizeVertical * 5,
                                                                                      margin: EdgeInsets.only(
                                                                                          top: SizeConfig.blockSizeVertical * 3,
                                                                                          bottom: SizeConfig.blockSizeVertical * 2,
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
                                                                        warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Project", context);
                                                                      }
                                                                    }else{
                                                                      print("falseValue");
                                                                      warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"Project", context);
                                                                    }
                                                                  });

                                                                },
                                                                child:
                                                                    Container(margin: EdgeInsets.only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                      right:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              2,
                                                                      top: SizeConfig
                                                                              .blockSizeVertical *
                                                                          2),
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              3,
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              3,
                                                                      bottom:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                      top: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          1),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .darkgreen,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  child: Text(
                                                                    'pay'.tr,
                                                                    style: TextStyle(
                                                                        letterSpacing:
                                                                            1.0,
                                                                        color: AppColors
                                                                            .whiteColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          35,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                      ),
                                                      child: Text(
                                                        listing.projectData
                                                            .elementAt(index)
                                                            .projectName,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig.blockSizeHorizontal * 38,
                                                      alignment: Alignment.topRight,
                                                      padding: EdgeInsets.only(
                                                        left: SizeConfig.blockSizeHorizontal * 1,
                                                        right: SizeConfig.blockSizeHorizontal * 1,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical * 1,
                                                      ),
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            'startdate'.tr,
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color:
                                                                AppColors.black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Poppins-Regular'),
                                                          ),
                                                          Text(" "+
                                                            listing.projectData
                                                                    .elementAt(
                                                                    index)
                                                                    .projectStartdate,
                                                            textAlign:
                                                            TextAlign.right,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color:
                                                                AppColors.black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Poppins-Regular'),
                                                          )
                                                        ],
                                                      )
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          35,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                      ),
                                                      child: Text(
                                                        //StringConstant.totalContribution+"-20",
                                                        "",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 9,
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
                                                          38,
                                                      alignment:
                                                          Alignment.topRight,
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
                                                                .blockSizeVertical *
                                                            1,
                                                      ),
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                           'enddate'.tr,
                                                            textAlign:
                                                            TextAlign.right,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color:
                                                                AppColors.black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Poppins-Regular'),
                                                          ),
                                                          Text(" "+listing.projectData
                                                                    .elementAt(
                                                                    index)
                                                                    .projectEnddate,
                                                            textAlign:
                                                            TextAlign.right,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color:
                                                                AppColors.black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Poppins-Regular'),
                                                          )
                                                        ],
                                                      )

                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: SizeConfig.blockSizeHorizontal *36,
                                                    alignment: Alignment.topLeft,
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical *1,
                                                        left: SizeConfig.blockSizeHorizontal * 1),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'collectiontarget'.tr,
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
                                                          " \$"+listing.projectData
                                                              .elementAt(index)
                                                              .budget.toString(),
                                                          style: TextStyle(
                                                              letterSpacing: 1.0,
                                                              color: Colors.lightBlueAccent,
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                    width: SizeConfig.blockSizeHorizontal *36,
                                                    alignment: Alignment.centerRight,
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical *1,
                                                        right: SizeConfig.blockSizeHorizontal * 4),
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'collectedamount'.tr,
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
                                                          " \$"+listing.projectData
                                                              .elementAt(index)
                                                              .totalcollectedamount
                                                              .toString(),
                                                          style: TextStyle(
                                                              letterSpacing: 1.0,
                                                              color: Colors.lightBlueAccent,
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
                                            )
                                          ],
                                        ),
                                        /* Container(
                                      height: SizeConfig.blockSizeVertical*30,
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                      child: Image.asset("assets/images/banner5.png",fit: BoxFit.fitHeight,),
                                    ),*/
                                        imageslist_length != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                                  callNext(
                                                      OngoingProjectDetailsscreen(
                                                          data: listing
                                                              .projectData
                                                              .elementAt(index)
                                                              .id
                                                              .toString(),
                                                          coming: "project"),
                                                      context);
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          2),
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      30,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomCenter,
                                                    children: <Widget>[
                                                      PageView.builder(
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemCount: imageslist_length
                                                                    .length ==
                                                                null
                                                            ? 0
                                                            : imageslist_length
                                                                .length,
                                                        onPageChanged:
                                                            (int page) {
                                                          getChangedPageAndMoveBar(
                                                              page);
                                                        },
                                                        controller: PageController(
                                                            initialPage:
                                                                currentPageValue,
                                                            keepPage: true,
                                                            viewportFraction:
                                                                1),
                                                        itemBuilder:
                                                            (context, ind) {
                                                          return Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                80,
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                50,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .transparent),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          Network.BaseApiProject +
                                                                              listing.projectData.elementAt(index).projectImages.elementAt(ind).imagePath,
                                                                        ),
                                                                        fit: BoxFit.scaleDown)),
                                                          );
                                                        },
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .bottomCenter,
                                                        children: <Widget>[
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                for (int i = 0;
                                                                    i <
                                                                        imageslist_length
                                                                            .length;
                                                                    i++)
                                                                  if (i ==
                                                                      currentPageValue) ...[
                                                                    circleBar(
                                                                        true)
                                                                  ] else
                                                                    circleBar(
                                                                        false),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                                  callNext(
                                                      OngoingProjectDetailsscreen(
                                                          data: listing
                                                              .projectData
                                                              .elementAt(index)
                                                              .id
                                                              .toString(),
                                                          coming: "project"),
                                                      context);
                                                },
                                                child: Container(
                                                  color: AppColors.themecolor,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .blockSizeVertical *
                                                          2),
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      30,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomCenter,
                                                    children: <Widget>[
                                                      PageView.builder(
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemCount:
                                                            introWidgetsList
                                                                .length,
                                                        onPageChanged:
                                                            (int page) {
                                                          getChangedPageAndMoveBar(
                                                              page);
                                                        },
                                                        controller: PageController(
                                                            initialPage:
                                                                currentPageValue,
                                                            keepPage: true,
                                                            viewportFraction:
                                                                1),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return introWidgetsList[
                                                              index];
                                                        },
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .bottomCenter,
                                                        children: <Widget>[
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                for (int i = 0;
                                                                    i <
                                                                        introWidgetsList
                                                                            .length;
                                                                    i++)
                                                                  if (i ==
                                                                      currentPageValue) ...[
                                                                    circleBar(
                                                                        true)
                                                                  ] else
                                                                    circleBar(
                                                                        false),
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  100,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1),
                                          child: new Html(
                                            data: listing.projectData
                                                .elementAt(index)
                                                .description,
                                            defaultTextStyle: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 12,
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
                    :
                Container(
                        margin: EdgeInsets.only(top: 180),
                        alignment: Alignment.center,
                        child: resultvalue == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Text('norecordsfound'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular'),
                              ),
                      ))
              ],
            )),
       // bottomNavigationBar: bottombar(context,counter!=null?counter:0),
        bottomNavigationBar: bottombar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(left:15.0,right:15.0,bottom: 30.0,top: 15.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      SharedUtils.readTerms("Terms").then((result){
                        if(result!=null){
                          if(result){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateProjectPost()));
                          }else{
                            print("falseValue");
                            warningDialog('pleasereadthetermsandconditionscarefullybeforecreatepost'.tr,"Project", context);
                          }
                        }else{
                          print("falseValue");
                          warningDialog('pleasereadthetermsandconditionscarefullybeforecreatepost'.tr,"Project", context);
                        }
                      });

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
                        child: Icon(Icons.public),
                        backgroundColor: AppColors.theme1color,
                        label: 'public'.tr,
                        onTap: () {
                          tabValue = "1";
                          getsortdata(userid, tabValue);
                          print('FIRST CHILD');
                        }),
                    SpeedDialChild(
                        child: Icon(Icons.privacy_tip),
                        backgroundColor: AppColors.theme1color,
                        label: 'private'.tr,
                        onTap: () {
                          tabValue = "2";
                          getsortdata(userid, tabValue);
                          print('FIRST CHILD');
                        }),
                    SpeedDialChild(
                        child: Icon(Icons.all_inclusive),
                        backgroundColor: AppColors.theme1color,
                        label: 'all'.tr,
                        onTap: () {
                          tabValue = "0";
                          getsortdata(userid, tabValue);
                          print('Third CHILD');
                        }),
                  ],
                ),
              ),)

              ],
            ))

        /*    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            CreateProjectPost()));
                  },
                  child: new Icon(Icons.add_box),
                  backgroundColor: AppColors.themecolor,
                ),
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
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
                              child: Icon(Icons.public),
                              backgroundColor: AppColors.theme1color,
                              label: 'Public',
                              onTap: () {
                                tabValue = "1";
                                getsortdata(userid, tabValue);
                                print('FIRST CHILD');
                              }
                          ),
                          SpeedDialChild(
                              child: Icon(Icons.privacy_tip),
                              backgroundColor: AppColors.theme1color,
                              label: 'Private',
                              onTap: () {
                                tabValue = "2";
                                getsortdata(userid, tabValue);
                                print('FIRST CHILD');
                              }
                          ),
                          SpeedDialChild(
                              child: Icon(Icons.all_inclusive),
                              backgroundColor: AppColors.theme1color,
                              label: 'All',
                              onTap: () {
                                tabValue = "0";
                                getsortdata(userid, tabValue);
                                print('Third CHILD');
                              }),
                        ],
                      )
                  ))

            ],
          ),*/

        );
  }

  Future<void> addlike(String id) async {
    Map data = {
      'userid': userid.toString(),
      'project_id': id.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.projectlikes, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      vallike = response.body; //store response as string
      if (jsonDecode(vallike)["success"] == false) {
        errorDialog(jsonDecode(jsonDecode(vallike)["message"]));
      } else {
        prolike = new projectlike.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          getdata(userid, pageNumber);
        } else {
          errorDialog(prolike.message);

        }
      }
    } else {
      errorDialog(jsonDecode(jsonDecode(vallike)["message"]));
    }
  }

  Future<void> Payamount(String id, String requiredAmount,double updatedAmount, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
    double actualamount = double.parse(requiredAmount);
    double originalamount;
    double commisionamount;

    if(actualamount < updatedAmount)
      {
        originalamount = actualamount;
        commisionamount = updatedAmount;
      }
    else
      {
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
          AmountController.text ="";
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                  data: jsonDecode(updateval)["data"]["id"].toString(),
                  amount:commisionamount.toString(),
                  coming:"pjt",
                  backto:"Project"
                ), context);
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
    errorDialog(jsonDecode(updateval)["message"]);
  }

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
        subject: "Project",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }


}
