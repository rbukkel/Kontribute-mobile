import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/sendinvitationpojo.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:kontribute/Pojo/FollowinglistPojo.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:share/share.dart';

class CreateProjectPost extends StatefulWidget {
  @override
  CreateProjectPostState createState() => CreateProjectPostState();
}

class CreateProjectPostState extends State<CreateProjectPost> {
  File _imageFile;
  bool image_value = false;
  bool selectall = false;
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
  bool expandFlag0 = false;
  final _formKey = GlobalKey<FormState>();
  final _formmainKey = GlobalKey<FormState>();
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
  final documentsFocus = FocusNode();
  final TermsFocus = FocusNode();
  final TextEditingController TermsController = new TextEditingController();
  final TextEditingController documentsController = new TextEditingController();
  final TextEditingController searchpostController = new TextEditingController();
  final TextEditingController ProjectNameController = new TextEditingController();
  final TextEditingController LocationController = new TextEditingController();
  final TextEditingController LocationDetailsController = new TextEditingController();
  final TextEditingController DescriptionController = new TextEditingController();
  final TextEditingController DateController = new TextEditingController();
  final TextEditingController TimeController = new TextEditingController();
  final TextEditingController ContactNoController = new TextEditingController();
  final TextEditingController EnterRequiredAmountController = new TextEditingController();
  final TextEditingController TotalBudgetController = new TextEditingController();
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
  String _documents;
  String userid;
  String searchvalue="";
  String username;
  sendinvitationpojo sendinvi;
  final NameFocus = FocusNode();
  final EmailotherFocus = FocusNode();
  final MobileFocus = FocusNode();
  final SubjectFocus = FocusNode();
  final MessageFocus = FocusNode();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  String _emailother,_name,_mobile,_subject,_descriptionother;
  bool isLoading = false;
  var categoryfollowinglist;
  bool resultfolowvalue = true;
  List _selecteFollowing = List();
  List _selecteFollowingName = List();
  var followingcatid;
  var followingvalues;
  var catFollowingname = null;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  FollowinglistPojo followlistpojo;
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only",
    "Invite",
  ];

  var selectedIndexes = [];
  static List<String> videoList = [''];
  var file1;
  var documentPath;
  final List<String> _dropdownprivecyvalue = ["Private", "Public"];
  String currentSelectedValue;
  int currentid = 0;
  String currentSelectedValueprivacy;
  String Date, EndDate;
  DateTime currentDate = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  DateTime currentEndDate = DateTime.now().add(Duration(days: 1));
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
      firstDate: currentDate,
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
        print("Current: "+currentDate.toString());
        print("END: "+currentEndDate.toString());
        if(currentDate.compareTo(currentEndDate)>0)
        {
          print('date is befor');
          //peform logic here.....
          errorDialog('Theenddatemustbeafterthestartdate'.tr);

        }
        else {
          currentEndDate = picked;
          print('date is after');
        }
        // currentEndDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      getData(userid,searchvalue);
      print("Login userid: " + userid.toString());
    });
    SharedUtils.readloginId("Usename").then((val) {
      print("username: " + val);
      username = val;
      print("Login username: " + username.toString());
    });
  }


  Future<void> getData(String a,String search) async {
    setState(() {
      categoryfollowinglist =null;
    });
    // Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'receiver_id': a.toString(),
      'search': search.toString(),
    };
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.followlisting, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      print("Json User" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        setState(() {
          resultfolowvalue = false;
          categoryfollowinglist = null;
        });
      }
      else {
        followlistpojo = new FollowinglistPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null)
        {
          setState(() {
            categoryfollowinglist = jsonResponse['result'];

          });
        }
        else {
          //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
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

        int sizeInBytes = file1.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 1){
          // This file is Longer the
          errorDialog('pleaseselectafilelessthan1mb'.tr);
        }
        else
          {
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
              documentsController.text =catname;
              print("Docname: "+catname.toString());
            }
            else{
              errorDialog('uploadupto2documents'.tr);
            }
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
    if(imageSource!=null)
      {
        if (imageSource == ImageSource.camera) {
          try {
            final imageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
            setState(() {
              if (imageFile != null) {
                setState(() {
                  _imageFile = imageFile;

                  if(_imageList.length<3)
                  {
                    _imageList.add(_imageFile);
                    for (int i = 0; i < _imageList.length; i++) {
                      print("ListImages:" + _imageList[i].toString());
                    }
                  }
                  else {
                    errorDialog('uploadupto3images'.tr);
                  }
                });

              } else {
                print('No image selected.');
              }
            });

          } catch (e) {
            print(e);
          }
        }
        else if (imageSource == ImageSource.gallery) {
          try {
            final imageFile =
            await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
            setState(() {
              if (imageFile != null) {
                setState(() {
                  _imageFile = imageFile;

                  if(_imageList.length<3)
                  {
                    _imageList.add(_imageFile);
                    for (int i = 0; i < _imageList.length; i++) {
                      print("ListImages:" + _imageList[i].toString());
                    }
                  }
                  else {
                    errorDialog('uploadupto3images'.tr);
                  }
                });

              } else {
                print('No image selected.');
              }
            });
          } catch (e) {
            print(e);
          }
        }
      }
    else {}


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
                                      OngoingProject()));
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
                        'createnewproject'.tr,
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
                      child:
                      Form(
                        key: _formmainKey,
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
                                          alignment: AlignmentDirectional.bottomCenter,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: SizeConfig.blockSizeVertical * 2),
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
                            _imageList.length != null
                                ? Container(
                                alignment: Alignment.topCenter,
                                height: SizeConfig.blockSizeVertical * 10,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 6,
                                    right: SizeConfig.blockSizeHorizontal * 6),
                                child: _imageList.length == 0
                                    ? Container()
                                    : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _imageList == null
                                        ? 0
                                        : _imageList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return
                                        Dismissible(
                                            key: Key(
                                                _imageList[index].toString()),
                                            direction: DismissDirection.vertical,
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
                                                    child:
                                                    _imageList!=null &&  _imageList.elementAt(index)!=null?
                                                    Image.file(
                                                      _imageList.elementAt(index),
                                                      fit: BoxFit.fill,
                                                      width: 60,
                                                      height: 60,
                                                    ):Container(),
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
                                'projectname'.tr,
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
                                    return '*';
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
                                'projectdescription'.tr,
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
                                          return '*';
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
                                        DescriptionController.text = DescriptionController.text + "#";
                                        DescriptionController.selection = TextSelection.fromPosition(TextPosition(
                                            offset: DescriptionController
                                                .text.length));
                                      },
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockSizeHorizontal * 3,
                                            right: SizeConfig.blockSizeHorizontal * 3,
                                            bottom: SizeConfig.blockSizeVertical * 2,
                                            top: SizeConfig.blockSizeVertical * 2),
                                        child: Text(
                                          'addhashtag'.tr,
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
                                              left: SizeConfig.blockSizeHorizontal * 3,
                                              right: SizeConfig.blockSizeHorizontal * 2,
                                              top: SizeConfig.blockSizeVertical * 2),
                                          child: Text(
                                            'startdate'.tr,
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
                                                left: SizeConfig.blockSizeHorizontal * 3,
                                                right: SizeConfig.blockSizeHorizontal * 2,
                                                top: SizeConfig.blockSizeVertical * 1),
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
                                                    width: SizeConfig.blockSizeHorizontal * 30,
                                                    padding: EdgeInsets.only(
                                                        left: SizeConfig.blockSizeHorizontal *1),
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
                                              'enddate'.tr,
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
                                                        myFormat.format(currentEndDate),
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
                                    'minimumcashbyparticipant'.tr,
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
                                                  return '*';
                                                else if(val.toString() =="0")
                                                  return 'morethan0amount'.tr;
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
                                    'totalbudget'.tr,
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
                                              width: SizeConfig.blockSizeHorizontal * 30,
                                              padding: EdgeInsets.only(
                                                  left: SizeConfig.blockSizeHorizontal * 1,
                                                  right: SizeConfig.blockSizeHorizontal * 1),
                                              child: TextFormField(
                                                autofocus: false,
                                                focusNode: TotalBudgetFocus,
                                                controller: TotalBudgetController,
                                                textInputAction:
                                                TextInputAction.done,
                                                keyboardType: TextInputType.number,
                                                validator: (val) {
                                                  return costValidation(val);
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
                                    'video'.tr,
                                    maxLines: 4,
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Bold'),
                                  ),
                                ),
                                /*Container(
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
                            )*/
                                Container(
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
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: VideoFocus,
                                    controller: VideoController,
                                    maxLines:6,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.url,

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
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 4,
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                'videoslinkwithcommasepratedwithoutspace'.tr,
                                maxLines: 4,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
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
                                  width: SizeConfig.blockSizeHorizontal * 22,
                                  child: Text(
                                    'relevantdocuments'.tr,
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          /* Container(
                                          width: SizeConfig.blockSizeHorizontal * 60,
                                            child:



                                           */
                                          /* Text(
                                              catname != null ? catname.toString() : "",
                                              maxLines: 5,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 10,
                                                color: AppColors.black,
                                              ),
                                            ),*/
                                          /*

                                            TextFormField(
                                              autofocus: false,
                                              focusNode: documentsFocus,
                                              controller: documentsController,
                                              maxLines:6,
                                              textInputAction: TextInputAction.done,
                                              keyboardType: TextInputType.url,
                                              validator: (val) {
                                                if (val.length == 0)
                                                  return "Please enter video url";
                                                else
                                                  return null;
                                              },
                                              onFieldSubmitted: (v) {
                                                documentsFocus.unfocus();
                                              },
                                              onSaved: (val) => _documents = val,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 10,
                                                color: AppColors.black,
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
                                                  hintText: ""),
                                            ),

                                      ),*/
                                          Container(
                                            height: SizeConfig.blockSizeVertical * 25,
                                            width: SizeConfig.blockSizeHorizontal * 59,
                                            child: ListView.builder(
                                                itemCount: _documentList.length == null
                                                    ? 0
                                                    : _documentList.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context, int inde) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical * 3,
                                                        left: SizeConfig.blockSizeHorizontal * 3,
                                                        right:
                                                        SizeConfig.blockSizeHorizontal * 1),
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [

                                                        Container(
                                                          width:
                                                          SizeConfig.blockSizeHorizontal * 25,
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            _documentList.elementAt(inde).toString(),
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                color: AppColors.black,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.normal,
                                                                fontFamily: 'Poppins-Regular'),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: ()
                                                          {
                                                            setState(() {
                                                              _documentList.removeAt(inde);
                                                              print(inde.toString());
                                                              print("Docname: "+_documentList.length.toString());
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                              top: SizeConfig.blockSizeVertical * 1,
                                                            ),
                                                            width:
                                                            SizeConfig.blockSizeHorizontal * 20,
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "remove".tr,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  decoration:
                                                                  TextDecoration.underline,
                                                                  letterSpacing: 1.0,
                                                                  color: Colors.blue,
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily: 'Poppins-Regular'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    /*   decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/images/files.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),*/
                                                  );
                                                }),
                                          ),
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal * 5,
                                            child:  GestureDetector(
                                              onTap: () {
                                                getPdfAndUpload();
                                              },
                                              child: Container(
                                                width: SizeConfig.blockSizeHorizontal * 5,
                                                child: Icon(
                                                  Icons.attachment,
                                                  color: AppColors.greyColor,
                                                ),
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
                                    'whocanseethisproject'.tr,
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
                                        'pleaseselect'.tr,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      items: _dropdownCategoryValues
                                          .map((String value) =>
                                          DropdownMenuItem(
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
                                          print(currentSelectedValue.toString().toLowerCase());
                                          if (currentSelectedValue == "Anyone")
                                          {
                                            currentid = 1;
                                          } else if (currentSelectedValue == "Connections only")
                                          {
                                            currentid = 2;
                                          }else if(currentSelectedValue=="Invite")
                                          {
                                            currentid = 3;
                                          }
                                          /*else if(currentSelectedValue=="Others")
                                      {
                                        currentid = 4;
                                      }*/
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            currentSelectedValue.toString().toLowerCase()=="invite"?categoryfollowinglist!=null?inviteView():
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                  top: SizeConfig.blockSizeVertical * 2),child: Text(
                              "noconnectionavailable".tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Bold'),
                            ),):
                            currentSelectedValue.toString().toLowerCase()=="others"?otherOptionview()
                                :Container(),
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
                                'addyourspecialtermscondition'.tr,
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
                                    return '*';
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

                                if (_formmainKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Internet_check().check().then((intenet) {
                                    if (intenet != null && intenet) {
                                      if(_imageList.isNotEmpty &&  _imageList.length!=null )
                                      {
                                        if(currentDate.compareTo(currentEndDate)>0)
                                        {
                                          print('date is befor');
                                          //peform logic here.....
                                          errorDialog('Theenddatemustbeafterthestartdate'.tr);

                                        }
                                        else {
                                          print("LENGTH:" +  _imageList.length.toString());
                                          createproject(
                                              context,
                                              ProjectNameController.text,
                                              DescriptionController.text,
                                              myFormat.format(currentDate),
                                              myFormat.format(currentEndDate),
                                              TermsController.text,
                                              EnterRequiredAmountController.text,
                                              TotalBudgetController.text,
                                              emailController.text,
                                              nameController.text,
                                              mobileController.text,
                                              messageController.text,
                                              followingvalues.toString(),
                                              VideoController.text,
                                              _imageList,
                                              _documentList);
                                        }

                                      }
                                      else {
                                        errorDialog("pleaseselectprojectimages".tr);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "nointernetconnection".tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                      );
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
                                child: Text('createnow'.tr,
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
                      )
                  ),
                ),
              )
            ],
          )),
    );
  }

  // add remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
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

  // get firends text-fields
  List<Widget> _getVideoLink() {
    List<Widget> friendsTextFields = new List<Widget>();
    friendsTextFields.add(Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(0)),
            SizedBox(width: 16),
            _addRemoveButton(0 == videoList.length - 1, 0),
          ],
        ),
      ),
    ));
    for (int i = 0; i < videoList.length; i++) {
      friendsTextFields.add(Container(
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.blockSizeHorizontal * 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(child: FriendTextFields(i)),
              SizedBox(width: 16),
              _addRemoveButton(i == videoList.length - 1, i),
            ],
          ),
        ),
      ));
    }
    return friendsTextFields;
  }

  otherOptionview() {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                right: SizeConfig.blockSizeHorizontal*2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical *2,
                left: SizeConfig.blockSizeHorizontal*2,
                right: SizeConfig.blockSizeHorizontal*2),

            child:
            TextFormField(
              autofocus: false,
              focusNode: NameFocus,
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "pleaseentername".tr;
                else if (val.length < 3)
                  return "namemustbemorethan2charater".tr;
                else
                  return null;
              },
              onSaved: (val) => _name = val,

              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(MobileFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular'),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Your Name*",
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

            child:  TextFormField(
              autofocus: false,
              focusNode: MobileFocus,
              controller: mobileController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "pleaseentermobilenumber".tr;
                else if (val.length < 10)
                  return "yourmobilenumbershouldbe10charlong".tr;
                else
                  return null;
              },
              onSaved: (val) => _mobile= val,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(EmailotherFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Phone Number*",
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

            child:
            TextFormField(
              autofocus: false,
              focusNode: EmailotherFocus,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "pleaseenteremail".tr;
                else if (!regex.hasMatch(val))
                  return "pleaseentervalidemail".tr;
                else
                  return null;
              },
              onSaved: (val) => _emailother= val,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(MessageFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Your Email*",
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
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal*2,
                right: SizeConfig.blockSizeHorizontal*2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical *2,
                left: SizeConfig.blockSizeHorizontal*2,
                right: SizeConfig.blockSizeHorizontal*2),

            child:
            TextFormField(
              autofocus: false,
              maxLines:6,
              focusNode: MessageFocus,
              controller: messageController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (val) {
                if (val.length == 0)
                  return "pleaseentermessage".tr;
                else if (val.length < 3)
                  return "messagemustbemorethan2charater".tr;
                else
                  return null;
              },
              onSaved: (val) => _descriptionother= val,
              onFieldSubmitted: (v) {
                MessageFocus.unfocus();
              },
              textAlign: TextAlign.left,
              style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "yourmessage".tr,
                labelStyle:TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  decoration: TextDecoration.none,
                ),

              ),
            ),
          ),

          /*    GestureDetector(
            onTap: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                Internet_check().check().then((intenet) {
                  if (intenet != null && intenet) {
                    if(_imageFile!=null)
                    {
                      sendInvitation(emailController.text, nameController.text,mobileController.text,messageController.text);
                    }
                    else {
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
                  // No-Internet Case
                });
              }
            },
            child: Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal * 38,
                height: SizeConfig.blockSizeVertical * 7,
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 5,
                    bottom: SizeConfig.blockSizeVertical * 5,
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
                    Text(StringConstant.sharelink,
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
          ),*/

        ],
      ),
    );
  }



  inviteView() {
    return Column(
      children: [
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
              width: SizeConfig.blockSizeHorizontal * 45,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 3),
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
              ),
              child: Text(
                //catname!=null?catname.toString():category_names.toString(),
                catFollowingname != null
                    ? catFollowingname.toString()
                    : "pleaseselectcontact".tr,
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
                  width: SizeConfig.blockSizeHorizontal * 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  child:
                  TextField(
                    onChanged: (value){
                      setState(() {
                        getData(userid,value);
                      });
                    },
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintStyle:  TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat-Bold'),hintText: "searchhere".tr),
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
        expandFlag0 == true ? ExpandedInvitationview0() : Container(),
      ],
    );
  }

  ExpandedInvitationview0() {
    return categoryfollowinglist!=null?
    Container(
        alignment: Alignment.topLeft,
        height: SizeConfig.blockSizeVertical * 30,
        child:
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child:
          ListView.builder(
              itemCount: categoryfollowinglist == null ? 0 : categoryfollowinglist.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: AppColors.theme1color,
                  value: _selecteFollowing.contains(categoryfollowinglist[index]['connection_id']),
                  onChanged: (bool selected) {
                    _onCategoryFollowingSelected(selected, categoryfollowinglist[index]['connection_id'],
                        categoryfollowinglist[index]['full_name']);
                  },
                  title: Text(
                    categoryfollowinglist[index]['full_name']==null?"":categoryfollowinglist[index]['full_name'],
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


    ): Container(
        alignment: Alignment.center,
        child: resultfolowvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text(
            "nosearchresultstoshow".tr,
            style: TextStyle(
                letterSpacing: 1.0,
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular'),
          ),
        ));
  }

  void _onCategorySelected(bool selected, category_id, category_name) {
    if (selected == true) {
      setState(() {
        _selecteFollowing.addAll(category_id);
        _selecteFollowingName.addAll(category_name);

      });
    } else {
      setState(() {
        _selecteFollowing.clear();
        _selecteFollowingName.clear();

      });
    }
    final input = _selecteFollowingName.toString();
    final removedBrackets = input.substring(1, input.length - 1);
    final parts = removedBrackets.split(',');
    catFollowingname = parts.map((parts) => "$parts").join(',').trim();

    final input1 = _selecteFollowing.toString();
    final removedBrackets1 = input1.substring(1, input1.length - 1);
    final parts1 = removedBrackets1.split(',');
    followingcatid = parts1.map((part1) => "$part1").join(',').trim();
    followingvalues = followingcatid.replaceAll(" ","");
    print(followingvalues);
    print("CatFollowName: "+catFollowingname);
  }

  void _onCategoryFollowingSelected(bool selected, category_id, category_name)
  {
    if (selected == true) {
      setState(() {
        _selecteFollowing.add(category_id);
        _selecteFollowingName.add(category_name);
      });
    } else {
      setState(() {
        _selecteFollowing.remove(category_id);

        _selecteFollowingName.remove(category_name);
      });
    }
    final input = _selecteFollowingName.toString();
    final removedBrackets = input.substring(1, input.length - 1);
    final parts = removedBrackets.split(',');
    catFollowingname = parts.map((parts) => "$parts").join(',').trim();

    final input1 = _selecteFollowing.toString();
    final removedBrackets1 = input1.substring(1, input1.length - 1);
    final parts1 = removedBrackets1.split(',');
    followingcatid = parts1.map((part1) => "$part1").join(',').trim();
    followingvalues = followingcatid.replaceAll(" ","");
    print(followingvalues);
    print("CatFollowName: "+catFollowingname);
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
      String email,
      String name,
      String mobile,
      String message,
      String connection,
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
    request.fields["name"] = name.toString();
    request.fields["mobile"] = mobile.toString();
    request.fields["email"] = email.toString();
    request.fields["message"] = message.toString();
    request.fields["sendername"] = username.toString();
    request.fields["members"] = connection.toString();

    print("Request: "+request.fields.toString());
        for (int i = 0; i < images.length; i++)
        {
          request.files.add(
            http.MultipartFile("fileimages[]", http.ByteStream(DelegatingStream.typed(images[i].openRead())),
              await images[i].length(), filename: path.basename(images[i].path),
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
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      if (response.statusCode == 200) {
        if (jsonData["success"] == false) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonData["message"]);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            setState(()
            {
              isLoading = false;
            });
            videoList.clear();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OngoingProject()), (route) => false);
          } else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            errorDialog(jsonData["message"]);

          }
        }
      } else if (response.statusCode == 500) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog('internalservererror'.tr);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonData["message"]);
      }
    });
  }

  costValidation(String val)
  {
    if (val.length == 0) {
      return '*';
    }
    else if(int.parse(EnterRequiredAmountController.text) > (int.parse(TotalBudgetController.text))){
      errorDialog('requiredamountshouldbelessthantotalbudget'.tr);
    }
    else
      return null;
  }
}

class FriendTextFields extends StatefulWidget
{
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields>
{
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
      _nameController.text = CreateProjectPostState.videoList[widget.index] ?? '';
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
          hintText: 'entervideolink'.tr,
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins-Regular',
            fontSize: 10,
          )),
      validator: (v) {
        if (v.trim().isEmpty) return 'pleaseentersomething'.tr;
        return null;
      },
    );
  }
}
