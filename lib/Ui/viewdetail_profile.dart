import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Pojo/ProfilePojo.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/createpostgift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class viewdetail_profile extends StatefulWidget{

  final String data;

  const viewdetail_profile({Key key, @required this.data})
      : super(key: key);

  @override
  viewdetail_profileState createState() => viewdetail_profileState();

}

class viewdetail_profileState extends State<viewdetail_profile>{
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
  bool internet = false;
  String val;
  String userid;
  var storelist_length;
  var pproject;
  ProfilePojo loginResponse;
  String data1;
  int a;
  bool imageUrl = false;
  bool _loading = false;
  String image;


  void getData(int id) async {
    Map data = {
      'userid': id.toString(),
    };
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.viewprofile, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        loginResponse = new ProfilePojo.fromJson(jsonResponse);
        print("Json profile data: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            storelist_length = loginResponse.data;
            pproject = loginResponse.data.copleteProjects;

            if(loginResponse.data.profilepic !=null || loginResponse.data.profilepic !=""){
              setState(() {
                image = loginResponse.data.profilepic;
                if(image.isNotEmpty){
                  imageUrl = true;
                  _loading = true;
                }
              });
            }

          });
        } else {
          Fluttertoast.showToast(
            msg: loginResponse.message,
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


  void getfollowstatus(String userid,String rec) async {
    Map data = {
      'receiver_id': rec.toString(),
      'userid': userid.toString(),
    };
    print("follow: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.checkfollow_status, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valfollowstatus = response.body; //store response as string
      if (jsonDecode(valfollowstatus)["status"] == false) {
        setState(() {
          Follow="Follow";
        });

        Fluttertoast.showToast(
          msg: jsonDecode(valfollowstatus)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        followstatusPojo = new followstatus.fromJson(jsonResponse);
        print("Json status: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            Follow="";
          });

          Fluttertoast.showToast(
            msg: jsonDecode(valfollowstatus)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        } else {
          Fluttertoast.showToast(
            msg: followstatusPojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(valfollowstatus)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }



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
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {

        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(a);
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
            storelist_length!=null?
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

                                imageUrl==false?
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10),
                                  height:
                                  SizeConfig.blockSizeVertical *
                                      17,
                                  width:
                                  SizeConfig.blockSizeVertical *
                                      17,
                                  child: ClipOval(child: Image.asset("assets/images/userProfile.png", height:
                                  SizeConfig.blockSizeVertical *
                                      17,
                                    width:
                                    SizeConfig.blockSizeVertical *
                                        17,)),
                                ):
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10),
                                  child: _loading? ClipOval(child:  CachedNetworkImage(
                                    height:
                                    SizeConfig.blockSizeVertical *
                                        17,
                                    width:
                                    SizeConfig.blockSizeVertical *
                                        17,fit: BoxFit.fill ,
                                    imageUrl:image,
                                    placeholder: (context, url) => Container(
                                        height:
                                        SizeConfig.blockSizeVertical *
                                            17,
                                        width:
                                        SizeConfig.blockSizeVertical *
                                            17,
                                        child: Center(child: new CircularProgressIndicator())),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),): CircularProgressIndicator(
                                    valueColor:
                                    new AlwaysStoppedAnimation<Color>(Colors.grey),
                                  ),
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
                          loginResponse.data.fullName+" ("+loginResponse.data.nickName+")",
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
                          loginResponse.data.email,
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
                              loginResponse.data.nationality,
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
                             //"326423 followers",
                              "",
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
                                tabvalue = "Past Projects";
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
                                  child: Text(StringConstant.pastprojects,
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
            ) :Container(
              child: Center(
                child: internet == true?CircularProgressIndicator():SizedBox(),
              ),
            ),


          ],
        ),
      ),

      bottomNavigationBar: bottombar(context),

    );
  }

  pastprojects() {
    return
      pproject!=null?
      Container(
      child:
      ListView.builder(
          itemCount: pproject.length == null
              ? 0
              : pproject.length,
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
    ) :Container(
        child: Center(
          child: internet == true?CircularProgressIndicator():SizedBox(),
        ),
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