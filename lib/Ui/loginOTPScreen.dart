import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';

import 'package:kontribute/Ui/forget_screen.dart';
import 'package:kontribute/Ui/register.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/MyConnections/ContactsPage.dart';

class loginOTPScreen extends StatefulWidget{
  final String data;
  final String pass;

  const loginOTPScreen({Key key, @required this.data, @required this.pass})
      : super(key: key);

  @override
  loginOTPScreenState createState() => loginOTPScreenState();
}

class loginOTPScreenState extends State<loginOTPScreen>{
  final _formKey = GlobalKey<FormState>();
  final EmailFocus = FocusNode();
  final PwdFocus = FocusNode();
  final OTPFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController OtpController = new TextEditingController();
  bool _showPassword = false;
  String _email;
  String _password;
  String _otp;
  String token;
  var facebookLogin = FacebookLogin();
  bool isLoggedIn = false;
  bool isLoading = false;
  var profileData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth _authtwitter = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User user;
  String data1;
  String pass1;
  String emai;
  String passwo;
  String message;
  bool internet = false;
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging();

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

  @override
  void initState() {
    super.initState();

    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("Login token: " + token.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        pass1 = widget.pass;
        print("ID: "+data1.toString());
        print("Pass: "+pass1.toString());
        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        errorDialog("No Internet Connection");

      }
    });

  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 9,
                  bottom: SizeConfig.blockSizeVertical * 1),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 8,
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      StringConstant.signin,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                          color: AppColors.whiteColor,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                    ),
                    child: Text(
                      StringConstant.welcometokontribute,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          color: AppColors.light_grey,
                          fontSize: 20),
                    ),
                  ),
              /*    Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 7,
                      left: SizeConfig.blockSizeHorizontal * 10,
                      right: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeVertical * 3,
                      right: SizeConfig.blockSizeVertical * 3,
                    ),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                    ),
                    child: TextFormField(
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
                          fontFamily: 'Poppins-Regular',  fontSize: 10,color: Colors.white),
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
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 5,
                      left: SizeConfig.blockSizeHorizontal * 10,
                      right: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeVertical * 3,
                      right: SizeConfig.blockSizeVertical * 3,
                    ),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                    ),
                    child: TextFormField(
                      autofocus: false,
                      focusNode: PwdFocus,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val.length == 0)
                          return "Please enter password";
                        else if (val.length <= 4)
                          return "Your password should be more then 5 char long";
                        else
                          return null;
                      },
                      onFieldSubmitted: (v) {
                        PwdFocus.unfocus();
                      },
                      onSaved: (val) => _password = val,
                      obscureText: !this._showPassword,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(letterSpacing: 1.0,   fontSize: 10, fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',color: Colors.white),
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 10,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.password,
                      ),
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 7,
                      left: SizeConfig.blockSizeHorizontal * 10,
                      right: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeVertical * 3,
                      right: SizeConfig.blockSizeVertical * 3,
                    ),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                    ),
                    child: TextFormField(
                      autofocus: false,
                      focusNode: OTPFocus,
                      controller: OtpController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val.length == 0)
                          return "Please enter otp";
                        else
                          return null;
                      },
                      onFieldSubmitted: (v) {
                        OTPFocus.unfocus();
                      },
                      onSaved: (val) => _otp = val,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(letterSpacing: 1.0,   fontSize: 10, fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 10,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.Otp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Internet_check().check().then((intenet) {
                          if (intenet != null && intenet) {
                            signIn(OtpController.text,token);
                          } else {
                            Fluttertoast.showToast(
                              msg: "No Internet Connection",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                            );
                          }
                          // No-Internet Case
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical * 7,
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 5,
                        left: SizeConfig.blockSizeHorizontal * 10,
                        right: SizeConfig.blockSizeHorizontal * 10,
                      ),
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/btn.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(StringConstant.signin,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forget_screen()));
                          },
                          child: Container(
                            child: Text(StringConstant.forgetpwd,
                                style: TextStyle(
                                    color: AppColors.light_grey,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 15,
                                    )),
                          ),
                        ),
                        Container(
                            height: 20,
                            child: VerticalDivider(
                                thickness: 1, color: AppColors.light_grey,)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register()));
                          },
                          child: Container(
                            child: Text(StringConstant.register,
                                style: TextStyle(
                                  color: AppColors.light_grey,
                                    fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',)),
                          ),
                        )
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





  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  signIn(String otp,String token) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "email":widget.data.toString(),
      "password":widget.pass.toString(),
      "mobile_token":token,
      "otp":otp,
      };
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.login, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        LoginResponse login = new LoginResponse.fromJson(jsonResponse);
        String jsonProfile = jsonEncode(login);
        print(jsonProfile);
        SharedUtils.saveProfile(jsonProfile);
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });
          SharedUtils.readloginData("login",true);
          SharedUtils.saveDate("Token", login.resultPush.mobileToken);
          SharedUtils.writeloginId("UserId", login.resultPush.userId.toString());
          SharedUtils.writeloginId("Usename", login.resultPush.fullName);
          errorDialog(login.message);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      selectlangauge()),
                  (route) => false);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
            //   isLoading = false;
          });
          errorDialog(login.message);
        }
      }
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);

    }
  }


}