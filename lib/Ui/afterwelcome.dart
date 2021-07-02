import 'package:flutter/material.dart';
import 'package:kontribute/Ui/login.dart';
import 'package:kontribute/Ui/register.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class afterwelcome extends StatefulWidget{
  @override
  afterwelcomeState createState() => afterwelcomeState();
  
}

class afterwelcomeState extends State<afterwelcome>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/afterwelcome_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              alignment: Alignment.topCenter,
              margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*18),
              child: Text(StringConstant.appname,textAlign:TextAlign.center,style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 2.0,),),),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 4,
                  left: SizeConfig.blockSizeHorizontal*2,
                  right: SizeConfig.blockSizeHorizontal*2),
              alignment: Alignment.topCenter,
              width: SizeConfig.blockSizeHorizontal * 92,
              child: Text(StringConstant.dummytext,textAlign:TextAlign.center,style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                letterSpacing:1.5,),),),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical * 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.whiteColor,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  color: AppColors.whiteColor,
                ),
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 10,
                  bottom: SizeConfig.blockSizeVertical * 3,
                  left: SizeConfig.blockSizeHorizontal * 12,
                  right: SizeConfig.blockSizeHorizontal * 12,
                ),
                child: Text(
                  StringConstant.register,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 1.0,
                      color: Colors.black,
                      fontSize:
                      SizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins-Regular'),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => register()));
              },
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical * 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 1.0,
                  ),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 5,
                  bottom: SizeConfig.blockSizeVertical * 3,
                  left: SizeConfig.blockSizeHorizontal * 12,
                  right: SizeConfig.blockSizeHorizontal * 12,
                ),
                child: Text(
                  StringConstant.login,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 1.0,
                      color: Colors.white,
                      fontSize:
                      SizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins-Regular'),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => login()));
              },
            )
          ],
        ),
      ),
    );
  }
}