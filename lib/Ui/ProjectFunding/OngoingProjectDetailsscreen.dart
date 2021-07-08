import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OngoingProjectDetailsscreen extends StatefulWidget {
  @override
  OngoingProjectDetailsscreenState createState() => OngoingProjectDetailsscreenState();
}

class OngoingProjectDetailsscreenState extends State<OngoingProjectDetailsscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => projectfunding()));
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
                        StringConstant.ongoingproject, textAlign: TextAlign.center,
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

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height:
                    SizeConfig.blockSizeVertical *
                        10,
                    width:
                    SizeConfig.blockSizeVertical *
                        10,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                            width: SizeConfig.blockSizeHorizontal *40,
                            padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical *1,
                            ),
                            child: Text(
                              "Phani Kumar G.",
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
                              margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2),
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *1,
                              ),
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: AppColors.darkgreen,
                                    fontSize:8,
                                    fontWeight:
                                    FontWeight.normal,
                                    fontFamily:
                                    'Poppins-Regular'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: ()
                            {
                            },
                            child: Container(
                              margin: EdgeInsets.only(left:
                              SizeConfig.blockSizeHorizontal *8,right: SizeConfig.blockSizeHorizontal *2,top: SizeConfig.blockSizeVertical *2),
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
                            width: SizeConfig.blockSizeHorizontal *33,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical *1,
                            ),
                            child: Text(
                              "Project Name",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal *40,
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
                              "Start Date- 21/05/2021",
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
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal *33,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical *1,
                            ),
                            child: Text(
                              "Total Contribution-20",
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
                            width: SizeConfig.blockSizeHorizontal *40,
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
                              "End Date- 30/05/2021",
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
                    width: SizeConfig.blockSizeHorizontal *25,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
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
                      "\$1000",
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
                      width: 100.0,
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
                      "Collected Amount- ",
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
                          1,
                    ),
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
              Container(
                height: SizeConfig.blockSizeVertical*30,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                child: Image.asset("assets/images/banner5.png",fit: BoxFit.fitHeight,),
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
              Container(
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
            ],
          )
         ),
    );
  }
}
