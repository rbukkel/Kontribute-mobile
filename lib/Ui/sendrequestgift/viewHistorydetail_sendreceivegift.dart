import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/SenddetailsPojo.dart';
import 'package:kontribute/Pojo/individualRequestDetailspojo.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class viewHistorydetail_sendreceivegift extends StatefulWidget{
  final String data;

  const viewHistorydetail_sendreceivegift({
    Key key,
    @required this.data}) : super(key: key);

  @override
  viewHistorydetail_sendreceivegiftState createState() => viewHistorydetail_sendreceivegiftState();
}

class viewHistorydetail_sendreceivegiftState extends State<viewHistorydetail_sendreceivegift>
{
  String data1;
  bool internet = false;
  String val;
  String image;
  var storelist_length;
  individualRequestDetailspojo senddetailsPojo;
  var productlist_length;

  @override
  void initState() {
    super.initState();
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        int a = int.parse(data1);
        print("receiverComing: "+a.toString());
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


  void getData(int id) async {
    Map data = {
      'id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.send_receive_gifts_contributer, body: data);
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
        senddetailsPojo = new individualRequestDetailspojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = senddetailsPojo.result;
            storelist_length = senddetailsPojo.paymentdetails.data;
            if (senddetailsPojo.result.receiverProfilePic == "")
            {
              setState(() {
                image = senddetailsPojo.result.adminProfilePic;
              });
            } else
            {
              setState(() {
                image = senddetailsPojo.result.receiverProfilePic;
              });
            }
          });
        } else {
          Fluttertoast.showToast(
            msg: senddetailsPojo.message,
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
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,
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
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset("assets/images/back.png",color:AppColors.whiteColor,width: 20,height: 20,),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal *75,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      StringConstant.sendandreceivehistorygift, textAlign: TextAlign.center,
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
                    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                  ),
                ],
              ),
            ),
            productlist_length != null?
            Container(
              child: Stack(
                children: [
                  Container(
                      height: SizeConfig.blockSizeVertical * 19,
                      width: SizeConfig.blockSizeHorizontal * 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: senddetailsPojo.result.giftPicture != null
                              ||
                              senddetailsPojo.result.giftPicture != ""
                              ? NetworkImage(Network.BaseApigift +senddetailsPojo.result.giftPicture)
                              : new AssetImage(
                              "assets/images/viewdetailsbg.png"),
                          fit: BoxFit.fill,
                        ),
                      )),
                  Row(
                    children: [
                      senddetailsPojo.result.receiverProfilePic ==
                          null ||
                          senddetailsPojo.result
                              .receiverProfilePic ==
                              ""
                          ?  senddetailsPojo.result.adminProfilePic ==
                          null ||
                          senddetailsPojo.result
                              .adminProfilePic ==
                              ""?
                      Container(
                          height:
                          SizeConfig.blockSizeVertical *
                              18,
                          width:
                          SizeConfig.blockSizeVertical *
                              17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: SizeConfig
                                  .blockSizeVertical *
                                  4,
                              bottom: SizeConfig
                                  .blockSizeVertical *
                                  1,
                              right: SizeConfig
                                  .blockSizeHorizontal *
                                  1,
                              left: SizeConfig
                                  .blockSizeHorizontal *
                                  4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors
                                  .themecolor,
                              style: BorderStyle.solid,
                            ),
                            image: new DecorationImage(
                              image: new AssetImage(
                                  "assets/images/account_circle.png"),
                              fit: BoxFit.fill,
                            ),
                          ))
                          : Container(
                        height:
                        SizeConfig.blockSizeVertical *
                            18,
                        width:
                        SizeConfig.blockSizeVertical *
                            17,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: SizeConfig
                                .blockSizeVertical *
                                4,
                            bottom: SizeConfig
                                .blockSizeVertical *
                                1,
                            right: SizeConfig
                                .blockSizeHorizontal *
                                1,
                            left: SizeConfig
                                .blockSizeHorizontal *
                                4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: AppColors
                                  .themecolor,
                              style: BorderStyle.solid,
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    senddetailsPojo.result
                                        .adminProfilePic),
                                fit: BoxFit.fill)),):
                      Container(
                        height:
                        SizeConfig.blockSizeVertical *
                            18,
                        width:
                        SizeConfig.blockSizeVertical *
                            17,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: SizeConfig
                                .blockSizeVertical *
                                4,
                            bottom: SizeConfig
                                .blockSizeVertical *
                                1,
                            right: SizeConfig
                                .blockSizeHorizontal *
                                1,
                            left: SizeConfig
                                .blockSizeHorizontal *
                                4),
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
                                    senddetailsPojo.result
                                        .receiverProfilePic),
                                fit: BoxFit.fill)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal *46,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *7),
                                child: Text(
                                  senddetailsPojo.result.receiverName == null
                                      ? senddetailsPojo.result.groupName
                                      : senddetailsPojo.result.receiverName,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                              GestureDetector(
                                onTap: ()
                                {
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top:  SizeConfig
                                        .blockSizeVertical *
                                        8,
                                    left: SizeConfig
                                        .blockSizeHorizontal *
                                        1,
                                    right: SizeConfig
                                        .blockSizeHorizontal *
                                        2,
                                  ),
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: AppColors.yelowbg,
                                        fontSize:12,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        'Poppins-Regular'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          /* Container(
                            width: SizeConfig.blockSizeHorizontal *60,
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal *3),
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(
                                left: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                right: SizeConfig
                                    .blockSizeHorizontal *
                                    2,
                                top: SizeConfig
                                    .blockSizeHorizontal *
                                    1),
                            child: Text(
                              StringConstant.totalContribution+"-25 ",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily:
                                  'Poppins-Regular'),
                            ),
                          ),*/
                          /* Container(
                            width: SizeConfig.blockSizeHorizontal *64,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(
                                left: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                right: SizeConfig
                                    .blockSizeHorizontal *
                                    2,
                                top: SizeConfig
                                    .blockSizeHorizontal *
                                    1),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                              maxLines: 2,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily:
                                  'Poppins-Regular'),
                            ),
                          ),*/
                          Container(
                            width: SizeConfig.blockSizeHorizontal *60,
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal *3),
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1,
                                right: SizeConfig.blockSizeHorizontal * 2,
                                bottom: SizeConfig.blockSizeVertical * 1,
                                top: SizeConfig.blockSizeHorizontal * 1),
                            child:
                            Text(
                              "Closing Date-" +
                                  senddetailsPojo.result.endDate!=null?senddetailsPojo.result.endDate:"",
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily:
                                  'Poppins-Regular'),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4),
                                child: Text(
                                  "Collection Target- ",
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
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  right: SizeConfig
                                      .blockSizeHorizontal *
                                      3,
                                ),
                                child: Text(
                                  "\$" +senddetailsPojo.result.price==null?senddetailsPojo.result.collectionTarget:senddetailsPojo.result.price,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.lightBlueAccent,
                                      fontSize: 10,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      'Poppins-Regular'),
                                ),
                              )
                            ],
                          ),
                          /*  Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Total Collected Amount- ",
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
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  right: SizeConfig
                                      .blockSizeHorizontal *
                                      3,
                                ),
                                child: Text(
                                  "\$40",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.lightBlueAccent,
                                      fontSize: 10,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      'Poppins-Regular'),
                                ),
                              )

                            ],
                          ),*/
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                            child:  LinearPercentIndicator(
                              width: 140.0,
                              lineHeight: 14.0,
                              percent: 0.6,
                              center: Text("60%"),
                              backgroundColor: AppColors.lightgrey,
                              progressColor:AppColors.themecolor,
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ],
              ),
            ):

            Container(
              child: Center(
                child: internet == true?CircularProgressIndicator():SizedBox(),
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
            /*   Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                  // margin: EdgeInsets.only(top: 10, left: 40),
                  child: Text(
                    StringConstant.exportto, textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
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
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical *2),
                    child: Image.asset("assets/images/csv.png",width: 80,height: 40,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical *2,right: SizeConfig.blockSizeHorizontal*4,),
                    child: Image.asset("assets/images/pdf.png",width: 80,height: 40,),
                  ),
                ),
              ],
            ),

            Expanded(
              child:
              ListView.builder(
                  itemCount: 8,
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
                                                width: SizeConfig.blockSizeHorizontal *53,
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
                                                width: SizeConfig.blockSizeHorizontal *53,
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
                                                margin: EdgeInsets.only( top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
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
            )*/
          ],
        ),
      ),

      bottomNavigationBar: bottombar(context),

    );
  }


}