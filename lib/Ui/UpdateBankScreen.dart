import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kontribute/Pojo/AddBankPojo.dart';
import 'package:kontribute/Pojo/Bank_pojo.dart';
import 'package:kontribute/Pojo/GetBankDeatilsPojo.dart';
import 'package:kontribute/Pojo/UpdateBankPojo.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/ProfileScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:kontribute/Pojo/gethyperwalletPojo.dart';

class UpdateBankScreen extends StatefulWidget {
  String fname, lname, postalcode, city, address, state;

  @override
  UpdateBankScreenState createState() => UpdateBankScreenState();

  UpdateBankScreen(
      {Key key,
        this.fname,
        this.lname,
        this.postalcode,
        this.city,
        this.address,
        this.state})
      : super(key: key);
}

class UpdateBankScreenState extends State<UpdateBankScreen> {
  TextEditingController firstNamecontroller = new TextEditingController();
  TextEditingController lastnamecontroller = new TextEditingController();
  TextEditingController countrycontroller = new TextEditingController();
  TextEditingController currencycontroller = new TextEditingController();
  TextEditingController transfercountrycodecontroller =
  new TextEditingController();
  TextEditingController statecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController citycontroller = new TextEditingController();
  TextEditingController postalCodecontroller = new TextEditingController();
  TextEditingController bankAccountRelationshipcontroller =
  new TextEditingController();
  TextEditingController branchIdcontroller = new TextEditingController();
  TextEditingController bankAccountIdcontroller = new TextEditingController();
  TextEditingController bankAccountPurposecontroller =
  new TextEditingController();
  GlobalKey<State> keylogger = new GlobalKey<State>();
  GlobalKey<State> keylogger1 = new GlobalKey<State>();
  final firstnamenode = FocusNode();
  final lastnamenode = FocusNode();
  final countrynode = FocusNode();
  final transfercountrynode = FocusNode();
  final currencynode = FocusNode();
  final statenode = FocusNode();
  final addressnode = FocusNode();
  final citynode = FocusNode();
  final postalCodenode = FocusNode();
  final bankAccountRelationshipnode = FocusNode();
  final branchIdnode = FocusNode();
  final bankAccountIdnode = FocusNode();
  final bankAccountPurposenode = FocusNode();
  UpdateBankPojo bankPojo;
  String hyperwalletuserid;
  String addbankstatusresponse;
  String userid;
  String code;
  GethyperwalletPojo _gethyperwalletPojo;

  String BankAccountId;
  GetBankDeatilsPojo getbankdetails;

