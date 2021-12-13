import 'dart:convert';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Ui/Donation/DonationReport.dart';
import 'package:kontribute/Ui/Donation/EditDonationPost.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/donationlistingPojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Pojo/searchsendreceivedpojo.dart';
import 'package:kontribute/Ui/ProjectFunding/EditCreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/Ui/ProjectFunding/ProjectReport.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SearchbarDonation extends StatefulWidget {

  @override
  SearchbarDonationState createState() => SearchbarDonationState();
}

class SearchbarDonationState extends State<SearchbarDonation> {
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

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
  String shortsharedlink = '';

  bool resultvalue = true;
  String searchvalue = "";
  searchsendreceivedpojo searchpojo;
  List<searchsendreceivedpojo> searchproductListing =
      new List<searchsendreceivedpojo>();
  donationlistingPojo listing;
  var storelist_length;
  var imageslist_length;
  var commentlist_length;
  String vallike;
  final AmountFocus = FocusNode();
  final TextEditingController AmountController = new TextEditingController();
  String _amount;
  projectlike prolike;
  int amoun;
  String updateval;
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

  SearchbarDonationState() {
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

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      getdata(userid,"");
      print("Login userid: " + userid.toString());
    });
    _IsSearching = false;

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
    http.Response response = await http.post(Network.BaseApi + Network.donationListing, body: data);
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
        listing = new donationlistingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
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
              print("SSSS");
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
                        double amount = double.parse(listing.projectData.elementAt(index).requiredAmount) /
                            double.parse(listing.projectData.elementAt(index).budget) * 100;
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
                            child: Container(
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
                                                  width: SizeConfig.blockSizeHorizontal *38,
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

                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *2,
                                                    left: SizeConfig.blockSizeHorizontal *1),
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
                                                  'ongoing'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color:AppColors.purple,
                                                      fontSize:9,
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
                                                    child: Text('cancel'.tr),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                  Widget continueButton = FlatButton(
                                                    child: Text('continue'.tr),
                                                    onPressed: () async {
                                                      Payamount(listing.projectData.elementAt(index).id,
                                                          listing.projectData.elementAt(index).requiredAmount,
                                                          userid);
                                                    },
                                                  );
                                                  // set up the AlertDialog
                                                  AlertDialog alert = AlertDialog(
                                                    title: Text('paynow'.tr),
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
                                                                return 'pleaseenterpaymentamount'.tr;
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
                                                              hintText:'enterpaymentamount'.tr,
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
                                                      right: SizeConfig.blockSizeHorizontal * 3,
                                                      left: SizeConfig.blockSizeHorizontal * 3,
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
                                                  listing.projectData.elementAt(index).campaignName,
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
                                                child:   Row(
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
                                                          FontWeight.normal,
                                                          fontFamily:
                                                          'Poppins-Regular'),
                                                    ),
                                                    Text(
                                                      " - "+listing.projectData.elementAt(index).campaignStartdate,
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.black,
                                                          fontSize:9,
                                                          fontWeight:
                                                          FontWeight.normal,
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
                                                child:  Row(
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
                                                          FontWeight.normal,
                                                          fontFamily:
                                                          'Poppins-Regular'),
                                                    ),
                                                    Text(
                                                      " - "+listing.projectData.elementAt(index).campaignEnddate,
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.black,
                                                          fontSize:9,
                                                          fontWeight:
                                                          FontWeight.normal,
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
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: SizeConfig.blockSizeHorizontal *35,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig.blockSizeVertical *1,
                                                  left: SizeConfig.blockSizeHorizontal * 2),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'collectiontarget'.tr,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.black87,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                  Text(
                                                    "  \$"+listing.projectData.elementAt(index).budget,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.lightBlueAccent,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
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
                                              width: SizeConfig.blockSizeHorizontal *33,
                                              alignment: Alignment.centerRight,
                                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                                  .blockSizeHorizontal *
                                                  5),
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
                                                        FontWeight.normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                  Text(
                                                    "  \$"+listing.projectData.elementAt(index).totalcollectedamount.toString(),
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: Colors.lightBlueAccent,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight.normal,
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
                                                listing.projectData.elementAt(index).id.toString(),
                                                coming:"searchdonation"
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
                                                width: SizeConfig.blockSizeHorizontal * 80,
                                                height: SizeConfig.blockSizeVertical * 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.transparent),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Network.BaseApidonation + listing.projectData.elementAt(index).projectImages.elementAt(ind).imagePath,
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
                                                listing.projectData.elementAt(index).id.toString(),
                                                coming:"searchdonation"
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
                                  /*Container(
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


                                  /* Container(

                                      child:
                                      ListView.builder(
                                          itemCount: 2,
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child:
                                                  InkWell(
                                                    child: Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [

                                                          Row(
                                                            children: [
                                                              Container(
                                                                height:
                                                                SizeConfig.blockSizeVertical *
                                                                    8,
                                                                width:
                                                                SizeConfig.blockSizeVertical *
                                                                    8,
                                                                alignment: Alignment.center,
                                                                margin: EdgeInsets.only(
                                                                    top: SizeConfig.blockSizeVertical *1,
                                                                    bottom: SizeConfig.blockSizeVertical *1,
                                                                    right: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        1,
                                                                    left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        2),
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image:new AssetImage("assets/images/userProfile.png"),
                                                                      fit: BoxFit.fill,)),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *47,
                                                                        alignment: Alignment.topLeft,
                                                                        padding: EdgeInsets.only(
                                                                          left: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                              1,
                                                                        ),
                                                                        child: Text(
                                                                          "Donator Life America",
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: Colors.black87,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Poppins-Regular'),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *25,
                                                                        alignment: Alignment.topRight,
                                                                        padding: EdgeInsets.only(
                                                                          left: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                              1,
                                                                          right: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                              2,
                                                                        ),
                                                                        child: Text(
                                                                          "Donates- \$120",
                                                                          textAlign: TextAlign.right,
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: AppColors.black,
                                                                              fontSize:10,
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
                                                                        width: SizeConfig.blockSizeHorizontal *52,
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
                                                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed..",
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color: Colors.black87,
                                                                              fontSize: 10,
                                                                              fontWeight:
                                                                              FontWeight.normal,
                                                                              fontFamily:
                                                                              'Poppins-Regular'),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *18,
                                                                        alignment: Alignment.center,
                                                                        padding: EdgeInsets.only(
                                                                            right: SizeConfig
                                                                                .blockSizeHorizontal *
                                                                               1,
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
                                                                            border: Border.all(color: AppColors.darkgreen)
                                                                        ),
                                                                        child: Text(
                                                                          "Follow",
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              letterSpacing: 1.0,
                                                                              color:AppColors.darkgreen,
                                                                              fontSize:10,
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
                                                    onTap: () {

                                                    },
                                                  )
                                              ),
                                            );
                                          }),

                                    ),
                                    GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingCampaignDetailsscreen()));

                                      },
                                      child:  Container(
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "Load more...",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.themecolor,
                                              fontSize:12,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily:
                                              'Poppins-Regular'),
                                        ),
                                      ),
                                    )*/


                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
                    :  Container(
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
              ],
            )
        ));
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
                    DonationReport(
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
                    EditDonationPost(
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
          height: SizeConfig.blockSizeVertical * 13,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
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
                        hintText: 'searchhere'.tr,
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
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

  Future<void> Payamount(String id, String requiredAmount, String userid) async {
    Map data = {
      'userid': userid.toString(),
      'donation_id': id.toString(),
      'amount': requiredAmount.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.donation_pay, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        errorDialog(jsonDecode(updateval)["message"]);
      }
      else {
        if (jsonResponse != null) {
          errorDialog(jsonDecode(updateval)["message"]);
          Future.delayed(Duration(seconds: 2),()
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SearchbarDonation()));
          });

          // getpaymentlist(a);
        } else {
          errorDialog(jsonDecode(updateval)["message"]);
        }
      }
    } else {
      errorDialog(jsonDecode(updateval)["message"]);
    }
  }

}
