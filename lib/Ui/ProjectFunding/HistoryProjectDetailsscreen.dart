import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/PostcommentPojo.dart';
import 'package:kontribute/Pojo/Projectdetailspojo.dart';
import 'package:kontribute/Pojo/projectlike.dart';
import 'package:kontribute/Ui/ProjectFunding/ProductVideoPlayerScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class HistoryProjectDetailsscreen extends StatefulWidget {
  final String data;

  const HistoryProjectDetailsscreen({Key key, @required this.data})
      : super(key: key);

  @override
  HistoryProjectDetailsscreenState createState() =>
      HistoryProjectDetailsscreenState();
}

class HistoryProjectDetailsscreenState extends State<HistoryProjectDetailsscreen> {
  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;
  String data1;
  String userid;
  int a;
  bool internet = false;
  String val;
  String vallike;
  String valPost;
  int amoun;
  var productlist_length;
  var storelist_length;
  var imageslist_length;
  var documentlist_length;
  var videolist_length;
  List<String> imagestore = [];
  Projectdetailspojo projectdetailspojo;
  projectlike prolike;
  PostcommentPojo postcom;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
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
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(userid, data1);

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

  void getData(String id, String projectid) async {
    Map data = {
      'userid': id.toString(),
      'project_id': projectid.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;http.Response response = await http.post(Network.BaseApi + Network.projectDetails, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        projectdetailspojo = new Projectdetailspojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = projectdetailspojo.commentsdata;
            storelist_length = projectdetailspojo.commentsdata.commentslist;
            imageslist_length = projectdetailspojo.commentsdata.projectimagesdata;
            documentlist_length = projectdetailspojo.commentsdata.documents;
            videolist_length = projectdetailspojo.commentsdata.videoLink;
            double amount = double.parse(projectdetailspojo.commentsdata.requiredAmount) /
                    double.parse(projectdetailspojo.commentsdata.budget) *
                    100;
            amoun = amount.toInt();
            print("Amountval: " + amoun.toString());
          });
        } else {
          Fluttertoast.showToast(
            msg: projectdetailspojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
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
                        StringConstant.historyproject, textAlign: TextAlign.center,
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
              productlist_length!=null?
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
                            projectdetailspojo.commentsdata.profilePic == null || projectdetailspojo.commentsdata.profilePic == ""
                                ? GestureDetector(
                              onTap: () {
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            viewdetail_profile()));*/
                              },
                              child: Container(
                                  height:
                                  SizeConfig.blockSizeVertical * 9,
                                  width: SizeConfig.blockSizeVertical * 9,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *
                                          2,
                                      bottom:
                                      SizeConfig.blockSizeVertical *
                                          1,
                                      right:
                                      SizeConfig.blockSizeHorizontal *
                                          1,
                                      left:
                                      SizeConfig.blockSizeHorizontal *
                                          2),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            viewdetail_profile()));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 9,
                                width: SizeConfig.blockSizeVertical * 9,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 2,
                                    bottom:
                                    SizeConfig.blockSizeVertical * 1,
                                    right:
                                    SizeConfig.blockSizeHorizontal *
                                        1,
                                    left: SizeConfig.blockSizeHorizontal *
                                        2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            projectdetailspojo
                                                .commentsdata.profilePic),
                                        fit: BoxFit.fill)),
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
                                      width: SizeConfig.blockSizeHorizontal *32,
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                        projectdetailspojo
                                            .commentsdata.fullName,
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
                                        projectdetailspojo
                                            .commentsdata.projectName,
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
                                        "Start Date- " +
                                            projectdetailspojo
                                                .commentsdata.projectStartdate,
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
                                      width: SizeConfig.blockSizeHorizontal *37,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                      ),
                                      child: Text(
                                       // StringConstant.totalContribution+"-20",
                                        "",
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
                                        "End Date- " +
                                            projectdetailspojo
                                                .commentsdata.projectEnddate,
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
                                    1,
                              ),
                              child: Text(
                                "\$" + projectdetailspojo.commentsdata.budget,
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
                                width: 70.0,
                                lineHeight: 14.0,
                                percent: amoun / 100,
                                center: Text(
                                  amoun.toString() + "%",
                                  style: TextStyle(
                                      fontSize: 8, color: AppColors.whiteColor),
                                ),
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
                                "\$" +
                                    projectdetailspojo
                                        .commentsdata.requiredAmount,
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
                        imageslist_length != null
                            ? Container(
                          color:Colors.transparent,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          height: SizeConfig.blockSizeVertical * 30,
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
                                              Network.BaseApiProject +
                                                  projectdetailspojo
                                                      .commentsdata
                                                      .projectimagesdata
                                                      .elementAt(ind)
                                                      .imagePath,
                                            ),
                                            fit: BoxFit.fill)),
                                  );
                                },
                              ),
                              Stack(
                                alignment:
                                AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.blockSizeVertical * 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                        )
                            : Container(
                          color: AppColors.themecolor,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          height: SizeConfig.blockSizeVertical * 30,
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
                                alignment:
                                AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                        SizeConfig.blockSizeVertical *
                                            2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0;
                                        i < introWidgetsList.length;
                                        i++)
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
                        Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: ()
                                {
                                  print("LIke");
                                  addlike();
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal*7,
                                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.asset("assets/images/heart.png",height: 20, width: 20,),
                                      ),
                                    ],
                                  ),
                                  //child: Image.asset("assets/images/flat.png"),
                                ),
                              ),
                              InkWell(
                                onTap: ()
                                {

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
                                        child: Text( projectdetailspojo
                                            .commentsdata.totalLike
                                            .toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6 ),),
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
                                        child: Text(projectdetailspojo
                                            .commentsdata.totalcomments
                                            .toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6  ),),
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
                          child: new Html(
                            data: projectdetailspojo.commentsdata.description,
                            defaultTextStyle: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal *100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,
                              top: SizeConfig.blockSizeVertical *1),
                          child: Text(
                            "View all " +
                                (projectdetailspojo
                                    .commentsdata.commentslist.length)
                                    .toString() +
                                " comments",
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
                        storelist_length != null
                            ? Container(
                          alignment: Alignment.topLeft,
                          height: SizeConfig.blockSizeVertical * 30,
                          child: ListView.builder(
                              itemCount: storelist_length.length == null
                                  ? 0
                                  : storelist_length.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  width: SizeConfig.blockSizeHorizontal *
                                      100,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical *1,
                                    bottom: SizeConfig.blockSizeVertical *1,
                                    left: SizeConfig.blockSizeHorizontal *
                                        3,
                                    right:
                                    SizeConfig.blockSizeHorizontal *
                                        3,
                                  ),
                                  child: Text(
                                    projectdetailspojo
                                        .commentsdata.commentslist
                                        .elementAt(i)
                                        .comment,
                                    maxLines: 2,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 8,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'NotoEmoji'),
                                  ),
                                );
                              }),
                        )
                            : Container(),

                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),

                        videolist_length!=null?
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount:  videolist_length.length == null
                                  ? 0
                                  : videolist_length.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int indx) {
                                return Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        left: SizeConfig.blockSizeHorizontal * 3,
                                        right: SizeConfig.blockSizeHorizontal * 1),
                                    child: Stack(
                                      children: [
                                        projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==null||projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail==""?
                                        Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 45,
                                          width:
                                          SizeConfig.blockSizeHorizontal *
                                              60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/events1.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ):
                                        Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 45,
                                          width:
                                          SizeConfig.blockSizeHorizontal *
                                              60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      projectdetailspojo.commentsdata.videoLink.elementAt(indx).videoThumbnail),
                                                  fit: BoxFit.fill)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // showAlert();
                                            callNext(ProductVideoPlayerScreen(data: projectdetailspojo.commentsdata.videoLink.elementAt(indx).vlink.toString()), context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    25,
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    25),
                                            child: Image.asset(
                                              "assets/images/play.png",
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              }),
                        ):Container(),
                        documentlist_length!=null?
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: ListView.builder(
                              itemCount:   documentlist_length.length == null
                                  ? 0
                                  : documentlist_length.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int inde) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right:
                                      SizeConfig.blockSizeHorizontal * 1),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/files.png",
                                        height:
                                        SizeConfig.blockSizeVertical * 10,
                                        width:
                                        SizeConfig.blockSizeHorizontal * 25,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        width:
                                        SizeConfig.blockSizeHorizontal * 20,
                                        alignment: Alignment.center,
                                        child: Text(
                                          projectdetailspojo.commentsdata.documents.elementAt(inde).documents.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.black,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                        ),
                                        width:
                                        SizeConfig.blockSizeHorizontal * 20,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Download",
                                          maxLines: 2,
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration.underline,
                                              letterSpacing: 1.0,
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /*   decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/images/files.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),*/
                                );
                              }),
                        ):Container(),
                      ],
                    ),
                  ),
                )
               ,
              )
                  :Container(
                child: Center(
                  child: internet == true?CircularProgressIndicator():SizedBox(),
                ),
              ),
            ],
          )
         ),
    );
  }

  void addlike() async {
    Map data = {
      'userid': userid.toString(),
      'project_id': a.toString(),
    };
    print("projectlikes: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.projectlikes, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      vallike = response.body; //store response as string
      if (jsonDecode(vallike)["success"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(vallike)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        prolike = new projectlike.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          Fluttertoast.showToast(
            msg: prolike.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          getData(userid, data1);
        } else {
          Fluttertoast.showToast(
            msg: prolike.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(vallike)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

}
