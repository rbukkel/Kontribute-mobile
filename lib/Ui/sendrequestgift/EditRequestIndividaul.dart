import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/UserListResponse.dart';
import 'package:kontribute/Pojo/get_send_gift_request.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/Ui/sendrequestgift/sendreceivedgifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class EditRequestIndividaul extends StatefulWidget {
  final String data;

  const EditRequestIndividaul({Key key, @required this.data})
      : super(key: key);
  @override
  EditRequestIndividaulState createState() => EditRequestIndividaulState();
}

class EditRequestIndividaulState extends State<EditRequestIndividaul> {
  final SearchContactFocus = FocusNode();
  final requiredamountFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchcontactController =new TextEditingController();
  final TextEditingController requiredamountController  = new TextEditingController();
  final TextEditingController DescriptionController =new TextEditingController();
  String _searchcontact;
  String _requiredamount;
  String _Description;
  bool showvalue;
  String notificationvalue="off";
  String Date;
  List<dynamic> categoryTypes = List();
  String formattedDate = "2021-07-07";
  File _imageFile;
  var currentSelectedValue;
  bool image_value = false;
  bool imageUrl = false;
  bool resultvalue = true;
  var userlist_length;
  String val;
  String userName;
  String receiverName;
  String user;
  String userid;
  int receiverid;
  bool internet = false;
  bool isLoading = false;
  TextEditingController controller = new TextEditingController();
  String filter;
  UserListResponse searchPojo;
  get_send_gift_request sendgift;

  var productlist_length;
  String id;
  String image;

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
                  captureImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  color: AppColors.whiteColor,
                  child:
                  Text(
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


  Future<void> captureImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      try {
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
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
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
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
      }
      catch (e)
      {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });
    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getCategory();
        id = widget.data;
        print("ID: "+id);
        getData(id);
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



