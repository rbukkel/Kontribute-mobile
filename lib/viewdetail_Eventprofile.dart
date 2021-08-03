import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/createpostgift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class viewdetail_Eventprofile extends StatefulWidget{
  @override
  viewdetail_EventprofileState createState() => viewdetail_EventprofileState();

}

class viewdetail_EventprofileState extends State<viewdetail_Eventprofile>{
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset("assets/images/banner5.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner2.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),
    Image.asset("assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),

  ];
  String tabvalue = "Home";
  bool home =true;
  bool pastproject = false;

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.pop(context, true);
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
                      "",
                      textAlign: TextAlign.center,
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
              child:
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 19,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage("assets/images/viewdetailsbg.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height:
                                  SizeConfig.blockSizeVertical *
                                      17,
                                  width:
                                  SizeConfig.blockSizeVertical *
                                      17,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *10,
                                      right: SizeConfig
                                          .blockSizeHorizontal *
                                          1,
                                      left: SizeConfig
                                          .blockSizeHorizontal *
                                          4),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image:new AssetImage("assets/images/userProfile.png"),
                                        fit: BoxFit.fill,)),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: SizeConfig.blockSizeHorizontal *90,
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *1,
                            left:SizeConfig.blockSizeHorizontal *5
                        ),
                        child: Text(
                          "Phani Kumar G.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: AppColors.themecolor,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal *90,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *1,
                            left:SizeConfig.blockSizeHorizontal *5
                        ),
                        child: Text(
                          "Associate Manager",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal *50,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical *1,
                                left:SizeConfig.blockSizeHorizontal *5
                            ),
                            child: Text(
                              "E-learning Mumbai, Maharashtra",
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
                                right:SizeConfig.blockSizeHorizontal *5
                            ),
                            child: Text(
                              "326423 followers",
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
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *2,
                            left: SizeConfig.blockSizeHorizontal *5),
                        width: SizeConfig.blockSizeHorizontal *28,
                        padding: EdgeInsets.only(
                            bottom: SizeConfig
                                .blockSizeHorizontal *
                                3,
                            top: SizeConfig
                                .blockSizeHorizontal *
                                3),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.darkgreen)
                        ),
                        child: Text(
                          StringConstant.follow.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color:AppColors.darkgreen,
                              fontSize:9,
                              fontWeight:
                              FontWeight.normal,
                              fontFamily:
                              'Poppins-Regular'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabvalue = "Home";
                                home = true;
                                pastproject = false;
                              });
                              print("Value: " + tabvalue);
                            },
                            child: Container(
                                decoration:BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: home?AppColors.theme1color:AppColors.sendreceivebg,
                                      width: 3.0,
                                    ),

                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical *2,
                                    left: SizeConfig.blockSizeHorizontal * 4,
                                    right: SizeConfig.blockSizeHorizontal * 1),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 42,
                                  height: SizeConfig.blockSizeVertical * 6,
                                  child: Text(StringConstant.home,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: home
                                              ? AppColors.theme1color
                                              : AppColors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular')),
                                )

                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabvalue = "Past Campaign";
                                home = false;
                                pastproject = true;

                              });
                              print("Value: " + tabvalue);
                            },
                            child: Container(
                                decoration:BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: pastproject?AppColors.theme1color:AppColors.sendreceivebg,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical *2,
                                    left: SizeConfig.blockSizeHorizontal *1,
                                    right: SizeConfig.blockSizeHorizontal * 4),
                                child:
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 42,
                                  height: SizeConfig.blockSizeVertical * 6,
                                  child: Text(StringConstant.pastcampaign,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: pastproject
                                              ? AppColors.theme1color
                                              : AppColors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular')),
                                )

                            ),
                          ),

                        ],
                      ),

                      tabvalue == "Home" ? homeview() : pastprojects()
                    ],
                  ),
                ),
              )
            )

          ],
        ),
      ),

      bottomNavigationBar: bottombar(context),

    );
  }

  pastprojects() {
    return  Container(
      child:
      ListView.builder(
          itemCount: 8,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2,
              left: SizeConfig.blockSizeHorizontal *3,
                  right: SizeConfig.blockSizeHorizontal *3),
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
                                        width: SizeConfig.blockSizeHorizontal *33,
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
                                            StringConstant.follow,
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
                                      ),



                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal *32,
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
                                   /*   Container(
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
                                      ),*/
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
                                          StringConstant.collectedamount+"-1000",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize:8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                     /* Container(
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
                                      ),*/
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),

                          Container(
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
                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HistoryProjectDetailsscreen()));
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
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HistoryProjectDetailsscreen()));
                    },
                  )
              ),
            );
          }),
    );
  }

  homeview() {
    return Column(
      children: [

        Container(
          width: SizeConfig.blockSizeHorizontal *90,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical *4,
              left:SizeConfig.blockSizeHorizontal *5
          ),
          child: Text(
            "About",
            textAlign: TextAlign.left,
            style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Regular'),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal *90,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical *1,
              left:SizeConfig.blockSizeHorizontal *5
          ),
          child: Text(
            StringConstant.dummytext,
            textAlign: TextAlign.left,
            maxLines: 4,
            style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black87,
                fontSize:8,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular'),
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
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical *2,
                        bottom: SizeConfig.blockSizeVertical *2,
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
                        /*   InkWell(
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
                            )*/
                      ],
                    )
                );
              }),
        ),
      ],
    );
  }


}