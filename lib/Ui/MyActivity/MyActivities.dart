import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Pojo/myactivitiesdonationpojo.dart';
import 'package:kontribute/Pojo/myactivitieseventpojo.dart';
import 'package:kontribute/Pojo/myactivitiesgiftpojo.dart';
import 'package:kontribute/Pojo/myactivitiesinvitepojo.dart';
import 'package:kontribute/Pojo/myactivitiesprojectpojo.dart';
import 'package:kontribute/Pojo/myactivitiesticketpojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Ui/Donation/DonationReport.dart';
import 'package:kontribute/Ui/Donation/EditDonationPost.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/Ui/Events/EditEventPost.dart';
import 'package:kontribute/Ui/Events/EventReport.dart';
import 'package:kontribute/Ui/Events/OngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/MyActivity/SearchMyActivities.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/Tickets/EditTicketPost.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/Tickets/TicketReport.dart';
import 'package:kontribute/Ui/sendrequestgift/EditCreatepool.dart';
import 'package:kontribute/Ui/sendrequestgift/EditRequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/EditSendIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';

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
  String textHolder="0";
  int mutliply;
  myactivitiesprojectpojo listing;
  myactivitiesdonationpojo listingdonation;
  myactivitieseventpojo listingevent;
  myactivitiesticketpojo listingticket;
  myactivitiesgiftpojo listinggift;
  myactivitiesinvitepojo listinginvite;
  int amount;
  int amoun;
  String vallike;
  projectlike prolike;
  String tabValue = "gift";
  String receivefrom = "gift";
  String updateval;
  String eventupdateval;
  String ticketupdateval;
  String donationupdateval;
  String giftupdateval;
  String Follow = "Follow";
  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  String onchangeval = "";
  String onchangedonationval = "";
  double totalamount;
  double totaldonationamount;
  double totalticketamount;
  double totalEventamount;
  String valcommision;
  var commisionlist_length;
  commisionpojo commission;
  String _amount;
  String shortsharedlink = '';
  String shortDonationsharedlink = '';
  String shortEventsharedlink = '';
  String shortTicketsharedlink = '';
  String product_id = '';
  bool _dialVisible = true;
  int currentPageValue = 0;
  final GlobalKey<State> _keyLoadergift = new GlobalKey<State>();
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();
  final GlobalKey<State> _keyLoaderevent = new GlobalKey<State>();
  final GlobalKey<State> _keyLoaderdonation = new GlobalKey<State>();
  final GlobalKey<State> _keyLoaderticket = new GlobalKey<State>();
  final _formmainKey = GlobalKey<FormState>();
  final _formmainKeyDonation = GlobalKey<FormState>();
  final _formmainKeyTicket = GlobalKey<FormState>();
  String deletegift;
  String deleteproject;
  String deleteevent;
  String deletedonation;
  String deleteticket;

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

  @override
  Future<void> initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      setState(() {
        userid = val;
        getsortdata(userid,tabValue);
        getCommision();
        print("Login userid: " + userid.toString());
      });
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
    }else if (sortval.toString() == "invitation") {
      receivefrom = "invitation";
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
        errorDialog(jsonDecode(val)["message"]);
      } else {

        if(sortval.toString() == "gift")
          {
            listinggift = new myactivitiesgiftpojo.fromJson(jsonResponse);
            print("Json User" + jsonResponse.toString());
            if (jsonResponse != null) {
              print("response");
              setState(() {
                if (listinggift.result.isEmpty) {
                  resultvalue = false;
                }
                else {
                  resultvalue = true;
                  print("gift");
                  storelist_length = listinggift.result;
                }
              });
            }
            else {
              errorDialog(listinggift.message);
            }
          }
        else if(sortval.toString() == "project")
        {
          listing = new myactivitiesprojectpojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              if (listing.result.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("project");
                storelist_length = listing.result;
              }
            });
          }
          else {
            errorDialog(listing.message);
          }
        }
        else if(sortval.toString() == "donation")
        {
          listingdonation = new myactivitiesdonationpojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              if (listingdonation.result.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("donation");
                storelist_length = listingdonation.result;
              }
            });
          }
          else {
            errorDialog(listingdonation.message);
          }
        }
        else if(sortval.toString() == "event")
        {
          listingevent = new myactivitieseventpojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              if (listingevent.result.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("event");
                storelist_length = listingevent.result;
              }
            });
          }
          else {
            errorDialog(listingevent.message);
          }
        }
        else if(sortval.toString() == "ticket")
        {
          listingticket = new myactivitiesticketpojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              if (listingticket.result.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("ticket");
                storelist_length = listingticket.result;
              }
            });
          }
          else {
            errorDialog(listingticket.message);
          }
        }
        else if(sortval.toString() == "invitation")
        {
          listinginvite = new myactivitiesinvitepojo.fromJson(jsonResponse);
          print("Json User" + jsonResponse.toString());
          if (jsonResponse != null) {
            print("response");
            setState(() {
              if (listinginvite.result.isEmpty) {
                resultvalue = false;
              }
              else {
                resultvalue = true;
                print("project");
                storelist_length = listinginvite.result;
              }
            });
          }
          else {
            errorDialog(listinginvite.message);
          }
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

  void deleteTicketDialog(String id) {
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
        deleteTicket(id);
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

  void deleteEventDialog(String id) {
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
        deleteEvent(id);
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

  void deleteDonationDialog(String id) {
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
        deleteDonation(id);
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

  void deleteProjectDialog(String id) {
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

  void deleteGiftDialog(String id) {
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
        deleteGift(id);
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

  Future<void> deleteGift(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoadergift);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.giftdelete, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deletegift = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(deletegift)["message"]);

      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            getsortdata(userid, "gift");
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deletegift)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(deletegift)["message"]);
    }
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
            getsortdata(userid, "project");
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

  Future<void> deleteDonation(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoaderdonation);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.donationdelete, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deletedonation = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(deletedonation)["message"]);

      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            getsortdata(userid, "donation");
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deletedonation)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(deletedonation)["message"]);
    }
  }

  Future<void> deleteEvent(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoaderevent);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.eventdelete, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deleteevent = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(deleteevent)["message"]);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            getsortdata(userid, "event");
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deleteevent)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(deleteevent)["message"]);
    }
  }

  Future<void> deleteTicket(String id) async {
    Dialogs.showLoadingDialog(context, _keyLoaderticket);
    Map data = {
      'id': id.toString(),
      'user_id': userid.toString(),
    };
    print("ID: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticketdelete, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      deleteticket = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(deleteticket)["message"]);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          print(" if Item Deleted Successfully");
          setState(() {
            getsortdata(userid, "ticket");
          });
        } else {
          print("if Item is not Deleted Successfully");
          Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(deleteticket)["message"]);
          setState(() {
            resultvalue = false;
            //getData();
          });
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(deleteticket)["message"]);
    }
  }

  _showGiftPopupMenu(int index, String valu) async {
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
                          data: listinggift.result
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "pool") {
                  callNext(
                      EditCreatepool(
                          data: listinggift.result
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "send") {
                  callNext(
                      EditSendIndividaul(
                          data: listinggift.result
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
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  deleteGiftDialog(listinggift.result.elementAt(index).id.toString());
                });
                // Navigator.of(context).pop();
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

  _showProjectEditPopupMenu(int index) async {
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
                  print("Copy: "+listing.result.elementAt(index).id.toString());
                  _createDynamicLink(listing.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();

              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr, style: TextStyle(fontSize: 14),)
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
                        data: listing.result.elementAt(index)
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
                  Text('edit'.tr, style: TextStyle(fontSize: 14),)
                ],
              ),
            )),

        PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {

                  deleteProjectDialog(listing.result
                      .elementAt(index)
                      .id
                      .toString()
                  );
                });
               // Navigator.of(context).pop();
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
  _showProjectPopupMenu(int index) async {
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
                  print("Copy: "+listing.result.elementAt(index).id.toString());
                  _createDynamicLink(listing.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();

              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr, style: TextStyle(fontSize: 14),)
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
                        data: listing.result.elementAt(index)
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
                  Text('report'.tr, style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  _showDonationEditPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingdonation.result.elementAt(index).id.toString());
                  _createDonationDynamicLink(listingdonation.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
        PopupMenuItem(
            value: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    EditDonationPost(
                        data: listingdonation.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text('edit'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )
        ),

        PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  deleteDonationDialog(listingdonation.result
                      .elementAt(index)
                      .id
                      .toString()
                  );
                });
                Navigator.of(context).pop();
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
  _showDonationPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingdonation.result.elementAt(index).id.toString());
                  _createDonationDynamicLink(listingdonation.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),

        PopupMenuItem(
            value:2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    DonationReport(
                        data: listingdonation.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text('report'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }


  _showEventEditPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingevent.result.elementAt(index).id.toString());
                  _createEventDynamicLink(listingevent.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
        PopupMenuItem(
            value: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    EditEventPost(
                        data: listingevent.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text('edit'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),

        PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  deleteEventDialog(listingevent.result.elementAt(index).id.toString());
                });
               // Navigator.of(context).pop();
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
  _showEventPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingevent.result.elementAt(index).id.toString());
                  _createEventDynamicLink(listingevent.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),

        PopupMenuItem(
            value:2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                callNext(
                    EventReport(
                        data: listingevent.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text('report'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  _showTicketEditPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingticket.result.elementAt(index).id.toString());
                  _createTicketDynamicLink(listingticket.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
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
                        data: listingticket.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text('edit'.tr,style: TextStyle(fontSize: 14),)
                ],
              ),
            )),
        PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  deleteTicketDialog(listingticket.result.elementAt(index).id.toString());
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
  _showTicketPopupMenu(int index) async {
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
                setState(() {
                  print("Copy: "+listingticket.result.elementAt(index).id.toString());
                  _createTicketDynamicLink(listingticket.result.elementAt(index).id.toString());
                });
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.content_copy),
                  ),
                  Text('sharevia'.tr,style: TextStyle(fontSize: 14),)
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
                        data: listingticket.result.elementAt(index).id.toString()
                    ), context);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.report),
                  ),
                  Text('report'.tr,style: TextStyle(fontSize: 14),)
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
        backgroundColor: AppColors.shadow,
        toolbarHeight: SizeConfig.blockSizeVertical *12,
        title: Container(
          child: Text(
            'myActivity'.tr,
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
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMyActivities()));
            },
            child: Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*4,),
              child:Image.asset("assets/images/search.png",height: 25,width: 25,color: Colors.white,) ,
            ),
          ),
        ],
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 12,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),

      ),
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            children: [

              receivefrom == "project"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0 : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listing.result
                          .elementAt(index)
                          .projectImages;
                      commentlist_length = listing.result
                          .elementAt(index)
                          .comments;
                      double amount = double.parse(listing.result
                          .elementAt(index)
                          .totalcollectedamount.toString()) /
                          double.parse(listing.result
                              .elementAt(index)
                              .budget) * 100;
                      amoun = amount.toInt();
                      reverid = listing.result
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
                                       listing.result.elementAt(index).userId == userid ? _showProjectEditPopupMenu(index) : _showProjectPopupMenu(index);
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
                                      listing.result
                                          .elementAt(index)
                                          .profilePic == null ||
                                          listing.result
                                              .elementAt(index)
                                              .profilePic == "" ?
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                          callNext(
                                              viewdetail_profile(
                                                  data: listing.result
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
                                                top: SizeConfig.blockSizeVertical * 2,
                                                bottom: SizeConfig.blockSizeVertical * 1,
                                                right: SizeConfig.blockSizeHorizontal * 1,
                                                left: SizeConfig.blockSizeHorizontal * 1),
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
                                          :
                                      GestureDetector(
                                        onTap: () {
                                          callNext(
                                              viewdetail_profile(
                                                  data: listing.result
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
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors
                                                    .themecolor,
                                                style: BorderStyle.solid,
                                              ),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      listing.result
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
                                                              .result
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
                                                    listing.result
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
                                              listing.result
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
                                                  listing
                                                      .result
                                                      .elementAt(index).status.toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.purple,
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                              listing.result
                                                  .elementAt(index)
                                                  .userId
                                                  .toString() != userid ?
                                              listing.result
                                                  .elementAt(index)
                                                  .status == "pending" ?
                                              GestureDetector(
                                                onTap: () {

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
                                                            Container(height: SizeConfig.blockSizeVertical *9,
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
                                                                        AmountController.text ="";
                                                                      });
                                                                    },
                                                                  );
                                                                  Widget continueButton = FlatButton(
                                                                    child: Text('continue'.tr),
                                                                    onPressed: () async {
                                                                      if (_formmainKey.currentState.validate())
                                                                        {
                                                                          Payamount(
                                                                              listing.result
                                                                                  .elementAt(index)
                                                                                  .id,
                                                                              AmountController.text,
                                                                              totalamount,
                                                                              userid);
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

                                                                                      if(onchangeval == listing.result.elementAt(index).requiredAmount.toString())
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

                                                                                      print("PrintSring: "+totalamount.toString());
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
                                                                                  child: Row(
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
                                                                    builder: (
                                                                        BuildContext context) {
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
                                                   'pay'.tr,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold,
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
                                                  listing.result
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
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                                      "- " +
                                                          listing.result
                                                              .elementAt(index)
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
                                                )

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
                                                      fontSize: 9,
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
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                                      "- " +
                                                          listing.result
                                                              .elementAt(index)
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
                                                )
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
                                                    " \$"+listing.result
                                                        .elementAt(index)
                                                        .budget,
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
                                            top: SizeConfig.blockSizeVertical *
                                                1),
                                        child: LinearPercentIndicator(
                                          width: 60.0,
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
                                                    " \$"+listing.result
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
                                  imageslist_length != null ?
                                  GestureDetector(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                                      callNext(
                                          OngoingProjectDetailsscreen(
                                              data: listing.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                                                  .result
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
                                              data: listing.result
                                                  .elementAt(index)
                                                  .id
                                                  .toString(), coming:"myactivity"
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
                                      data: listing.result.elementAt(index).description,
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
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              ):
              receivefrom == "donation"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null
                        ? 0
                        : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listingdonation.result.elementAt(index).projectImages;
                      commentlist_length = listingdonation.result.elementAt(index).comments;
                      double amount = listingdonation.result.elementAt(index).totalcollectedamount.toDouble() /
                          double.parse(listingdonation.result.elementAt(index).budget) * 100;
                      amoun =amount.toInt();
                      reverid = listingdonation.result.elementAt(index).userId.toString();
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
                                    listingdonation.result.elementAt(index).userId==userid? _showDonationEditPopupMenu(index):
                                    _showDonationPopupMenu(index);
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
                                    listingdonation.result.elementAt(index).profilePic== null ||
                                        listingdonation.result.elementAt(index).profilePic == "" ?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            viewdetail_profile(
                                                data: listingdonation.result.elementAt(index).userId.toString()
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
                                                data: listingdonation.result.elementAt(index).userId.toString()
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
                                                    listingdonation.result.elementAt(index).profilePic),
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
                                                        data: listingdonation.result.elementAt(index).userId.toString()
                                                    ), context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                width: SizeConfig.blockSizeHorizontal *31,
                                                padding: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                ),
                                                child: Text(
                                                  listingdonation.result.elementAt(index).fullName,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.themecolor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ) ,
                                            ),

                                            listingdonation.result.elementAt(index).userId.toString()==userid?
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
                                                      FontWeight.bold,
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
                                                listingdonation.result.elementAt(index).status.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color:AppColors.purple,
                                                    fontSize:8,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    'Poppins-Regular'),
                                              ),
                                            ),
                                            listingdonation.result.elementAt(index).userId.toString()!=userid?
                                            listingdonation.result.elementAt(index).status=="pending"?
                                            GestureDetector(
                                              onTap: ()
                                              {
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
                                                          Container(height: SizeConfig.blockSizeVertical *9,
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
                                                                      AmountController.text ="";
                                                                    });
                                                                  },
                                                                );
                                                                Widget continueButton = FlatButton(
                                                                  child: Text('continue'.tr),
                                                                  onPressed: () async {
                                                                    if (_formmainKeyDonation.currentState.validate()){
                                                                      setState(() {
                                                                        PayDonationamount(listingdonation.result.elementAt(index).id,
                                                                            AmountController.text,
                                                                            totaldonationamount,
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
                                                                          key: _formmainKeyDonation,
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
                                                                                    onchangedonationval = text;

                                                                                    if(onchangedonationval == listingdonation.result.elementAt(index).requiredAmount.toString())
                                                                                    {
                                                                                      double tectString = double.parse(onchangedonationval)*(commission.commisiondata.senderCommision/100);
                                                                                      totaldonationamount = double.parse(onchangedonationval) + tectString;
                                                                                      print("PrintUpdated: "+totaldonationamount.toString());
                                                                                      print("PrintActual: "+onchangedonationval.toString());
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                      double tectString = double.parse(onchangedonationval)*(commission.commisiondata.senderCommision/100);
                                                                                      totaldonationamount = double.parse(onchangedonationval) - tectString;
                                                                                      print("PrintUpdated: "+totaldonationamount.toString());
                                                                                      print("PrintActual: "+onchangedonationval.toString());
                                                                                    }

                                                                                  });
                                                                                  print("value_1 : "+onchangedonationval);
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
                                                                                child: Row(
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
                                                                  textAlign:TextAlign.center,
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
                                                  'pay'.tr,
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
                                                listingdonation.result.elementAt(index).campaignName,
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
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                 children: [
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
                                                     " - "+listingdonation.result.elementAt(index).campaignStartdate,
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

                                                 ],
                                              )

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
                                                    fontSize:9,
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
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
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
                                                    " - "+listingdonation.result.elementAt(index).campaignEnddate,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *36,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
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
                                                "  \$"+listingdonation.result.elementAt(index).budget,
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
                                      alignment: Alignment.center,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *36,
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                              .blockSizeHorizontal *
                                             4),
                                          child:
                                          Row(
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
                                                  "  \$"+listingdonation.result.elementAt(index).totalcollectedamount.toString(),
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
                                imageslist_length!=null?
                                GestureDetector(
                                  onTap: () {

                                    callNext(
                                        OngoingCampaignDetailsscreen(
                                            data:
                                            listingdonation.result.elementAt(index).id.toString(),
                                          coming:"myactivity"
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
                                                            listingdonation.result.elementAt(index).projectImages.elementAt(ind).imagePath,
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
                                            listingdonation.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                    data: listingdonation.result.elementAt(index).description,
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
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              )
                  :receivefrom == "gift"?
              storelist_length != null ?
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
                                                listinggift.result
                                                    .elementAt(
                                                    index)
                                                    .status ==
                                                    "request"
                                                    ? 'sendarequest'.tr
                                                    : listinggift
                                                    .result
                                                    .elementAt(
                                                    index)
                                                    .status ==
                                                    "sent"
                                                    ? 'sendto'.tr
                                                    : listinggift
                                                    .result
                                                    .elementAt(index)
                                                    .status ==
                                                    "group"
                                                    ? 'grouprequest'.tr
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
                                                listinggift
                                                    .result
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
                                            listinggift
                                                .result
                                                .elementAt(
                                                index)
                                                .status ==
                                                "sent"?Container():
                                            userid == listinggift.result.elementAt(index).senderId.toString()?
                                            GestureDetector(
                                              onTapDown:
                                                  (TapDownDetails
                                              details) {
                                                _tapDownPosition =
                                                    details
                                                        .globalPosition;
                                              },
                                              onTap: () {
                                                if (listinggift
                                                    .result
                                                    .elementAt(
                                                    index)
                                                    .status ==
                                                    "request") {
                                                  _showGiftPopupMenu(
                                                      index,
                                                      "request");
                                                } else if (listinggift
                                                    .result
                                                    .elementAt(
                                                    index)
                                                    .status ==
                                                    "group") {
                                                  _showGiftPopupMenu(
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
                                            ):
                                                Container()
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black12,
                                        ),
                                        Row(
                                          children: [
                                            listinggift.result
                                                .elementAt(
                                                index)
                                                .facebookId ==
                                                null
                                                ?
                                            listinggift.result
                                                .elementAt(
                                                index)
                                                .profilePic !=
                                                null ||
                                                listinggift
                                                    .result
                                                    .elementAt(
                                                    index)
                                                    .profilePic !=
                                                    ""
                                                ? Container(
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
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        Network.BaseApiprofile +
                                                            listinggift.result.elementAt(index).profilePic,
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
                                                        listinggift
                                                            .result
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
                                                  listinggift.result.elementAt(index).fullName !=
                                                            null
                                                            ? listinggift
                                                            .result
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
                                                                data: listinggift
                                                                    .result
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
                                                    listinggift
                                                        .result
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
                                                        fontSize: 9,
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
                                                        listinggift.result
                                                            .elementAt(
                                                            index)
                                                            .price !=
                                                            null
                                                            ? "  \$" +
                                                            listinggift
                                                                .result
                                                                .elementAt(
                                                                index)
                                                                .price
                                                            : listinggift.result.elementAt(index).minCashByParticipant !=
                                                            null
                                                            ? "  \$" +
                                                            listinggift.result.elementAt(index).minCashByParticipant
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
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              ):
              receivefrom == "event"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null ? 0 : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listingevent.result.elementAt(index).projectImages;
                      commentlist_length = listingevent.result.elementAt(index).comments;
                      double amount = listingevent.result.elementAt(index).totalcollectedamount.toDouble() /
                          double.parse(listingevent.result.elementAt(index).totalslotamount.toString()) * 100;

                      amoun =amount.toInt();
                      return Container(
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
                                    listingevent.result.elementAt(index).userId==userid? _showEventEditPopupMenu(index):
                                    _showEventPopupMenu(index);
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
                                    listingevent.result.elementAt(index).profilePic== null ||
                                        listingevent.result.elementAt(index).profilePic == "" ?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            viewdetail_profile(
                                                data: listingevent.result.elementAt(index).userId.toString()
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
                                                data: listingevent.result.elementAt(index).userId.toString()
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
                                                    listingevent.result.elementAt(index).profilePic),
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
                                                        data: listingevent.result.elementAt(index).userId.toString()
                                                    ), context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                width: SizeConfig.blockSizeHorizontal *35,
                                                padding: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                ),
                                                child: Text(
                                                  listingevent.result.elementAt(index).fullName,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.themecolor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ) ,
                                            ),
                                            /* GestureDetector(
                                                  onTap: ()
                                                  {
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.blockSizeHorizontal*1),
                                                    padding: EdgeInsets.only(
                                                      top: SizeConfig.blockSizeVertical *2,
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
                                            Container(
                                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3, top: SizeConfig.blockSizeVertical *2,),

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
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: AppColors.purple)
                                              ),
                                              child: Text(
                                                listingevent.result.elementAt(index).status.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color:AppColors.purple,
                                                    fontSize:8,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    'Poppins-Regular'),
                                              ),
                                            ),
                                            listingevent.result.elementAt(index).userId.toString()!=userid?
                                            listingevent.result.elementAt(index).status=="pending"?
                                            GestureDetector(
                                              onTap: ()
                                              {
                                                double tectString = double.parse(listingevent.result.elementAt(index).entryFee)*(commission.commisiondata.senderCommision/100);
                                                totalEventamount = double.parse(listingevent.result.elementAt(index).entryFee) + tectString;
                                                print("PrintSring: "+totalEventamount.toString());
                                                print("PrintSringpers: "+tectString.toString());

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
                                                          child:
                                                          new Container(
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
                                                                Container(height: SizeConfig.blockSizeVertical *9,
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
                                                                        onPressed: ()
                                                                        {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      );
                                                                      Widget continueButton = FlatButton(
                                                                        child: Text('continue'.tr),
                                                                        onPressed: () async {
                                                                          PayEventamount( listingevent.result.elementAt(index).id,listingevent.result.elementAt(index).entryFee, totalEventamount.toString(),userid);
                                                                        },
                                                                      );
                                                                      // set up the AlertDialog
                                                                      AlertDialog alert = AlertDialog(
                                                                        title: Text('paynow'.tr,textAlign: TextAlign.center,),
                                                                        // content: Text("Are you sure you want to Pay this project?"),
                                                                        content:
                                                                        Container(
                                                                          width: SizeConfig.blockSizeHorizontal * 80,
                                                                          height: SizeConfig.blockSizeVertical *15,
                                                                          child:
                                                                          new Column(
                                                                            children: [
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  new Text('eventeentryfees'.tr,
                                                                                      style: TextStyle(
                                                                                          letterSpacing: 1.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontFamily: 'Poppins-Regular',
                                                                                          fontSize: 14,
                                                                                          color: Colors.black)),

                                                                                  new Text(" \$"+listingevent.result.elementAt(index).entryFee,
                                                                                      style: TextStyle(
                                                                                          letterSpacing: 1.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontFamily: 'Poppins-Regular',
                                                                                          fontSize: 14,
                                                                                          color: Colors.black))

                                                                                ],
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
                                                                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text('totalpayfees'.tr,
                                                                                        style: TextStyle(
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontFamily: 'Poppins-Regular',
                                                                                            fontSize: 14,
                                                                                            color: Colors.black)),
                                                                                    Text(" \$"+totalEventamount.toString(),
                                                                                        style: TextStyle(
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontFamily: 'Poppins-Regular',
                                                                                            fontSize: 14,
                                                                                            color: Colors.black)),
                                                                                  ],
                                                                                )

                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        actions:
                                                                        [
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
                                                                        textAlign:TextAlign.center,
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
                                                      warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"SearchEvent", context);
                                                    }
                                                  }else{
                                                    print("falseValue");
                                                    warningDialog('pleasereadthetermsandconditionscarefullybeforepaying'.tr,"SearchEvent", context);
                                                  }
                                                });




                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left:
                                                    SizeConfig.blockSizeHorizontal *2,
                                                    right: SizeConfig.blockSizeHorizontal *2,
                                                    top: SizeConfig.blockSizeVertical *2),
                                                padding: EdgeInsets.only(
                                                    right: SizeConfig.blockSizeHorizontal * 4,
                                                    left: SizeConfig.blockSizeHorizontal * 4,
                                                    bottom: SizeConfig.blockSizeHorizontal * 1,
                                                    top: SizeConfig.blockSizeHorizontal * 1),
                                                decoration: BoxDecoration(
                                                  color: AppColors.darkgreen,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'pay'.tr,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.whiteColor,
                                                      fontSize:12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ),
                                            ): Container()
                                                : Container()
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal *36,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Text(
                                                listingevent.result.elementAt(index).eventName,
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
                                                right: SizeConfig.blockSizeHorizontal * 2,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'startdate'.tr,
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.black,
                                                          fontSize:8,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Poppins-Regular'),
                                                    ),
                                                    Text(
                                                      " - "+listingevent.result.elementAt(index).eventStartdate,
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.black,
                                                          fontSize:8,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Poppins-Regular'),
                                                    ),
                                                  ],
                                              )

                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal *36,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                              child:
                                              Text(
                                                "",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black87,
                                                    fontSize:8,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins-Regular'),
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal *38,
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.only(
                                                left: SizeConfig.blockSizeHorizontal * 1,
                                                right: SizeConfig.blockSizeHorizontal * 2,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'enddate'.tr,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.black,
                                                        fontSize:8,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily: 'Poppins-Regular'),
                                                  ),
                                                  Text(
                                                    " - "+listingevent.result.elementAt(index).eventEnddate,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.black,
                                                        fontSize:8,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily: 'Poppins-Regular'),
                                                  ),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *35,
                                          alignment: Alignment.topLeft,
                                          margin:
                                          EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *1,
                                              left: SizeConfig.blockSizeHorizontal * 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'soldslots'.tr,
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
                                                "  \$"+listingevent.result.elementAt(index).totalslotamount.toString(),
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
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: SizeConfig.blockSizeHorizontal *37,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                              right: SizeConfig.blockSizeHorizontal * 3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'remainingslots'.tr,
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
                                                "  \$"+listingevent.result.elementAt(index).balanceslot.toString(),
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.lightBlueAccent,
                                                    fontSize: 9,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    'Poppins-Regular'),
                                              ),
                                            ],
                                          )


                                        ),

                                      ],)
                                  ],
                                ),
                                imageslist_length!=null?
                                GestureDetector(
                                  onTap: () {
                                    callNext(
                                        OngoingEventsDetailsscreen(
                                            data:
                                            listingevent.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                          imageslist_length.length == null ? 0 : imageslist_length.length,
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
                                                        listingevent.result.elementAt(index).eventPath +
                                                            listingevent.result.elementAt(index).projectImages.elementAt(ind).imagePath,
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
                                        OngoingEventsDetailsscreen
                                          (
                                            data: listingevent.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                /*  Container(
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){},
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
                                          ),
                                        ],
                                      ),
                                    ),*/
                                Container(
                                  width: SizeConfig.blockSizeHorizontal *100,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                      top: SizeConfig.blockSizeVertical *1,bottom: SizeConfig.blockSizeVertical *1),
                                  child: new Html(
                                    data: listingevent.result.elementAt(index).description,
                                    defaultTextStyle: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular'),

                                  ),
                                ),
                                /*  GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingEventsDetailsscreen()));
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
                                              fontSize: 9,
                                              fontWeight:
                                              FontWeight.bold,
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
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.bold,
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
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.bold,
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
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.bold,
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
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              ):
              receivefrom == "ticket"?
              storelist_length != null ?
              Expanded(
                child:
                ListView.builder(
                    itemCount: storelist_length.length == null ? 0 : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listingticket.result.elementAt(index).ticketImages;
                      commentlist_length = listingticket.result.elementAt(index).comments;
                      double amount = listingticket.result.elementAt(index).ticketsold.toDouble() /
                          double.parse(listingticket.result.elementAt(index).maximumQtySold) * 100;
                      amoun =amount.toInt();
                      reverid = listingticket.result.elementAt(index).userId.toString();
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
                                    listingticket.result.elementAt(index).userId.toString()!=userid?
                                    listingticket.result.elementAt(index).status=="pending"?
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
                                                                    if (_formmainKeyTicket.currentState.validate()){

                                                                      PayTicketamount(
                                                                          listingticket.result.elementAt(index).id,
                                                                          mutliply.toString(),
                                                                          totalticketamount.toString(),
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
                                                                                Text(" \$"+listingticket.result.elementAt(index).ticketCost.toString(),style: TextStyle(
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
                                                                          key:_formmainKeyTicket,
                                                                          child: new TextFormField(
                                                                            autofocus: false,
                                                                            focusNode: AmountFocus,
                                                                            controller: AmountController,
                                                                            onChanged: (text) {
                                                                              setState(() {
                                                                                onchangeval = text;
                                                                                mutliply = int.parse(listingticket.result.elementAt(index).ticketCost) * int.parse(onchangeval);
                                                                                print("Multi: "+mutliply.toString());
                                                                                double tectString = double.parse(mutliply.toString())*(commission.commisiondata.senderCommision/100);
                                                                                totalticketamount = double.parse(mutliply.toString()) + tectString;
                                                                                setState(() {
                                                                                  textHolder = totalticketamount.toString();
                                                                                });
                                                                                //  UpdateText(totalamount.toString());
                                                                                print("PrintSring: "+totalticketamount.toString());
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
                                    ): Container(): Container(),
                                    GestureDetector(
                                      onTapDown: (TapDownDetails details){
                                        _tapDownPosition = details.globalPosition;
                                      },
                                      onTap: ()
                                      {
                                        listingticket.result.elementAt(index).userId==userid? _showTicketEditPopupMenu(index):
                                        _showTicketPopupMenu(index);
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
                                    listingticket.result.elementAt(index).profilePic== null ||
                                        listingticket.result.elementAt(index).profilePic == "" ?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            viewdetail_profile(
                                                data: listingticket.result.elementAt(index).userId.toString()
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
                                                data: listingticket.result.elementAt(index).userId.toString()
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
                                                    listingticket.result.elementAt(index).profilePic),
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
                                                callNext(viewdetail_profile(data: listingticket.result.elementAt(index).userId.toString()), context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                width: SizeConfig.blockSizeHorizontal *37,
                                                padding: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                ),
                                                child: Text(
                                                  listingticket.result.elementAt(index).fullName,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.themecolor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ) ,
                                            ),
                                            listingticket.result.elementAt(index).userId.toString()==userid?
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
                                                      FontWeight.bold,
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
                                              width: SizeConfig.blockSizeHorizontal *36,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child: Text(
                                                listingticket.result.elementAt(index).ticketName,
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
                                                    2,
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
                                                    " - "+listingticket.result.elementAt(index).ticketStartdate,
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
                                              width: SizeConfig.blockSizeHorizontal *36,
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
                                                    fontSize:9,
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
                                                   2,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *1,
                                              ),
                                              child:  Row(
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
                                                      " - "+listingticket.result.elementAt(index).ticketEnddate,
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
                                        left: SizeConfig.blockSizeHorizontal * 2),
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
                                            " - "+ listingticket.result.elementAt(index).maximumQtySold.toString(),
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

                                    Container(
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                      child:  LinearPercentIndicator(
                                        width: 60.0,
                                        lineHeight: 14.0,
                                        percent: amoun/100,
                                        center: Text(amoun.toString()+"%",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: AppColors.whiteColor),),
                                        backgroundColor: AppColors.lightgrey,
                                        progressColor:AppColors.themecolor,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: SizeConfig.blockSizeHorizontal *36,
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                          .blockSizeHorizontal *
                                          4),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'availabletickets'.tr,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                          Text(
                                            " - "+ listingticket.result.elementAt(index).balanceQtySlot.toString(),
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
                                                fontSize: 9,
                                                fontWeight:
                                                FontWeight.bold,
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
                                            listingticket.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                                            listingticket.result.elementAt(index).ticketImages.elementAt(ind).imagePath,
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
                                        TicketOngoingEventsDetailsscreen(
                                            data:
                                            listingticket.result.elementAt(index).id.toString(),
                                            coming:"myactivity"
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
                                    data: listingticket.result.elementAt(index).description,
                                    defaultTextStyle: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular'),

                                  ),
                                ),

                                Container(
                                  width: SizeConfig.blockSizeHorizontal *100,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                      top: SizeConfig.blockSizeVertical *1),
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
                                        " - "+listingticket.result.elementAt(index).totalcontributor.toString(),
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
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1, left: SizeConfig.blockSizeHorizontal *3),
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
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                              .blockSizeHorizontal *
                                              1),
                                          alignment: Alignment.topLeft,

                                          child: Text(
                                            "  \$"+listingticket.result.elementAt(index).ticketCost.toString(),
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
                                )
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
                  child: Text('norecordsfound'.tr,style: TextStyle(
                      letterSpacing: 1.0,
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              ):
              receivefrom == "invitation"?
              storelist_length != null ?
              Expanded(
                child: ListView.builder(
                    itemCount: storelist_length.length == null ? 0 : storelist_length.length,
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
                                                'invitation'.tr,
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
                                                listinginvite
                                                    .result
                                                    .elementAt(index)
                                                    .receiverEndDate
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


                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black12,
                                        ),
                                        Row(
                                          children: [
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
                                                          80,
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              1,
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              3,
                                                        ),
                                                      alignment:
                                                      Alignment
                                                          .topLeft,
                                                      child: Text(
                                                        listinginvite.result.elementAt(index).receiverName !=
                                                            null
                                                            ? listinginvite
                                                            .result
                                                            .elementAt(index)
                                                            .receiverName
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
                                                  /*  GestureDetector(
                                                      onTap: () {
                                                        callNext(
                                                            viewdetail_sendreceivegift(
                                                                data: listinggift
                                                                    .result
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
                                                    )*/
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
                                                    listinginvite
                                                        .result
                                                        .elementAt(
                                                        index)
                                                        .receiverMessage
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.0,
                                                        color: Colors
                                                            .black87,
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight
                                                            .normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),


                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width:SizeConfig.blockSizeHorizontal * 50,
                                                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *1),
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
                                                          listinginvite.result.elementAt(index).receiverMobile != null
                                                              ?
                                                          listinginvite.result.elementAt(index).receiverMobile
                                                              : "",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                              1.0,
                                                              color: Colors
                                                                  .black,
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
                                                        width:SizeConfig.blockSizeHorizontal * 42,
                                                        alignment: Alignment.topRight,
                                                        padding: EdgeInsets.only(

                                                            top: SizeConfig.blockSizeHorizontal * 2),
                                                        child:  Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              'amount'.tr,
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                  1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  fontFamily:
                                                                  'Poppins-Regular'),
                                                            ),
                                                            Text(
                                                              listinginvite.result.elementAt(index).receiverRequestPrice !=
                                                                  null
                                                                  ? " \$" +
                                                                  listinginvite.result.elementAt(index).receiverRequestPrice.toString()
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
                                                          ],
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
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Regular')),
                ),
              ):
                  Container()
            ],
          )
      ),
      bottomNavigationBar: bottombar(context),
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
              child: Icon(Icons.phone_android),
              backgroundColor: AppColors.theme1color,
              label: 'phonebookinvitation'.tr,
              onTap: () {
                tabValue = "invitation";
                getsortdata(userid, tabValue);
                print('sixth CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.margin),
              backgroundColor: AppColors.theme1color,
              label: 'tickets'.tr,
              onTap: () {
                tabValue = "ticket";
                getsortdata(userid, tabValue);
                print('Fiveth CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.event),
              backgroundColor: AppColors.theme1color,
              label: 'events'.tr,
              onTap: () {
                tabValue = "event";
                getsortdata(userid, tabValue);
                print('Fourth CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.whatshot),
              backgroundColor: AppColors.theme1color,
              label: 'donations'.tr,
              onTap: () {
                tabValue = "donation";
                getsortdata(userid, tabValue);
                print('Third CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.request_page),
              backgroundColor: AppColors.theme1color,
              label: 'projectfunding'.tr,
              onTap: () {
                tabValue = "project";
                getsortdata(userid, tabValue);
                print('Second CHILD');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.wallet_giftcard),
              backgroundColor: AppColors.theme1color,
              label: 'sendandreceivegift'.tr,
              onTap: () {
                tabValue = "gift";
                getsortdata(userid, tabValue);
                print('FIRST CHILD');
              }),
        ],
      ),
    );
  }


  Future<void> PayTicketamount(String id,String cost, String requiredAmount,String qtyval, String userid) async {
   Dialogs.showLoadingDialog(context, _keyLoaderticket);
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
      ticketupdateval = response.body; //store response as string
      if (jsonResponse["status"] == false)
      {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(ticketupdateval)["message"]);
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
                    data: jsonDecode(ticketupdateval)["data"]["id"].toString(),
                    amount:totalticketamount.toString(),
                    coming:"tkt",
                    backto:"MyActivity"
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
                        jsonDecode(ticketupdateval)["message"],
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
                                builder: (BuildContext context) => MyActivities()));
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
          errorDialog(jsonDecode(ticketupdateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
          errorDialog(jsonDecode(ticketupdateval)["message"]);
    }
  }

  Future<void> Payamount(String id, String requiredAmount,double updatedAmount,  String userid) async {
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
    http.Response response = await http.post(Network.BaseApi + Network.project_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(updateval)["message"]);
      }
      else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          AmountController.text =null;
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: jsonDecode(updateval)["data"]["id"].toString(),
                    amount:commisionamount.toString(),
                    coming:"pjt",
                    backto:"MyActivity"
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
                                builder: (BuildContext context) => MyActivities()));
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

  Future<void> PayEventamount(String id, String fees,String requiredAmount, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoaderevent);
    Map data = {
      'userid': userid.toString(),
      'event_id': id.toString(),
      'amount': fees.toString(),
      'updated_amount': requiredAmount.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.event_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      eventupdateval = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(eventupdateval)["message"]);
      }
      else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: jsonDecode(eventupdateval)["data"]["id"].toString(),
                    amount:totalEventamount.toString(),
                    coming:"evt",
                    backto:"MyActivity"
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
                        jsonDecode(eventupdateval)["message"],
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
                                builder: (BuildContext context) => MyActivities()));
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
          errorDialog(jsonDecode(eventupdateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(eventupdateval)["message"]);

    }
  }

  Future<void> PayDonationamount(String id, String requiredAmount,double updatedAmount, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoaderdonation);

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
      'donation_id': id.toString(),
      'amount': originalamount.toString(),
      'updated_amount': commisionamount.toString(),
    };

    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.donation_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      donationupdateval = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(donationupdateval)["message"]);

      }
      else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: jsonDecode(donationupdateval)["data"]["id"].toString(),
                    amount:commisionamount.toString(),
                    coming:"dnt",
                    backto:"MyActivity"
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
                        jsonDecode(donationupdateval)["message"],
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
                                builder: (BuildContext context) => MyActivities()));
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
          errorDialog(jsonDecode(donationupdateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(donationupdateval)["message"]);
    }
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
        errorDialog(jsonDecode(vallike)["message"]);
      } else {
        prolike = new projectlike.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          getsortdata(userid,tabValue);
        } else {
          errorDialog(prolike.message);
        }
      }
    } else {
      errorDialog(jsonDecode(vallike)["message"]);
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
      giftupdateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(giftupdateval);
      } else {
        if (jsonResponse != null) {
          showToast(giftupdateval);
          setState(() {
            Follow = "";
          });
        } else {
          showToast(giftupdateval);
        }
      }
    } else {
      showToast(giftupdateval);
    }
  }

  void showToast(String updateval) {
    errorDialog(jsonDecode(updateval)["message"]);
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
 Future<void> _createEventDynamicLink(String productid) async {
    print("Product: "+productid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://kontri.page.link',
        link: Uri.parse(Network.sharelinevent + productid),
        androidParameters: AndroidParameters(
          packageName: 'com.kont.kontribute',
          minimumVersion: 1,
        )
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    shortEventsharedlink = shortUrl.toString();
    print("Shorturl2:-" + shortUrl.toString());
    shareeventlink();
  }

  void shareeventlink() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(shortEventsharedlink,
        subject: "Kontribute",
        sharePositionOrigin:
        box.localToGlobal(Offset.zero) &
        box.size);
  }

  Future<void> _createTicketDynamicLink(String productid) async {
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
    shortTicketsharedlink = shortUrl.toString();
    print("Shorturl2:-" + shortUrl.toString());
    shareticketlink();
  }

  void shareticketlink() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(shortTicketsharedlink,
        subject: "Kontribute",
        sharePositionOrigin:
        box.localToGlobal(Offset.zero) &
        box.size);
  }

  Future<void> _createDonationDynamicLink(String productid) async {
    print("Product: "+productid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://kont.page.link',
        link: Uri.parse(Network.sharelindonation + productid),
        androidParameters: AndroidParameters(
          packageName: 'com.kont.kontribute',
          minimumVersion: 1,
        )
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    shortDonationsharedlink = shortUrl.toString();
    print("Shorturl2:-" + shortUrl.toString());
    shareDonationproductlink();
  }

  void shareDonationproductlink() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(shortDonationsharedlink,
        subject: "Donation",
        sharePositionOrigin:
        box.localToGlobal(Offset.zero) &
        box.size);
  }

}
