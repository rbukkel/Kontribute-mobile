import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class mytranscation extends StatefulWidget {
  @override
  mytranscationState createState() => mytranscationState();
}

class mytranscationState extends State<mytranscation> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String tabvalue ="Paid";
  bool paid = true;
  bool receive = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 12,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/appbar.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 6,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/menu.png",
                          color: AppColors.whiteColor,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    // margin: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      "My Transcation",
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
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 3,
                        top: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      tabvalue ="Paid";
                      paid = true;
                      receive = false;
                    });

                    print("Value: "+tabvalue);
                  },
                  child:  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 6,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Card(
                        color: paid?AppColors.light_grey:AppColors.whiteColor,
                        child: Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          height: SizeConfig.blockSizeVertical * 5,
                          child: Text(StringConstant.amountpaid),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      tabvalue ="Received";
                      paid = false;
                      receive = true;
                      
                    });

                    print("Value: "+tabvalue);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 6,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Card(
                          color: receive?AppColors.light_grey:AppColors.whiteColor,
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(StringConstant.amountreceive),
                          ))) ,
                ),
              ],
            ),

            tabvalue=="Received"?tabReceivedlist():tabPaidlist()

          ],
        ),
      ),
    );
  }

  tabPaidlist() {
    return Expanded(
      child:
      ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
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
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
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
                                    12,
                                width:
                                SizeConfig.blockSizeVertical *
                                    12,
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
                                        width: SizeConfig.blockSizeHorizontal *52,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Sam Miller",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
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
                                          "01-01-2020",
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
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                        width: SizeConfig.blockSizeHorizontal *50,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Project Name",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
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
                                          "Amount Paid",
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
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                        width: SizeConfig.blockSizeHorizontal *48,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                                          maxLines: 2,
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
                                        width: SizeConfig.blockSizeHorizontal *20,
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
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
                                                1,
                                            top: SizeConfig
                                                .blockSizeHorizontal *
                                                1),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1.0)
                                        ),
                                        child: Text(
                                          "\$200",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.white,
                                              fontSize: 12,
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
    );
  }
  tabReceivedlist() {
    return Expanded(
      child:
      ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
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
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2),
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
                                    12,
                                width:
                                SizeConfig.blockSizeVertical *
                                    12,
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
                                        width: SizeConfig.blockSizeHorizontal *52,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Sam Miller",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
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
                                          "01-01-2020",
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
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                        width: SizeConfig.blockSizeHorizontal *45,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Project Name",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
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
                                          "Amount Received",
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
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
                                        width: SizeConfig.blockSizeHorizontal *48,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig
                                              .blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                                          maxLines: 2,
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
                                        width: SizeConfig.blockSizeHorizontal *20,
                                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1),
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
                                                1,
                                            top: SizeConfig
                                                .blockSizeHorizontal *
                                                1),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1.0)
                                        ),
                                        child: Text(
                                          "\$200",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.white,
                                              fontSize: 12,
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
    );
  }
}
