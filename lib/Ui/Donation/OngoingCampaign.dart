import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/Donation/CreateDonationPost.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:kontribute/viewdetail_Eventprofile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OngoingCampaign extends StatefulWidget {
  @override
  OngoingCampaignState createState() => OngoingCampaignState();
}

class OngoingCampaignState extends State<OngoingCampaign> {

  Offset _tapDownPosition;

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
          color: isActive ? AppColors.whiteColor : AppColors.lightgrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

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

  bool _dialVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            children: [
              Expanded(
                child:
                ListView.builder(
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
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
                                        _showPopupMenu();
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
                                        GestureDetector(
                                          onTap: ()
                                          {
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_Eventprofile()));
                                          },
                                          child: Container(
                                            height:
                                            SizeConfig.blockSizeVertical *
                                                9,
                                            width:
                                            SizeConfig.blockSizeVertical *
                                                9,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockSizeVertical *2,
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
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                                                  width: SizeConfig.blockSizeHorizontal *38,
                                                  padding: EdgeInsets.only(
                                                    top: SizeConfig.blockSizeVertical *1,
                                                  ),
                                                  child: Text(
                                                    "Amitofo Care Center International",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.themecolor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.normal,
                                                        fontFamily: 'Poppins-Regular'),
                                                  ),
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
                                                    "OnGoing".toUpperCase(),
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

                                                GestureDetector(
                                                  onTap: ()
                                                  {
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.topRight,
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.blockSizeHorizontal *2,
                                                        right: SizeConfig.blockSizeHorizontal *2,
                                                        top: SizeConfig.blockSizeVertical *2),
                                                    padding: EdgeInsets.only(
                                                        right: SizeConfig
                                                            .blockSizeHorizontal *
                                                            4,
                                                        left: SizeConfig
                                                            .blockSizeHorizontal *
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
                                                      "PAY",
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
                                                )


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
                                                    StringConstant.totalContribution+"-20",
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
                                                    "Project Timeline- 8 Days",
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
                                      children: [
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal *23,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,left: SizeConfig.blockSizeHorizontal * 2),
                                          child: Text(
                                            "Collection Target- ",
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
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            right: SizeConfig
                                                .blockSizeHorizontal *
                                                3,
                                          ),
                                          child: Text(
                                            "\$100",
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.lightBlueAccent,
                                                fontSize: 8,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                'Poppins-Regular'),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          child:  LinearPercentIndicator(
                                            width: 90.0,
                                            lineHeight: 14.0,
                                            percent: 0.6,
                                            center: Text("60%",style: TextStyle(fontSize: 8,color: AppColors.whiteColor),),
                                            backgroundColor: AppColors.lightgrey,
                                            progressColor:AppColors.themecolor,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: SizeConfig.blockSizeHorizontal *25,
                                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                          child: Text(
                                            "Collected Amount-",
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
                                            "\$40",
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingCampaignDetailsscreen()));
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
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *100,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                                      top: SizeConfig.blockSizeVertical *1),
                                      child: Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed....",
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
                                    GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingCampaignDetailsscreen()));
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
                                          top: SizeConfig.blockSizeVertical *1,
                                      bottom: SizeConfig.blockSizeVertical *1),
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
                                    )


                                  ],
                                ),
                              ),
                        ),
                      );
                    }),
              )
            ],
          )
         ),
    /*  floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
        icon: Icon(Icons.edit,color: AppColors.selectedcolor,),
        label: Text('Create Post',style: TextStyle(color:AppColors.selectedcolor ),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateDonationPost()));
        },
      ),*/
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
            child: Icon(Icons.public),
            backgroundColor: AppColors.theme1color,
            label: 'Public',

            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.privacy_tip),
            backgroundColor: AppColors.theme1color,
            label: 'Private',

            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}
