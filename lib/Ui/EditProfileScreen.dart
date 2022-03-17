import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kontribute/Pojo/User_pojo.dart';
import 'package:kontribute/Ui/ProfileScreen.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String data;

  const EditProfileScreen({Key key, @required this.data}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final NickNameFocus = FocusNode();
  final FullNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final DateofbirthFocus = FocusNode();
  final MobileFocus = FocusNode();
  final CountryFocus = FocusNode();
  final CompanynameFocus = FocusNode();
  final NatinalityFocus = FocusNode();
  final CurrentCountryFocus = FocusNode();
  final postalcodeFocus = FocusNode();
  final cityFocus = FocusNode();
  final addressFocus = FocusNode();
  final stateFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyLoader1 = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nicknameController = new TextEditingController();
  final TextEditingController fullnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController CountryController = new TextEditingController();
  final TextEditingController dateofbirthController = new TextEditingController();
  final TextEditingController companynameController = new TextEditingController();
  final TextEditingController natinalityController = new TextEditingController();
  final TextEditingController currentCountryController = new TextEditingController();
  final TextEditingController postalcodeController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController statesController = new TextEditingController();
  UserPojo userPojo;
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
  String _Country;
  String userid;
  String hyperwalletuserid;
  String data1;
  String countrycode;
  String countrycode2digit;
  String mobile;
  bool internet = false;
  int a;
  LoginResponse loginResponse;
  String val;
  bool imageUrl = false;
  bool _loading = false;
  String image;
  String token;
  var storelist_length;
  String selecteddate = "Date of Birth";
  bool isLoading = false;
  bool selected = false;
  bool selectedit = false;
  final _formmainKey = GlobalKey<FormState>();
  String programtoken = "prg-b8828386-e4d2-40fb-afb3-57d298729759";
  String username = 'restapiuser@130393261610';
  String password = 'rohit_knickglobal@123';




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
            errorDialog('pleaseselectimage'.tr);
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
            errorDialog('pleaseselectimage'.tr);
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selecteddate = DateFormat('yyyy-MM-dd').format(picked);
        print("onDate: " + selecteddate.toString());
        dateofbirthController.text =selecteddate.toString();
      });
  }

  @override
  void initState() {
    super.initState();
    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("Login token: " + token.toString());
    });
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });
    SharedUtils.readhyperwalletuserid("hyperwalletuserId").then((val) {
      hyperwalletuserid = val;
      if(hyperwalletuserid.toString()!="null"){
        print("Login userid: " + hyperwalletuserid.toString());
      }
    });


    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(a);

        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        errorDialog('nointernetconnection'.tr);
      }
    });
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
                    'ok'.tr,
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

  void getData(int id) async {
    Map data = {
      'userid': id.toString(),
    };
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.get_profiledata, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);
      } else {
        loginResponse = new LoginResponse.fromJson(jsonResponse);
        print("Json profile data: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            storelist_length = loginResponse.resultPush;
            if (loginResponse.resultPush.fullName == "") {
              fullnameController.text = "";
            } else {
              var str=loginResponse.resultPush.fullName;
              List parts = str.split(' ');
              print("Name Length"+parts.length.toString());
              fullnameController.text = parts[0].trim();
              if(parts.length>1){
                lastnameController.text = parts[1].trim();
              }

              // fullnameController.text = loginResponse.resultPush.fullName;
            }

            if (loginResponse.resultPush.nickName == "") {
              nicknameController.text = "";
            } else {
              nicknameController.text = loginResponse.resultPush.nickName;
            }

            if (loginResponse.resultPush.email == "") {
              emailController.text = "";
            } else {
              emailController.text = loginResponse.resultPush.email;
            }

            if (loginResponse.resultPush.mobile == "") {
              mobileController.text = "";
            } else {
              mobileController.text = loginResponse.resultPush.mobile;
            }

            if (loginResponse.resultPush.countryCode == "") {
              CountryController.text = "";
            } else {
              CountryController.text = loginResponse.resultPush.countryCode;
            }

            if (loginResponse.resultPush.dob == "") {
              dateofbirthController.text = "";
            } else {
              dateofbirthController.text = loginResponse.resultPush.dob;
            }

            if (loginResponse.resultPush.nationality == "") {
              natinalityController.text = "";
            } else {
              natinalityController.text = loginResponse.resultPush.nationality;
            }

            if (loginResponse.resultPush.currentCountry == "") {
              currentCountryController.text = "";
            } else {
              currentCountryController.text =
                  loginResponse.resultPush.currentCountry;
            }
            if (loginResponse.resultPush.postalCode == "") {
              postalcodeController.text = "";
            } else {
              postalcodeController.text =
                  loginResponse.resultPush.postalCode;
            }

            if (loginResponse.resultPush.city == "") {
              cityController.text = "";
            } else {
              cityController.text =
                  loginResponse.resultPush.city;
            }
            if (loginResponse.resultPush.addressLine1 == "") {
              addressController.text = "";
            } else {
              addressController.text =
                  loginResponse.resultPush.addressLine1;
            }
            if (loginResponse.resultPush.stateProvince == "") {
              statesController.text = "";
            } else {
              statesController.text =
                  loginResponse.resultPush.stateProvince;
            }

            if(loginResponse.resultPush.facebookId== null)
            {
              setState(() {
                image = Network.BaseApiprofile+loginResponse.resultPush.profilePic;
                if (image.isNotEmpty) {
                  image_value = true;
                  _loading = true;
                }
              });
            }
            else{
              if (!loginResponse.resultPush.profilePic.startsWith("https://"))
              {
                setState(() {
                  image = Network.BaseApiprofile+loginResponse.resultPush.profilePic;
                  if (image.isNotEmpty) {
                    image_value = true;
                    _loading = true;
                  }
                });
              }
              else
              {
                setState(() {
                  image = loginResponse.resultPush.profilePic;
                  if (image.isNotEmpty) {
                    image_value = true;
                    _loading = true;
                  }
                });
              }
            }


          });
        } else {
          errorDialog(loginResponse.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
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
                    'camera'.tr,
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
                    'gallery'.tr,
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
                    'cancel'.tr,
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
                      'editprofile'.tr,
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
            storelist_length != null
                ? Expanded(
                    child: SingleChildScrollView(
                        child: Form(
                      key: _formmainKey,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 2,
                            left: SizeConfig.blockSizeHorizontal * 1,
                            right: SizeConfig.blockSizeHorizontal * 1),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                /*   GestureDetector(
                              onTap: () {
                                showAlert();
                              },
                              child:  imageUrl==false?
                              Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                width: 120,
                                height: 120,
                                child: ClipOval(child:  image_value?Image.file(_imageFile, fit: BoxFit.fill,):Image.asset("assets/images/person.png",height: 120,width: 120,),),
                              ):
                              loginResponse.resultPush.facebookId == ""?
                              Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*4),
                                child: _loading? ClipOval(child:  CachedNetworkImage(
                                  height: 120,width: 120,fit: BoxFit.fill ,
                                  imageUrl:Network.BaseApiprofile+image,
                                  placeholder: (context, url) => Container(
                                      height: SizeConfig.blockSizeVertical * 5, width: SizeConfig.blockSizeVertical * 5,
                                      child: Center(child: new CircularProgressIndicator())),
                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                ),): CircularProgressIndicator(
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.grey),
                                ),
                              ):Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*4),
                                child: _loading? ClipOval(child:  CachedNetworkImage(
                                  height: 120,width: 120,fit: BoxFit.fill ,
                                  imageUrl:image,
                                  placeholder: (context, url) => Container(
                                      height: SizeConfig.blockSizeVertical * 5, width: SizeConfig.blockSizeVertical * 5,
                                      child: Center(child: new CircularProgressIndicator())),
                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                ),): CircularProgressIndicator(
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.grey),
                                ),
                              ),
                            ),*/

                                image_value == false
                                    ? Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                2),
                                        width: 120.0,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: _imageFile != null
                                                  ? FileImage(_imageFile)
                                                  : AssetImage(
                                                      "assets/images/person.png")),
                                        ),
                                      )

                                        : Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    2),
                                            width: 120.0,
                                            height: 120.0,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: image,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 120.0,
                                                height: 120.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                            )),

                                GestureDetector(
                                  onTap: () {
                                    showAlert();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *12,
                                        left: SizeConfig.blockSizeHorizontal * 24
                                      ),
                                      child:CircleAvatar(
                                        backgroundColor: AppColors.themecolor,
                                        radius: 22.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                           /* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAlert();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  8),
                                      child:CircleAvatar(
                                        backgroundColor: AppColors.themecolor,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ],
                            ),*/
                            Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'nickname'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 58,
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
                                          return 'pleaseenternickname'.tr;
                                        else
                                          return null;
                                      },
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(FullNameFocus);
                                      },
                                      onSaved: (val) => _nickname = val,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 12,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        focusColor: AppColors.selectedcolor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.light_grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.selectedcolor),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.selectedcolor),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'firstname'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
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
                                        return 'pleaseenterfirstname'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(EmailFocus);
                                    },
                                    onSaved: (val) => _fullname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
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
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'lastname'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: lastNameFocus,
                                    controller: lastnameController,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'enterlastname'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(EmailFocus);
                                    },
                                    onSaved: (val) => _fullname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
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
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'email'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
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
                                        return 'pleaseenteremail'.tr;
                                      else if (!regex.hasMatch(val))
                                        return 'pleaseentervalidemail'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(CountryFocus);
                                    },
                                    onSaved: (val) => _email = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Container()),
                            selectedit == true ? editmobile() : withouteditmobile(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'dateofbirth'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),



                                ),
                                /* Container(
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
                            ),*/

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = true;
                                    });
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2,
                                        top: SizeConfig.blockSizeVertical * 2),
                                    width: SizeConfig.blockSizeHorizontal * 58,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColors.whiteColor,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                      color: Colors.transparent,
                                    ),
                                    child:
                                    /*Text(
                                      selecteddate,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 10,
                                          color: selected
                                              ? Colors.black
                                              : Colors.black),
                                    ),*/
                                    TextFormField(
                                      autofocus: false,
                                      enabled: false,
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
                                  ),
                                ),
                              ],
                            ),
                            /*   Row(
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
                        ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'nationality'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
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
                                        return 'pleaseenternatinality'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(CurrentCountryFocus);
                                    },
                                    onSaved: (val) => _currentCountry = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
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
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'currentcountry'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
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
                                        return 'pleaseentercurrentcountry'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      CurrentCountryFocus.unfocus();
                                    },
                                    onSaved: (val) => _currentCountry = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'postalcode'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: postalcodeFocus,
                                    controller: postalcodeController,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenterpostalcode'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      postalcodeFocus.unfocus();
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'city'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: cityFocus,
                                    controller: cityController,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentercurrentcity'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      CurrentCountryFocus.unfocus();
                                    },
                                    onSaved: (val) => _currentCountry = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'address'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: addressFocus,
                                    controller: addressController,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentercurrentaddress'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      addressFocus.unfocus();
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  child: Text(
                                    'state'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  width: SizeConfig.blockSizeHorizontal * 58,
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: stateFocus,
                                    controller: statesController,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentercurrentstate'.tr;
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      stateFocus.unfocus();
                                    },

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusColor: AppColors.selectedcolor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.light_grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.selectedcolor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formmainKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Internet_check().check().then((intenet) {
                                    if (intenet != null && intenet) {

                                      print("Hyperwallert user id:-"+hyperwalletuserid.toString());

                                      if(hyperwalletuserid.toString()=="null" || hyperwalletuserid==""){
                                        createhyperawalletuser();
                                      }else{
                                        if(mobile==null || mobile ==" " && countrycode==null || countrycode=="")
                                        {
                                          updateprofile(
                                              userid,
                                              fullnameController.text+" "+lastnameController.text,
                                              nicknameController.text,
                                              mobileController.text,
                                              CountryController.text,
                                              dateofbirthController.text,
                                              natinalityController.text,
                                              currentCountryController.text,
                                              token,
                                              _imageFile,
                                              postalcodeController.text,
                                              cityController.text,
                                              addressController.text,
                                              statesController.text,
                                              hyperwalletuserid
                                          );
                                        }
                                        else{
                                          updateprofile(
                                              userid,
                                              fullnameController.text+" "+lastnameController.text,
                                              nicknameController.text,
                                              mobile,
                                              countrycode,
                                              dateofbirthController.text,
                                              natinalityController.text,
                                              currentCountryController.text,
                                              token,
                                              _imageFile,
                                              postalcodeController.text,
                                              cityController.text,
                                              addressController.text,
                                              statesController.text,
                                              hyperwalletuserid
                                          );
                                        }
                                      }
                                    } else {
                                      errorDialog('nointernetconnection'.tr);
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
                                  bottom: SizeConfig.blockSizeVertical * 4,
                                  left: SizeConfig.blockSizeHorizontal * 20,
                                  right: SizeConfig.blockSizeHorizontal * 20,
                                ),
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "assets/images/sendbutton.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Text('update'.tr,
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
                    )),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 150),
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  withouteditmobile() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeVertical * 2),
              width: SizeConfig.blockSizeHorizontal * 35,
              child: Text(
                'countrycode'.tr,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold'),
              ),
            ),
            GestureDetector(
              onTap: ()
              {

              },
              child:
              Container(
                  margin: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 2,
                      top: SizeConfig.blockSizeVertical * 2),
                  width: SizeConfig.blockSizeHorizontal * 35,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    //  borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    CountryController.text,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        color: Colors.black),
                  )

                /* TextFormField(
                autofocus: false,
                focusNode: CountryFocus,
                controller: CountryController,
                cursorColor: AppColors.selectedcolor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val.length == 0)
                    return 'pleaseentercountrycode'.tr;
                  else
                    return null;
                },
                onFieldSubmitted: (v)
                {
                  FocusScope.of(context).requestFocus(MobileFocus);
                },
                onSaved: (val) => _Country = val,
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
              ),*/

              ),
            ),

            GestureDetector(
              onTap: () {

                setState(() {
                  selectedit = !selectedit;
                });
                print("Selected: "+selectedit.toString());
              },
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal * 20,
                height: SizeConfig.blockSizeVertical * 5,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2,
                bottom:  SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/sendbutton.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text('select'.tr,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
              ),
              width: SizeConfig.blockSizeHorizontal * 35,
              child: Text(
                'mobileno'.tr,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 2,
              ),
              width: SizeConfig.blockSizeHorizontal * 58,
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
                    return 'pleaseentermobilenumber'.tr;
                  else if (val.length != 10)
                    return 'pleaseentervalidmobilenumber'.tr;
                  else
                    return null;
                },
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(DateofbirthFocus);
                },
                onSaved: (val) => _mobile = val,
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Regular',
                    fontSize: 12,
                    color: Colors.black),
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
      ],
    );
  }

  editmobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              top: SizeConfig.blockSizeVertical * 2),
          child: Text(
            'mobileno'.tr,
            style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Bold'),
          ),
        ),
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 2,
                top: SizeConfig.blockSizeVertical * 2),
            decoration: BoxDecoration(
              //  borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: IntlPhoneField(
              decoration: InputDecoration(
                //decoration for Input Field
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
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 10,
                  decoration: TextDecoration.none,
                ),
                hintText: StringConstant.mobile,
              ),

              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 10,
                  color: Colors.black),
              initialCountryCode: 'NP', //default contry code, NP for Nepal
              onChanged: (phone) {
                setState(() {
                  mobile = phone.number;
                  countrycode = phone.countryCode;
                  countrycode2digit=phone.countryISOCode;
                  //when phone number country code is changed
                  print(phone.completeNumber); //get complete number
                  print("Country Dial code:-"+phone.countryCode); // get country code only
                  print("Country code:-"+countrycode2digit); // get country code only
                  print(phone.number); // only phone number
                });
              },
            ))
      ],
    );
  }


  void createhyperawalletuser() async {
    print("Api Call");
    Dialogs.showLoadingDialog(context, _keyLoader);

    String username = StringConstant.hyperwalletusername;
    String password = StringConstant.hyperwalletpassword;

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': basicAuth
    };
    final bodynew = jsonEncode({
      'clientUserId': a.toString(),
      'profileType': "INDIVIDUAL",
      'firstName': fullnameController.text,
      'lastName': lastnameController.text,
      'dateOfBirth': dateofbirthController.text,
      'email': emailController.text,
      'addressLine1': addressController.text,
      'city': cityController.text,
      'stateProvince': statesController.text,
      'country': countrycode2digit,
      'postalCode': postalcodeController.text,
      'programToken': StringConstant.programtoken,
    }
    );

    print("body:-"+bodynew);

    var jsonResponse = null;
    http.Response response = await http.post(Network.hyperwallet_baseApi+Network.hyperwalletusers,body: bodynew,headers: headers,);
    jsonResponse = json.decode(response.body);
    print("Response1:-"+jsonResponse.toString());

    if (response.statusCode == 201) {
      // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print("Response2:-"+jsonResponse.toString());
      if (jsonResponse != null) {
        userPojo=new UserPojo.fromJson(jsonResponse);
        print('user id is in Response'+userPojo.token);

        SharedUtils.savehyperwalletuserid("hyperwalletuserId",userPojo.token.toString());
        Fluttertoast.showToast(
            msg: "Account Created Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);

        print("Response4:-"+jsonResponse.toString());

        if(mobile==null || mobile ==" " && countrycode==null || countrycode=="")
        {
          updateprofile(
              userid,
              fullnameController.text+" "+lastnameController.text,
              nicknameController.text,
              mobileController.text,
              CountryController.text,
              dateofbirthController.text,
              natinalityController.text,
              currentCountryController.text,
              token,
              _imageFile,
              postalcodeController.text,
              cityController.text,
              addressController.text,
              statesController.text,
              userPojo.token.toString()
          );
        }
        else{
          updateprofile(
              userid,
              fullnameController.text+" "+lastnameController.text,
              nicknameController.text,
              mobile,
              countrycode,
              dateofbirthController.text,
              natinalityController.text,
              currentCountryController.text,
              token,
              _imageFile,
              postalcodeController.text,
              cityController.text,
              addressController.text,
              statesController.text,
              userPojo.token.toString()
          );
        }
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Home_screen()));
      }

      else {
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        print("Response5:-"+jsonResponse.toString());

      }
    } else {
      print("Response6:-"+jsonResponse.toString());
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg:jsonResponse["errors"][0]["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  void updateprofile(
      String user,
      String name,
      String nickname,
      String phone,
      String code,
      String dob,
      String nation,
      String country,
      String tken,
      File imageFile,
      String postalcode,
      String city,
      String address,
      String state,
      String hyperwalletuser_id
      ) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader1);
    var request = http.MultipartRequest(
        "POST", Uri.parse(Network.BaseApi + Network.update_profiledata));
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["userid"] = user.toString();
    request.fields["full_name"] = name.toString();
    request.fields["nick_name"] = nickname;
    request.fields["mobile"] = phone.toString();
    request.fields["dob"] = dob.toString();
    request.fields["nationality"] = nation.toString();
    request.fields["current_country"] = country;
    request.fields["mobile_token"] = tken;
    request.fields["country_code"] = code;
    request.fields["hyperwallet_id"] = hyperwalletuser_id;
    request.fields["city"] = city;
    request.fields["addressLine1"] = address;
    request.fields["stateProvince"] = state;
    request.fields["postalCode"] = postalcode;
    print("Request: " + request.fields.toString());
    if (imageFile != null) {
      print("Imagefile:-"+imageFile.toString());
      print("PATH: " + imageFile.path);
      request.files.add(await http.MultipartFile.fromPath(
          "profile_pic", imageFile.path,
          filename: imageFile.path));
    }
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      if (response.statusCode == 200) {
        if (jsonData["success"] == false) {
          Navigator.of(_keyLoader1.currentContext, rootNavigator: true).pop();
          errorDialog(jsonData["message"]);
        } else {
          Navigator.of(_keyLoader1.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
                (route) => false);
          } else {
            Navigator.of(_keyLoader1.currentContext, rootNavigator: true).pop();
            setState(() {
              Navigator.of(context).pop();
            });
            errorDialog(jsonData["message"]);
          }
        }
      } else if (response.statusCode == 500) {
        Navigator.of(_keyLoader1.currentContext, rootNavigator: true).pop();
        errorDialog('internalservererror'.tr);
      } else {
        Navigator.of(_keyLoader1.currentContext, rootNavigator: true).pop();
        errorDialog('somethingwentwrong'.tr);
      }
    });
  }
}
