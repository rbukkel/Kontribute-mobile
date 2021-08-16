import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/Checkgroupnames.dart';
import 'package:kontribute/Ui/sendrequestgift/sendreceivedgifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';

class Createpool extends StatefulWidget {
  @override
  CreatepoolState createState() => CreatepoolState();
}

class CreatepoolState extends State<Createpool> {
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only",
    "Group members"
  ];
  var categorylist;
  List _selecteCategorys = List();
  List _selecteName = List();
  var catid;
  var values;
  String val;
  var productlist_length;
  bool resultvalue = true;
  String currentSelectedValue;
  int currentid=0;
  final TermsFocus = FocusNode();
  bool expandFlag0 = false;
  final TextEditingController TermsController = new TextEditingController();
  String _terms;
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
  final TextEditingController _date = new TextEditingController();
  final TextEditingController requiredamountController =
  new TextEditingController();
  final TextEditingController DescriptionController =
  new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String _searchpost;
  String _searchcontact;
  String _requiredamount;
  String _createpool;
  String _Description;
  final _formKey = GlobalKey<FormState>();
  String _Collection;
  bool showvalue = false;
  String Date;
  String formattedDate = "07-07-2021";
  File _imageFile;
  bool image_value = false;
  bool imageUrl = false;
  var catname = null;
  String data;
  String userid;
  bool isLoading = false;
  List<dynamic> categoryTypes = List();
  var currentSelectedValues;
  Checkgroupnames checkgroupnames;

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });
    getData();
    createpoolController.addListener(() {
      print(createpoolController.text);
      if(createpoolController.text!=null || createpoolController.text!="")
      {
        CheckGroupNames(createpoolController.text);
      }

    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    createpoolController.dispose();
    super.dispose();
  }

  /* void getCategory() async {
    var res =
        await http.get(Uri.encodeFull(Network.BaseApi + Network.username_list));
    final data = json.decode(res.body);
    List<dynamic> data1 = data["data"];

    setState(() {
      categoryTypes = data1;
    });
  }*/

  void getData() async {
    http.Response response = await http.get(Network.BaseApi + Network.username_list);
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      if (jsonDecode(data)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(data)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        setState(() {
          categorylist = jsonDecode(data)['data'];
          //get all the data from json string superheros
          //  print(categorylist.length); // just printed length of data
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(data)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  DateView() async {
    final DateTime picked = await showDatePicker(
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
                    'Camera',
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
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  height: 50,
                  child:
                  Text(
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

  Future<void> captureImage(ImageSource imageSource) async
  {
    if (imageSource == ImageSource.camera)
    {
      try {
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 80);
        setState(() async {
          _imageFile = imageFile;
          if (_imageFile != null && await _imageFile.exists())
          {
            setState(() {
              print("Path: " + _imageFile.toString());
              image_value = true;
              imageUrl = false;
            });
          } else
          {
            Fluttertoast.showToast(
              msg: "Please Select Image",
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
            setState(()
            {
              print("Path: " + _imageFile.toString());
              image_value = true;
              imageUrl = false;
            });
          } else
          {
            Fluttertoast.showToast(
              msg: "Please Select Image",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        });
      }
      catch (e) {
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
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            height: SizeConfig.blockSizeVertical * 45,
                            width: SizeConfig.blockSizeHorizontal * 100,
                            alignment: Alignment.center,
                            child: ClipRect(
                              child: image_value
                                  ? Image.file(
                                _imageFile,
                                fit: BoxFit.fill,
                                height: SizeConfig.blockSizeVertical * 45,
                                width: SizeConfig.blockSizeHorizontal * 100,
                              )
                                  : new Image.asset(
                                "assets/images/banner1.png",
                                height: SizeConfig.blockSizeVertical * 45,
                                width: SizeConfig.blockSizeHorizontal * 100,
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
                            /* onChanged: (value){
                          setState(() {
                            CheckGroupNames(value);
                          });
                        },*/
                            validator: (val) {
                              if (val.length == 0)
                                return "Please enter pool name";
                              else
                                return null;
                            },
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(DescriptionFocus);
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
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                      child: Text(
                        StringConstant.message,
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
                            return "Please enter message";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(SearchContactFocus);
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
                          hintText: "Type here message...",
                        ),
                      ),
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                          width: SizeConfig.blockSizeHorizontal * 45,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 3),
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 3,
                          ),
                          child: Text(
                            //catname!=null?catname.toString():category_names.toString(),
                            catname != null
                                ? catname.toString()
                                : "please select contact",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black38,
                                fontSize: SizeConfig.blockSizeHorizontal * 3,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat-Bold'),
                          ),
                        )
                      ],
                    ),
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
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child:
                            Text(
                              "Search contact",
                              style:
                              TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal * 3,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Montserrat-Bold'),
                            ),
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
                      /* FormField<dynamic>(
                    builder: (FormFieldState<dynamic> state) {
                      return InputDecorator(
                        decoration: InputDecoration.collapsed(hintText: ''),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<dynamic>(
                            hint: Text("select contact",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold')),
                            dropdownColor: Colors.white,
                            value: currentSelectedValues,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValues = newValue;
                                userid = (newValue["id"]);
                                userName = (newValue["full_name"]);
                                print("User: " + userName.toString());
                                print("Userid: " + userid.toString());
                              });
                            },
                            items: categoryTypes.map((dynamic value) {
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
                  ),*/
                    ),
                    Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Container()),
                    expandFlag0 == true ? Expandedview0() : Container(),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                                onTap: () {},
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
                                          right:
                                          SizeConfig.blockSizeHorizontal * 1),
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
                                )))
                      ],
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                                onTap: () {},
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
                                          right:
                                          SizeConfig.blockSizeHorizontal * 1),
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
                                )))
                      ],
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                            ))
                      ],
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("please select",
                                  style: TextStyle(fontSize: 12)),
                              items: _dropdownCategoryValues
                                  .map((String value) => DropdownMenuItem(
                                child: Text(
                                  value,
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
                              value: currentSelectedValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  currentSelectedValue = newValue;

                                  print(currentSelectedValue
                                      .toString()
                                      .toLowerCase());
                                  if(currentSelectedValues=="Anyone")
                                  {
                                    currentid =1;
                                  }else if(currentSelectedValue=="Connections only")
                                  {
                                    currentid =2;
                                  }else if(currentSelectedValue=="Group members")
                                  {
                                    currentid =3;
                                  }
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
                              onTap: () {},
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
                                        FocusScope.of(context)
                                            .requestFocus(TermsFocus);
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
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 5,
                          top: SizeConfig.blockSizeVertical * 2),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      child: Text(
                        StringConstant.addyourspecialtermcond,
                        textAlign: TextAlign.left,
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
                        top: SizeConfig.blockSizeVertical * 1,
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
                        focusNode: TermsFocus,
                        controller: TermsController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.length == 0)
                            return "Please add your special terms & condition";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          TermsFocus.unfocus();
                        },
                        onSaved: (val) => _terms = val,
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
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          Internet_check().check().then((intenet) {
                            if (intenet != null && intenet) {
                              if (_imageFile != null) {
                                createpool(
                                    createpoolController.text,
                                    DescriptionController.text,
                                    requiredamountController.text,
                                    collectionController.text,
                                    currentid.toString(),
                                    formattedDate,
                                    TermsController.text,
                                    _imageFile);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please select gift image",
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
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.blockSizeHorizontal * 40,
                        height: SizeConfig.blockSizeVertical * 5,
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
              ))),
    );
  }

  void createpool(String createpool, String description, String requiredamount, String collection,
      String currentSelected, String date, String terms, File imageFile) async
  {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.create_group));
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["group_members"] = catid.toString();
    request.fields["pool_messages"] = description.toString();
    request.fields["group_name"] = createpool;
    request.fields["min_cash_by_participant"] = requiredamount.toString();
    request.fields["collection_target"] = collection.toString();
    request.fields["end_date"] = date.toString();
    request.fields["can_see"] = currentSelected;
    request.fields["special_terms_conditions"] = terms;
    request.fields["userid"] = userid.toString();

    print("Request: " + request.fields.toString());
    if (imageFile != null) {
      print("PATH: " + imageFile.path);
      request.files.add(await http.MultipartFile.fromPath("file", imageFile.path, filename: imageFile.path));
    }
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      if (response.statusCode == 200) {
        if (jsonData["status"] == false) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(
            msg: jsonData["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: jsonData["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => sendreceivedgifts()),
                    (route) => false);
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
      } else if (response.statusCode == 500) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: "Internal server error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }

  Expandedview0() {
    return Container(
      alignment: Alignment.topLeft,
      height: SizeConfig.blockSizeVertical * 30,
      child: ListView.builder(
          itemCount: categorylist == null ? 0 : categorylist.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              activeColor: AppColors.theme1color,
              value: _selecteCategorys.contains(categorylist[index]['id']),
              onChanged: (bool selected) {
                _onCategorySelected(selected, categorylist[index]['id'],
                    categorylist[index]['full_name']);
              },
              title: Text(
                categorylist[index]['full_name'],
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 3,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat-Bold'),
              ),
            );
          }),
    );
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
    values = catid.replaceAll(" ", "");
    print(values);
    print(catname);
  }



  void CheckGroupNames(String search) async {
    Map data = {
      'polname': search,
    };
    print("Dta: "+data.toString());
    var jsonResponse = null;
    http.Response response =
    await http.post(Network.BaseApi + Network.check_pool_name, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        checkgroupnames = new Checkgroupnames.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });

        } else {
          Fluttertoast.showToast(
            msg: checkgroupnames.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else if (response.statusCode == 422) {
      val = response.body;
      if (jsonDecode(val)["status"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
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

}
