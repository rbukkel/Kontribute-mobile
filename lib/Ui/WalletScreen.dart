import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/Paymentdetail_pojo.dart';
import 'package:kontribute/Pojo/wallletBalancePojo.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  int _index = 0;
  bool home = false;
  bool wallet = false;
  bool notification = false;
  bool setting = false;
  String _dropDownValueInch;
  String _dropDownValueYears;
  String tabvalue = "Debit";
  final AcholdernameFocus = FocusNode();
  final AccountnoFocus = FocusNode();
  final IFSCCodeFocus = FocusNode();
  final AmountBankFocus = FocusNode();
  final MobileFocus = FocusNode();
  final PaypalIdFocus = FocusNode();
  final AmountFocus = FocusNode();
  final TextEditingController AcholdernameController =
      new TextEditingController();
  final TextEditingController IFSCCodeController = new TextEditingController();
  final TextEditingController AmountBankController =
      new TextEditingController();
  final TextEditingController AccountnoController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController PaypalIdController = new TextEditingController();
  final TextEditingController amountController = new TextEditingController();
  String _mobile;
  String _PaypalId;
  String _amount;
  String _Acholdername;
  String _IFSCCode;
  String _AmountBank;
  String _Accountno;

  bool debit = true;
  bool credit = false;
  bool withdraw = false;
  bool addmoney = false;
  String userid;
  String walletbalance = "";
  var languageselect = 1;
  GlobalKey<State> keylogger = new GlobalKey<State>();
  List<RadioModel> sampleData = new List<RadioModel>();
  wallletBalancePojo _wallletBalance;
  PaymentdetailPojo _paymentdetailPojo;
  String hyperwalletuserid;
  bool resultvalue = false;
  bool resultvalue1 = false;
  String bankstatus;
  final List<String> _dropdownCategoryyears = [
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'Paypal Account'));
    sampleData.add(new RadioModel(false, 'Bank Account details'));
    sampleData.add(new RadioModel(false, 'VISA card'));
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });

    SharedUtils.readhyperwalletuserid("hyperwalletuserId").then((val) {
      hyperwalletuserid = val;
      print("Hyperwallet UserId: " + hyperwalletuserid.toString());
      getcurrent_balance(hyperwalletuserid);
    });
    getbankstatus();
  }

  Future<void> getcurrent_balance(String userid) async {
    // Dialogs.showLoadingDialog(context, keylogger);
    print("Api Call");

    Map data = {
      'user_id': userid,
    };

    print("profile data: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.wallet, body: data);
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Response:-" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
        resultvalue1 = true;

        Fluttertoast.showToast(
          msg: jsonResponse["success"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );

      } else {
        if (jsonResponse != null) {
          // Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
          _wallletBalance = wallletBalancePojo.fromJson(jsonResponse);
          resultvalue1 = true;

          // Fluttertoast.showToast(
          //     msg: "Wallet balance response success!",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1);
          print("Wallet balance response success!");
          setState(() {
            walletbalance = _wallletBalance.currentBalance.toString();
          });
        } else {
          resultvalue1 = true;

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
      resultvalue1 = true;

      Fluttertoast.showToast(
        msg: jsonResponse["success"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                mytranscation()));
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
                      StringConstant.wallet,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Montserrat",
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
            Container(
              child: Stack(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 8),
                    height: SizeConfig.blockSizeVertical * 20,
                    width: SizeConfig.blockSizeHorizontal * 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/wallet_bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 4,
                        left: SizeConfig.blockSizeHorizontal * 25,
                        right: SizeConfig.blockSizeHorizontal * 10),
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.blockSizeHorizontal * 50,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image:
                            new AssetImage("assets/images/walletbalace_bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Current Balance",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 3),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "\$",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2),
                              alignment: Alignment.topCenter,
                              child: Text(
                                walletbalance,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      tabvalue = "Debit";
                    });
                    print("Value: " + tabvalue);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 35,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: Text(StringConstant.withdraw.toUpperCase(),
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular')),
                      )),
                ),

                /*  GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      tabvalue ="Credit";
                      debit = false;
                      credit = true;
                      withdraw = false;
                      addmoney = false;
                    });

                    print("Value: "+tabvalue);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal *1),
                      child: Card(
                          color: credit?AppColors.light_grey:AppColors.whiteColor,
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(StringConstant.credit,style: TextStyle(letterSpacing: 1.0,
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular')),
                          ))) ,
                ),*/

                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("Hyperwallet id on click:-"+hyperwalletuserid.toString());
                      print("Bank details on click:-"+bankstatus.toString());
                      if (hyperwalletuserid.toString() == "null" || hyperwalletuserid == "") {
                        Fluttertoast.showToast(
                          msg: 'completeyourprofilefirst'.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      } else {
                        if (bankstatus == "0" || bankstatus.toString()=="null" || bankstatus=="") {
                          Fluttertoast.showToast(
                            msg: 'addyourbankfirst'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                          );
                        } else {
                          showDialog(
                            context: context,
                            child: Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: AppColors.whiteColor,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  height: SizeConfig.blockSizeVertical * 45,
                                  child: new Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            amountController.text = "";
                                          });

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: SizeConfig
                                                  .blockSizeHorizontal *
                                                  3,
                                              top:
                                              SizeConfig.blockSizeVertical *
                                                  2),
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.close,
                                            size: 20.0,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                            right:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                            top: SizeConfig.blockSizeVertical *
                                                2),
                                        alignment: Alignment.topCenter,
                                        width: SizeConfig.blockSizeHorizontal *
                                            100,
                                        child: Text(
                                          StringConstant.withdrawrequest,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Bold'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                            right:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                            top: SizeConfig.blockSizeVertical *
                                                5),
                                        alignment: Alignment.topCenter,
                                        width: SizeConfig.blockSizeHorizontal *
                                            100,
                                        child: Text(
                                          StringConstant.enteramount,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Bold'),
                                        ),
                                      ),
                                      Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 6,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                2,
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                8,
                                            right:
                                            SizeConfig.blockSizeHorizontal *
                                                8,
                                          ),
                                          padding: EdgeInsets.only(
                                            left: SizeConfig.blockSizeVertical *
                                                1,
                                            right:
                                            SizeConfig.blockSizeVertical *
                                                1,
                                          ),
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    5,
                                                child: Text(
                                                  "\$",
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Poppins-Bold'),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                        .blockSizeVertical *
                                                        0.5),
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    45,
                                                child: TextFormField(
                                                  autofocus: false,
                                                  focusNode: AmountFocus,
                                                  controller: amountController,
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  validator: (val) {
                                                    if (val.length == 0)
                                                      return "Please enter amount";
                                                    else
                                                      return null;
                                                  },
                                                  onFieldSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                        MobileFocus);
                                                  },
                                                  onSaved: (val) =>
                                                  _amount = val,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                    InputBorder.none,
                                                    hintStyle: TextStyle(
                                                      color: Colors.black12,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                      fontSize: 12,
                                                      decoration:
                                                      TextDecoration.none,
                                                    ),
                                                    hintText: "30000",
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          sendmoney();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                          MediaQuery.of(context).size.width,
                                          height:
                                          SizeConfig.blockSizeVertical * 6,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                5,
                                            bottom:
                                            SizeConfig.blockSizeVertical *
                                                6,
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                15,
                                            right:
                                            SizeConfig.blockSizeHorizontal *
                                                15,
                                          ),
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/sendbutton.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: Text(StringConstant.withdraw,
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
                                )),
                          );
                        }
                      }
                      print("Hyperwallet id on click:-" +
                          hyperwalletuserid.toString());
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 4),
                      child: Card(
                          color: addmoney
                              ? AppColors.light_grey
                              : AppColors.whiteColor,
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(
                              StringConstant.withdrawrequest,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ))),
                ),
              ],
            ),
            tabDebitList()
          ],
        ),
      ),
    );
  }

  tabDebitList() {
    return resultvalue1 == true
        ? Expanded(
            child: ListView.builder(
                itemCount: _wallletBalance.withdrawlisting.length,
                /* physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,*/
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical * 2),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.blockSizeVertical * 8,
                                      width: SizeConfig.blockSizeVertical * 8,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                          bottom:
                                              SizeConfig.blockSizeVertical * 1,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: new AssetImage(
                                            "assets/images/walletlisticon.png"),
                                        fit: BoxFit.fill,
                                      )),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  55,
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                              ),
                                              child: Text(
                                                _wallletBalance.withdrawlisting
                                                    .elementAt(index)
                                                    .clientPaymentId
                                                    .toString(),
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black87,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                              ),
                                              child: Text(
                                                "\$" +
                                                    _wallletBalance
                                                        .withdrawlisting
                                                        .elementAt(index)
                                                        .amount
                                                        .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.redbg,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  55,
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                  top: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              child: Text(
                                                _wallletBalance.withdrawlisting
                                                    .elementAt(index)
                                                    .createdAt
                                                    .toString(),
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black87,
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                top: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                              ),
                                              child: Text(
                                                "USD",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black26,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        )),
                  );
                }),
          )
        : Container();
  }

  tabPaypal() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeVertical * 4),
            alignment: Alignment.topCenter,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Text(
              StringConstant.withdrawtitle,
              style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Bold'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
            child: Divider(
              thickness: 1,
              color: Colors.black12,
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: PaypalIdFocus,
              controller: PaypalIdController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter paypal id";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(MobileFocus);
              },
              onSaved: (val) => _PaypalId = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "myself@me.com",
              ),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: AmountFocus,
              controller: amountController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter amount";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                AmountFocus.unfocus();
              },
              onSaved: (val) => _amount = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "30000",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
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
              child: Text(StringConstant.proceedtopay,
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
    );
  }

  tabBankdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: AccountnoFocus,
              controller: AccountnoController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter account no.";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(AcholdernameFocus);
              },
              onSaved: (val) => _Accountno = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "215256123123123",
              ),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: AcholdernameFocus,
              controller: AcholdernameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter account holder name";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(IFSCCodeFocus);
              },
              onSaved: (val) => _Acholdername = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "Jack",
              ),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: IFSCCodeFocus,
              controller: IFSCCodeController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter IFSC code";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(AmountBankFocus);
              },
              onSaved: (val) => _IFSCCode = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "ICICI001",
              ),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 5,
            ),
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical * 1,
              right: SizeConfig.blockSizeVertical * 1,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black26,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
            ),
            child: TextFormField(
              autofocus: false,
              focusNode: AmountBankFocus,
              controller: AmountBankController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter amount";
                else
                  return null;
              },
              onFieldSubmitted: (v) {
                AmountBankFocus.unfocus();
              },
              onSaved: (val) => _AmountBank = val,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
                hintText: "3000",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
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
              child: Text(StringConstant.proceedtopay,
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
    );
  }

  tabVisaCard() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical * 5,
        ),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 7,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeVertical * 1,
                    right: SizeConfig.blockSizeVertical * 1,
                  ),
                  alignment: Alignment.topLeft,
                  /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                  ),*/
                  child: TextFormField(
                    autofocus: false,
                    focusNode: AccountnoFocus,
                    controller: AccountnoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val.length == 0)
                        return "Please enter account no.";
                      else
                        return null;
                    },
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(AcholdernameFocus);
                    },
                    onSaved: (val) => _Accountno = val,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                      hintText: "Name on card",
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 7,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeVertical * 1,
                    right: SizeConfig.blockSizeVertical * 1,
                  ),
                  alignment: Alignment.topLeft,
                  /* decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                  ),*/
                  child: TextFormField(
                    autofocus: false,
                    focusNode: AcholdernameFocus,
                    controller: AcholdernameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val.length == 0)
                        return "Please enter account holder name";
                      else
                        return null;
                    },
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(IFSCCodeFocus);
                    },
                    onSaved: (val) => _Acholdername = val,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                      hintText: "Card Number",
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: Text(
                    "Expiry date",
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 30,
                      height: SizeConfig.blockSizeVertical * 7,
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical * 5,
                        right: SizeConfig.blockSizeVertical * 1,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black26,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.transparent,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            "00",
                            style: TextStyle(fontSize: 12),
                          ),
                          items: List<String>.generate(
                                  31, (int index) => '${index + 1}')
                              .map((String value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Bold'),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          value: _dropDownValueInch,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _dropDownValueInch = newValue;
                              print(_dropDownValueInch.toString());
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 40,
                      height: SizeConfig.blockSizeVertical * 7,
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        right: SizeConfig.blockSizeHorizontal * 5,
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical * 5,
                        right: SizeConfig.blockSizeVertical * 1,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black26,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.transparent,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            "0000",
                            style: TextStyle(fontSize: 12),
                          ),
                          items: _dropdownCategoryyears
                              .map((String value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Bold'),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          value: _dropDownValueYears,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _dropDownValueYears = newValue;
                              print(_dropDownValueYears.toString());
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
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
                    child: Text(StringConstant.proceedtopay,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 15,
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }

  tabCreditlist() {
    return Expanded(
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: SizeConfig.blockSizeVertical * 8,
                                width: SizeConfig.blockSizeVertical * 8,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 1,
                                    bottom: SizeConfig.blockSizeVertical * 1,
                                    right: SizeConfig.blockSizeHorizontal * 1,
                                    left: SizeConfig.blockSizeHorizontal * 2),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: new AssetImage(
                                      "assets/images/walletlisticon.png"),
                                  fit: BoxFit.fill,
                                )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 55,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1,
                                        ),
                                        child: Text(
                                          "Card **** **** ****5678",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 20,
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                        child: Text(
                                          "+3400",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.darkgreen,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 55,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            top:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
                                        child: Text(
                                          "5March, 18:33",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 20,
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2,
                                          top: SizeConfig.blockSizeHorizontal *
                                              2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                        child: Text(
                                          "USD",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black26,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  )),
            );
          }),
    );
  }

  tabWithdraw() {
    String valuesel = "Paypal Account";
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 45,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: sampleData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // margin: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: SizeConfig.blockSizeVertical * 3),
                  child: Column(
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              sampleData.forEach(
                                  (element) => element.isSelected = false);
                              sampleData[index].isSelected = true;
                              valuesel = sampleData[index].text.toString();
                              print("SElect: " + valuesel);
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    sampleData[index].text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                    child: new RadioItem(sampleData[index])),
                              ]),
                        ),
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Container()),
                      sampleData[index].text == "Paypal Account" &&
                              sampleData[index].isSelected == true
                          ? tabPaypal()
                          : sampleData[index].text == "Bank Account details" &&
                                  sampleData[index].isSelected == true
                              ? tabBankdetails()
                              : sampleData[index].text == "VISA card" &&
                                      sampleData[index].isSelected == true
                                  ? tabVisaCard()
                                  : Container()
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> sendmoney() async {
    Dialogs.showLoadingDialog(context, keylogger);
    var rnd = Random();
    String randomno;
    randomno = rnd.nextInt(1000000).toString();
    print("Api Call");

    Map bodynew = {
      "amount": amountController.text,
      "clientPaymentId": randomno,
      "currency": "USD",
      "destinationToken": hyperwalletuserid,
      "programToken": StringConstant.programtoken,
      "purpose": "OTHER",
    };

    var body = json.encode(bodynew);

    String username = StringConstant.hyperwalletusername;
    String password = StringConstant.hyperwalletpassword;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': basicAuth
    };

    var jsonResponse = null;
    http.Response response = await http.post(
      Network.hyperwallet_baseApi + Network.payments,
      body: body,
      headers: headers,
    );
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
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

          // Fluttertoast.showToast(
          //     msg: 'withdrawalsuccessfully'.tr,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1);
          _paymentdetailPojo = PaymentdetailPojo.fromJson(jsonResponse);
          addwithdrawnstatus(
              userid,
              _paymentdetailPojo.expiresOn,
              _paymentdetailPojo.createdOn,
              _paymentdetailPojo.amount,
              _paymentdetailPojo.currency,
              _paymentdetailPojo.clientPaymentId,
              _paymentdetailPojo.destinationToken,
              _paymentdetailPojo.purpose,
              _paymentdetailPojo.status);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ProfileScreen()));
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

  Future<void> addwithdrawnstatus(
      String userid,
      String expiresOn,
      String createdOn,
      String amount,
      String currency,
      String clientPaymentId,
      String destinationToken,
      String purpose,
      String status) async {
    Dialogs.showLoadingDialog(context, keylogger);

    print("Api Call");

    Map bodynew = {
      "user_id": userid,
      "expiresOn": expiresOn,
      "createdOn": createdOn,
      "token": hyperwalletuserid,
      "amount": amount,
      "currency": currency,
      "clientPaymentId": clientPaymentId,
      "destinationToken": destinationToken,
      "purpose": purpose,
      "programToken": StringConstant.programtoken,
      "links": "",
      "status": status,
    };

    var body = json.encode(bodynew);

    String username = StringConstant.hyperwalletusername;
    String password = StringConstant.hyperwalletpassword;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': basicAuth
    };

    var jsonResponse = null;
    http.Response response = await http.post(
      Network.hyperwallet_baseApi + Network.withdrawamount,
      body: body,
      headers: headers,
    );
    jsonResponse = json.decode(response.body);

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
        resultvalue = true;
        print("Response:-" + jsonResponse.toString());
      } else {
        if (jsonResponse != null) {
          print("Response:-" + jsonResponse.toString());
          Navigator.of(keylogger.currentContext, rootNavigator: true).pop();
          resultvalue = true;

          Fluttertoast.showToast(
              msg: 'withdrawalsuccessfully'.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        } else {
          resultvalue = true;
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
      resultvalue = true;

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

  Future<void> getbankstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      bankstatus = sharedPreferences.getString("bankstatus");
      print("Bank status:-" + bankstatus.toString());
    });
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 30.0,
            width: 30.0,
            decoration: new BoxDecoration(
              image: _item.isSelected
                  ? new DecorationImage(
                      image:
                          new ExactAssetImage('assets/images/click_radio.png'),
                      fit: BoxFit.cover,
                    )
                  : new DecorationImage(
                      image: new ExactAssetImage('assets/images/not_click.png'),
                      fit: BoxFit.cover,
                    ),
              // color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: new Border.all(
                width: 1.0,

                //    color: _item.isSelected ? Colors.blueAccent : Colors.grey
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