  @override
  void initState() {
    super.initState();

    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      gethyperwalletid(userid);
      getAccountInfo(userid);

      print("Login userid: " + userid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      home: Scaffold(
          key: keylogger,
          body: Container(
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
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
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        left: SizeConfig.blockSizeVertical * 5,


                                    ),
                                    // margin: EdgeInsets.only(top: 10, left: 40),
                                    child: Text(
                                      'updatebank'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.white),
                                    ),
                                  ),




                                ],
                              ),
                            ),

                            /*   Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: firstnamenode,
                                    controller: firstNamecontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter First Name";
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
                                      hintText: widget.fname,
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
                          ),*/

                            /*    Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: lastnamenode,
                                    controller: lastnamecontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter Last Name";
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
                                      hintText:widget.lname,
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
                                    'bankaccountid'.tr,
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
                                      focusNode: bankAccountIdnode,
                                      controller: bankAccountIdcontroller,
                                      cursorColor: AppColors.selectedcolor,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        if (val.length == 0)
                                          return 'pleaseenterbankaccountnumber'.tr;
                                        else
                                          return null;
                                      },
                                      // onFieldSubmitted: (v) {
                                      //   FocusScope.of(context)
                                      //       .requestFocus(FullNameFocus);
                                      // },
                                      // onSaved: (val) => _nickname = val,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 12,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: "7861012445",
                                        hintStyle: TextStyle(
                                            fontSize: 12.0, color: AppColors.greyColor),
                                        focusColor: AppColors.selectedcolor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: AppColors.light_grey),
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
                                    'branchid'.tr,
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
                                      focusNode: branchIdnode,
                                      controller: branchIdcontroller,
                                      cursorColor: AppColors.selectedcolor,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        if (val.length == 0)
                                          return 'pleaseenterbranchid'.tr;
                                        else
                                          return null;
                                      },
                                      // onFieldSubmitted: (v) {
                                      //   FocusScope.of(context)
                                      //       .requestFocus(FullNameFocus);
                                      // },
                                      // onSaved: (val) => _nickname = val,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 12,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 12.0, color: AppColors.greyColor),
                                        hintText: "101089292",
                                        focusColor: AppColors.selectedcolor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: AppColors.light_grey),
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
                                    'transfermethodcurrencycode'.tr,
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
                                      focusNode: currencynode,
                                      controller: currencycontroller,
                                      cursorColor: AppColors.selectedcolor,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.length == 3) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      validator: (val) {
                                        if (val.length == 0)
                                          return 'pleaseentertransfercurrency'.tr;
                                        else
                                          return null;
                                      },
                                      // onFieldSubmitted: (v) {
                                      //   FocusScope.of(context)
                                      //       .requestFocus(FullNameFocus);
                                      // },
                                      // onSaved: (val) => _nickname = val,
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(3),
                                      ],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 12,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 12.0, color: AppColors.greyColor),
                                        hintText: "USD",
                                        focusColor: AppColors.selectedcolor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: AppColors.light_grey),
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
                                    'transfermethodcountrycode'.tr,
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
                                      focusNode: transfercountrynode,
                                      controller: transfercountrycodecontroller,
                                      cursorColor: AppColors.selectedcolor,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.length == 2) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      validator: (val) {
                                        if (val.length == 0)
                                          return 'pleaseentertransfercountrycode'.tr;
                                        else
                                          return null;
                                      },
                                      // onFieldSubmitted: (v) {
                                      //   FocusScope.of(context)
                                      //       .requestFocus(FullNameFocus);
                                      // },
                                      // onSaved: (val) => _nickname = val,
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(2),
                                      ],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 12,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 12.0, color: AppColors.greyColor),
                                        hintText: "US",
                                        focusColor: AppColors.selectedcolor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: AppColors.light_grey),
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

                            /*    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 2,
                                    top: SizeConfig.blockSizeVertical * 2),
                                width: SizeConfig.blockSizeHorizontal * 35,
                                child: Text(
                                  'bankaccountpurpose'.tr,
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
                                    focusNode: bankAccountPurposenode,
                                    controller: bankAccountPurposecontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenterbankaccountpurpose'.tr;
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "SAVINGS",
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
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
                                    'countrycode'.tr,
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
                                  child: CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    textStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      MediaQuery.of(context).size.width /
                                          100 *
                                          4,
                                      color: Colors.black,
                                    ),
                                    onChanged: (e) {
                                      code = e.code;
                                      print('country code is' + code.toString());
                                    },
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: true,
                                    favorite: ['+91', 'hi'],
                                  ),
                                )
                              ],
                            ),

                            /*    Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: statenode,
                                    controller: statecontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenterstate'.tr;
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
                                      hintText: "Haryana",
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
                          ),*/

                            /*    Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: addressnode,
                                    controller: addresscontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenteraddress'.tr;
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "178",
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
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
                          ),*/

                            /*      Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: citynode,
                                    controller: citycontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentercity'.tr;
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,

                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Panchkula",
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
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
                          ),*/

                            /*   Row(
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
                                width: SizeConfig.blockSizeHorizontal * 58,
                                margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                alignment: Alignment.topLeft,
                                child: TextFormField(
                                    autofocus: false,
                                    focusNode: postalCodenode,
                                    controller:
                                    postalCodecontroller,
                                    cursorColor: AppColors.selectedcolor,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenterpostalCode'.tr;
                                      else
                                        return null;
                                    },
                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FullNameFocus);
                                    // },
                                    // onSaved: (val) => _nickname = val,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: widget.postalcode,
                                      hintStyle: TextStyle(fontSize: 12.0, color: AppColors.greyColor),
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
                          ),*/

                            GestureDetector(
                              onTap: () {
                                addbank();
                                // addbankstatus();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 38,
                                  height: SizeConfig.blockSizeVertical * 7,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      bottom: SizeConfig.blockSizeVertical * 2,
                                      left: SizeConfig.blockSizeHorizontal * 5,
                                      right: SizeConfig.blockSizeHorizontal * 5),
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/images/sendbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('updatebank'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 15,
                                          )),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }

  Future<void> addbank() async {
    print("Api Callssss" + hyperwalletuserid);
    Dialogs.showLoadingDialog(context, keylogger);

    String username = StringConstant.hyperwalletusername;
    String password = StringConstant.hyperwalletpassword;
    Map bodynew;
    if (code == 'IN') {
      bodynew = {
        "profileType": "INDIVIDUAL",
        "transferMethodCountry": transfercountrycodecontroller.text,
        "transferMethodCurrency": currencycontroller.text,
        "type": "BANK_ACCOUNT",
        "branchId": branchIdcontroller.text,
        "bankAccountId": bankAccountIdcontroller.text,
        "bankAccountPurpose": "SAVINGS",
        "firstName": widget.fname,
        "lastName": widget.lname,
        "country": code,
        "stateProvince": widget.state,
        "addressLine1": widget.address,
        "city": widget.city,
        "postalCode": widget.postalcode,
        "bankAccountRelationship": "SELF",
      };
    } else if (code == 'AE') {
      bodynew = {
        "profileType": "INDIVIDUAL",
        "transferMethodCountry": transfercountrycodecontroller.text,
        "transferMethodCurrency": currencycontroller.text,
        "type": "BANK_ACCOUNT",
        "branchId": branchIdcontroller.text,
        "bankAccountId": bankAccountIdcontroller.text,
        "bankAccountPurpose": "SAVINGS",
        "firstName": widget.fname,
        "lastName": widget.lname,
        "country": code,
        "stateProvince": 'HR',
        "addressLine1": widget.address,
        "city": widget.city,
        "postalCode": '51133',
        "bankAccountRelationship": "SELF",
      };
    }

    print("Body:-" + bodynew.toString());

    var body = json.encode(bodynew);

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': basicAuth
    };

    var jsonResponse = null;
    http.Response response = await http.put(
      Network.hyperwallet_baseApi + "users/" + hyperwalletuserid + "/bank-accounts/"+getbankdetails.data.elementAt(0).token,
      body: body,
      headers: headers,
    );
    jsonResponse = json.decode(response.body);
    print("Jsonreponse:-" + jsonResponse.toString());
    print("hyperwalletuserid:-" + hyperwalletuserid.toString());
    if (response.statusCode == 200) {
      print("Response:-" + jsonResponse.toString());
      if (jsonResponse["status"] == false) {
        Navigator.of(keylogger.currentContext, rootNavigator: true).pop();

        Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        print("Response:-" + jsonResponse.toString());
      } else {
        if (jsonResponse != null) {
          print("Response:-" + jsonResponse.toString());
          Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
          bankPojo = UpdateBankPojo.fromJson(jsonResponse);

          setState(() {
            String branchid = bankPojo.branchId.toString();
            print("Branch Id:-" + branchid.toString());
            // sharedPreferences.setString("branchid", branchid);
          });
          Fluttertoast.showToast(
              msg: "Add Bank Status Successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);

          addBanktoServer(
              userid,
              bankPojo.profileType,
              bankPojo.userToken,
              bankPojo.token,
              bankPojo.bankName,
              bankPojo.transferMethodCountry,
              bankPojo.transferMethodCurrency,
              bankPojo.type,
              bankPojo.branchId,
              bankAccountIdcontroller.text,
              bankPojo.links.elementAt(0).href.toString(),
              bankPojo.status,
              bankPojo.bankAccountPurpose,
              bankPojo.country);

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          print("Response:-" + jsonResponse.toString());
          Fluttertoast.showToast(
            msg: jsonResponse["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
        }
      }
    } else {
      print("Response:-" + jsonResponse.toString());
      Navigator.of(keylogger.currentContext, rootNavigator: true).pop();

      Fluttertoast.showToast(
        msg: jsonResponse["errors"][0]["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> addbankstatus() async {
    print("Api Call");

    Map data = {
      'userid': userid,
      'bank_status': "1",
    };
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
    await http.post(Network.BaseApi + Network.updatebankstatus, body: data);
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Response:-" + jsonResponse.toString());
      if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        print("Response:-" + jsonResponse.toString());
      } else {
        if (jsonResponse != null) {
          print("Response:-" + jsonResponse.toString());

          if (jsonResponse["success"].toString() == "true") {
            savesharedpreference();
            Fluttertoast.showToast(
                msg: "Add Bank Status Successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));

            print('bankPojo.profileType' + bankPojo.profileType);
          } else {
            Fluttertoast.showToast(
                msg: "Add Bank Status Failed!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
          }
        } else {
          print("Response:-" + jsonResponse.toString());
          Fluttertoast.showToast(
            msg: jsonResponse["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      print("Response:-" + jsonResponse.toString());

      Fluttertoast.showToast(
        msg: jsonResponse["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> savesharedpreference() async {
    SharedPreferences mPref = await SharedPreferences.getInstance();
    mPref.setString('bankstatus', "1");
  }

  Future<void> gethyperwalletid(String userid) async {
    print("Api Call");
    Map data = {
      "userid": userid,
    };
    print("Data: " + data.toString());
    var jsonResponse = null;
    var response =
    await http.post(Network.BaseApi + Network.getHyperwalletid, body: data);
    jsonResponse = json.decode(response.body);

    print("Response hyperwallet:-" + jsonResponse.toString());

    if (response.statusCode == 200) {
      if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );

        print("Response:-" + jsonResponse.toString());
      } else {
        if (jsonResponse != null) {
          print("Response:-" + jsonResponse.toString());

          setState(() {
            _gethyperwalletPojo = GethyperwalletPojo.fromJson(jsonResponse);
            print("Get Hyperwallet user id:-" +
                _gethyperwalletPojo.data.hyperwalletId);
            hyperwalletuserid = _gethyperwalletPojo.data.hyperwalletId;
            /*
            print("Hyperwallet user id:-"+hyperwalletuserid.toString());
            SharedUtils.savehyperwalletuserid("hyperwalletuserId",hyperwalletuserid);
            print('saved hyper id is :'+SharedUtils.readhyperwalletuserid('hyperwalletuserId').toString());
            SharedUtils.savebankstatus("hyperwalletuserId",_gethyperwalletPojo.data.bankStatus.toString());
            */
          });
        } else {
          print("Response:-" + jsonResponse.toString());
          Fluttertoast.showToast(
            msg: jsonResponse["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      print("Response:-" + jsonResponse.toString());

      Fluttertoast.showToast(
        msg: jsonResponse["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  void addBanktoServer(
      String userid,
      String profileType,
      String userToken,
      String token,
      String bankName,
      String transferMethodCountry,
      String transferMethodCurrency,
      String type,
      String branchId,
      String bankAccountId,
      String links,
      String status,
      String bankAccountPurpose,
      String country,
      ) async {
    Map data = {
      'user_id': userid,
      'profileType': profileType,
      'userToken': userToken,
      'token': token,
      'bankName': bankName.trim(),
      'transferMethodCountry': transferMethodCountry,
      'transferMethodCurrency': transferMethodCurrency,
      'type': type,
      'branchId': branchId,
      'bankAccountId': bankAccountId,
      'links': links,
      'status': status,
      'bankAccountPurpose': bankAccountPurpose,
      'country': country,
    };
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
    await http.post(Network.BaseApi + Network.addbankdetails, body: data);
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Response:-" + jsonResponse.toString());
      if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        print("Response:-" + jsonResponse.toString());
      } else {
        if (jsonResponse != null) {
          print("Response:-" + jsonResponse.toString());

          AddBankPojo bankPojo = AddBankPojo.fromJson(jsonResponse);
          String addbankstatusresponse = jsonResponse.toString();
          if (jsonResponse["success"].toString() == "true") {
            savesharedpreference();
            Fluttertoast.showToast(
                msg: "Bank Added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            addbankstatus();
          } else {
            Fluttertoast.showToast(
                msg: "Add Bank Status Failed!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
          }
        } else {
          print("Response:-" + jsonResponse.toString());
          Fluttertoast.showToast(
            msg: jsonResponse["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      print("Response:-" + jsonResponse.toString());

      Fluttertoast.showToast(
        msg: jsonResponse["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  void getAccountInfo(String userid) async {
    print("Api Call");

    Map data = {
      'user_id': userid,
    };
    https: //kontribute.biz/api/getbankdetails
    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
    await http.post(Network.BaseApi + Network.getbankdetails, body: data);
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Response:-" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();

        Fluttertoast.showToast(
          msg: jsonResponse["success"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        if (jsonResponse != null) {
          // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
           getbankdetails =
          GetBankDeatilsPojo.fromJson(jsonResponse);
          setState(() {
            BankAccountId = getbankdetails.data.elementAt(0).bankAccountId;
            countrycontroller.text = getbankdetails.data.elementAt(0).country;

            print("bank details is : " +
                getbankdetails.data.elementAt(0).id.toString());

            bankAccountIdcontroller.text =
                getbankdetails.data.elementAt(0).bankAccountId;
            branchIdcontroller.text = getbankdetails.data.elementAt(0).branchId;
            currencycontroller.text =
                getbankdetails.data.elementAt(0).transferMethodCurrency;
            transfercountrycodecontroller.text =
                getbankdetails.data.elementAt(0).transferMethodCountry;
          });
        } else {
          Fluttertoast.showToast(
            msg: jsonResponse["success"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
        }
      }
    } else {
      // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();

      Fluttertoast.showToast(
        msg: jsonResponse["success"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
