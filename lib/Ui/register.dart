import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

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
                            InkWell(
                              onTap: () {
                                showAlert();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                                child: Image.asset(
                                  "assets/images/camera.png",
                                  width: 80,
                                  height: 80,
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
                            Container(
                              height: SizeConfig.blockSizeVertical *7.5,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                                left: SizeConfig.blockSizeHorizontal * 12,
                                right: SizeConfig.blockSizeHorizontal * 12,
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
                              Text("Date of Birth", textAlign: TextAlign.center,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7.5,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                                left: SizeConfig.blockSizeHorizontal * 12,
                                right: SizeConfig.blockSizeHorizontal * 12,
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
                                        hint: Text("Nationality",textAlign: TextAlign.center,style:
                                        TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),),
                                        dropdownColor: Colors.white,
                                        value: currentSelectedValue,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentSelectedValue = newValue;
                                            //  nationalityid = int.parse(newValue["inst_id"]);
                                          });
                                        },
                                        items: nationalityTypes.map((dynamic value) {
                                          return DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text("",textAlign: TextAlign.center,style:
                                            TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical *7.5,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                                left: SizeConfig.blockSizeHorizontal * 12,
                                right: SizeConfig.blockSizeHorizontal * 12,
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
                                        hint: Text("Current Country",textAlign: TextAlign.center,style:
                                        TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),),
                                        dropdownColor: Colors.white,
                                        value: currentSelectedCountry,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentSelectedCountry = newValue;
                                            //  nationalityid = int.parse(newValue["inst_id"]);
                                          });
                                        },
                                        items: currentcountryTypes.map((dynamic value) {
                                          return DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text("",textAlign: TextAlign.center,style:
                                            TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',  fontSize: 15,color: Colors.white),),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5,
                                left: SizeConfig.blockSizeHorizontal * 10,
                                right: SizeConfig.blockSizeHorizontal * 10,

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
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => selectlangauge()),
                                        (route) => false);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: SizeConfig.blockSizeVertical * 8,
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


}