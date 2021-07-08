import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';

class Createpool extends StatefulWidget{
  @override
  CreatepoolState createState() => CreatepoolState();

}

class CreatepoolState extends State<Createpool> {
  final List<String> _dropdownCategoryValues = [
    "Invite",
    "Request"
  ];
  String currentSelectedValue;
  final CreatepoolFocus = FocusNode();
  final SearchContactFocus = FocusNode();
  final SearchPostFocus = FocusNode();
  final requiredamountFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final CollectionFocus = FocusNode();
  final TextEditingController searchcontactController = new TextEditingController();
  final TextEditingController collectionController = new TextEditingController();
  final TextEditingController searchpostController = new TextEditingController();
  final TextEditingController createpoolController = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  final TextEditingController requiredamountController =
  new TextEditingController();
  final TextEditingController DescriptionController =
  new TextEditingController();
  String _searchpost;
  String _searchcontact;
  String _requiredamount;
  String _createpool;
  String _Description;
  String _Collection;
  bool showvalue = false;
  String Date;
  String formattedDate="07-07-2021";
  File _imageFile;
  bool image_value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateView() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100));


    setState(() {
      Date =  picked.toString();
      formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print("onDate: "+formattedDate.toString());
    });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 45,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/banner1.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                        StringConstant.createpoolname,
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
                      height: SizeConfig.blockSizeVertical * 7,
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
                      child: TextFormField(
                        autofocus: false,
                        maxLines: 2,
                        focusNode: CreatepoolFocus,
                        controller: createpoolController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.length == 0)
                            return "Please enter pool name";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(
                              SearchContactFocus);
                        },
                        onSaved: (val) => _createpool = val,
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
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
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
                        StringConstant.searchcontact,
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
                        height: SizeConfig.blockSizeVertical * 7,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: TextFormField(
                                autofocus: false,
                                maxLines: 2,
                                focusNode: SearchContactFocus,
                                controller: searchcontactController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter search contact";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(
                                      requiredamountFocus);
                                },
                                onSaved: (val) => _searchcontact = val,
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
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 5,
                              child: Icon(
                                Icons.search,
                                color: AppColors.greyColor,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
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
                      child: Text(
                        StringConstant.enterrequiredamount,
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
                      child: TextFormField(
                        autofocus: false,
                        focusNode: requiredamountFocus,
                        controller: requiredamountController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.length == 0)
                            return "Please enter required amount";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(CollectionFocus);
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
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
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
                      child: Text(
                        StringConstant.collectiontarget,
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
                      child: TextFormField(
                        autofocus: false,
                        focusNode: CollectionFocus,
                        controller: collectionController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.length == 0)
                            return "Please enter collection target";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          CollectionFocus.unfocus();
                        },
                        onSaved: (val) => _Collection = val,
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
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
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
                        StringConstant.timeframeforcollection,
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
                                child:
                                Text(
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
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
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
                        StringConstant.showpost,
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
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: _dropdownCategoryValues
                              .map((String value) =>
                              DropdownMenuItem(
                                child: Text(value, style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),),
                                value: value,
                              ))
                              .toList(),
                          value: currentSelectedValue,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              currentSelectedValue = newValue;
                              print(currentSelectedValue.toString()
                                  .toLowerCase());
                            });
                          },
                          isExpanded: true,
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
                          left: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical * 2),
                      width: SizeConfig.blockSizeHorizontal * 45,
                      child: Text(
                        "",
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

                          },
                          child: Row(
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 30,
                                child: TextFormField(
                                  autofocus: false,
                                  focusNode: SearchPostFocus,
                                  controller: searchpostController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return "Please enter search post";
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    SearchPostFocus.unfocus();
                                  },
                                  onSaved: (val) => _searchpost = val,
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
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 5,
                                child: Icon(
                                  Icons.search,
                                  color: AppColors.greyColor,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    /* Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => selectlangauge()),
                                            (route) => false);*/
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
                    child: Text(StringConstant.submit,
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
