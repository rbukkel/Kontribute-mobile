import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/MyConnections/ContactsPage.dart';
import 'package:kontribute/Pojo/CountrylistPojo.dart';
import 'package:kontribute/Pojo/ResutPush.dart';
import 'package:kontribute/Pojo/NationalitylistPojo.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Ui/ContactFromKontribute.dart';
import 'package:kontribute/Ui/Contactlis.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/data.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';

class register extends StatefulWidget {
  @override
  registerState createState() => registerState();
}

class registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  final NickNameFocus = FocusNode();
  final FullNameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final PwdFocus = FocusNode();
  final MobileFocus = FocusNode();
  final String title = "AutoComplete Demo";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nicknameController = new TextEditingController();
  final TextEditingController fullnameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  bool _showPassword = false;
  bool isLoading = false;
  bool _confirmPassword = false;
  String _email;
  String _password;
  String _nickname;
  String _fullname;
  String _mobile;
  File _imageFile;
  bool image_value = false;
  bool imageUrl = false;
  int nationalityid;
  int currentcountryid;
  String countryname;
  String nationalityname;
  List<dynamic> nationalityTypes = List();
  List<dynamic> currentcountryTypes = List();
  var currentSelectedValue;
  bool showvalue = false;
  var currentSelectedCountry;
  String currentCountry;
  String token;
  var facebookLogin = FacebookLogin();
  bool isLoggedIn = false;
  var profileData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User user;
  String mobile, countrycode;
  String selecteddate = "Date of Birth";
  bool selected =false;
  String _selectedCity;
  Map<String, String> selectedValueMap = Map();
  AutoCompleteTextField searchTextField;
  final TextEditingController _typeAheadController = TextEditingController();
  TextEditingController controller = new TextEditingController();
  String val;
  String contryval;
  var nationalitylist;
  var countrylist;
  AutoCompleteTextField searchTextFields;
  GlobalKey<AutoCompleteTextFieldState<ResutPush>> key = new GlobalKey();
  static List<ResutPush> users = new List<ResutPush>();
  bool loading = true;
  bool resultvalue = true;
  bool countryresultvalue = true;
  bool expandFlag0 = false;
  bool expandFlag1 = false;
  NationalitylistPojo listing;
  CountrylistPojo listingCountry;
  final mycontroller = new TextEditingController();
  final myCountrycontroller = new TextEditingController();


  static List<ResutPush> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<ResutPush>((json) => ResutPush.fromJson(json)).toList();
  }

  Widget row(ResutPush user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.country,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),

      ],
    );
  }

  @override
  void initState() {
    super.initState();
    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("Register token: " + token.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
       // getUsers();
        getNationalList("");
        getCountryList("");
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


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selecteddate = DateFormat('dd-MM-yyyy').format(picked);
        print("onDate: " + selecteddate.toString());
      });
  }

  void getCountryList(String search) async {
    Map data = {
      'search': search.toString(),
    };
    print("search: " + data.toString());
    http.Response res = await http.post(Network.BaseApi + Network.countrylist, body: data);
    var jsonResponse = null;
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      contryval = res.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          countryresultvalue = false;
        });
        errorDialog(jsonDecode(contryval)["message"]);
      } else {
        listingCountry = new CountrylistPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          setState(() {

            if (listingCountry.resultPush.isEmpty) {
              countryresultvalue = false;
            } else {
              countryresultvalue = true;
              print("SSSS");
              countrylist = listingCountry.resultPush;
              List<dynamic> data1 = jsonResponse["result_push"];
              setState(() {
                currentcountryTypes = data1;
              });
            }
          });
        } else {
          setState(() {
            errorDialog(jsonDecode(contryval)["message"]);
          });
        }
      }
    } else {
      errorDialog(jsonDecode(contryval)["message"]);
    }
  }

  void getNationalList(String search) async {
    Map data = {
      'search': search.toString(),
    };
    print("search: " + data.toString());
    http.Response res = await http.post(Network.BaseApi + Network.nationality, body: data);
    var jsonResponse = null;
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      val = res.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
        });
        errorDialog(jsonDecode(val)["message"]);
      } else {
        listing = new NationalitylistPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          setState(() {

            if (listing.resultPush.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              nationalitylist = listing.resultPush;
              List<dynamic> data1 = jsonResponse["result_push"];
              setState(() {
                nationalityTypes = data1;
              });
            }

          });
        } else {
          //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            errorDialog(jsonResponse["message"]);
          });
        }

      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex1 = new RegExp(pattern1);
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/welcome_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 5,
                bottom: SizeConfig.blockSizeVertical * 1),
            child:
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      titlebar(context, ""),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(

                        alignment: Alignment.topCenter,
                        child: Text(
                          StringConstant.signup,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Bold',
                              color: AppColors.black,
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
                              color: AppColors.black,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3,
                                    right: SizeConfig.blockSizeHorizontal * 3),
                                child: Image.asset(
                                  "assets/images/gmail.png",
                                  height: SizeConfig.blockSizeVertical *20,
                                  width:SizeConfig.blockSizeHorizontal * 20,
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
                                  "assets/images/facebook.png",
                                  height: SizeConfig.blockSizeVertical *20,
                                  width:SizeConfig.blockSizeHorizontal * 20,
                                ),
                              ),
                              onTap: () {
                                loginmethod();
                              },
                            ),

                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3,
                                    right: SizeConfig.blockSizeHorizontal * 3),
                                child: Image.asset(
                                  "assets/images/twitter.png",
                                  height: SizeConfig.blockSizeVertical *20,
                                  width:SizeConfig.blockSizeHorizontal * 20,
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
                        width: 300,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width:80,
                                child: Divider(
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
                                      fontFamily: 'Poppins-Regular',
                                    )),
                              ),
                              Container(
                                width: 80,
                                child: Divider(
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
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 3),
                          child: ClipOval(child:  image_value?Image.file(_imageFile, fit: BoxFit.fill,height: 80,width: 80,)
                              :Image.asset("assets/images/camera.png",height: 80,width: 80,),),

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
                              color: AppColors.black,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 13,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical *3,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:
                        Row(
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
                                child: Icon(Icons.person_outline, color: AppColors.iconcolor),
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
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(FullNameFocus);
                                  },
                                  onSaved: (val) => _nickname = val,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      decoration: TextDecoration.none,
                                    ),
                                    hintText: StringConstant.nickname,
                                  ),
                                ),
                            )

                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 13,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical *2,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
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
                                child: Icon(Icons.person_outline, color: AppColors.iconcolor),
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
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(EmailFocus);
                                },
                                onSaved: (val) => _fullname = val,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10,
                                    decoration: TextDecoration.none,
                                  ),
                                  hintText: StringConstant.fullname,
                                ),
                              ),
                            )

                          ],
                        ),


                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 13,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical *2,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:  Row(
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
                                    else if (!regex1.hasMatch(val))
                                      return "Please enter valid email";
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(PwdFocus);
                                  },
                                  onSaved: (val) => _email = val,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      decoration: TextDecoration.none,
                                    ),
                                    hintText: StringConstant.emailaddres,
                                  ),
                                ),
                            )

                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 13,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical *2,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          // bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:  Row(
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
                                child: Icon(Icons.lock, color: AppColors.iconcolor),
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
                                focusNode: PwdFocus,
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter password";
                                  else if(!regex.hasMatch(val))
                                    return "should contain at least one upper case, lower case, digit,Special character and Must be at least 8 characters in length";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(MobileFocus);
                                },
                                onSaved: (val) => _password = val,
                                obscureText: !this._showPassword,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10,
                                    decoration: TextDecoration.none,
                                  ),
                                  hintText: StringConstant.password,
                                  suffixIcon:  InkWell(
                                    onTap: (){
                                      setState(() => this._showPassword = !this._showPassword);
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        )

                      ),
                    /*  Container(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 5,
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
                          onFieldSubmitted: (v) {
                            MobileFocus.unfocus();
                          },
                          onSaved: (val) => _mobile = val,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 10,
                              color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            ),
                            hintText: StringConstant.mobile,
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
                          height: SizeConfig.blockSizeVertical * 13,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            top: SizeConfig.blockSizeVertical *2,
                          ),
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                             bottom: SizeConfig.blockSizeVertical *1,
                          ),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/images/registerbtn.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
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
                                  child: Icon(Icons.calendar_today_outlined, color: AppColors.iconcolor),
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
                                Text(
                                  selecteddate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      color: selected?Colors.black:Colors.grey),
                                ),
                              )
                            ],
                          )



                        ),
                      ),
                      Container(
                          height: SizeConfig.blockSizeVertical * 14.5,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1,
                            right: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 10,
                            right: SizeConfig.blockSizeHorizontal * 5,
                            bottom: SizeConfig.blockSizeVertical *1,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/images/registerbtn.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child:
                          IntlPhoneField(
                            decoration: InputDecoration( //decoration for Input Field
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 10,
                                decoration: TextDecoration.none,
                              ),
                              hintText: StringConstant.mobile,
                              focusedBorder: InputBorder.none,
                            ),
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 10,
                                color: Colors.black),
                            initialCountryCode: 'NP', //default contry code, NP for Nepal
                            onChanged: (phone) {
                              mobile =phone.number;
                              countrycode =phone.countryCode;
                              //when phone number country code is changed
                              print(phone.completeNumber); //get complete number
                              print(phone.countryCode); // get country code only
                              print(phone.number); // only phone number
                            },
                          )
                      ),


                      Container(
                        height: SizeConfig.blockSizeVertical * 14.5,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 10,
                          right: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 65,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                ),
                                child: TextField(
                                  controller: mycontroller,
                                  onChanged: (value) {
                                    setState(() {
                                      getNationalList(value);
                                    });
                                  },
                                 style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10,
                                    color: Colors.black),
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Montserrat-Bold'),
                                      hintText: 'please select nationality'),
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              child: IconButton(
                                  icon: new Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: new Center(
                                      child: new Icon(
                                        expandFlag0
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: Colors.black87,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      expandFlag0 = !expandFlag0;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Container()),
                      expandFlag0 == true ? ExpandedInvitationview0() : Container(),

                    /*  Container(
                        height: SizeConfig.blockSizeVertical * 14.5,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 8,
                          right: SizeConfig.blockSizeHorizontal * 10,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: FormField<dynamic>(
                          builder: (FormFieldState<dynamic> state) {
                            return InputDecorator(
                              decoration:
                                  InputDecoration.collapsed(hintText: ''),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<dynamic>(
                                  hint: Text(
                                    "please select nationality",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ),
                                  dropdownColor: AppColors.whiteoff,
                                  value: currentSelectedValue,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedValue = newValue;
                                      nationalityid = int.parse(newValue["num_code"]);
                                      nationalityname = newValue["nationality"];
                                      print("National: "+nationalityname);
                                    });
                                  },
                                  items: nationalityTypes.map((dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(
                                        value["nationality"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',
                                            fontSize:9,
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),*/


                      Container(
                        height: SizeConfig.blockSizeVertical * 14.5,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 10,
                          right: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 65,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                ),
                                child: TextField(
                                  controller: myCountrycontroller,
                                  onChanged: (value) {
                                    setState(() {
                                      getCountryList(value);
                                    });
                                  },
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      color: Colors.black),
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Montserrat-Bold'),
                                      hintText: 'please select country'),
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              child: IconButton(
                                  icon: new Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: new Center(
                                      child: new Icon(
                                        expandFlag1
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: Colors.black87,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      expandFlag1 = !expandFlag1;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Container()),
                      expandFlag1 == true ? ExpandedCountryview0() : Container(),
                    /*  Container(
                        height: SizeConfig.blockSizeVertical * 14.5,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 8,
                          right: SizeConfig.blockSizeHorizontal * 10,
                          bottom: SizeConfig.blockSizeVertical *1,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/registerbtn.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:
                        FormField<dynamic>(
                          builder: (FormFieldState<dynamic> state) {
                            return InputDecorator(
                              decoration: InputDecoration.collapsed(hintText: ''),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<dynamic>(
                                  hint: Text(
                                    "please select country",
                                    maxLines: 2,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ),
                                  dropdownColor: AppColors.whiteoff,
                                  value: currentSelectedCountry,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedCountry = newValue;
                                      currentcountryid = int.parse(newValue["num_code"]);
                                      countryname = newValue["country"];
                                      print("Country: "+countryname);
                                    });
                                  },
                                  items: currentcountryTypes.map((dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(
                                        value["country"],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 9,
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),*/
                     /*

                      loading
                          ? CircularProgressIndicator()
                          : searchTextField = AutoCompleteTextField<ResutPush>(
                        key: key,
                        clearOnSubmit: false,
                        suggestions: users,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                          hintText: "Search Name",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        itemFilter: (item, query) {
                          return item.country
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.country.compareTo(b.country);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            searchTextField.textField.controller.text = item.country;
                          });
                        },
                        itemBuilder: (context, item) {
                          // ui for the autocompelete row
                          return row(item);
                        },
                      ),
*/
                     /* TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                                labelText: 'City'
                            )
                        ),
                        suggestionsCallback: (pattern) {
                          return BackendService.getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadController.text = suggestion;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select a city';
                          }
                        },
                        onSaved: (value) => this._selectedCity = value,
                      ),*/

                      Container(
                        alignment: Alignment.center,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          top: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Montserrat')),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Text(" " + StringConstant.condition,
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
                          if (_formKey.currentState.validate()) {
                            if (showvalue) {
                              setState(() {
                                isLoading = true;
                              });
                              Internet_check().check().then((intenet) {
                                if (intenet != null && intenet) {
                                  if(mobile!=null || mobile!="")
                                    {
                                      register(
                                          emailController.text,
                                          passwordController.text,
                                          fullnameController.text,
                                          nicknameController.text,
                                          mobile,
                                          countrycode,
                                          _imageFile,
                                          selecteddate,
                                          myCountrycontroller.text,
                                          mycontroller.text);
                                    }
                                  else {
                                    Fluttertoast.showToast(
                                      msg: "Please enter mobile number",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "No Internet Connection",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                  );
                                }
                              });
                            } else {
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
                          height: SizeConfig.blockSizeVertical * 10,
                          padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }


  ExpandedInvitationview0() {
    return nationalitylist != null ?
    Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
        ),
        height: SizeConfig.blockSizeVertical * 30,
        child: Card(
          child:  MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: nationalitylist == null
                    ? 0
                    : nationalitylist.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    GestureDetector(
                      onTap: ()
                      {
                        mycontroller.text =listing.resultPush.elementAt(index).nationality;
                        print("Selection: "+listing.resultPush.elementAt(index).nationality);
                        print("SelectionController: "+mycontroller.text);
                        print("Selectioncode: "+listing.resultPush.elementAt(index).numCode.toString());
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical *7,
                        margin: EdgeInsets.only(
                          top:SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        child: Text(
                          listing.resultPush.elementAt(index).nationality == null
                              ? ""
                              : listing.resultPush.elementAt(index).nationality,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                      ),
                    ) ;

                }),
          ),
        )

    )
        : Container(
        alignment: Alignment.center,
        child: resultvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text(
            'No search results to show',
            style: TextStyle(
                letterSpacing: 1.0,
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular'),
          ),
        ));
  }


  ExpandedCountryview0() {
    return countrylist != null ?
    Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
        ),
        height: SizeConfig.blockSizeVertical * 30,
        child: Card(
          child:  MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: countrylist == null
                    ? 0
                    : countrylist.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    GestureDetector(
                      onTap: ()
                      {
                        myCountrycontroller.text =listingCountry.resultPush.elementAt(index).country;
                        print("Selection: "+listingCountry.resultPush.elementAt(index).country);
                        print("SelectionController: "+myCountrycontroller.text);
                        print("Selectioncode: "+listingCountry.resultPush.elementAt(index).numCode.toString());
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical *7,
                        margin: EdgeInsets.only(
                          top:SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        child: Text(
                          listingCountry.resultPush.elementAt(index).country == null
                              ? ""
                              : listingCountry.resultPush.elementAt(index).country,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                      ),
                    ) ;

                }),
          ),
        )
    )
        : Container(
        alignment: Alignment.center,
        child: countryresultvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text(
            'No search results to show',
            style: TextStyle(
                letterSpacing: 1.0,
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular'),
          ),
        ));
  }


  Widget getSearchableDropdown(List<dynamic> listData) {
    List<DropdownMenuItem> items = [];
    for(int i=0; i < listData.length; i++) {
      items.add(new DropdownMenuItem(
        child: new Text(
          listData[i],
        ),
        value: listData[i],
      )
      );
    }
    return new SearchableDropdown(
      items: items,
      value: currentCountry,
      isCaseSensitiveSearch: false,
      hint: new Text(
          'please select country'
      ),
      searchHint: new Text(
        'please select country',
        style: new TextStyle(
            fontSize: 20
        ),
      ),
      onChanged: (newValue) {
        setState(() {
          currentCountry = newValue;
        });
        print("selectv: "+ currentCountry.toString());
      },

    );
  }


  Future<List> getServerData() async {
    var response = await http.get(Uri.encodeFull(Network.BaseApi + Network.countrylist));
    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body);
      List<dynamic> responseBody = data["result_push"];
      List<dynamic> countries = new List();
      for(int i=0; i < responseBody.length; i++) {
        countries.add(responseBody[i]['country']);
      }
      return responseBody;
    }
    else {
      print("error from server : $response");
      throw Exception('Failed to load post');
    }
  }

  void register(
      String email,
      String password,
      String fullname,
      String nickname,
      String mobile,
      String code,
      File Imge,
      String selected,
      String country,
      String nationality,) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.register),);
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["email"] = email.toString();
    request.fields["password"] = password.toString();
    request.fields["full_name"] = fullname;
    request.fields["nick_name"] = nickname;
    request.fields["mobile_no"] = mobile;
    request.fields["dob"] = selected.toString();
    request.fields["nationality"] = nationality;
    request.fields["country"] = country.toString();
    request.fields["mobile_token"] = token.toString();
    request.fields["country_code"] = code.toString();

    print("Request: "+request.fields.toString());

    if (Imge != null) {
      print("PATH: " + Imge.path);
      request.files.add(await http.MultipartFile.fromPath("profile_pic", Imge.path,
          filename: Imge.path));
    }
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);

      if (jsonData["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonData["message"]);


      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        LoginResponse login = new LoginResponse.fromJson(jsonData);
        String jsonProfile = jsonEncode(login);
        print(jsonProfile);
        SharedUtils.saveProfile(jsonProfile);
       // print('Result: ${login.resultPush.uid}');
        if (jsonData != null) {
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
                      Contactlis()),
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


  fetchData(String name, String email, String id, String photoURL) async {
    print("email: " + email.toString());
    print("name: " + name.toString());
    print("id: " + id.toString());
    print("photoURL: " + photoURL.toString());
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'email': email.toString(),
      'full_name': name.toString(),
      'mobile_token': token.toString(),
      'facebook_id': id.toString(),
      'profile_pic': photoURL.toString(),
    };


    print(data.toString());
    var jsonResponse = null;
    var response =
    await http.post(Network.BaseApi + Network.socailLogin, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["success"] == false) {
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
                      Contactlis()),
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
              print("Path: "+_imageFile.toString());
              image_value = true;
              imageUrl = false;
            });
          } else {
            errorDialog("Please Select Image");
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
              print("Path: "+_imageFile.toString());
              image_value = true;
              imageUrl = false;
            });
          } else {
            errorDialog("Please Select Image");
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
        errorDialog("No Internet Connection");
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
        fetchData(user.displayName, user.email, user.uid, user.photoURL);
        SharedUtils.writeloginId("login_type", "google");
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
    var facebookLoginResult = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
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
        /*print("ProfileBirthday: " + profile['birthday'].toString());
        print("ProfileBirthday: " + profile['birthday'].toString());
        print("ProfileHometown: " + profile['hometown'].toString());*/
        print(profile['picture']['data']['url']);
        onLoginStatusChanged(true, profileData: profile);
        SharedUtils.readloginData("login", true);
        fetchData(
          profile['name'].toString(),
          profile['email'].toString(),
          profile['id'].toString(),
          profile['picture']['data']['url'].toString(),
        );
        SharedUtils.writeloginId("login_type", "facebook");

        // Navigator.of(context).pop();
        break;
    }
  }
}
