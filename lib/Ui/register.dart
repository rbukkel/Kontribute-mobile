import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;

class register extends StatefulWidget{
  @override
  registerState createState() => registerState();
  
}

class registerState extends State<register>{
  final _formKey = GlobalKey<FormState>();
  final NickNameFocus = FocusNode();
  final FullNameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final PwdFocus = FocusNode();
  final MobileFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nicknameController = new TextEditingController();
  final TextEditingController fullnameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  bool _showPassword = false;
  bool isLoading = false;
  String _email;
  String _password;
  String _nickname;
  String _fullname;
  String _mobile;
  File _imageFile;
  bool image_value = false;
  int nationalityid;
  int currentcountryid;
  List<dynamic> nationalityTypes = List();
  List<dynamic> currentcountryTypes = List();
  var currentSelectedValue;
  bool showvalue = false;
  var currentSelectedCountry;
  String token;
  var facebookLogin = FacebookLogin();
  bool isLoggedIn = false;
  var profileData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("Register token: " + token.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getNationalList();
      getCountryList();


      } else {
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }
  String selecteddate="Date of Birth";


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate:  DateTime.now());
    if (picked != null)
      setState(() {

        selecteddate = DateFormat('dd-MM-yyyy').format(picked);
        print("onDate: "+selecteddate.toString());
      });
  }

  void getCountryList() async {
    var res = await http.get(Uri.encodeFull(Network.BaseApi+Network.countrylist));
    final data = json.decode(res.body);
    List<dynamic> data1 = data["result_push"];

    setState(() {
      currentcountryTypes = data1;
    });
  }

  void getNationalList() async {
    var res = await http.get(Uri.encodeFull(Network.BaseApi+Network.nationality));
    final data = json.decode(res.body);
    List<dynamic> data1 = data["result_push"];

    setState(() {
      nationalityTypes = data1;
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
            image: new AssetImage("assets/images/signup_bg.png"),
            fit: BoxFit.fill,
          ),
        ),

          child:
          Form(
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


                  Expanded(
                      child: SingleChildScrollView(
                        child:  Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                              ),
                              alignment: Alignment.topCenter,
                              child: Text(
                                StringConstant.signup,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold',
                                    color: AppColors.whiteColor,
                                    fontSize: 26),
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
                              margin:
                              EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3,bottom: SizeConfig.blockSizeVertical * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal * 3,
                                          right: SizeConfig.blockSizeHorizontal * 3
                                      ),
                                      child: Image.asset(
                                        "assets/images/facebook.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    onTap: ()
                                    {
                                      loginmethod();
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left:SizeConfig.blockSizeHorizontal * 3,
                                          right: SizeConfig.blockSizeHorizontal * 3),
                                      child: Image.asset(
                                        "assets/images/gmail.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    onTap: () {
                                      signInWithGoogle();
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal * 3,
                                          right: SizeConfig.blockSizeHorizontal * 3),
                                      child: Image.asset(
                                        "assets/images/twitter.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    onTap: () {
                                      // signInWithGoogle();
                                    },
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
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
                            InkWell(
                              onTap: () {
                                showAlert();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                                child: Image.asset(
                                  "assets/images/camera.png",
                                  width:60,
                                  height: 60,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                              ),
                              child: Text(
                                StringConstant.profileoptional,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    color: AppColors.light_grey,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
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
                                focusNode: NickNameFocus,
                                controller: nicknameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter nick name";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  FocusScope.of(context).requestFocus(FullNameFocus);
                                },
                                onSaved: (val) => _nickname = val,
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
                                  hintText: StringConstant.nickname,
                                ),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
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
                                focusNode: FullNameFocus,
                                controller: fullnameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter full name";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  FocusScope.of(context).requestFocus(EmailFocus);
                                },
                                onSaved: (val) => _fullname = val,
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
                                  hintText: StringConstant.fullname,
                                ),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
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
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
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
                                  FocusScope.of(context).requestFocus(MobileFocus);
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
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
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
                                focusNode: MobileFocus,
                                controller: mobileController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter mobile number";
                                  else if (val.length != 10)
                                    return "Please enter valid mobile number";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  MobileFocus.unfocus();
                                },
                                onSaved: (val) => _mobile = val,
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
                                  hintText: StringConstant.mobile,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()
                              {
                                _selectDate(context);
                              },
                              child:  Container(
                                height: SizeConfig.blockSizeVertical *7,
                                width: SizeConfig.blockSizeHorizontal *90,
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 5,
                                ),
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 1,
                                  right: SizeConfig.blockSizeVertical * 1,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: Colors.transparent,
                                ),
                                child:
                                Text(selecteddate, textAlign: TextAlign.center,
                                  style:
                                  TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                              ),
                              padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeVertical * 2,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.transparent,
                              ),
                              child:
                              FormField<dynamic>(
                                builder: (FormFieldState<dynamic> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration.collapsed(hintText: ''),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<dynamic>(
                                        hint: Text("please select nationality",textAlign: TextAlign.center,style:
                                        TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.white),),
                                        dropdownColor: Colors.blueGrey,
                                        value: currentSelectedValue,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentSelectedValue = newValue;
                                             nationalityid = int.parse(newValue["num_code"]);
                                          });
                                        },
                                        items: nationalityTypes.map((dynamic value) {
                                          return DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text(value["nationality"],
                                              textAlign: TextAlign.center,style:
                                            TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.white),),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7,
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                              ),
                              padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeVertical * 2,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.transparent,
                              ),
                                child: FormField<dynamic>(
                                  builder: (FormFieldState<dynamic> state) {
                                    return InputDecorator(
                                      decoration:
                                      InputDecoration.collapsed(hintText: ''),
                                      child:
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<dynamic>(
                                          hint: Text("please select country",
                                            maxLines: 2,
                                            style:
                                          TextStyle(letterSpacing: 1.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              color: Colors.white),),
                                          dropdownColor: Colors.blueGrey,
                                          value: currentSelectedCountry,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              currentSelectedCountry = newValue;
                                              currentcountryid = int.parse(newValue["num_code"]);
                                            });
                                          },
                                          items:
                                          currentcountryTypes.map((dynamic value) {
                                            return DropdownMenuItem<dynamic>(
                                              value: value,

                                              child: Text(value["country"],
                                                maxLines: 2,
                                                style:
                                              TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.white),),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal *90,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,


                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 18,
                                    width: 18,
                                    child: Checkbox(
                                      value: showvalue,
                                      onChanged: (bool value) {
                                        setState(() {
                                          showvalue = value;
                                        });
                                      },

                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(StringConstant.terms,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Montserrat')),
                                  ),
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => TermsCondition()));*/
                                    },
                                    child: Container(
                                      child: Text(" " +StringConstant.condition,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 11,
                                              fontFamily: 'Montserrat')),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            GestureDetector(

                              /*  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => selectlangauge()),
                                        (route) => false);*/

                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    if (showvalue) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Internet_check().check().then((intenet) {
                                        if (intenet != null && intenet) {
                                          /*register(
                                            nicknameController.text,
                                              fullnameController.text,
                                              emailController.text,
                                              passwordController.text,
                                              mobileController.text,
                                              confirmpasswordController.text,
                                              nameController.text,token);*/
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
                                    else {
                                      Fluttertoast.showToast(
                                        msg: "please check Terms & Conditions",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                      );
                                    }
                                  }
                                },

                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: SizeConfig.blockSizeVertical * 7,
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 5,
                                  bottom: SizeConfig.blockSizeVertical * 2,
                                  left: SizeConfig.blockSizeHorizontal * 12,
                                  right: SizeConfig.blockSizeHorizontal * 12,
                                ),
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage("assets/images/btn.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Text(StringConstant.createnow,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    )),
                              ),
                            ),

                          ],
                        ),
                      )

                  )

                ],
              ),
            ),
          ),

      ),
    );
  }


  /*register(String email, String pass, String confirmPass, String name,String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'fullname': name,
      'email': email,
      'password': pass,
      'confirm_password': confirmPass,
      'mobile_token': token,
    };

    var jsonResponse = null;
    var response = await http.post(
        Network.BaseApi + Network.register, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();


        LoginResponse login = new LoginResponse.fromJson(jsonResponse);
        print('Result: ${login.resultPush.uid}');
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });
          sharedPreferences?.setBool("isLoggedIn", true);
          SharedUtils.saveDate("Token", login.resultPush.mobileToken);
          sharedPreferences.setInt("id", login.resultPush.uid);
          sharedPreferences.setString("name", login.resultPush.fullname);
          sharedPreferences.setString("email", login.resultPush.email);
          sharedPreferences.setString("mobile", login.resultPush.mobile);
          sharedPreferences.setString("image", login.resultPush.profilePic);
          sharedPreferences.setString(
              "billing_address", login.resultPush.billingAddress);
          sharedPreferences.setString(
              "shipping_address", login.resultPush.shippingAddress);

          Fluttertoast.showToast(
            msg: login.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => home()), (
              Route<dynamic> route) => false);
        }
        else {
          setState(() {
            isLoading = false;
          });
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(
            msg: login.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    }
    else if (response.statusCode == 422) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonResponse["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }*/


  showAlert() {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: AppColors.CameraDialog,
        child: new Container(
          margin: EdgeInsets.all(5),
          width: 300.0,
          height: 300.0,
          /*decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 120.0,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  /* setState(() {
                    image_value = false;
                  });*/
                  captureImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  color: AppColors.whiteColor,
                  child: Text(
                    'Camera ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  /* setState(() {
                    image_value = false;
                  });*/
                  captureImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
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
                    'Cancel',
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

  Future<void> captureImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      try {
        final imageFile =
        await ImagePicker.pickImage(source: imageSource, imageQuality: 80);
        setState(() async {
          _imageFile = imageFile;
          if (_imageFile != null && await _imageFile.exists()) {
            setState(() {
              image_value = false;
            });
          } else {
            Fluttertoast.showToast(
              msg: "Please Select Image ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        });
      } catch (e) {
        print(e);
      }
    } else if (imageSource == ImageSource.gallery) {
      try {
        final imageFile =
        await ImagePicker.pickImage(source: imageSource, imageQuality: 80);
        setState(() async {
          _imageFile = imageFile;
          if (_imageFile != null && await _imageFile.exists()) {
            setState(() {
              image_value = false;
            });
          } else {
            Fluttertoast.showToast(
              msg: "Please Select Image ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }
  void loginmethod() {
    Internet_check().check().then((intenet) async {
      if (intenet != null && intenet) {
        initiateFacebookLogin();
      } else {
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      setState(() {
        SharedUtils.readloginData("login", true);
        /* fetchData(
            user.displayName, user.email, user.uid, user.photoURL, vendorname);
        SharedUtils.readloginId("login_type", "google");*/


      });
      return '$user';
    } else {
      print('Already Login: $user');
    }
    return null;
  }


  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Facebook error: ");
        onLoginStatusChanged(false);
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("Facebook cancel");
        onLoginStatusChanged(false);
        break;

      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        print("ProfileEmail" + profile['email'].toString());
        print("ProfileID: " + profile['id'].toString());
        print("ProfileName: " + profile['name'].toString());
        print(profile['picture']['data']['url']);
        onLoginStatusChanged(true, profileData: profile);
        SharedUtils.readloginData("login", true);
        /* fetchData(
            profile['name'].toString(),
            profile['email'].toString(),
            profile['id'].toString(),
            profile['picture']['data']['url'].toString(),
            vendorname);*/
        SharedUtils.readloginId("login_type", "facebook");

        // Navigator.of(context).pop();
        break;
    }
  }

}