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

class viewHistorydetail_sendreceivegift extends StatefulWidget{
  @override
  viewHistorydetail_sendreceivegiftState createState() => viewHistorydetail_sendreceivegiftState();

}

class viewHistorydetail_sendreceivegiftState extends State<viewHistorydetail_sendreceivegift>{

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
                            18,
                        width:
                        SizeConfig.blockSizeVertical *
                            17,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical *6,
                            bottom: SizeConfig.blockSizeVertical *1,
                            right: SizeConfig
                                .blockSizeHorizontal *
                                1,
                            left: SizeConfig
                                .blockSizeHorizontal *
                                4),
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
                                width: SizeConfig.blockSizeHorizontal *46,
                                alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *7),
                                child: Text(
                                  "Sam Miller",
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
                          Container(
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
                          ),
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
                                left: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                right: SizeConfig
                                    .blockSizeHorizontal *
                                    2,
                                bottom: SizeConfig.blockSizeVertical *1,
                                top: SizeConfig
                                    .blockSizeHorizontal *
                                    1),
                            child: Text(
                              "Closing Date-21-05-2021 ",
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
                                  "\$1000",
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
                          Row(
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
                          ),
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
            )
          ],
        ),
      ),

      bottomNavigationBar: bottombar(context),

    );
  }


}