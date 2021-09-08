import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class CreateProjectPost extends StatefulWidget {
  @override
  CreateProjectPostState createState() => CreateProjectPostState();
}

class CreateProjectPostState extends State<CreateProjectPost> {
  File _imageFile;
  bool image_value = false;
  bool fileTyp = false;
  String fileName;
  String pth;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;
  var basename=null;
  var catname=null;
  var vidoname=null;
  List<File> _imageList = [];
  List<File> _documentList = [];
  List _selecteName = List();
  final ProjectNameFocus = FocusNode();
  final LocationFocus = FocusNode();
  final LocationDetailsFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final DateFocus = FocusNode();
  final TimeFocus = FocusNode();
  final ContactNoFocus = FocusNode();
  final EmailFocus = FocusNode();
  final SearchPostFocus = FocusNode();
  final EnterRequiredAmountFocus = FocusNode();
  final TotalBudgetFocus = FocusNode();
  final VideoFocus = FocusNode();
  final TermsFocus = FocusNode();
  final TextEditingController TermsController = new TextEditingController();
  final TextEditingController searchpostController =
      new TextEditingController();
  final TextEditingController ProjectNameController =
      new TextEditingController();
  final TextEditingController LocationController = new TextEditingController();
  final TextEditingController LocationDetailsController =
      new TextEditingController();
  final TextEditingController DescriptionController =
      new TextEditingController();
  final TextEditingController DateController = new TextEditingController();
  final TextEditingController TimeController = new TextEditingController();
  final TextEditingController ContactNoController = new TextEditingController();
  final TextEditingController EnterRequiredAmountController =
      new TextEditingController();
  final TextEditingController TotalBudgetController =
      new TextEditingController();
  final TextEditingController EmailController = new TextEditingController();
  final TextEditingController VideoController = new TextEditingController();
  String _ProjectName;
  String _terms;
  String _location;
  String _locationdetails;
  String _description;
  String _date;
  String _time;
  String _contactno;
  String _email;
  String _searchpost;
  String _requiredamount;
  String _totalbudget;
  String _Video;
  String userid;
  bool isLoading = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only"
  ];
  static List<String> videoList = [null];
  var file1;
  var documentPath;
  final List<String> _dropdownprivecyvalue = ["Private", "Public"];
  String currentSelectedValue;
  int currentid = 0;
  String currentSelectedValueprivacy;
  String Date, EndDate;
  DateTime currentDate = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

  DateTime currentEndDate = DateTime.now();
  var myFormatEndDate = DateFormat('yyyy-MM-dd');
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset(
      "assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 25,
      width: SizeConfig.blockSizeHorizontal * 100,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner2.png",
      height: SizeConfig.blockSizeVertical * 25,
      width: SizeConfig.blockSizeHorizontal * 100,
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      "assets/images/banner1.png",
      height: SizeConfig.blockSizeVertical * 25,
      width: SizeConfig.blockSizeHorizontal * 100,
      fit: BoxFit.fitHeight,
    ),
  ];

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.whiteColor : AppColors.lightgrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  DateView(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != currentDate)
      setState(() {
        currentDate = picked;
      });
  }

  EndDateView(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != currentEndDate)
      setState(() {
        currentEndDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
    });
  }

  Future getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );

    if (file != null) {
      setState(() {
        file1 = file; //file1 is a global variable which i created
        print("File Path: " + file1.toString());

        if(_documentList.length<2)
          {
            _documentList.add(file1);
            for (int i = 0; i < _documentList.length; i++) {
              print("ListDoc:" + _documentList[i].toString());
            }
            documentPath = file.path.toString();
            print("File Path1: " + file.path.toString());
            basename = path.basename(file.path);
            print("File basename: " + basename.toString());
            _selecteName.add(basename);

            final input = _selecteName.toString();
            final removedBrackets = input.substring(1, input.length - 1);
            final parts = removedBrackets.split(',');
            catname = parts.map((part) => "$part").join(',').trim();
            print("Docname: "+catname.toString());
          }
        else{
          Fluttertoast.showToast(
            msg: "upload upto 2 documents",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }

      });
     /* setState(() {
        file1 = file;
        _imageList.add(file1);
        for (int i = 0; i < _imageList.length; i++) {
          print("ListImages:" + _imageList[i].toString());
        }
      });*/
    }
  }

  showAlert(BuildContext context) {
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
        final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
        setState(() {
          _imageFile = imageFile;

          if(_imageList.length<3)
            {
              _imageList.add(_imageFile);
              for (int i = 0; i < _imageList.length; i++) {
                print("ListImages:" + _imageList[i].toString());
              }
            }
          else{
          Fluttertoast.showToast(
          msg: "upload upto 3 images",
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
            await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
        setState(() {
          _imageFile = imageFile;
          if(_imageList.length<3)
          {
            _imageList.add(_imageFile);
            for (int i = 0; i < _imageList.length; i++) {
              print("ListImages:" + _imageList[i].toString());
            }
          }
          else{
            Fluttertoast.showToast(
              msg: "upload upto 3 images",
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
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      projectfunding()));
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
                          top: SizeConfig.blockSizeVertical * 2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        StringConstant.createnewproject,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins-Regular",
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
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                      child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                color: AppColors.themecolor,
                                alignment: Alignment.topCenter,
                                height: SizeConfig.blockSizeVertical * 25,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: <Widget>[
                                    PageView.builder(
                                      physics: ClampingScrollPhysics(),
                                      itemCount: introWidgetsList.length,
                                      onPageChanged: (int page) {
                                        getChangedPageAndMoveBar(page);
                                      },
                                      controller: PageController(
                                          initialPage: currentPageValue,
                                          keepPage: true,
                                          viewportFraction: 1),
                                      itemBuilder: (context, index) {
                                        return introWidgetsList[index];
                                      },
                                    ),
                                    Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              for (int i = 0;
                                                  i < introWidgetsList.length;
                                                  i++)
                                                if (i == currentPageValue) ...[
                                                  circleBar(true)
                                                ] else
                                                  circleBar(false),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showAlert(context);
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 3),
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
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Container()),
                        _imageList.length != 0
                            ? Container(
                                alignment: Alignment.topCenter,
                                height: SizeConfig.blockSizeVertical * 10,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 6,
                                    right: SizeConfig.blockSizeHorizontal * 6),
                                child: _imageList.length == 0
                                    ? new Image.asset(
                                        'assets/images/orderListing.png')
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _imageList == null
                                            ? 0
                                            : _imageList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Dismissible(
                                              key: Key(
                                                  _imageList[index].toString()),
                                              direction:
                                                  DismissDirection.vertical,
                                              onDismissed: (direction) {
                                                setState(() {
                                                  _imageList.removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: 60,
                                                height: 60,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2,
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        1,
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      width: 60,
                                                      height: 60,
                                                      child: Image.file(
                                                        _imageList
                                                            .elementAt(index),
                                                        fit: BoxFit.fill,
                                                        width: 60,
                                                        height: 60,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        }))
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
                          width: SizeConfig.blockSizeHorizontal * 45,
                          child: Text(
                            StringConstant.projectname,
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
                            focusNode: ProjectNameFocus,
                            controller: ProjectNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val.length == 0)
                                return "Please enter project name";
                              else
                                return null;
                            },
                            onFieldSubmitted: (v) {
                              FocusScope.of(context)
                                  .requestFocus(DescriptionFocus);
                            },
                            onSaved: (val) => _ProjectName = val,
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
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
                          width: SizeConfig.blockSizeHorizontal * 45,
                          child: Text(
                            StringConstant.projectdescription,
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
                            child: Column(
                              children: [
                                TextFormField(
                                  autofocus: false,
                                  maxLines: 4,
                                  focusNode: DescriptionFocus,
                                  controller: DescriptionController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return "Please enter project description";
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(DateFocus);
                                  },
                                  onSaved: (val) => _description = val,
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
                                GestureDetector(
                                  onTap: () {
                                    DescriptionController.text =
                                        DescriptionController.text + "#";
                                    DescriptionController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: DescriptionController
                                                .text.length));
                                  },
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 2,
                                        top: SizeConfig.blockSizeVertical * 2),
                                    child: Text(
                                      StringConstant.addhashtag,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.lightBlue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Bold'),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              3,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                          top:
                                              SizeConfig.blockSizeVertical * 2),
                                      child: Text(
                                        StringConstant.startdate,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Bold'),
                                      ),
                                    ),
                                    Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            top: SizeConfig.blockSizeVertical *
                                                1),
                                        padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.blockSizeVertical * 1,
                                          right:
                                              SizeConfig.blockSizeVertical * 1,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black26,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            DateView(context);
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    30,
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1),
                                                child: Text(
                                                  myFormat.format(currentDate),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      letterSpacing: 1.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          'Poppins-Regular',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5,
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: AppColors.greyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                  width: SizeConfig.blockSizeHorizontal * 50,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            top: SizeConfig.blockSizeVertical *
                                                2),
                                        child: Text(
                                          StringConstant.enddate,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Bold'),
                                        ),
                                      ),
                                      Container(
                                          height:
                                              SizeConfig.blockSizeVertical * 8,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                1,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
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
                                              color: Colors.black26,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              EndDateView(context);
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      30,
                                                  padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1),
                                                  child: Text(
                                                    myFormat
                                                        .format(currentEndDate),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                  child: Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: AppColors.greyColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ))
                            ],
                          ),
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
                                        height:
                                            SizeConfig.blockSizeVertical * 7,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
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
                                            SizeConfig.blockSizeHorizontal * 30,
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    1),
                                        child: TextFormField(
                                          autofocus: false,
                                          focusNode: EnterRequiredAmountFocus,
                                          controller:
                                              EnterRequiredAmountController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val.length == 0)
                                              return "Please enter required amount";
                                            else
                                              return null;
                                          },
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(TotalBudgetFocus);
                                          },
                                          onSaved: (val) =>
                                              _requiredamount = val,
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
                                StringConstant.totalbudget,
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
                                          height:
                                              SizeConfig.blockSizeVertical * 7,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  10,
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
                                          child: TextFormField(
                                            autofocus: false,
                                            focusNode: TotalBudgetFocus,
                                            controller: TotalBudgetController,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.number,
                                            validator: (val) {
                                              if (val.length == 0)
                                                return "Please enter total budget";
                                              else
                                                return null;
                                            },
                                            onFieldSubmitted: (v) {
                                              TotalBudgetFocus.unfocus();
                                            },
                                            onSaved: (val) =>
                                                _totalbudget = val,
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
                                        )
                                      ],
                                    )))
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
                              width: SizeConfig.blockSizeHorizontal * 15,
                              child: Text(
                                StringConstant.video,
                                maxLines: 4,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 75,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeHorizontal * 3,
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeVertical * 1,
                                right: SizeConfig.blockSizeVertical * 1,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black26,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                children: [..._getVideoLink()],
                              ),
                            )

                           /*   Container(
                              width: SizeConfig.blockSizeHorizontal * 65,
                              height: SizeConfig.blockSizeVertical *10,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeHorizontal * 3,
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeVertical * 1,
                                right: SizeConfig.blockSizeVertical * 1,
                              ),
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

                              TextFormField(
                                autofocus: false,
                                focusNode: VideoFocus,
                                controller: VideoController,
                                maxLines: 5,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter video url";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  VideoFocus.unfocus();
                                },
                                onSaved: (val) => _Video = val,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 10,
                                  color: AppColors.themecolor,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: AppColors.themecolor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10,
                                      decoration: TextDecoration.none,
                                    ),
                                    hintText: "https://www.youtube.com/watch?v=HFX6AZ5bDDo"),
                              ),
                            )*/
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
                              width: SizeConfig.blockSizeHorizontal * 22,
                              child: Text(
                                StringConstant.revelantdocuents,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 70,
                                height: SizeConfig.blockSizeVertical * 10,
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 1,
                                  right: SizeConfig.blockSizeVertical * 1,
                                ),
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  60,
                                            child: Text(
                                              catname != null
                                                  ? catname.toString()
                                                  : "",
                                              maxLines: 5,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 10,
                                                color: AppColors.black,
                                              ),
                                            ),

                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          getPdfAndUpload();
                                        },
                                        child: Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          child: Icon(
                                            Icons.attachment,
                                            color: AppColors.greyColor,
                                          ),
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
                                StringConstant.showpostproject,
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
                                  hint: Text(
                                    "please select",
                                    style: TextStyle(fontSize: 12),
                                  ),
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
                                      print(currentSelectedValue
                                          .toString()
                                          .toLowerCase());
                                      if (currentSelectedValue == "Anyone") {
                                        currentid = 1;
                                      } else if (currentSelectedValue ==
                                          "Connections only") {
                                        currentid = 2;
                                      }
                                     /* else if (currentSelectedValue ==
                                          "Group members") {
                                        currentid = 3;
                                      }*/
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            )
                          ],
                        ),
                      /*  Row(
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 30,
                                        child: TextFormField(
                                          autofocus: false,
                                          focusNode: SearchPostFocus,
                                          controller: searchpostController,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          */
                      /*validator: (val) {
                                            if (val.length == 0)
                                              return "Please enter search post";
                                            else
                                              return null;
                                          },*/
                      /*
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 5,
                                        child: Icon(
                                          Icons.search,
                                          color: AppColors.greyColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),*/
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
                          width: SizeConfig.blockSizeHorizontal * 80,
                          child: Text(
                            StringConstant.addyourspecialtermcond,
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
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                            final input2 = videoList.toString();
                            final removedBrackets = input2.substring(1, input2.length - 1);
                            final parts = removedBrackets.split(',');
                            vidoname = parts.map((part) => "$part").join(',').trim();
                            print("Vidoname: "+vidoname.toString());

                            createproject(
                                context,
                                ProjectNameController.text,
                                DescriptionController.text,
                                myFormat.format(currentDate),
                                myFormat.format(currentEndDate),
                                TermsController.text,
                                EnterRequiredAmountController.text,
                                TotalBudgetController.text,
                                vidoname,
                                _imageList,
                               _documentList);

                            /* Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => selectlangauge()),
                                            (route) => false);*/
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: SizeConfig.blockSizeVertical * 6,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 3,
                                bottom: SizeConfig.blockSizeVertical * 3,
                                left: SizeConfig.blockSizeHorizontal * 25,
                                right: SizeConfig.blockSizeHorizontal * 25),
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/sendbutton.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Text(StringConstant.creat,
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
                ),
              )
            ],
          )),
    );
  }

  /// get firends text-fields
  List<Widget> _getVideoLink() {
    List<Widget> friendsTextFields = [];

        for (int i = 0; i < videoList.length; i++) {
          friendsTextFields.add(Container(
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(child: FriendTextFields(i)),
                  SizedBox(
                    width: 16,
                  ),
                  // we need add button at last friends row
                  _addRemoveButton(i == videoList.length - 1, i),
                ],
              ),
            ),
          ));
        }



    return friendsTextFields;
  }

  // add remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          videoList.insert(0, null);
        } else
          videoList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  void createproject(
      BuildContext context,
      String projectname,
      String description,
      String startdate,
      String enddate,
      String terms,
      String enterrequiredamount,
      String totalbudget,
      String video,
      List images, List documentList) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.create_project));
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["project_name"] = projectname.toString();
    request.fields["project_description"] = description.toString();
    request.fields["start_date"] = startdate.toString();
    request.fields["end_date"] = enddate;
    request.fields["minimum_participant"] = enterrequiredamount.toString();
    request.fields["project_budget"] = totalbudget.toString();
    request.fields["who_can_see"] = currentid.toString();
    request.fields["video_link"] = video;
    request.fields["special_terms_conditions"] = terms;
    request.fields["userid"] = userid.toString();


    print("Request: "+request.fields.toString());
    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile(
          "fileimages[]",
          http.ByteStream(DelegatingStream.typed(images[i].openRead())),
          await images[i].length(),
          filename:path.basename(images[i].path),
        ),
      );
    }

    for (int i = 0; i < documentList.length; i++) {
      request.files.add(
        http.MultipartFile(
          "file[]",
          http.ByteStream(DelegatingStream.typed(documentList[i].openRead())),
          await documentList[i].length(),
          filename:path.basename(documentList[i].path),
        ),
      );
    }

   /* if (documentPath != null) {
      print("DocumentPATH: " + documentPath);
      request.files.add(await http.MultipartFile.fromPath(
          "file[]", documentPath,
          filename: documentPath));
    }*/
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
            videoList.clear();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => projectfunding()), (route) => false);
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
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          CreateProjectPostState.videoList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => CreateProjectPostState.videoList[widget.index] = v,
      style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins-Regular',
      fontSize: 10,
    ),
      decoration: InputDecoration(
          hintText: 'Enter video link',hintStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins-Regular',
        fontSize: 10,
      )),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
