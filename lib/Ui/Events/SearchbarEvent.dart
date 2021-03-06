import 'dart:convert';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/EventOngoingPojo.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Pojo/searchsendreceivedpojo.dart';
import 'package:kontribute/Ui/Events/OngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';
import 'package:kontribute/Ui/Events/EditEventPost.dart';
import 'package:kontribute/Ui/Events/EventReport.dart';
import 'package:share/share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SearchbarEvent extends StatefulWidget {

  @override
  SearchbarEventState createState() => SearchbarEventState();
}

class SearchbarEventState extends State<SearchbarEvent> {
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  String shortsharedlink = '';
  Offset _tapDownPosition;
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  bool search = true;
  bool internet = false;
  String val;
  String userid;
  final GlobalKey<State> _keyLoaderproject = new GlobalKey<State>();
  String deleteproject;
  var storelist_length;
  var imageslist_length;
  var commentlist_length;
  bool resultvalue = true;
  String searchvalue = "";
  searchsendreceivedpojo searchpojo;
  List<searchsendreceivedpojo> searchproductListing = new List<searchsendreceivedpojo>();
  EventOngoingPojo listing;
  String onchangeval = "";
  double totalamount;
  String vallike;
  String image;
  String activeLanguage;
  bool shiftEnabledProjectname = false;
  bool showkeyboardProjectname = false;
  bool isNumericMode = false;
  String text = '';
  projectlike prolike;
  int amoun;
  String radioVal="1";
  String radioLang="1";
  String updateval;
  int currentPageValue = 0;
  var commisionlist_length;
  String valcommision;
  commisionpojo commission;
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

