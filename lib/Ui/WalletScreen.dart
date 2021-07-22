import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

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

  var languageselect = 1;

  List<RadioModel> sampleData = new List<RadioModel>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.sendreceivebg,

          child:  Column(
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
                        onTap: () {},
                        child: Container(),
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
                                  "16,756.00",
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
                        debit = true;
                        credit = false;
                        withdraw = false;
                        addmoney = false;
                      });

                      print("Value: " + tabvalue);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      child: Card(
                          color:
                          debit ? AppColors.light_grey : AppColors.whiteColor,
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(StringConstant.debit,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black87,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular')),
                          )),
                    ),
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
                        tabvalue = "Withdraw";
                        debit = false;
                        credit = false;
                        withdraw = true;
                        addmoney = false;
                      });
                      print("Value: " + tabvalue);
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 1),
                        child: Card(
                            color: withdraw
                                ? AppColors.light_grey
                                : AppColors.whiteColor,
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.blockSizeHorizontal * 25,
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Text(StringConstant.withdraw,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular')),
                            ))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tabvalue = "AddMoney";
                        debit = false;
                        credit = false;
                        withdraw = false;
                        addmoney = true;
                      });
                      print("Value: " + tabvalue);
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 2),
                        child: Card(
                            color: addmoney
                                ? AppColors.light_grey
                                : AppColors.whiteColor,
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.blockSizeHorizontal * 25,
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Text(
                                StringConstant.addmoney,
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
              tabvalue == "Debit"
                  ? tabDebitList()
                  : tabvalue == "Credit"
                  ? tabCreditlist()
                  : tabvalue == "Withdraw"
                  ? tabWithdraw()
                  : tabvalue == "AddMoney"
                  ? tabAddMoney()
                  : Container()
            ],
          ),

      ),
      bottomNavigationBar: bottombar(context),
    );
  }

  bottombar(context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 8,
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/homeicon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Home",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => WalletScreen()));
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/walleticon.png",
                      height: 20,
                      width: 20,
                      color: AppColors.selectedcolor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Wallet",
                        style: TextStyle(
                            color: AppColors.selectedcolor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NotificationScreen()));
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/notificationicon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Notification",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingScreen()));
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                margin:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/settingicon.png",
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        "Setting",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    // final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddScreen()));
      },
      child: Image.asset("assets/images/addpost.png"),
      elevation: 3.0,
    );
  }

  void _selectedTab(int index) {
    index = -1;
    setState(() {
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletScreen()));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingScreen()));
      }
    });
  }

  tabDebitList() {
    return Expanded(
      child: ListView.builder(
          itemCount: 8,
         /* physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,*/
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
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
                                          "-2220",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: AppColors.redbg,
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
      child: Container
        (
        margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical * 5,

        ),
        child:  Card(
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
                  width:
                  SizeConfig.blockSizeHorizontal * 70,
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
                          items: List<String>.generate(31,
                                  (int index) => '${index + 1}')
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
                              print(_dropDownValueInch
                                  .toString());
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
                          items:_dropdownCategoryyears
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
                              print(_dropDownValueYears
                                  .toString());
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
                  margin: EdgeInsets.only(left: 20, right: 20,bottom: SizeConfig.blockSizeVertical *3),
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                          : sampleData[index].text ==
                          "Bank Account details" &&
                          sampleData[index].isSelected == true
                          ? tabBankdetails()
                          : sampleData[index].text ==
                          "VISA card" &&
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

  tabAddMoney() {
    return Expanded(
      child: SingleChildScrollView(
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
                StringConstant.enteramountadd,
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
            /*  Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *3,right: SizeConfig.blockSizeHorizontal *3,top: SizeConfig.blockSizeVertical * 2),
              alignment: Alignment.topCenter,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Text(
                StringConstant.enterupimobileno,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Bold'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical *2,
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
                  color: Colors.black,
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
                    fontFamily: 'Poppins-Regular',  fontSize: 12,color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Regular',  fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                  hintText: "00-000-000-00",
                ),
              ),
            ),*/

            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeVertical * 2),
              alignment: Alignment.topCenter,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Text(
                StringConstant.enteramount,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Bold'),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 7,
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
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
                  FocusScope.of(context).requestFocus(MobileFocus);
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
                    color: Colors.black,
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
                  bottom: SizeConfig.blockSizeVertical * 6,
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
      ),
    );
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
