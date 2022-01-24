import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/removerequestpojo.dart';
import 'package:kontribute/Pojo/sendfollow_RequestlistingPojo.dart';
import 'package:kontribute/Ui/viewdetail_profile.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class SendRequest extends StatefulWidget {
  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userid;
  bool resultvalue = true;
  bool internet = false;
  String val;
  String requestval;
  var storelist_length;
  sendfollow_RequestlistingPojo requestpojo;
  String searchvalue="";
  removerequestpojo removePojo;

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getdata(userid,searchvalue);

    });
  }

  void getdata(String user_id,String search) async {
    setState(() {
      storelist_length=null;
    });
    Map data = {
      'sender_id': user_id.toString(),
      'search': search.toString(),
    };
    print("follow_Request: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.sendfollow_Requestlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false)
      {
        setState(() {
          resultvalue = false;
        });
      } else {
        requestpojo = new sendfollow_RequestlistingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(requestpojo.result.isEmpty)
            {
              resultvalue = false;
            }
            else
            {
              resultvalue = true;
              print("SSSS");
              storelist_length = requestpojo.result;
            }
          });
        }
        else {
          errorDialog(requestpojo.message);

        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
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
                    'okay'.tr,
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


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
     /* key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),*/
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            _createSearchView(),
            SearchView()
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal*1,
          right: SizeConfig.blockSizeHorizontal *1),
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical *20,
          left: SizeConfig.blockSizeHorizontal*4,
          right: SizeConfig.blockSizeHorizontal*4),
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/searchbar.png"),
            fit: BoxFit.fill,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(textAlign: TextAlign.start,
            onChanged: (value){
              setState(() {
                getdata(userid,value);
              });
            },
            decoration: new InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black,fontSize: 12), hintText: 'search'.tr),
          )
        ],
      ) ,
    );
  }


  SearchView() {
    return Expanded(
      child: storelist_length != null ?
      Container(
        //height: SizeConfig.blockSizeVertical * 30,
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 2,
            right: SizeConfig.blockSizeHorizontal * 2),
        child:  MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child:
            ListView.builder(
                itemCount:  storelist_length.length == null
                    ? 0
                    : storelist_length.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
                      child: Row(
                        children: [
                          requestpojo.result.elementAt(index).profilePic!=null?
                          !requestpojo.result.elementAt(index).profilePic.startsWith("https://")?
                          GestureDetector(
                            onTap: ()
                            {
                              callNext(
                                  viewdetail_profile(
                                      data: requestpojo.result.elementAt(index).receiverId.toString()
                                  ), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.blockSizeVertical *
                                      1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
                                      5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors
                                        .themecolor,
                                    style: BorderStyle.solid,
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        Network.BaseApiprofile+requestpojo.result.elementAt(index).profilePic,
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                          ):
                          GestureDetector(
                            onTap: ()
                            {
                              callNext(
                                  viewdetail_profile(
                                      data: requestpojo.result.elementAt(index).receiverId.toString()
                                  ), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.blockSizeVertical *
                                      1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
                                      5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors
                                        .themecolor,
                                    style: BorderStyle.solid,
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        requestpojo.result.elementAt(index).profilePic,
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                          ):
                          GestureDetector(
                            onTap: ()
                            {
                              callNext(
                                  viewdetail_profile(
                                      data: requestpojo.result.elementAt(index).senderId.toString()
                                  ), context);
                            },
                            child: Container(
                              height:
                              SizeConfig.blockSizeVertical * 9,
                              width: SizeConfig.blockSizeVertical * 9,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.blockSizeVertical *
                                      1,
                                  top: SizeConfig.blockSizeVertical *
                                      1,
                                  right:
                                  SizeConfig.blockSizeHorizontal *
                                      1,
                                  left:
                                  SizeConfig.blockSizeHorizontal *
                                      5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors
                                      .themecolor,
                                  style: BorderStyle.solid,
                                ),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: new AssetImage("assets/images/account_circle.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),),
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 45,
                                    child: Text(
                                      requestpojo.result.elementAt(index).fullName!=null?requestpojo.result.elementAt(index).fullName:"",
                                      maxLines: 2,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.normal,
                                          fontFamily:
                                          'Poppins-Regular'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: ()
                                    {
                                     Removefromlisting(requestpojo.result.elementAt(index).id.toString());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal *23,
                                      padding: EdgeInsets.only(
                                          right: SizeConfig.blockSizeHorizontal * 2,
                                          left: SizeConfig.blockSizeHorizontal * 2,
                                          bottom: SizeConfig.blockSizeHorizontal * 2,
                                          top: SizeConfig.blockSizeHorizontal * 2),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: AppColors.themecolor)
                                      ),
                                      margin: EdgeInsets.only(
                                          right: SizeConfig.blockSizeHorizontal * 2,
                                          left: SizeConfig.blockSizeHorizontal * 2),
                                      child: Text(
                                        'remove'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: AppColors.themecolor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            'Poppins-Regular'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ));
                })),
      ):
      Container(
        margin: EdgeInsets.only(top: 60),
        alignment: Alignment.center,
        child: resultvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text('norecordsfound'.tr,style: TextStyle(
              letterSpacing: 1.0,
              color: AppColors.black,
              fontSize: 16,
              fontWeight:
              FontWeight.normal,
              fontFamily:
              'Poppins-Regular')),
        ),
      ),
    );
  }

  Future<void>  Removefromlisting(String id) async{
    Map data = {
      'id': id.toString(),
    };
    print("Remove id: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.remove_sendrequest, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      requestval = response.body;
      if (jsonResponse["success"] == false) {
        errorDialog(jsonDecode(requestval)["message"]);

      } else {
        removePojo = new removerequestpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");

          setState(() {
            getdata(userid,searchvalue);
          });
        }
        else {
          errorDialog(removePojo.message);
        }
      }
    } else {
      errorDialog(jsonDecode(requestval)["message"]);
    }
  }

}