  void getData(String id) async {
    Map data = {
      'id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.get_send_gift_request, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);
      } else {
        sendgift = new get_send_gift_request.fromJson(jsonResponse);
        print("Json User Details: " + jsonResponse.toString());
        if (jsonResponse != null)
        {
          print("response");
          setState(() {
            productlist_length = sendgift.data;
            if (sendgift.data.giftPicture != null) {
              setState(() {
                image = sendgift.data.giftPicture;
              });
            }
            requiredamountController.text = sendgift.data.price.toString();
            DescriptionController.text = sendgift.data.message.toString();
            receiverid = int.parse(sendgift.data.receiverId);
            receiverName = sendgift.data.fullName;
            formattedDate = sendgift.data.endDate;
            if(sendgift.data.notification=="on")
            {
              showvalue = true;
            }
            else if(sendgift.data.notification=="off")
            {
              showvalue = false;
            }
          });
        } else {
          errorDialog(sendgift.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);
    }
  }

  DateView() async {
    final DateTime picked = await
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    setState(() {
      Date = picked.toString();
      formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print("onDate: " + formattedDate.toString());
    });
  }


  void getCategory() async {
    var res = await http.get(Uri.encodeFull(Network.BaseApi + Network.username_listing));
    final data = json.decode(res.body);
    List<dynamic> data1 = data["data"];
    setState(()
    {
      categoryTypes = data1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.theme1color,
                child:
                Row(
                  children: [
                    createUpperBar(context, 'editrequestindividual'.tr),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              productlist_length!=null?
              Expanded(
                child: SingleChildScrollView(
                  child:Form(
                    key: _formKey,
                    child:  Column(
                      children: [

                        Container(
                          child: Stack(
                            children: [
                            /*  image_value==false?Container(
                                height: SizeConfig.blockSizeVertical * 25,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                alignment: Alignment.center,
                                child:  CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: Network.BaseApigift+image,
                                  imageBuilder:
                                      (context, imageProvider) =>
                                      Container(
                                        height: SizeConfig.blockSizeVertical * 25,
                                        width: SizeConfig.blockSizeHorizontal * 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                )
                              ):
                              Container(
                                height: SizeConfig.blockSizeVertical * 25,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                alignment: Alignment.center,
                                child:ClipRect(child: _imageFile!=null?
                                Image.file(_imageFile,
                                  fit: BoxFit.fill,
                                  height: SizeConfig.blockSizeVertical * 45,
                                  width: SizeConfig.blockSizeHorizontal * 100) :
                                new Image.asset("assets/images/banner1.png",
                                  height: SizeConfig.blockSizeVertical * 45,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  fit: BoxFit.fill)
                                ),
                              ),*/

                              image_value==false?Container(
                                 // margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *12),
                                  height: SizeConfig.blockSizeVertical * 25,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  alignment: Alignment.center,
                                  child:  CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: Network.BaseApigift+image,
                                    imageBuilder:
                                        (context, imageProvider) =>
                                        Container(
                                          height: SizeConfig.blockSizeVertical * 25,
                                          width: SizeConfig.blockSizeHorizontal * 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.scaleDown),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                  )
                              ):
                              Container(
                                height: SizeConfig.blockSizeVertical * 25,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                alignment: Alignment.center,
                                child:ClipRect(child: _imageFile!=null?
                                Image.file(_imageFile,
                                    fit: BoxFit.scaleDown,
                                    height: SizeConfig.blockSizeVertical * 25,
                                    width: SizeConfig.blockSizeHorizontal * 100) :
                                new Image.asset("assets/images/banner1.png",
                                    height: SizeConfig.blockSizeVertical * 25,
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    fit: BoxFit.scaleDown)
                                ),
                              ),
                              InkWell(
                                onTap: ()
                                {
                                  showAlert();
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 4,
                                      right: SizeConfig.blockSizeHorizontal * 2),
                                  child: Image.asset(
                                    "assets/images/camera.png",
                                    width: 50,
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
                              child: Text(
                                'searchcontact'.tr,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
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
                              child: FormField<dynamic>(
                                builder: (FormFieldState<dynamic> state) {
                                  return InputDecorator(
                                    decoration:
                                    InputDecoration.collapsed(hintText:''),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<dynamic>(
                                        hint: Text(receiverName!=null?receiverName:'selectcontact'.tr,
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Bold')),
                                        dropdownColor: Colors.white,
                                        value: currentSelectedValue,
                                        isDense: true,
                                        onChanged: (newValue)
                                        {
                                          setState(() {
                                            currentSelectedValue = newValue;
                                            receiverid = (newValue["id"]);
                                            userName = (newValue["full_name"]);
                                            print("User: "+userName.toString());
                                            print("Userid: "+receiverid.toString());
                                          });
                                        },
                                        items: categoryTypes.map((dynamic value)
                                        {
                                          return DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text(value["full_name"],
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
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                              EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  top: SizeConfig.blockSizeVertical * 2),
                              width: SizeConfig.blockSizeHorizontal * 45,
                              child: Text(
                                'enterrequiredamount'.tr,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
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
                                      width: SizeConfig.blockSizeHorizontal * 30,
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal * 1,
                                          right: SizeConfig.blockSizeHorizontal * 1),
                                      child: TextFormField(
                                        autofocus: false,
                                        focusNode: requiredamountFocus,
                                        controller: requiredamountController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        validator: (val) {
                                          if (val.length == 0)
                                            return 'pleaseenterrequiredamount'.tr;
                                          else
                                            return null;
                                        },
                                        onFieldSubmitted: (v) {
                                          requiredamountFocus.unfocus();
                                        },
                                        onSaved: (val) => _requiredamount = val,
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
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  top: SizeConfig.blockSizeVertical * 2),
                              width: SizeConfig.blockSizeHorizontal * 45,
                              child: Text(
                                'timeframeforcollection'.tr,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                height: SizeConfig.blockSizeVertical * 7,
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                ),
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 1,
                                  right: SizeConfig.blockSizeVertical * 1,
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
                                child: GestureDetector(
                                  onTap: () {
                                    DateView();
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 30,
                                        child: Text(
                                          formattedDate,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 5,
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppColors.greyColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            'message'.tr,
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
                            focusNode: DescriptionFocus,
                            maxLines: 4,
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
                                      showvalue = value;
                                      if(showvalue == true)
                                      {
                                        notificationvalue = "on";
                                      }
                                      else{
                                        notificationvalue = "off";
                                      }
                                      print("Notification: "+notificationvalue);
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
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              if (receiverid != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                Internet_check().check().then((intenet) {
                                  if (intenet != null && intenet) {
                                    if(_imageFile!=null)
                                    {
                                      requestIndivial(
                                          notificationvalue,
                                          requiredamountController.text,
                                          DescriptionController.text,
                                          formattedDate,
                                          _imageFile,
                                          receiverid
                                      );
                                    }
                                    else {
                                      errorDialog('pleaseselectgiftimage'.tr);

                                    }
                                  } else {
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
                            child: Text('invite'.tr,
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

              )
                  :Container(
                child: Center(
                  child: internet == true?CircularProgressIndicator():SizedBox(),
                ),
              ),
            ],
          )

      ),
    );
  }


  void requestIndivial(String notification, String requiredamoun, String description,
      String date,File Imge, int receiver) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.edit_send_gift_request),);
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["price"] = requiredamoun.toString();
    request.fields["message"] = description;
    request.fields["sender_id"] = userid.toString();
    request.fields["end_date"] = date.toString();
    request.fields["receiver_id"] = receiver.toString();
    request.fields["notification"] = notification.toString();
    request.fields["id"] = id.toString();

    print("Request: "+request.fields.toString());

    if (Imge != null) {
      print("PATH: " + Imge.path);
      request.files.add(await http.MultipartFile.fromPath("file", Imge.path,
          filename: Imge.path));
    }
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      if (response.statusCode == 200) {
        jsonData = json.decode(value);
        if (jsonData["success"] == false) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonData["message"]);
        }
        else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingSendReceived()), (route) => false);
          }
          else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            setState(() {
              Navigator.of(context).pop();
            });
            errorDialog(jsonData["message"]);
          }
        }
      }
      else if(response.statusCode == 500)
      {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog('nointernetconnection'.tr);
      }
      else{
        errorDialog('somethingwentwrong'.tr);
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      }
    });
  }
}