  SearchbarSendreceivedState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  _modalBottomSheetMenu() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(00.0),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 300, //could change this to Color(0xFF737373),
                child: Column(
                  children: [
                    showkeyboardProjectname == true
                        ? Container(
                      color: Colors.white54,
                      child: VirtualKeyboard(
                          height: 250,
                          textColor: Colors.black,
                          textController: _searchQuery,

                          defaultLayouts: [
                            // VirtualKeyboardDefaultLayouts.English,
                            VirtualKeyboardDefaultLayouts.Arabic
                          ],
                          //reverseLayout :true,
                          type: isNumericMode
                              ? VirtualKeyboardType.Numeric
                              : VirtualKeyboardType.Alphanumeric,
                          onKeyPress: _onKeyPress),
                    )
                        : Container(),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 20,
                        margin: EdgeInsets.only(
                            right: SizeConfig
                                .blockSizeHorizontal *
                                3),
                        alignment: Alignment.center,
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
                            color: AppColors
                                .whiteColor,
                            borderRadius:
                            BorderRadius
                                .circular(20),
                            border: Border.all(
                                color: AppColors
                                    .black)),
                        child: Text(
                          "Done",
                          textAlign:
                          TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color:
                              AppColors.black,
                              fontSize: 9,
                              fontWeight:
                              FontWeight.bold,
                              fontFamily:
                              'Poppins-Regular'),
                        ),
                      ),
                    )
                  ],
                ));
          });
        });
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


  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      getdata(userid,"");
      getCommision();
      print("Login userid: " + userid.toString());
    });

    SharedUtils.readLangaunage("Langauge").then((val) {
      if (val == null || val == "") {
        activeLanguage = "English";
        print("Login : " + activeLanguage.toString());
      } else {
        activeLanguage = val;
        print("Login Langauge: " + activeLanguage.toString());
      }
    });
    _IsSearching = false;
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


  void getdata(String user_id,String search) async {
    setState(() {
      storelist_length =null;
    });
    Map data = {
      'userid': user_id.toString(),
      'search': search.toString(),
    };
    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.eventListing, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          storelist_length =null;
          resultvalue = false;
        });

      } else {
        listing = new EventOngoingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          setState(() {
            if(listing.projectData.isEmpty)
            {
              setState(() {
                storelist_length =null;
                resultvalue = false;
              });
            }
            else
            {
              resultvalue = true;
              storelist_length = listing.projectData;
            }
          });
        }
        else {
          errorDialog(listing.message);

        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabledProjectname ? key.capsText : key.text);
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
          shiftEnabledProjectname = !shiftEnabledProjectname;
          break;
        default:
      }
    }
    getdata(userid, text);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: key,
        appBar: buildBar(context),
        /* body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),*/

        body: Container(
          height: double.infinity,
          color: AppColors.shadow,
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  storelist_length != null ?
                  Expanded(
                    child:
                    ListView.builder(
                        itemCount: storelist_length.length == null
                            ? 0
                            : storelist_length.length,
                        itemBuilder: (BuildContext context, int index) {
                          imageslist_length = listing.projectData.elementAt(index).projectImages;
                          commentlist_length = listing.projectData.elementAt(index).comments;
                          double amount = listing.projectData.elementAt(index).totalcollectedamount.toDouble() /
                              double.parse(listing.projectData.elementAt(index).totalslotamount.toString()) * 100;

                          amoun =amount.toInt();
                          if (!listing.projectData.elementAt(index).profilePic.startsWith("https://"))
                          {
                            image=Network.BaseApiprofile+listing.projectData.elementAt(index).profilePic;

                          }
                          else
                          {
                            image=listing.projectData.elementAt(index).profilePic;
                          }
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
                                        listing.projectData.elementAt(index).userId.toString()==userid? _showEditPopupMenu(index):
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
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors
                                                      .themecolor,
                                                  style: BorderStyle.solid,
                                                ),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        image),
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
                                                    width: SizeConfig.blockSizeHorizontal *35,
                                                    padding: EdgeInsets.only(
                                                      top: SizeConfig.blockSizeVertical *1,
                                                    ),
                                                    child: Text(
                                                      listing.projectData.elementAt(index).fullName,
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
                                                          fontSize:9,
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
                                                    listing.projectData.elementAt(index).status.toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color:AppColors.purple,
                                                        fontSize:9,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                                listing.projectData.elementAt(index).userId.toString()!=userid?
                                                listing.projectData.elementAt(index).status=="pending"?
                                                GestureDetector(
                                                  onTap: ()
                                                  {

                                                    double tectString = double.parse(listing.projectData.elementAt(index).entryFee)*(commission.commisiondata.senderCommision/100);
                                                    totalamount = double.parse(listing.projectData.elementAt(index).entryFee) + tectString;
                                                    print("PrintSring: "+totalamount.toString());
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
                                                                            },
                                                                          );
                                                                          Widget continueButton = FlatButton(
                                                                            child: Text('continue'.tr),
                                                                            onPressed: () async {
                                                                              Payamount(listing.projectData.elementAt(index).id,listing.projectData.elementAt(index).entryFee, totalamount.toString(),userid);
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

                                                                                      new Text(" \$"+listing.projectData.elementAt(index).entryFee,
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
                                                                                        Text(" \$"+totalamount.toString(),
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
                                                                        height: SizeConfig.blockSizeVertical *5,
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
                                                                              fontSize: 15,
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
                                                    margin: EdgeInsets.only(left:
                                                    SizeConfig.blockSizeHorizontal *2,
                                                        right: SizeConfig.blockSizeHorizontal *2,
                                                        top: SizeConfig.blockSizeVertical *2),
                                                    padding: EdgeInsets.only(
                                                        right: SizeConfig.blockSizeHorizontal * 4,
                                                        left: SizeConfig.blockSizeHorizontal *
                                                            4,
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
                                                ): Container()
                                                    : Container()


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
                                                    listing.projectData.elementAt(index).eventName,
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
                                                  child:  Row(
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
                                                            fontFamily: 'Poppins-Regular'),
                                                      ),
                                                      Text(
                                                        " - "+listing.projectData.elementAt(index).eventStartdate,
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color: AppColors.black,
                                                            fontSize:9,
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
                                                        fontSize:9,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Poppins-Regular'),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal *38,
                                                  alignment: Alignment.topRight,
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal * 1,
                                                    right: SizeConfig.blockSizeHorizontal * 1,
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
                                                            fontSize:9,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily: 'Poppins-Regular'),
                                                      ),
                                                      Text(
                                                        " - "+listing.projectData.elementAt(index).eventEnddate,
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            color: AppColors.black,
                                                            fontSize:9,
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
                                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                                  left: SizeConfig.blockSizeHorizontal * 2),
                                              child:
                                              Row(
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
                                                    "  \$"+listing.projectData.elementAt(index).totalslotamount.toString(),
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
                                        Row(children: [
                                          Container(
                                              alignment: Alignment.centerRight,
                                              width: SizeConfig.blockSizeHorizontal *37,
                                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,
                                                  right: SizeConfig.blockSizeHorizontal * 3),
                                            child:
                                            Row(
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
                                                  "  \$"+listing.projectData.elementAt(index).balanceslot.toString(),
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
                                            OngoingEventsDetailsscreen(
                                                data:
                                                listing.projectData.elementAt(index).id.toString(),
                                                coming:"searchevent"
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
                                                            listing.projectData.elementAt(index).eventPath +
                                                                listing.projectData.elementAt(index).projectImages.elementAt(ind).imagePath,
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
                                                data:
                                                listing.projectData.elementAt(index).id.toString(),
                                                coming:"searchevent"
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
                                              fontSize: 8,
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
                                        "thekratos carry killed it????????????",
                                        maxLines: 2,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 8,
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
                                        "itx_kamie_94????????????",
                                        maxLines: 2,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 8,
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
                                            fontSize: 8,
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
                  ):
                  Container(
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
                ],
              ),


        ));
  }
  Future<void> _createDynamicLink(String productid) async {
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

  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy),
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
                        data: listing.projectData.elementAt(index).id.toString()
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
                        data: listing.projectData.elementAt(index).id.toString()
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
            ))
      ],
      elevation: 8.0,
    );
  }


  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.white,
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 15,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          activeLanguage =="English"?
          new IconButton(
            icon: actionIcon,
            onPressed: () {

              setState(() {

                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        getdata(userid,value);
                      });
                    },
                    decoration: new InputDecoration(
                      //prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText:'searchhere'.tr,
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }

              });

            },
          ):
          activeLanguage =="Arabic"?
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextFormField(
                    onTap: () => setState(() {
                      showkeyboardProjectname = true;
                      _modalBottomSheetMenu();
                    }),
                    enableInteractiveSelection: true,
                    toolbarOptions: ToolbarOptions(
                      copy: true,
                      cut: true,
                      paste: true,
                      selectAll: true,
                    ),
                    autofocus: false,
                    readOnly: true,
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (_searchQuery) {
                      setState(() {
                        getdata(userid, text);
                      });
                    },
                    decoration: new InputDecoration(
                      //prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: 'searchhere'.tr,
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ):
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        getdata(userid,value);
                      });
                    },
                    decoration: new InputDecoration(
                      //prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText:'searchhere'.tr,
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          )
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle =
          new Text("", style: new TextStyle(color: Colors.white));
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Future<void> Payamount(String id,String fees, String requiredAmount, String userid) async {
    Dialogs.showLoadingDialog(context, _keyLoaderproject);
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
      updateval = response.body; //store response as string
      if (jsonResponse["status"] == false)
      {
        Navigator.of(context, rootNavigator: true).pop();
        errorDialog(jsonDecode(updateval)["message"]);
      }
      else {
        Navigator.of(context, rootNavigator: true).pop();
        if (jsonResponse != null) {

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
                                builder: (BuildContext context) => SearchbarEvent()));
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

          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1),()
          {
            callNext(
                payment(
                    data: jsonDecode(updateval)["data"]["id"].toString(),
                    amount:totalamount.toString(),
                    coming:"evt",
                    backto:"SearchEvent"
                ), context);
          });

        } else {
          errorDialog(jsonDecode(updateval)["message"]);
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      errorDialog(jsonDecode(updateval)["message"]);
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
    http.Response response = await http.post(Network.BaseApi + Network.eventdelete, body: data);
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
            getdata(userid,"");
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

}
