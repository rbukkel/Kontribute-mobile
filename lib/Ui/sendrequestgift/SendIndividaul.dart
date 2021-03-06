import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Payment/payment.dart';
import 'package:kontribute/Pojo/SendIndividualPojo.dart';
import 'package:kontribute/Pojo/commisionpojo.dart';
import 'package:kontribute/Pojo/get_send_gift.dart';
import 'package:kontribute/Pojo/individualRequestDetailspojo.dart';
import 'package:kontribute/Pojo/sendmoneypojo.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/Ui/sendrequestgift/sendreceivedgifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class SendIndividaul extends StatefulWidget{
  @override
  SendIndividaulState createState() => SendIndividaulState();
}

class SendIndividaulState extends State<SendIndividaul>{
  final SearchContactFocus = FocusNode();
  final requiredamountFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  sendmoneypojo moneypojo;
  final TextEditingController searchcontactController = new TextEditingController();
  final TextEditingController requiredamountController = new TextEditingController();
  final TextEditingController DescriptionController = new TextEditingController();
  final MoneyCashFocus = FocusNode();
  final TextEditingController MoneyCashController = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String _requiredamount;
  var valcommision;
  String _searchcontact;
  String _moneyCash;
  String _Description;
  bool showvalue = false;
  String notificationvalue="off";
  File _imageFile;
  bool image_value = false;
  bool imageUrl = false;
  final _formKey = GlobalKey<FormState>();
  String userName;
  String user;
  String userid;
  String val;
  individualRequestDetailspojo senddetailsPojo;
  bool isLoading = false;
  List<dynamic> categoryTypes = List();
  var currentSelectedValue;
  get_send_gift sendgift;
  var productlist_length;
  String image;
  bool isNumericMode = false;
  String text = '';
  var updateval;
  SendIndividualPojo sendIndividualPojo;
  String activeLanguage;
  bool showkeyboardDescription = false;
  bool shiftEnabledProjectname = false;
  commisionpojo commission;
  var commisionlist_length;

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      user = val;
     getCategory(user);
      print("Login userid: " + user.toString());
    });
    SharedUtils.readLangaunage("Langauge").then((val) {
      if(val == null || val =="")
      {
        activeLanguage ="English";
        print("Login : " + activeLanguage.toString());
      }
      else{
        activeLanguage = val;
        print("Login Langauge: " + activeLanguage.toString());
      }
    });
  }

  void getData(int id) async {
    Map data = {
      'id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.get_send_gift, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        sendgift = new get_send_gift.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = sendgift.data;
            // storelist_length = senddetailsPojo.paymentdetails.data;
            if (sendgift.data.giftPicture != null) {
              setState(() {
                image = sendgift.data.giftPicture;
              });
            }
          });
        } else {
          Fluttertoast.showToast(
            msg: sendgift.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> getCategory(String a) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {'receiver_id': a.toString()};
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.followlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      print("Json User" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          final data = json.decode(response.body);
          List<dynamic> data1 = data["result"];
          setState(()
          {
            categoryTypes = data1;
          });
        }
        else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            errorDialog(jsonResponse["message"]);
          });
        }
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

  Future<void> captureImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      try {
        final imageFile =
        await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
        setState(() async {
          _imageFile = imageFile;
          if (_imageFile != null && await _imageFile.exists()) {
            setState(() {
              print("Path: "+_imageFile.toString());
              image_value = true;
              imageUrl = false;
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
        await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
        setState(() async {
          _imageFile = imageFile;
          if (_imageFile != null && await _imageFile.exists()) {
            setState(() {
              print("Path: "+_imageFile.toString());
              image_value = true;
              imageUrl = false;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:  Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 45,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.center,
                          child:ClipRect(child:  image_value?Image.file(_imageFile, fit: BoxFit.fill, height: SizeConfig.blockSizeVertical * 45,
                            width: SizeConfig.blockSizeHorizontal * 100,)
                              :new Image.asset("assets/images/banner1.png", height: SizeConfig.blockSizeVertical * 45,
                            width: SizeConfig.blockSizeHorizontal * 100,fit: BoxFit.fill,),),
                        ),
                        InkWell(
                          onTap: () {
                            showAlert();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 21,
                                right: SizeConfig.blockSizeHorizontal*2),
                            child: Image.asset(
                              "assets/images/camera.png",
                              width:50,
                              height: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3,
                            top: SizeConfig.blockSizeVertical * 2),
                        width: SizeConfig.blockSizeHorizontal * 32,
                        child: Row(
                          children: [
                            Text(
                              'searchcontact'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                            Text(
                              '  *',
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ],
                        )
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 60,
                        height: SizeConfig.blockSizeVertical * 8,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 2,
                            right: SizeConfig.blockSizeHorizontal * 2),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),
                        child:
                        FormField<dynamic>(
                          builder: (FormFieldState<dynamic> state) {
                            return InputDecorator(
                              decoration:
                              InputDecoration.collapsed(hintText:''),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<dynamic>(
                                  hint: Text('selectcontact'.tr,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Bold')),
                                  dropdownColor: Colors.white,
                                  value: currentSelectedValue,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedValue = newValue;
                                      userid = (newValue["connection_id"].toString());
                                      if(newValue["full_name"]==null)
                                        {
                                          userName="";
                                        }
                                      else
                                        {
                                          userName = (newValue["full_name"]);
                                        }

                                      print("User: "+userName.toString());
                                      print("Userid: "+userid.toString());
                                    });
                                  },
                                  items: categoryTypes.map((dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value["full_name"]==null?"":value["full_name"],
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Bold')),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3,
                            top: SizeConfig.blockSizeVertical * 2),
                        width: SizeConfig.blockSizeHorizontal * 45,
                        child: Row(
                          children: [
                            Text(
                              'enteramount'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                            Text(
                              '  *',
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ],
                        )

                      ),
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 42,
                          height: SizeConfig.blockSizeVertical * 7,
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                            right: SizeConfig.blockSizeHorizontal * 3,
                          ),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black26,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: SizeConfig.blockSizeVertical * 7,
                                width: SizeConfig.blockSizeHorizontal * 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                  border: Border.all(
                                    color: AppColors.theme1color,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: AppColors.theme1color,
                                ),
                                padding: EdgeInsets.all(0.7),
                                child: Image.asset(
                                  "assets/images/dollersign.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.blockSizeHorizontal *
                                    30,
                                padding: EdgeInsets.only(
                                    left: SizeConfig
                                        .blockSizeHorizontal *
                                        1,
                                    right: SizeConfig
                                        .blockSizeHorizontal *
                                        1),
                                child:
                                TextFormField(
                                  autofocus: false,
                                  focusNode: MoneyCashFocus,
                                  controller: MoneyCashController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return 'pleaseenterrequiredamount'.tr;
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(DescriptionFocus);
                                  },
                                  onSaved: (val) => _moneyCash = val,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 12,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      children: [
                        Text(
                          'message'.tr,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Bold'),
                        ),
                        Text(
                          '  *',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Bold'),
                        ),
                      ],
                    )
                  ),
                  activeLanguage =="Arabic"?
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeVertical * 1,
                              right: SizeConfig.blockSizeVertical * 1,
                            ),
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black26,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              onTap: ()
                              {
                                setState(() {
                                  showkeyboardDescription = true;
                                });
                              },
                              enableInteractiveSelection: true,
                              toolbarOptions: ToolbarOptions(
                                copy: true,
                                cut: true,
                                paste: true,
                                selectAll: true,
                              ),
                              autofocus: false,
                              readOnly: true,
                              maxLines: 4,
                              focusNode: DescriptionFocus,
                              controller: DescriptionController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val.length == 0)
                                  return 'pleaseentermessage'.tr;
                                else
                                  return null;
                              },
                              onFieldSubmitted: (v) {
                                DescriptionFocus.unfocus();
                              },
                              onSaved: (val) => _Description = val,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 15,
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
                                hintText: 'typeheremessage'.tr,
                              ),
                            ),
                          ),
                          Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: Container()),
                          showkeyboardDescription == true? Container(
                            color: Colors.white54,
                            child: VirtualKeyboard(
                                height: 250,
                                textColor: Colors.black,
                                textController: DescriptionController,
                                defaultLayouts: [
                                  VirtualKeyboardDefaultLayouts.Arabic
                                ],
                                //reverseLayout :true,
                                type: isNumericMode
                                    ? VirtualKeyboardType.Numeric
                                    : VirtualKeyboardType.Alphanumeric,
                                onKeyPress: _onKeyPress),
                          ):Container()
                        ],
                      ):
                  activeLanguage =="English"?
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical * 1,
                          right: SizeConfig.blockSizeVertical * 1,
                        ),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),
                        child: TextFormField(
                          autofocus: false,
                          maxLines: 4,
                          focusNode: DescriptionFocus,
                          controller: DescriptionController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.length == 0)
                              return 'pleaseentermessage'.tr;
                            else
                              return null;
                          },
                          onFieldSubmitted: (v) {
                            DescriptionFocus.unfocus();
                          },
                          onSaved: (val) => _Description = val,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
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
                            hintText: 'typeheremessage'.tr,
                          ),
                        ),
                      ),

                    ],
                  ):
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical * 1,
                          right: SizeConfig.blockSizeVertical * 1,
                        ),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),
                        child: TextFormField(
                          autofocus: false,
                          maxLines: 4,
                          focusNode: DescriptionFocus,
                          controller: DescriptionController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.length == 0)
                              return 'pleaseentermessage'.tr;
                            else
                              return null;
                          },
                          onFieldSubmitted: (v) {
                            DescriptionFocus.unfocus();
                          },
                          onSaved: (val) => _Description = val,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
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
                            hintText: 'typeheremessage'.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.white,
                          child: Checkbox(
                            value: showvalue,
                            onChanged: (bool value) {
                              setState(() {
                                showkeyboardDescription = false;
                                showvalue = value;
                                if(showvalue == true)
                                {
                                  notificationvalue = "on";
                                }
                                else{
                                  notificationvalue = "off";
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text('receivenotificationswhenfriendpay'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',
                              )),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showkeyboardDescription = false;
                      });
                      if (_formKey.currentState.validate()) {
                        if (userid != null) {
                          setState(() {
                            isLoading = true;
                          });
                          Internet_check().check().then((intenet) {
                            if (intenet != null && intenet) {
                              if(_imageFile!=null)
                              {
                                sendIndivial(
                                    notificationvalue,
                                    MoneyCashController.text,
                                    DescriptionController.text,
                                    _imageFile,
                                    userid.toString()
                                );
                              }
                              else
                                {
                                errorDialog('pleaseselectgiftimage'.tr);
                                }
                            } else
                              {
                              errorDialog('nointernetconnection'.tr);
                              }
                          });
                        } else {
                          errorDialog('pleaseselectcontacts'.tr);
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: SizeConfig.blockSizeHorizontal * 40,
                      height: SizeConfig.blockSizeVertical * 6,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                          bottom: SizeConfig.blockSizeVertical * 3,
                          left: SizeConfig.blockSizeHorizontal * 5,
                          right: SizeConfig.blockSizeHorizontal * 5),
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/sendbutton.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text('send'.tr,
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
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabledProjectname ? key.capsText : key.text);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabledProjectname = !shiftEnabledProjectname;
          break;
        default:
      }
    }
    // Update the screen
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
                    'okay'.tr,
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


  void sendIndivial(String  notification, String requiredamoun, String description,File Imge, String userid) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.send_gift),);


    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["notification"] = notification.toString();
    request.fields["price"] = requiredamoun.toString();
    request.fields["message"] = description;
    request.fields["sender_id"] = user.toString();
    request.fields["receiver_id"] = userid.toString();


    print("Request: "+request.fields.toString());
    if (Imge != null) {
      print("PATH: " + Imge.path);
      request.files.add(await http.MultipartFile.fromPath("file", Imge.path, filename: Imge.path));
    }
    var response = await request.send();


    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      print("jsonData : " + jsonData.toString());
      if (jsonData["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonData["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonData != null) {
          setState(() {
            isLoading = false;
          });
          sendIndividualPojo=SendIndividualPojo.fromJson(jsonData);

          getCommision(sendIndividualPojo.data.id.toString(),sendIndividualPojo.data.senderId.toString());

          errorDialog(jsonData["message"]);


/*

          Future.delayed(Duration(seconds: 2),()
          {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) =>
                OngoingSendReceived()),
                    (route) => false);
          });
*/





        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
            //   isLoading = false;
          });
          Fluttertoast.showToast(
            msg: jsonData["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    });
  }

  void getCommision(String id, String userid) async {
    var jsonResponse = null;
    var response = await http.get(Uri.encodeFull(Network.BaseApi + Network.admincommission));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valcommision = response.body;
      print("Commission:"+valcommision.toString());
      if (jsonResponse["success"] == false) {
        errorDialog(jsonDecode(valcommision)["message"]);
      } else {
        commission = new commisionpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          payamount(id,userid);
          // setState(() {Response 1
          //   commisionlist_length = commission.commisiondata;
          //
          //
          // });
        } else {
          errorDialog(commission.message);
        }
      }
    } else {
      errorDialog(jsonDecode(valcommision)["message"]);
    }
  }

  Future<void> payamount(String id, String userid) async {


    String price=MoneyCashController.text;



   /* if(senddetailsPojo.result.price != null)
    {`
      price =senddetailsPojo.result.price.toString();
    }
    else
    {
      price = senddetailsPojo.result.collectionTarget.toString();
    }*/
    print("Price: "+price.toString());
    int pricenew=int.parse(price) - commission.commisiondata.senderCommision;


    // Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'id':id,
      'sender_id': sendIndividualPojo.data.senderId.toString(),
      'price_money': price.toString(),
      'updated_price': pricenew.toString(),
    };
    print("DATA: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.pay_money, body: data);
    print("Pay amount api working");
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      updateval = response.body; //store response as string
      if (jsonResponse["success"] == false) {
        // Navigator.of(context, rootNavigator: true).pop();
        showToast(updateval);
        print("Response 1");

      }

      else {
        moneypojo = new sendmoneypojo.fromJson(jsonResponse);



        if (jsonResponse != null) {
          print("Response 2"+moneypojo.paymentId.toString());
          print("Response 2"+moneypojo.paypalAmount.toString());


          Navigator.push(context, MaterialPageRoute(builder: (context) =>  payment(
              data: moneypojo.paymentId.toString(),
              amount:price.toString(),
              coming:"gift",
              backto:"GIFT"
          )));




          // Navigator.of(context, rootNavigator: true).pop();

          // Future.delayed(Duration(seconds: 5),()
          // {
          //   callNext(
          //       payment(
          //           data: moneypojo.paymentId.toString(),
          //           amount:moneypojo.paypalAmount.toString(),
          //           coming:"gift",
          //           backto:"GIFT"
          //       ), context);
          // });
          /*
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
                        jsonDecode(updateval)["message"],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingSendReceived()), (route) => false);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        color: AppColors.whiteColor,
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          'okay'.tr,
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
          );*/
          // getpaymentlist(a);
        } else {
          showToast(updateval);

        }
      }
    } else {
      // Navigator.of(context, rootNavigator: true).pop();
      showToast(updateval);
    }
  }
  void showToast(String updateval) {
    errorDialog(jsonDecode(updateval)["message"]);
  }
}



