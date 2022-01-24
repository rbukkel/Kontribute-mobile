import 'dart:convert';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Pojo/ProfilePojo.dart';
import 'package:kontribute/Pojo/followstatus.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
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

  const viewdetail_profile({Key key, @required this.data}) : super(key: key);

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
      height: SizeConfig.blockSizeVertical * 30,fit: BoxFit.fitHeight,),];

  String tabvalue = "Past Projects";
  bool home =false;
  bool pastproject = true;
  bool internet = false;
  String val;
  String valfollowstatus;
  String userid;
  var storelist_length;
  var commentlist_length;
  var imageslist_length;
  var pproject;
  ProfilePojo loginResponse;
  String data1;
  int a;
  bool imageUrl = false;
  bool _loading = false;
  String image;
  String Follow="Follow";
  followstatus followstatusPojo;
  String updateval;

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
        getData(a);
        getfollowstatus(userid,a);
        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        errorDialog('nointernetconnection'.tr);
      }
    });
  }

  void errorDialog(String text) {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: AppColors.whiteColor,
        child: new Container(
          margin: EdgeInsets.all(5),
          width: 300.0,
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.error,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                color: AppColors.whiteColor,
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    'ok'.tr,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


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
        errorDialog(jsonDecode(val)["message"]);

      } else {
        loginResponse = new ProfilePojo.fromJson(jsonResponse);
        print("Json profile data: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            storelist_length = loginResponse.data;
            pproject = loginResponse.data.copleteProjects;

            if(loginResponse.data.profilepic !=null || loginResponse.data.profilepic !=""){
              if (!loginResponse.data.profilepic.startsWith("https://"))
              {
                setState(() {
                  image = Network.BaseApiprofile+loginResponse.data.profilepic;
                  if (image.isNotEmpty) {
                    imageUrl = true;
                    _loading = true;
                  }
                });
              }
              else
                {
                  setState(() {
                    image = loginResponse.data.profilepic;
                    if(image.isNotEmpty){
                      imageUrl = true;
                      _loading = true;
                    }
                  });
                }
            }

          });
        } else {
          errorDialog(loginResponse.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }
  }


  void getfollowstatus(String userid,int rec) async {
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
       // errorDialog(jsonDecode(valfollowstatus)["message"]);

      } else {
        followstatusPojo = new followstatus.fromJson(jsonResponse);
        print("Json status: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            Follow="";
          });

        } else {
          errorDialog(followstatusPojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(valfollowstatus)["message"]);
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
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,left: SizeConfig.blockSizeHorizontal *5),
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
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,left: SizeConfig.blockSizeHorizontal *5),
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
                      loginResponse.data.nickName==null?
                      Container(
                        alignment: Alignment.centerLeft,
                        width: SizeConfig.blockSizeHorizontal *90,
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *1,
                            left:SizeConfig.blockSizeHorizontal *5
                        ),
                        child: Text(
                          loginResponse.data.fullName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: AppColors.themecolor,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ):
                      Container(
                        alignment: Alignment.centerLeft,
                        width: SizeConfig.blockSizeHorizontal *90,
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *1,
                            left:SizeConfig.blockSizeHorizontal *5
                        ),
                        child: Text(
                          loginResponse.data.fullName
                              +" ("+loginResponse.data.nickName+")",
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
                          loginResponse.data.email==null?"":loginResponse.data.email,
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
                              loginResponse.data.nationality==null?"":loginResponse.data.nationality,
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
                      Follow=="Follow"?
                      GestureDetector(
                        onTap:()
                            {
                              followapi(userid,a);
                            },
                        child: Container(
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
                            'follow'.tr,
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
                      ):Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  child: Text('pastprojects'.tr,
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
                         /* GestureDetector(
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
                          ),*/
                        ],
                      ),
                      tabvalue == "Past Projects" ? pastprojects(): Container()
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

  Future<void>  followapi(String useid,int rece) async {
    Map data = {
      'sender_id': useid.toString(),
      'receiver_id': rece.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi+Network.follow, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        showToast(updateval);
      }
      else {
        if (jsonResponse != null) {
          showToast(updateval);
          setState(() {
            Follow = "";
          });
        } else {
          showToast(updateval);
        }
      }
    } else {
      showToast(updateval);
    }
  }
  void showToast(String updateval) {
    Fluttertoast.showToast(
      msg: jsonDecode(updateval)["message"],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
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
          itemBuilder: (BuildContext context, int indx) {
            imageslist_length = loginResponse.data.copleteProjects.elementAt(indx).projectImages;
            commentlist_length = loginResponse.data.copleteProjects.elementAt(indx).commentslist;
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
                              loginResponse.data.copleteProjects.elementAt(indx).profilePic== null ||
                                  loginResponse.data.copleteProjects.elementAt(indx).profilePic == ""
                                  ?
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                  callNext(
                                      viewdetail_profile(
                                          data: loginResponse.data.copleteProjects.elementAt(indx).userId.toString()
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
                                            2),
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: new AssetImage(
                                            "assets/images/userProfile.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              )
                                  :
                              GestureDetector(
                                onTap: () {
                                  callNext(
                                      viewdetail_profile(
                                          data: loginResponse.data.copleteProjects.elementAt(indx).userId.toString()
                                      ), context);

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
                                          2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              loginResponse.data.copleteProjects.elementAt(indx).profilePic),
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
                                        width: SizeConfig.blockSizeHorizontal *33,
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical *1,
                                        ),
                                        child: Text(
                                          loginResponse.data.copleteProjects.elementAt(indx).fullName,
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
                                            //StringConstant.follow,
                                            "",
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
                                       width: SizeConfig.blockSizeHorizontal *21,
                                        alignment: Alignment.center,
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
                                          'completed'.tr,
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
                                          //StringConstant.totalContribution+"-20",
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
                                        child:
                                            Row(
                                              children: [
                                                Text(
                                                  'collectedamount'.tr,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize:8,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                                Text(
                                                 " "+loginResponse.data.copleteProjects.elementAt(indx).budget,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize:8,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'Poppins-Regular'),
                                                ),
                                              ],
                                            )

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


                          imageslist_length!=null?
                          GestureDetector(
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                              callNext(
                                  OngoingProjectDetailsscreen(
                                      data:
                                      loginResponse.data.copleteProjects.elementAt(indx).id.toString(),
                                      coming:"viewprofileproject"
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
                                                  Network.BaseApiProject +
                                                      loginResponse.data.copleteProjects.elementAt(indx).projectImages.elementAt(ind).imagePath,
                                                ),
                                                fit: BoxFit.fill)),
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
                          ):
                          GestureDetector(
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProjectDetailsscreen()));
                              callNext(
                                  OngoingProjectDetailsscreen(
                                      data: loginResponse.data.copleteProjects.elementAt(indx).id.toString(),
                                      coming:"viewprofileproject"
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

                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal*7,
                                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                    child: Column(
                                      children: [
                                       /* Container(
                                          child: Image.asset("assets/images/heart.png",height: 20,width: 20,),
                                        ),*/
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
                                       /* Container(
                                          child: Image.asset("assets/images/message.png",height: 20,width: 20),
                                        ),*/

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
                                          child: Text(loginResponse.data.copleteProjects.elementAt(indx).totallike.toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6 ),),
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
                                          child: Text(loginResponse.data.copleteProjects.elementAt(indx).totalcomments.toString(),style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize:SizeConfig.blockSizeVertical*1.6  ),),
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
                            child:new Html(
                              data: loginResponse.data.copleteProjects.elementAt(indx).description,
                              defaultTextStyle: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Row(
                              children: [
                                Text(
                                  'viewall'.tr,
                                  maxLines: 2,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black26,
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                                Text(" "+(loginResponse.data.copleteProjects.elementAt(indx).commentslist.length).toString()+" ",
                                  maxLines: 2,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black26,
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                                Text('comments'.tr,
                                  maxLines: 2,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black26,
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ],
                            )



                          ),
                          commentlist_length != null
                              ?
                          Container(
                            alignment: Alignment.topLeft,
                            height: SizeConfig.blockSizeVertical * 30,
                            child: ListView.builder(
                                itemCount: commentlist_length.length == null
                                    ? 0
                                    : commentlist_length.length,
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
                                     loginResponse.data.copleteProjects.elementAt(indx).commentslist.elementAt(i).comment,
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
            'about'.tr,
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