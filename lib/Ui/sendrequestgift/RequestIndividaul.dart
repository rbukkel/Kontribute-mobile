import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/MyConnections/app-contacts.class.dart';
import 'package:kontribute/Pojo/UserListResponse.dart';
import 'package:kontribute/Pojo/sendinvitationpojo.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/Ui/sendrequestgift/sendreceivedgifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';

class RequestIndividaul extends StatefulWidget {
  @override
  RequestIndividaulState createState() => RequestIndividaulState();
}

class RequestIndividaulState extends State<RequestIndividaul> {
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
  bool showvalue = false;
  List<AppContacts> _contacts;
  String notificationvalue="off";
  DateTime currentDate = DateTime.now();
  String Date;
  List<dynamic> categoryTypes = List();
  File _imageFile;
  var currentSelectedValue;
  bool image_value = false;
  bool imageUrl = false;
  bool resultvalue = true;
  var userlist_length;
  String val;
  String userName;
  String userid;
  String searchvalue="";
  int receiverid;
  bool isLoading = false;
  TextEditingController controller = new TextEditingController();
  String filter;
  UserListResponse searchPojo;
  sendinvitationpojo sendinvi;
  bool rememberMe = false;
  var categorylist;
  List _selecteCategorys = List();
  List _selecteContact= List();
  List _selecteName = List();
  List _seleName = List();
  var catid;
  var contactid;
  var values;
  var contactvalues;
  var myFormat = DateFormat('yyyy-MM-dd');
  bool expandFlag0 = false;
  var catname = null;
  var contactname = null;
  String radioVal="1";
  final NameFocus = FocusNode();
  final AmountFocus = FocusNode();
  final EmailFocus = FocusNode();
  final MobileFocus = FocusNode();
  final SubjectFocus = FocusNode();
  final MessageFocus = FocusNode();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController amountController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  String _email,_name,_mobile,_subject,_amount,_description;
  bool contactsLoaded = false;
  TextEditingController searchController = new TextEditingController();
  List<AppContacts> contactsFiltered = [];

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }


  Future<void> getContacts() async {
    List<AppContacts> contacts = (await ContactsService.getContacts(
      withThumbnails: false,
      photoHighResolution: false,)).map((contact) {
      return new AppContacts(info: contact);
    }).toList();

    setState(() {
      _contacts = contacts;
      contactsLoaded = true;
    });

  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContacts() {
    List<AppContacts> _contats = [];
    _contats.addAll(_contacts);
    if (searchController.text.isNotEmpty) {
      _contats.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true)
        {
          return true;
        }
        if (searchTermFlatten.isEmpty) {
          return false;
        }
        var phone = contact.info.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contats;
    });
  }
  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }


