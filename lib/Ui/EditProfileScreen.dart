import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class EditProfileScreen extends StatefulWidget{
  @override
  EditProfileScreenState createState() => EditProfileScreenState();

}

class EditProfileScreenState extends State<EditProfileScreen>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final NickNameFocus = FocusNode();
  final FullNameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final DateofbirthFocus = FocusNode();
  final MobileFocus = FocusNode();
  final CompanynameFocus = FocusNode();
  final NatinalityFocus = FocusNode();
  final CurrentCountryFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nicknameController = new TextEditingController();
  final TextEditingController fullnameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController dateofbirthController = new TextEditingController();
  final TextEditingController companynameController = new TextEditingController();
  final TextEditingController natinalityController = new TextEditingController();
  final TextEditingController currentCountryController = new TextEditingController();
  File _imageFile;
  bool image_value = false;
  bool _showPassword = false;
  String _email;
  String _dateofbirth;
  String _nickname;
  String _fullname;
  String _mobile;
  String _companyname;
  String _natinality;
  String _currentCountry;

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



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
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
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/back.png",
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
                      "Edit Profile",
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
                child: Form(
                  child: Container(
                    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *1,right: SizeConfig.blockSizeHorizontal *1),
                    child: Column(
                      children: [
                        Stack(
                          children: [

                            GestureDetector(
                              onTap: () {
                                showAlert();
                              },
                              child:  Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 4),
                                height: 120,
                                width: 120,
                                child: Image.asset(
                                  "assets/images/userProfile.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.nickname,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal *58,
                              margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              alignment: Alignment.topLeft,

                              child: TextFormField(
                                  autofocus: false,
                                  focusNode: NickNameFocus,
                                  controller: nicknameController,
                                  cursorColor: AppColors.selectedcolor,
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
                                  textAlign: TextAlign.left,
                                  style:
                                  TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                  decoration: InputDecoration(
                                    focusColor: AppColors.selectedcolor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.light_grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.selectedcolor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.selectedcolor),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.fullname,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                autofocus: false,
                                focusNode: FullNameFocus,
                                controller: fullnameController,
                                cursorColor: AppColors.selectedcolor,
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
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.emailid,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                autofocus: false,
                                focusNode: EmailFocus,
                                controller: emailController,
                                cursorColor: AppColors.selectedcolor,
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
                                  FocusScope.of(context).requestFocus(MobileFocus);
                                },
                                onSaved: (val) => _email = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.mobileno,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
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
                                cursorColor: AppColors.selectedcolor,
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
                                  FocusScope.of(context).requestFocus(DateofbirthFocus);
                                },
                                onSaved: (val) => _mobile = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.dateofbirth,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
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
                                focusNode: DateofbirthFocus,
                                controller: dateofbirthController,
                                cursorColor: AppColors.selectedcolor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter date of birth";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  FocusScope.of(context).requestFocus(CompanynameFocus);
                                },
                                onSaved: (val) => _dateofbirth = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.companyname,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                autofocus: false,
                                focusNode: CompanynameFocus,
                                controller: companynameController,
                                cursorColor: AppColors.selectedcolor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter company name";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  FocusScope.of(context).requestFocus(NatinalityFocus);
                                },
                                onSaved: (val) => _companyname = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.nationality,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                autofocus: false,
                                focusNode: NatinalityFocus,
                                controller: natinalityController,
                                cursorColor: AppColors.selectedcolor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter natinality";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                  FocusScope.of(context).requestFocus(CurrentCountryFocus);
                                },
                                onSaved: (val) => _currentCountry = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal * 35,
                              child: Text(
                                StringConstant.currentcountry,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2,top: SizeConfig.blockSizeVertical *2),
                              width: SizeConfig.blockSizeHorizontal *58,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                autofocus: false,
                                focusNode: CurrentCountryFocus,
                                controller: currentCountryController,
                                cursorColor: AppColors.selectedcolor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter current country";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v)
                                {
                                 CurrentCountryFocus.unfocus();
                                },
                                onSaved: (val) => _currentCountry = val,
                                textAlign: TextAlign.left,
                                style:
                                TextStyle(letterSpacing: 1.0,  fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                                decoration: InputDecoration(
                                  focusColor: AppColors.selectedcolor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.light_grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.selectedcolor),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: SizeConfig.blockSizeVertical * 7,
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 5,
                              bottom: SizeConfig.blockSizeVertical * 4,
                              left: SizeConfig.blockSizeHorizontal * 20,
                              right: SizeConfig.blockSizeHorizontal * 20,
                            ),
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage("assets/images/sendbutton.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Text(StringConstant.update,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 15,
                                )),
                          ),
                        )

                      ],
                    ),
                  ),
                )

              ),
            )
          ],
        ),
      ),
    );
  }
}