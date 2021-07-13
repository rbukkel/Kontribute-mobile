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
  Offset _tapDownPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;

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
              Expanded(
                child: Container(
                  child:  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                top: SizeConfig.blockSizeVertical *1,
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
                                      width: SizeConfig.blockSizeHorizontal *32,
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
                                        margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal*1),
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
                                        margin: EdgeInsets.only(left:
                                        SizeConfig.blockSizeHorizontal *2,right: SizeConfig.blockSizeHorizontal *2,top: SizeConfig.blockSizeVertical *2),
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
                                      width: SizeConfig.blockSizeHorizontal *37,
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
                                      width: SizeConfig.blockSizeHorizontal *41,
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
                                            2,
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
                        ),
                        Container(
                          alignment: Alignment.center,
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
                                        child: InkWell(
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
                                                              width: SizeConfig.blockSizeHorizontal *55,
                                                              alignment: Alignment.topLeft,
                                                              padding: EdgeInsets.only(
                                                                left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    1,
                                                              ),
                                                              child: Text(
                                                                "Life America",
                                                                style: TextStyle(
                                                                    letterSpacing: 1.0,
                                                                    color: Colors.black87,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: 'Poppins-Regular'),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: SizeConfig.blockSizeHorizontal *20,
                                                              alignment: Alignment.topRight,
                                                              padding: EdgeInsets.only(
                                                                left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    1,
                                                                right: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    3,
                                                              ),
                                                              child: Text(
                                                                "Status",
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                    letterSpacing: 1.0,
                                                                    color: AppColors.black,
                                                                    fontSize:12,
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
                                                              width: SizeConfig.blockSizeHorizontal *55,
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
                                                                "Contribute-\$120",
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
                                                              width: SizeConfig.blockSizeHorizontal *20,
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
                                                                  border: Border.all(color: AppColors.orange)
                                                              ),
                                                              child: Text(
                                                                "Pending".toUpperCase(),
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    letterSpacing: 1.0,
                                                                    color:AppColors.orange,
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
