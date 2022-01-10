import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Pojo/ContactusPojo.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class ContactUs extends StatefulWidget{
  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUs>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final NameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final MobileFocus = FocusNode();
  final SubjectFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();
  ContactusPojo contactpojo;
  String _email,_name,_mobile,_subject,_description;
  bool showvalue = false;
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
        height: SizeConfig.blockSizeVertical *12,
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
            width: 20,height: 20,
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *2),
                child:
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/images/menu.png",color:AppColors.whiteColor,width: 20,height: 20,),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal *60,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                // margin: EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  'contactus'.tr, textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat",
                      color: Colors.white),
                ),
              ),
              Container(
                width: 25,height: 25,
                margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *2),

              ),
            ],
          ),
        ),
            Expanded(
                child: SingleChildScrollView(
                  child:  Column(
                    children: [
                  Container(
                  height: SizeConfig.blockSizeVertical *30,
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *10,right: SizeConfig.blockSizeHorizontal *10,
                      top: SizeConfig.blockSizeVertical *2,),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/contct.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,
                            right: SizeConfig.blockSizeHorizontal*5,
                            top: SizeConfig.blockSizeVertical*2),
                        height: SizeConfig.blockSizeVertical*70,
                        child: Card(
                          child: Form(
                            key:_formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    focusNode: EmailFocus,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseenteremail'.tr;
                                      else if (!regex.hasMatch(val))
                                        return 'pleaseentervalidemail'.tr;
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _email= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(NameFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'youremail'.tr,
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    focusNode: NameFocus,
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentername'.tr;
                                      else if (val.length < 3)
                                        return 'namemustbemorethan2charater'.tr;
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _name= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(MobileFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'yourname'.tr,
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:  TextFormField(
                                    autofocus: false,
                                    focusNode: MobileFocus,
                                    controller: mobileController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentermobilenumber'.tr;
                                      else if (val.length < 10)
                                        return 'yourmobilenumbershouldbe10charlong'.tr;
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _mobile= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(SubjectFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'phonenumber'.tr,
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),


                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*10 ,
                                  width: SizeConfig.blockSizeHorizontal*80,

                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    maxLines:2,
                                    focusNode: SubjectFocus,
                                    controller: subjectController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentersubject'.tr;
                                      else if (val.length < 3)
                                        return 'subjectmustbemorethan2charater'.tr;
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _subject= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(DescriptionFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular'),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'subject'.tr,
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),

                                    ),
                                  ),
                                ),

                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*15 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    maxLines: 3,
                                    focusNode: DescriptionFocus,
                                    controller: descriptionController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return 'pleaseentermessage'.tr;
                                      else if (val.length < 3)
                                        return 'messagemustbemorethan2charater'.tr;
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _description= val,
                                    onFieldSubmitted: (v) {
                                      DescriptionFocus.unfocus();
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'yourmessage'.tr,
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),

                                    ),
                                  ),
                                ),
                              /*  Container(
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*3,
                                      right: SizeConfig.blockSizeHorizontal*5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        color: Colors.white,
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
                                        child: Text('bysendingthismessageyou'.tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',)),
                                      ),

                                    ],
                                  ),
                                ),*/
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Internet_check().check().then((intenet) {
                                        if (intenet != null && intenet) {
                                          contactus(
                                              emailController.text,
                                              nameController.text,
                                              mobileController.text,
                                              subjectController.text,
                                              descriptionController.text,
                                          );
                                        } else {
                                          errorDialog('nointernetconnection'.tr);

                                        }
                                        // No-Internet Case
                                      });
                                    }


                                   /* Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => selectlangauge()),
                                            (route) => false);*/
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 38,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      bottom: SizeConfig.blockSizeVertical * 2,
                                      left: SizeConfig.blockSizeHorizontal *5,
                                      right: SizeConfig.blockSizeHorizontal *5

                                    ),
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: new AssetImage("assets/images/sendbutton.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('send'.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 15,
                                            )),
                                        Container(
                                          child:IconButton(icon: Icon(Icons.arrow_forward,color: AppColors.whiteColor,), onPressed: () {}),
                                        )
                                      ],
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )

            )
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
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 24,
                margin:
                EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/homeicon.png",
                      height: 15,
                      width: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'home'.tr,
                        style:
                        TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => mytranscation()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal *24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_mytranscaton.png",
                      height: 15,
                      width: 15,
                      color: AppColors.greyColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'mytransactions'.tr,
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NotificationScreen()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/notificationicon.png",
                      height: 15,
                      width: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'notification'.tr,
                        style:
                        TextStyle(color: AppColors.greyColor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ContactUs()));
              });
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 23,
                margin:
                EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nav_contactus.png",
                      height: 15,
                      width: 15,
                      color: AppColors.selectedcolor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1),
                      child: Text(
                        'contactus'.tr,
                        style:
                        TextStyle(color: AppColors.selectedcolor, fontSize: 10),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
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


  contactus(String emal,String name,String phone,String sub,String message) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "email":emal,
      "mobile":name,
      "name":phone,
      "subject":sub,
      "message":message,
    };
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.contactus, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        contactpojo = new ContactusPojo.fromJson(jsonResponse);
        if (jsonResponse != null)
        {
          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(()
          {
            Navigator.of(context).pop();
          });


        }
      }
    } else if (response.statusCode == 500){
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog("Internal Server Error");
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);
    }
  }

}