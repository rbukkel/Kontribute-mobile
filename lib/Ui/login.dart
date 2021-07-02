import 'package:flutter/material.dart';
import 'package:kontribute/Ui/forget_screen.dart';
import 'package:kontribute/Ui/register.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class login extends StatefulWidget{
  @override
  loginState createState() => loginState();
}

class loginState extends State<login>{
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
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 7,
                      left: SizeConfig.blockSizeHorizontal * 12,
                      right: SizeConfig.blockSizeHorizontal * 12,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeVertical * 1,
                      right: SizeConfig.blockSizeVertical * 1,
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
                          fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.emailaddres,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 5,
                      left: SizeConfig.blockSizeHorizontal * 12,
                      right: SizeConfig.blockSizeHorizontal * 12,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeVertical * 1,
                      right: SizeConfig.blockSizeVertical * 1,
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
                      textInputAction: TextInputAction.done,
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
                      TextStyle(letterSpacing: 1.0,   fontSize: 15, fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',color: Colors.white),
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.password,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => selectlangauge()),
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
                      height: SizeConfig.blockSizeVertical * 8,
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
                  Container(
                    margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                    width: 300,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                     Container(
                       width:60,
                       child:  Divider(
                         color: Colors.grey,
                         thickness: 1,
                       ),
                     ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text(StringConstant.or,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',)),
                      ),
                      Container(
                        width:60,
                        child:  Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ]),
                  ),

                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3),
                            child: Image.asset(
                              "assets/images/facebook.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          onTap: ()
                          {

                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3),
                            child: Image.asset(
                              "assets/images/gmail.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          onTap: () {
                           // signInWithGoogle();
                          },
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}