/*  void checkper() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted)
    {
      getContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
    else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              CupertinoAlertDialog(
                title: Text('permissionserror'.tr),
                content: Text('pleaseenableaccesstocontacts'.tr+
                    'permissioninsystemsettings'.tr),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('ok'.tr),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
      );
    }
  }*/


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



  Future<void> captureImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      try {
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);


        if (imageFile != null)
          {

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
        else {
          print('No image selected.');
          errorDialog('pleaseselectimage'.tr);
        }

      } catch (e) {
        print(e);
      }
    } else if (imageSource == ImageSource.gallery) {
      try {
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);

        if (imageFile != null)
          {
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
        else {
          print('No image selected.');
          errorDialog('pleaseselectimage'.tr);
        }
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
    getPermissions();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: "+val);
      userid = val;
      getCategory(userid,searchvalue);
      print("Login userid: " +userid.toString());
    });
    SharedUtils.readloginId("Usename").then((val) {
      print("username: " + val);
      userName = val;
      print("Login username: " + userName.toString());
    });
  }


  DateView() async {
    final DateTime picked = await
    showDatePicker(
        context: context,
        initialDate: currentDate,
      firstDate:DateTime.now(),
      lastDate: DateTime(2050),);

    if (picked != null && picked != currentDate)
      setState(() {
        currentDate = picked;
       /* formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
        print("onDate: " + formattedDate.toString());*/
       /* final DateFormat formatter = DateFormat('yyyy-MM-dd');
        formattedDate = formatter.format(currentDate);
        print(formattedDate); */
       //
      });
   /* final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(currentDate);
    print(formattedDate); // something like 2013-04-20*/

   /* setState(() {
      Date = picked.toString();
      formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print("onDate: " + formattedDate.toString());
    });*/

  }

  Future<void> getCategory(String a,String search) async {
    setState(() {
      categorylist =null;
    });
  //  Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {'receiver_id': a.toString(), 'search': search.toString()};
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.followlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      print("Json User" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        setState(() {
          resultvalue = false;
          categorylist =null;
        });
       // errorDialog(jsonResponse["message"]);
      }
      else {
       // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null)
        {
          setState(() {
            resultvalue = true;
            categorylist = jsonResponse['result'];
          });
        }
        else {
         // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            errorDialog(jsonResponse["message"]);

          });
        }
      }
    }
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
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *15),
                          height: SizeConfig.blockSizeVertical * 35,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.center,
                          child:ClipRect(child:  image_value?
                          Image.file(_imageFile, fit: BoxFit.scaleDown, height: SizeConfig.blockSizeVertical * 45,
                            width: SizeConfig.blockSizeHorizontal * 100,)
                              :new Image.asset("assets/images/banner1.png", height: SizeConfig.blockSizeVertical * 45,
                            width: SizeConfig.blockSizeHorizontal * 100,fit: BoxFit.fill,),),
                        ),
                        InkWell(
                          onTap: ()
                          {
                            showAlert();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 21,
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
                          "findin".tr,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Bold'),
                        ),
                      ),
                      radioVal=="1"? Container(
                        width: SizeConfig.blockSizeHorizontal * 45,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3),
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: Text(
                          catname != null ? catname.toString() : 'pleaseselectcontact'.tr,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black38,
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                      ):radioVal=="0"?Container(
                        width: SizeConfig.blockSizeHorizontal * 45,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3),
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: Text(
                         contactname!=null?contactname.toString(): 'pleaseselectcontact'.tr,
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black38,
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                      ):Container(),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: RadioListTile(
                          //  contentPadding:EdgeInsets.only(left: 5),
                          activeColor: AppColors.themecolor,
                          groupValue: radioVal == ""
                              ? 0
                              : radioVal == "0"
                              ? false
                              : true,
                          title: Text(
                            'mynetwork'.tr,
                            textAlign: TextAlign.left,
                            style:
                            TextStyle(fontSize: 12),
                          ),
                          value: true,
                          onChanged: (val) {
                            setState(() {
                              radioVal = "1";
                              print("Radio: "+radioVal);
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          // contentPadding:EdgeInsets.only(left: 5),
                          activeColor: AppColors.themecolor,
                          groupValue: radioVal == ""
                              ? 0
                              : radioVal == "0"
                              ? false
                              : true,
                          title: Text(
                            'phonebook'.tr,
                            textAlign: TextAlign.left,
                            style:
                            TextStyle(fontSize: 12),
                          ),
                          value: false,
                          onChanged: (val) {
                            setState(() {
                              radioVal = "0";
                              print("Radio: "+radioVal);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  radioVal=="1"? mynetworkview():radioVal=="0"?otherOptionview():Container(),

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
                                    else if(val.toString() =="0")
                                      return 'morethan0amount'.tr;
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
                                    myFormat.format(currentDate),
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
                        setState(() {
                          isLoading = true;
                        });
                        Internet_check().check().then((intenet) {
                          if (intenet != null && intenet) {
                            if(_imageFile!=null)
                            {
                              if(radioVal=="0")
                              {
                                if (contactvalues==null ||contactvalues=="" || contactname==null || contactname=="")
                                {
                                  errorDialog('pleaseselectcontacts'.tr);
                                }
                                else{
                                  sendInvitation(
                                    notificationvalue,
                                    requiredamountController.text,
                                    DescriptionController.text,
                                    myFormat.format(currentDate),
                                    _imageFile,
                                    contactname.toString(),
                                    contactvalues.toString(),

                                  );
                                }


                              }
                              else if(radioVal=="1")
                              {
                                if (values==null || values=="")
                                {
                                  errorDialog('pleaseselectcontacts'.tr);
                                }
                                else
                                {
                                  requestIndivial(
                                      notificationvalue,
                                      requiredamountController.text,
                                      DescriptionController.text,
                                      myFormat.format(currentDate),
                                      _imageFile,
                                      values.toString()
                                  );
                                }

                              }
                            }
                            else {
                              errorDialog('pleaseselectgiftimage'.tr);
                            }
                          } else {
                            errorDialog('nointernetconnection'.tr);

                          }
                        });
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
          )),
    );
  }


  void requestIndivial(String notification, String requiredamoun, String description, String date,File Imge, String receiver) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.send_gift_request),);
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["price"] = requiredamoun.toString();
    request.fields["message"] = description;
    request.fields["sender_id"] = userid.toString();
    request.fields["end_date"] = date.toString();
    request.fields["receiver_id"] = receiver.toString();
    request.fields["notification"] = notification.toString();
    print("Request: "+request.fields.toString());

    if (Imge != null) {
      print("PATH: " + Imge.path);
      request.files.add(await http.MultipartFile.fromPath("file", Imge.path,
          filename: Imge.path));
    }
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      if (response.statusCode == 200) {
        if (jsonData["success"] == true) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingSendReceived()), (route) => false);
           // errorDialog(jsonData["message"]);
          }
          else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            setState(() {
              Navigator.of(context).pop();
            });
            errorDialog(jsonData["message"]);
          }
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonData["message"]);
        }
      }
      else if (response.statusCode == 500) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog("Internal server error");

      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog("somethingwentwrong".tr);
      }
    });
  }

  Expandedview05() {
    bool isSearching = searchController.text.isNotEmpty;

    return Column(
      children: [
        isSearching == true ? contactsFiltered!=null?

        Container(
            alignment: Alignment.topLeft,
            height: SizeConfig.blockSizeVertical * 30,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child:  ListView.builder(
                  itemCount:contactsFiltered == null ? 0 : contactsFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    AppContacts contact = contactsFiltered[index];
                    return  contact.info.phones.isNotEmpty?
                      CheckboxListTile(
                      activeColor: AppColors.theme1color,
                      value: _selecteContact.contains(contact.info.phones.length==null || contact.info.phones.length==0?"":contact.info.phones.first.value),
                      onChanged: (bool selected) {
                        _onCateSelected(selected, contact.info.phones.first.value==null?"":contact.info.phones.first.value,
                            contact.info.displayName??'');
                      },
                      title: Text(
                        contact.info.displayName ??'',
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat-Bold'),
                      ),
                    ):Container();
                  }),
            )
        )
            :
        Center(
          child: CircularProgressIndicator(),
        ) :
        _contacts!=null?
        Container(
            alignment: Alignment.topLeft,
            height: SizeConfig.blockSizeVertical * 30,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child:  ListView.builder(
                  itemCount:_contacts == null ? 0 : _contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    AppContacts contact = _contacts[index];
                    return contact.info.phones.isNotEmpty?
                      CheckboxListTile(
                      activeColor: AppColors.theme1color,
                      value: _selecteContact.contains(contact.info.phones.length==null || contact.info.phones.length==0 ||contact.info.phones.isEmpty?"":contact.info.phones.first.value),
                      onChanged: (bool selected) {




                        if(contact.info.phones.isEmpty)
                          {
                            print("no value here");
                          }
                        else{
                          _onCateSelected(selected, contact.info.phones.first.value,
                              contact.info.displayName??'');
                        }

                      },
                      title: Text(
                        contact.info.displayName ??'',
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat-Bold'),
                      ),
                    ):Container();
                  }),
            )
        ):
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  Expandedview0() {
    return Column(
      children: [
        categorylist !=null?
      Container(
      alignment: Alignment.topLeft,
      height: SizeConfig.blockSizeVertical * 30,
      child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child:  ListView.builder(
                  itemCount: categorylist == null ? 0 : categorylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      activeColor: AppColors.theme1color,
                      value: _selecteCategorys.contains(categorylist[index]['connection_id']),
                      onChanged: (bool selected) {
                        _onCategorySelected(selected, categorylist[index]['connection_id'],
                            categorylist[index]['full_name']);
                      },
                      title: Text(
                        categorylist[index]['full_name']==null?"":categorylist[index]['full_name'],
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat-Bold'),
                      ),
                    );
                  }),
            )
      ):

        Container(
            alignment: Alignment.center,
            child: resultvalue == true
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Center(
              child: Text('nosearchresultstoshow'.tr,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins-Regular'),
              ),
            ))

      ],


    );
  }

  void _onCateSelected(bool selected, category_id, category_name) {
    if (selected == true) {
      setState(() {
        if(category_id==null||category_id=="")
          {
            print("NO valkue");
          }
        else
          {
            _selecteContact.add(category_id);
            _seleName.add(category_name);
          }

      });
    } else {
      setState(() {
        _selecteContact.remove(category_id);
        _seleName.remove(category_name);
      });
    }
    final input = _seleName.toString();
    final removedBrackets = input.substring(1, input.length - 1);
    final parts = removedBrackets.split(',');
    contactname = parts.map((part) => "$part").join(',').trim();

    final input1 = _selecteContact.toString();
    final removedBrackets1 = input1.substring(1, input1.length - 1);
    final parts1 = removedBrackets1.split(',');
    contactid = parts1.map((part1) => "$part1").join(',').trim();
    contactvalues = contactid.replaceAll(" ","");
    print(contactvalues);
    print("CatNa: "+contactname);
    print("Catva: "+contactvalues);
  }


  void _onCategorySelected(bool selected, category_id, category_name) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
        _selecteName.add(category_name);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
        _selecteName.remove(category_name);
      });
    }
    final input = _selecteName.toString();
    final removedBrackets = input.substring(1, input.length - 1);
    final parts = removedBrackets.split(',');
    catname = parts.map((part) => "$part").join(',').trim();
    final input1 = _selecteCategorys.toString();
    final removedBrackets1 = input1.substring(1, input1.length - 1);
    final parts1 = removedBrackets1.split(',');
    catid = parts1.map((part1) => "$part1").join(',').trim();
    values = catid.replaceAll(" ","");
    print(values);
    print("CatName: "+catname);
    print("Catvalues: "+values);
  }

  mynetworkview() {
    return Column(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 7,
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3,
          ),
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 2
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: SizeConfig.blockSizeHorizontal * 60,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3,
                ),
                child:
                TextField(
                  onChanged: (value){
                    setState(() {
                      getCategory(userid,value);
                    });
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintStyle:  TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 3,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat-Bold'),hintText: 'search'.tr),
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                ),
                child: IconButton(
                    icon: new Container(
                      height: 50.0,
                      width: 50.0,
                      child: new Center(
                        child:
                        new Icon(
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
        expandFlag0 == true ? Expandedview0() : Container(),
      ],
    );
  }

  otherOptionview() {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 7,
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3,
          ),
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 2
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 60,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                 // left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3,
                ),
                child:
                /*Text(
                  "Search contact",
                  style:
                  TextStyle(
                      letterSpacing: 1.0,
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 3,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat-Bold'),
                ),*/

                TextField(
                  controller: searchController,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.black
                      ),
                      border: InputBorder.none,
                      hintStyle:  TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 3,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat-Bold'),hintText: 'search'.tr),
                )

               /* TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search...',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: AppColors.black
                        )
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.black
                    ),
                  ),
                ),*/
              ),
              Container(
                padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                ),
                child: IconButton(
                    icon: new Container(
                      height: 50.0,
                      width: 50.0,
                      child: new Center(
                        child:
                        new Icon(
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
        expandFlag0 == true ? Expandedview05() : Container(),
      ],
    );
  }


  sendInvitation(String notification,String required,String description,String dat,File Imge,String names,String numbers) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "name":names.toString(),
      "mobile":numbers.toString(),
      "sender_id":userid.toString(),
      "price":required.toString(),
      "message":description,
      "end_date":dat.toString(),
      "notification":notification.toString(),
    };

    print("DataSend: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.mobile_invitation, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);

      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        sendinvi = new sendinvitationpojo.fromJson(jsonResponse);
        String jsonProfile = jsonEncode(sendinvi);
        print(jsonProfile);
        SharedUtils.saveProfile(jsonProfile);
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
            requiredamountController.text = "";
            DescriptionController.text ="";
          });
          final RenderBox box1 = _formKey.currentContext.findRenderObject();
          if(sendinvi.shareLink!=null)
          Share.share("Let's join on Kontribute! Get it at " +sendinvi.shareLink,
              subject: "Kontribute",
              sharePositionOrigin:
              box1.localToGlobal(Offset.zero) & box1.size);

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingSendReceived()), (route) => false);

        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
          });
          errorDialog(sendinvi.message);

        }
      }
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);
    }
  }
}
