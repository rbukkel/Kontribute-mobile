import 'package:flutter/material.dart';
import 'package:kontribute/Ui/login.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

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
                    height: SizeConfig.blockSizeVertical * 17,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 10,
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      bottom: SizeConfig.blockSizeVertical *1,
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/email_bg.png"),
                        fit: BoxFit.fill,
                      ),
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
                          fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.emailaddres,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                              (route) => false);
/*
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Internet_check().check().then((intenet) {
                          if (intenet != null && intenet) {
                            signIn(
                                emailController.text, passwordController.text,token);
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
*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical * 7,
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
}