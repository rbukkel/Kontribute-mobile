import 'package:flutter/material.dart';
import 'package:kontribute/Ui/login.dart';
import 'package:kontribute/Ui/ForgotOTPScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kontribute/Pojo/ForgotPasswordPojo.dart';

class forget_screen extends StatefulWidget{
  @override
  forget_screenState createState() => forget_screenState();
}

class forget_screenState extends State<forget_screen>{
  final _formKey = GlobalKey<FormState>();
  final EmailFocus = FocusNode();
  final PwdFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _showPassword = false;
  String _email;
  String _password;
  bool isLoading = false;
  ForgotPasswordPojo forgotpass;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/welcome_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 5,
                  bottom: SizeConfig.blockSizeVertical * 1),
              child: Column(
                children: [
                  Container(
                    child:
                    Row(
                      children: [
                        titlebar(context, ""),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 8,
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      StringConstant.appname,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                          color: AppColors.black,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                    ),
                    child: Text(
                      StringConstant.forgotyourpassword,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          color: AppColors.black,
                          fontSize:18),
                    ),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 13,
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      top: SizeConfig.blockSizeVertical *7,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      bottom: SizeConfig.blockSizeVertical *1,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/registerbtn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child:TextFormField(
                      autofocus: false,
                      focusNode: EmailFocus,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val.length == 0)
                          return "Please enter email";
                        else if (!regex.hasMatch(val))
                          return "Please enter valid email";
                        else
                          return null;
                      },
                      onFieldSubmitted: (v)
                      {
                        FocusScope.of(context).requestFocus(PwdFocus);
                      },
                      onSaved: (val) => _email = val,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 14,color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.emailaddres,
                      ),
                    ),
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical *1,
                          ),
                          alignment: Alignment.centerLeft,
                          height: SizeConfig.blockSizeVertical *18,
                          width: SizeConfig.blockSizeHorizontal *18,
                          child:  ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.mail_outline_sharp, color: AppColors.iconcolor),
                            style: ElevatedButton.styleFrom(
                              shadowColor: AppColors.iconcolor,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              primary: Colors.white, // <-- Button color
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                          ),
                        ),
                        Container(
                            width: SizeConfig.blockSizeHorizontal *60,
                            child:
                            TextFormField(
                              autofocus: false,
                              focusNode: EmailFocus,
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val.length == 0)
                                  return "Please enter email";
                                else if (!regex.hasMatch(val))
                                  return "Please enter valid email";
                                else
                                  return null;
                              },
                              onFieldSubmitted: (v)
                              {
                                FocusScope.of(context).requestFocus(PwdFocus);
                              },
                              onSaved: (val) => _email = val,
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',  fontSize: 10,
                                  decoration: TextDecoration.none,
                                ),
                                hintText: StringConstant.emailaddres,
                              ),
                            ),
                        )

                      ],
                    )*/
                  ),

                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Internet_check().check().then((intenet) {
                          if (intenet != null && intenet) {
                            signIn(emailController.text,context);
                          } else {
                            errorDialog("No Internet Connection");
                          }
                          // No-Internet Case
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical * 9,
                      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 5,
                        left: SizeConfig.blockSizeHorizontal * 12,
                        right: SizeConfig.blockSizeHorizontal * 12,
                      ),
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/btn.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(StringConstant.reset,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 30,bottom: SizeConfig.blockSizeVertical *2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forget_screen()));*/
                          },
                          child: Container(
                            child: Text(StringConstant.needhelp,
                                style: TextStyle(
                                  color: AppColors.light_grey,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 15,
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
  
  signIn(String emal, BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "email":emal,
    };
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.forgetPassword_user, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        forgotpass = new ForgotPasswordPojo.fromJson(jsonResponse);
        if (jsonResponse != null) {

          emailController.text =" ";


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
                        forgotpass.message,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => ForgotOTPScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        color: AppColors.whiteColor,
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          'OK',
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

        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          errorDialog(forgotpass.message);
        }
      }
    } else if (response.statusCode == 500){
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog("Internal Server Error");
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);
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
                    'OK',
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

  void errorDialog1(String text) {
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
                    'OK',
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

}