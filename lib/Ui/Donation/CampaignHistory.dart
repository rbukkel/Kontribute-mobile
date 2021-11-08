import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/donationlistingPojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Pojo/projectlisting.dart';
import 'package:kontribute/Ui/Donation/CampaignHistoryDetailsscreen.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:kontribute/viewdetail_Eventprofile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;

class CampaignHistory extends StatefulWidget {
  @override
  CampaignHistoryState createState() => CampaignHistoryState();
}

class CampaignHistoryState extends State<CampaignHistory> {
  String userid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  donationlistingPojo listing;
  var storelist_length;
  var imageslist_length;
  int amoun;
  String vallike;
  projectlike prolike;
  String tabValue ="1";

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
    http.Response response = await http.post(Network.BaseApi + Network.donationListing_history, body: data);
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
        listing = new donationlistingPojo.fromJson(jsonResponse);
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
                    itemCount: storelist_length.length == null
                        ? 0
                        : storelist_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      imageslist_length = listing.projectData.elementAt(index).projectImages;
                      double amount = double.parse(listing.projectData.elementAt(index).requiredAmount) / double.parse(listing.projectData.elementAt(index).budget) * 100;
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        listing.projectData.elementAt(index).profilePic== null ||
                                            listing.projectData.elementAt(index).profilePic == ""
                                            ? GestureDetector(
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
                                                image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "assets/images/account_circle.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                        )
                                            : GestureDetector(
                                          onTap: () {
                                            callNext(viewdetail_profile(data: listing.projectData.elementAt(index).userId.toString()), context);
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
                                                    image: NetworkImage(listing.projectData.elementAt(index).profilePic),
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
                                                    width: SizeConfig.blockSizeHorizontal *40,
                                                    padding: EdgeInsets.only(
                                                      top: SizeConfig.blockSizeVertical *1,
                                                    ),
                                                    child: Text(
                                                      listing.projectData.elementAt(index).fullName,
                                                      style: TextStyle(
                                                          letterSpacing: 1.0,
                                                          color: AppColors.themecolor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: 'Poppins-Regular'),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig.blockSizeVertical *2,
                                                      left: SizeConfig.blockSizeHorizontal *3),
                                                  alignment: Alignment.topRight,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig.blockSizeHorizontal * 2,
                                                      left: SizeConfig.blockSizeHorizontal * 2,
                                                      bottom: SizeConfig.blockSizeHorizontal * 2,
                                                      top: SizeConfig.blockSizeHorizontal * 2),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.whiteColor,
                                                      borderRadius: BorderRadius.circular(20),
                                                      border: Border.all(color: AppColors.purple)
                                                  ),
                                                  child: Text(
                                                    "Completed".toUpperCase(),
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
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal *55,
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
                                                    StringConstant.totalContribution+"-",
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
                                                  width: SizeConfig.blockSizeHorizontal *35,
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
                                                    "Target Achieved- \$"+listing.projectData.elementAt(index).requiredAmount,
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
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal * 23,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 1,
                                            left: SizeConfig.blockSizeHorizontal *2
                                          ),
                                          child: Text(
                                            "Collection Target- ",
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical * 1),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            right: SizeConfig.blockSizeHorizontal * 3,
                                          ),
                                          child: Text(
                                            "\$" + listing.projectData.elementAt(index).budget,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical * 1),
                                          child: LinearPercentIndicator(
                                            width: 70.0,
                                            lineHeight: 14.0,
                                            percent: amoun / 100,
                                            center: Text(
                                              amoun.toString() + "%",
                                              style: TextStyle(
                                                  fontSize: 8, color: AppColors.whiteColor),
                                            ),
                                            backgroundColor: AppColors.lightgrey,
                                            progressColor: AppColors.themecolor,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: SizeConfig.blockSizeHorizontal * 25,
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical * 1),
                                          child: Text(
                                            "Collected Amount- ",
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical * 1,
                                              right: SizeConfig.blockSizeHorizontal * 3),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            right: SizeConfig.blockSizeHorizontal * 1,
                                          ),
                                          child: Text(
                                            "\$" + listing.projectData.elementAt(index).requiredAmount,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        )
                                      ],
                                    ),
                                    imageslist_length!=null?
                                    GestureDetector(
                                      onTap: () {
                                        callNext(
                                            CampaignHistoryDetailsscreen(
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
                                                            Network.BaseApidonation +
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
                                                        if (i == currentPageValue) ...
                                                        [
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
                                            CampaignHistoryDetailsscreen(
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
                                   /* Container(
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              print("LIke");
                                             // addlike(listing.projectData.elementAt(index).id);
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
                                          *//*InkWell(
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
                                          ),*//*
                                        ],
                                      ),
                                    ),*/
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *100,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *3,
                                          right: SizeConfig.blockSizeHorizontal *3,
                                          top: SizeConfig.blockSizeVertical *1),
                                      child:  new Html(
                                        data: listing.projectData.elementAt(index).description,
                                        defaultTextStyle: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),

                                 /*   Container(

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
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CampaignHistoryDetailsscreen()));

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
    );
  }
}
