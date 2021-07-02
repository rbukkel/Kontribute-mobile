
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:kontribute/Ui/Carousel.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';
import 'dart:async';

import 'package:percent_indicator/linear_percent_indicator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    Timer timer;
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        percent += 1;

        if (percent >= 2) {
          timer.cancel();
          nextScreen();
        }

      });
    });
  }

  void nextScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Carousel()),
            (route) => false);

    /* SharedUtils.writeloginData("login").then((result) {
      if (result != null) {
        if (result) {
          print("trueValue");
          SharedUtils.readUserType('USERTYPE').then((response) {
            setState(() {
              if (response != null) {
                setState(() {
                  userType = response;
                  print("userType: " + userType.toString());
                });
              }
            });
          });

          if (userType == "store") {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeMotherScreen()),
                      (route) => false);
            });
          } else if (userType == "vendor") {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
            });
          }
        } else {
          print("falseValue");
          print("falseValue");
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
          });
        }
      } else {
        print("falseValue");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.whiteColor,
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                height: 450,
                width: 250,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 15,
                    right: SizeConfig.blockSizeHorizontal * 15),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 3000,
                  percent: 1.0,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  linearGradient:  LinearGradient(
                    colors: <Color>[AppColors.green, AppColors.parentgreen],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
