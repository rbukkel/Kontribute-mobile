import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/Donation/donation.dart';
import 'package:kontribute/Ui/Events/events.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/Tickets/tickets.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TicketOngoingEventsDetailsscreen extends StatefulWidget {
  @override
  TicketOngoingEventsDetailsscreenState createState() => TicketOngoingEventsDetailsscreenState();
}

class TicketOngoingEventsDetailsscreenState extends State<TicketOngoingEventsDetailsscreen> {

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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => tickets()));
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
                        StringConstant.ongoingevents, textAlign: TextAlign.center,
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
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
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
                                        margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2,
                                            left: SizeConfig.blockSizeHorizontal*1),
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *1,
                                        ),
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
                                        "Sold tickets- 20",
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black87,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular'),
                                      ),
                                    ),

                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *37,
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
                                        "End Date- 31/05/2021",
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
                              width: SizeConfig.blockSizeHorizontal *25,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,left: SizeConfig.blockSizeHorizontal * 2),
                              child: Text(
                                "No. of Tickets sold- ",
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
                                "85",
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
                                "Available Tickets- ",
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
                                "150",
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
                            maxLines: 2,
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
                                color: Colors.black26,
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
                          width: SizeConfig.blockSizeHorizontal *100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                              top: SizeConfig.blockSizeVertical *2),
                          child: Text(
                            "No. of Persons joined- 80",
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,bottom:SizeConfig.blockSizeVertical *2 ,left: SizeConfig.blockSizeHorizontal *3),
                                  child: Text(
                                    "Ticket Price-",
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
                                      1,bottom:SizeConfig.blockSizeVertical *2 ,),
                                  alignment: Alignment.topLeft,

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
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: ()
                              {
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom:SizeConfig.blockSizeVertical *2 ,left:
                                SizeConfig.blockSizeHorizontal *1,
                                    right: SizeConfig.blockSizeHorizontal *3,
                                    top: SizeConfig.blockSizeVertical *2),
                                padding: EdgeInsets.only(
                                    right: SizeConfig
                                        .blockSizeHorizontal *
                                        7,
                                    left: SizeConfig
                                        .blockSizeHorizontal *
                                        7,
                                    bottom: SizeConfig
                                        .blockSizeHorizontal *
                                        3,
                                    top: SizeConfig
                                        .blockSizeHorizontal *
                                        3),
                                decoration: BoxDecoration(
                                  color: AppColors.darkgreen,
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                child: Text(
                                  "BUY",
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
                                StringConstant.totalticketsold, textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
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
                                    fontSize: 12,
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
                                child: Image.asset("assets/images/csv.png",width: 70,height: 40,),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,
                                  top: SizeConfig.blockSizeVertical *2,right: SizeConfig.blockSizeHorizontal*4,),
                                child: Image.asset("assets/images/pdf.png",width: 70,height: 40,),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                          color: AppColors.purplecolor,
                          height: SizeConfig.blockSizeVertical *7,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *8,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                child: Text(
                                  StringConstant.srno, textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *30,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal*3,
                                    ),
                                child: Text(
                                  StringConstant.names, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *25,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal*3,
                                    ),
                                child: Text(
                                  StringConstant.noofticket, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: SizeConfig.blockSizeHorizontal *25,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal*3,
                                    ),
                                child: Text(
                                  StringConstant.totalamount, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Poppins-Regular",
                                      color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          child:
                          ListView.builder(
                              itemCount: 5,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return
                                  Container(

                                    child: Column(

                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: SizeConfig.blockSizeHorizontal *8,
                                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3),
                                              child: Text(
                                                "1", textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Poppins-Regular",
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: SizeConfig.blockSizeHorizontal *30,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal*3),
                                              child: Text(
                                                "Kartik Kalyan", textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Poppins-Regular",
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: SizeConfig.blockSizeHorizontal *25,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal*3),
                                              child: Text(
                                                "4", textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Poppins-Regular",
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: SizeConfig.blockSizeHorizontal *25,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal*3),
                                              child: Text(
                                                "400", textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Poppins-Regular",
                                                    color: Colors.black),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: ()
                                              {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Stack(
                                                          overflow: Overflow.visible,
                                                          children: <Widget>[
                                                              Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                 Container(
                                                                   color:AppColors.headingblue,
                                                                   width: SizeConfig.blockSizeHorizontal *100,
                                                                   height: SizeConfig.blockSizeVertical *6,
                                                                   child:Row(
                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                                     children: [
                                                                       Container(
                                                                         width: 20,height: 20,
                                                                         margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,),
                                                                       ),
                                                                       Container(
                                                                         width: SizeConfig.blockSizeHorizontal *40,
                                                                         alignment: Alignment.center,
                                                                         // margin: EdgeInsets.only(top: 10, left: 40),
                                                                         child: Text(
                                                                           "Ticket Details", textAlign: TextAlign.center,
                                                                           style: TextStyle(
                                                                               decoration: TextDecoration.none,
                                                                               fontSize: 14,
                                                                               fontWeight: FontWeight.normal,
                                                                               fontFamily: "Poppins-Regular",
                                                                               color: Colors.white),
                                                                         ),
                                                                       ),
                                                                       GestureDetector(
                                                                         onTap: ()
                                                                         {
                                                                           Navigator.of(context).pop();
                                                                         },
                                                                         child: Container(
                                                                           margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,),
                                                                           child: Image.asset("assets/images/cross.png",color:AppColors.whiteColor,width: 12,height: 12,),
                                                                         ),
                                                                       )

                                                                     ],
                                                                   ),
                                                                 ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *25,
                                                                        alignment: Alignment.center,
                                                                        // margin: EdgeInsets.only(top: 10, left: 40),
                                                                        child: Text(
                                                                          "QR Code", textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.none,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "Poppins-Regular",
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: SizeConfig.blockSizeHorizontal *25,
                                                                        alignment: Alignment.center,
                                                                        // margin: EdgeInsets.only(top: 10, left: 40),
                                                                        child: Text(
                                                                          "Ticket No.", textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.none,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "Poppins-Regular",
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                    ListView.builder(
                                                                        itemCount:4,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          return
                                                                            Container(

                                                                                child:
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: SizeConfig.blockSizeHorizontal *25,
                                                                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                                                                      alignment: Alignment.center,
                                                                                     child: Container
                                                                                       (
                                                                                       alignment: Alignment.center,
                                                                                       width: SizeConfig.blockSizeHorizontal *10,
                                                                                       height: SizeConfig.blockSizeVertical *7,
                                                                                       decoration: BoxDecoration(
                                                                                         image: new DecorationImage(
                                                                                           image: new AssetImage("assets/images/qrcode.png",),
                                                                                           fit: BoxFit.fill,
                                                                                         ),
                                                                                       ),
                                                                                     ),
                                                                                    ),
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      width: SizeConfig.blockSizeHorizontal *25,
                                                                                      margin: EdgeInsets.only(
                                                                                          left: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *1),
                                                                                      child: Text(
                                                                                        "#56864921", textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                            decoration: TextDecoration.none,
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontFamily: "Poppins-Regular",
                                                                                            color: Colors.black),
                                                                                      ),
                                                                                    ),



                                                                                  ],
                                                                                )
                                                                            );
                                                                        }),
                                                                  )
                                                                ],
                                                              ),

                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: SizeConfig.blockSizeHorizontal *20,
                                                alignment: Alignment.bottomRight,
                                                 margin: EdgeInsets.only(
                                                right: SizeConfig.blockSizeHorizontal *3,
                                                top: SizeConfig.blockSizeVertical *2),
                                                padding: EdgeInsets.only(
                                                    right: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2,
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2,
                                                    bottom: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3,
                                                    top: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3),
                                                decoration: BoxDecoration(
                                                  color: AppColors.yelowbg,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: AppColors.whiteColor,
                                                      fontSize:8,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ],
                                    )
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
