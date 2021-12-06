import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Ui/afterwelcome.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';

class CustomIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomIndicatorState();
  }
}

class CustomIndicatorState extends State<CustomIndicator> {
  int currentPos = 0;
  List<String> listPaths = [
    "assets/images/welcome1.png",
    "assets/images/welcome2.png",
    "assets/images/welcome3.png",
  ];

  List<String> textlist = [
    "assets/images/welcome1.png",
    "assets/images/welcome2.png",
    "assets/images/welcome3.png",
  ];

  Widget circleText(int i, String text) {
    var parts = text.split(',');
    var FirstText = parts[0].trim();
    var SecondText = parts[1].trim();
    var ThirdText = parts[2].trim();
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      //margin: EdgeInsets.symmetric(horizontal: 8),
      child: i == 0
          ? Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => afterwelcome()),
                          (route) => false);
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            letterSpacing: 1.0,
                          ),
                        )),
                  ),*/
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 90,
                    alignment: Alignment.topCenter,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                    child: Text(
                      "Send/Receive Gifts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                    width: SizeConfig.blockSizeHorizontal * 90,
                    alignment: Alignment.topCenter,
                    child: Text(
                      FirstText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        SecondText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 1.0,
                        ),
                      )),
                  Container(
                      alignment: Alignment.topCenter,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        ThirdText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 1.0,
                        ),
                      )),
                ],
              ),
            )
          : i == 1 ? Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*   GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => afterwelcome()),
                              (route) => false);
                        },
                        child: Container(
                            alignment: Alignment.topRight,
                            width: SizeConfig.blockSizeHorizontal * 90,
                            child: Text(
                              "Skip",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Bold',
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 1.0,
                              ),
                            )),
                      ),*/
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 4),
                        child: Text(
                          "Projects",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                        alignment: Alignment.topCenter,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: Text(
                          FirstText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            SecondText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Bold',
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              letterSpacing: 1.0,
                            ),
                          )
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            ThirdText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Bold',
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              letterSpacing: 1.0,
                            ),
                          )),
                    ],
                  ),
                )
              :
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*  GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => afterwelcome()),
                              (route) => false);
                        },
                        child: Container(
                            alignment: Alignment.topRight,
                            width: SizeConfig.blockSizeHorizontal * 90,
                            child: Text(
                              "Next",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Bold',
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 1.0,
                              ),
                            )),
                      ),*/
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 4),
                        child: Text(
                          "Events",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 4),
                        alignment: Alignment.topCenter,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: Text(
                          FirstText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            SecondText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Bold',
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              letterSpacing: 1.0,
                            ),
                          )),
                      Container(
                          alignment: Alignment.topCenter,
                          width: SizeConfig.blockSizeHorizontal * 90,
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                          ),
                          child: Text(
                            ThirdText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Bold',
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              letterSpacing: 1.0,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/welcome_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
          width: SizeConfig.blockSizeHorizontal * 90,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < listPaths.length; i++)
                if (i == currentPos) ...[
                  i == 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => afterwelcome()),
                                (route) => false);
                          },
                          child: Container(
                              alignment: Alignment.topRight,
                              width: SizeConfig.blockSizeHorizontal * 90,
                              child: Text(
                                "Skip",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins-Bold',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                ),
                              )),
                        )
                      : i == 1
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => afterwelcome()),
                                    (route) => false);
                              },
                              child: Container(
                                  alignment: Alignment.topRight,
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  child: Text(
                                    "Skip",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Bold',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      letterSpacing: 1.0,
                                    ),
                                  )),
                            )
                          : i == 2
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                afterwelcome()),
                                        (route) => false);
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 90,
                                      child: Text(
                                        "Next",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins-Bold',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          letterSpacing: 1.0,
                                        ),
                                      )),
                                )
                              : SizedBox()
                ]
            ],
          ),
        ),
        CarouselSlider.builder(
          itemCount: listPaths.length,
          options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPos = index;
                });
              }),
          itemBuilder: (context, index) {
            return MyImageView(listPaths[index]);
          },
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
          child: Row(
            children: <Widget>[
              for (int i = 0; i < listPaths.length; i++)
                if (i == currentPos) ...[
                  i == 0
                      ? circleText(i,
                          'Receive Birthday Gifts in cash from ,Friends and also send Gifts them..., ')
                      : i == 1
                          ? circleText(i,
                              'Collect Cash to support entrepreneurs ,in their projects or ask for support,in their own projects...')
                          : i == 2
                              ? circleText(i,
                                  'Collect Cash for Social,Events as a Gift...,')
                              : SizedBox()
                ]
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listPaths.map((url) {
            int index = listPaths.indexOf(url);
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPos == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
        /* GestureDetector(
        onTap: ()
        {
          for (int i = 0; i < listPaths.length; i++)
            if (i == currentPos){
              i == 0 ? circleText(i,
                  'Receive Birthday Gifts in cash from ,Friends and also send Gifts them..., ')
                  : i == 1
                  ? circleText(i,
                  'Collect Cash to support entrepreneurs ,in their projects or ask for support,in their own projects...')
                  : i == 2
                  ? circleText(i,
                  'Collect Cash for Social,Events as a Gift...,')
                  : SizedBox()
            }
        },
        child: Container(
          alignment: Alignment.center,
          height: SizeConfig.blockSizeVertical * 6,
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 5,
              bottom: SizeConfig.blockSizeVertical * 3,
              left: SizeConfig.blockSizeHorizontal * 15,
              right: SizeConfig.blockSizeHorizontal * 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: new DecorationImage(
              image: new AssetImage("assets/images/sendbutton.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Text('Next'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
                fontSize: 15,
              )),
        ),
      )*/
      ]),
    ));
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
          left: 5, right: 5, top: SizeConfig.blockSizeVertical * 10),
      child: Image.asset(
        imgPath,
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal * 60,
        fit: BoxFit.fill,
      ),
    );
  }
}
