import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/Events/events.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EventsHistoryProjectDetailsscreen extends StatefulWidget {
  @override
  EventsHistoryProjectDetailsscreenState createState() => EventsHistoryProjectDetailsscreenState();
}

class EventsHistoryProjectDetailsscreenState extends State<EventsHistoryProjectDetailsscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                height: SizeConfig.blockSizeVertical *12,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/appbar.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,height: 20,
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *2),
                      child:
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => events()));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset("assets/images/back.png",color:AppColors.whiteColor,width: 20,height: 20,),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal *60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        StringConstant.historyevents, textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins-Regular",
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 25,height: 25,
                      margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *2),

                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child:  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
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
                                      1),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:new AssetImage("assets/images/userProfile.png"),
                                    fit: BoxFit.fill,)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *2,
                                        bottom: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        "American Tourism",
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.themecolor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: ()
                                      {
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockSizeHorizontal*1, top: SizeConfig.blockSizeVertical *2,
                                          bottom: SizeConfig.blockSizeVertical *1,),

                                        child: Text(
                                          "@park plaza",
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
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,
                                        top: SizeConfig.blockSizeVertical *2,
                                        bottom: SizeConfig.blockSizeVertical *1,),

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
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        "Event Name",
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
                                      child: Text(
                                        "Event Date- 21/05/2021",
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
                                        "Followers-255",
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
                                        "Total Contributions- 20",
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

                        Container(
                          alignment: Alignment.center,
                          height: SizeConfig.blockSizeVertical*30,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                          child: Image.asset("assets/images/chrimasevents.png",fit: BoxFit.fitHeight,),
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
                              top: SizeConfig.blockSizeVertical *1,bottom: SizeConfig.blockSizeVertical *1),
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EventsHistoryProjectDetailsscreen()));
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
                              top: SizeConfig.blockSizeVertical *1),
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
                          height: SizeConfig.blockSizeVertical *25,
                          child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2,
                                        left: SizeConfig.blockSizeHorizontal * 3,
                                        right: SizeConfig.blockSizeHorizontal *1),
                                    child:
                                    Stack(
                                      children: [
                                        Container(
                                          height: SizeConfig.blockSizeVertical * 45,
                                          width: SizeConfig.blockSizeHorizontal * 60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new AssetImage("assets/images/events1.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // showAlert();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.blockSizeHorizontal * 25,right:  SizeConfig.blockSizeHorizontal * 25),
                                            child: Image.asset(
                                              "assets/images/play.png",
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                );
                              }),
                        ),
                        Container(

                          child:
                          ListView.builder(
                              itemCount: 5,
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
                                                            width: SizeConfig.blockSizeHorizontal *48,
                                                            alignment: Alignment.topLeft,
                                                            padding: EdgeInsets.only(
                                                              left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                            child: Text(
                                                              "Jordan",
                                                              style: TextStyle(
                                                                  letterSpacing: 1.0,
                                                                  color: Colors.black87,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: SizeConfig.blockSizeHorizontal *29,
                                                            alignment: Alignment.topRight,

                                                            child: Text(
                                                              "Contributes- \$120",
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
                                                            width: SizeConfig.blockSizeHorizontal *58,
                                                            alignment: Alignment.topLeft,
                                                            padding: EdgeInsets.only(
                                                              right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  1,
                                                              left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  1,
                                                            ),
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

                        )
                      ],
                    ),
                  ),
                )
               ,
              )
            ],
          )
         ),
    );
  }
}
