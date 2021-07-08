import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/Donation/donation.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CampaignHistoryDetailsscreen extends StatefulWidget {
  @override
  CampaignHistoryDetailsscreenState createState() => CampaignHistoryDetailsscreenState();
}

class CampaignHistoryDetailsscreenState extends State<CampaignHistoryDetailsscreen> {

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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => donation()));
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
                        StringConstant.campaignhistory, textAlign: TextAlign.center,
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
                                      width: SizeConfig.blockSizeHorizontal *49,
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
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),

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
                                      width: SizeConfig.blockSizeHorizontal *38,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        "Campaign Name",
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
                                      width: SizeConfig.blockSizeHorizontal *38,
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
                                        "Target Achieved- \$1000",
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
                    /*    Row(
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
                                width: 110.0,
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
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig
                                  .blockSizeHorizontal *
                                  2),
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
                        ),*/
                        Container(
                          height: SizeConfig.blockSizeVertical*30,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                          child: Image.asset("assets/images/banner1.png",fit: BoxFit.fitHeight,),
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
                                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,left:SizeConfig.blockSizeHorizontal*2),
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed....",
                            maxLines:8,
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
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeVertical * 1,
                            right: SizeConfig.blockSizeVertical * 1,
                          ),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            autofocus: false,
                            focusNode: CommentFocus,
                            controller: CommentController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            validator: (val) {
                              if (val.length == 0)
                                return "Please enter comment";
                              else
                                return null;
                            },
                            onFieldSubmitted: (v)
                            {
                              CommentFocus.unfocus();
                            },
                            onSaved: (val) => _Comment = val,
                            textAlign: TextAlign.left,
                            style:
                            TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.tag_faces),
                              focusedBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',  fontSize: 12,
                                decoration: TextDecoration.none,
                              ),
                              hintText: "Add a comment...",
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal *100,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *5,
                              top: SizeConfig.blockSizeVertical *1),
                          child: Text(
                            "Post",
                            maxLines: 2,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: AppColors.themecolor,
                                fontSize: 16,
                                fontWeight:
                                FontWeight.normal,
                                fontFamily:
                                'Poppins-Regular'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *3),
                              child: Text(
                                StringConstant.contribution, textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,
                                  top: SizeConfig.blockSizeVertical *2),
                              child: Text(
                                StringConstant.exportto, textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.black),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*1,
                                    top: SizeConfig.blockSizeVertical *2),
                                child: Image.asset("assets/images/csv.png",width: 80,height: 40,),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,
                                  top: SizeConfig.blockSizeVertical *2,right: SizeConfig.blockSizeHorizontal*4,),
                                child: Image.asset("assets/images/pdf.png",width: 80,height: 40,),
                              ),
                            ),
                          ],
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
