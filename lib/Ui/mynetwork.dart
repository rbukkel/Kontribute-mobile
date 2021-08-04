import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';

class mynetwork extends StatefulWidget {
  @override
  _mynetworkState createState() => _mynetworkState();
}

class _mynetworkState extends State<mynetwork> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      "My Network",
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
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    color: AppColors.whiteColor,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 5),
                            child: Text(
                              "Connections",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins-Regular",
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 5),
                            child: Text(
                              "883",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins-Regular",
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    color: AppColors.whiteColor,
                    // height: SizeConfig.blockSizeVertical *8,
                    child: Card(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Invitations",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: AppColors.theme1color),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Image.asset(
                                "assets/images/next.png",
                                color: AppColors.black,
                                width: 15,
                                height: 15,
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: ListView.builder(
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
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
                                            image: DecorationImage(
                                          image: new AssetImage(
                                              "assets/images/userProfile.png"),
                                          fit: BoxFit.fill,
                                        )),
                                      ),
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
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  45,
                                              padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                              ),
                                              child: Text(
                                                "Yogita Sharma",
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.themecolor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  45,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                1,
                                          ),
                                          child: Text(
                                            "android,iOS,Laravel,PHP",
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black87,
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular'),
                                          ),
                                        ),
                                        Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    45,
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                new Icon(
                                                  Icons.all_inclusive,
                                                  color: Colors.black87,
                                                  size: 10.0,
                                                ),
                                                Text(
                                                  " 53 mutual connections",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black87,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.blockSizeHorizontal * 1,
                                              right: SizeConfig.blockSizeHorizontal *3,
                                              top: SizeConfig.blockSizeVertical * 1),
                                          child: Image.asset(
                                            "assets/images/error.png",
                                            color: AppColors.black,
                                            width: 38,
                                            height: 38,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1),
                                          child: Image.asset(
                                            "assets/images/check.png",
                                            color: AppColors.theme1color,
                                            width: 38,
                                            height: 38,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            "Show more",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Poppins-Regular",
                                color: AppColors.theme1color),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    color: AppColors.whiteColor,
                    // height: SizeConfig.blockSizeVertical *8,
                    child: Card(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Connections",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Poppins-Regular",
                                    color: AppColors.theme1color),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Image.asset(
                                "assets/images/next.png",
                                color: AppColors.black,
                                width: 15,
                                height: 15,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 30,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              bottom: SizeConfig.blockSizeVertical * 2,
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1),
                                            child: Image.asset(
                                              "assets/images/error.png",
                                              color: AppColors.black,
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewdetail_profile()));
                                                },
                                                child: Container(
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      12,
                                                  width: SizeConfig
                                                          .blockSizeVertical *
                                                      12,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      bottom: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                      right: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          5),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                    image: new AssetImage(
                                                        "assets/images/userProfile.png"),
                                                    fit: BoxFit.fill,
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    55,
                                            padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Yogita Sharma",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    55,
                                            padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Android Developer",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  55,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  new Icon(
                                                    Icons.all_inclusive,
                                                    color: Colors.black87,
                                                    size: 10.0,
                                                  ),
                                                  Text(
                                                    " 10 mutual connections",
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        color: AppColors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            'Poppins-Regular'),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
