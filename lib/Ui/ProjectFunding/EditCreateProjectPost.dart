import 'dart:convert';
import 'dart:io';
import 'package:share/share.dart';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/get_createProjectPojo.dart';
import 'package:kontribute/Ui/ProjectFunding/CreateProjectPost.dart';
import 'package:kontribute/Ui/ProjectFunding/projectfunding.dart';
import 'package:kontribute/Ui/Tickets/tickets.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:kontribute/Pojo/sendinvitationpojo.dart';

class EditCreateProjectPost extends StatefulWidget {
  final String data;

  const EditCreateProjectPost({Key key, @required this.data}) : super(key: key);

  @override
  EditCreateProjectPostState createState() => EditCreateProjectPostState();
}

class EditCreateProjectPostState extends State<EditCreateProjectPost> {
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
  var basename = null;
  var catname = null;
  var videoname = null;
  List<File> _imageList = [];
  List<File> _documentList = [];
  List _selecteName = List();
  List _selectlink = List();
  String data1;
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
  var categoryfollowinglist;
  List _selecteFollowing = List();
  List _selecteFollowingName = List();
  var followingcatid;
  var followingvalues;
  var catFollowingname = null;
  String _ProjectName;
  String _terms;
  String _location;
  bool expandFlag0 = false;
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
  int a;
  bool internet = false;
  String val;
  bool isLoading = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only",
    "Invite",
    "Others"
  ];
  var file1;
  var documentPath;
  var vidoname = null;
  final List<String> _dropdownprivecyvalue = ["Private", "Public"];
  sendinvitationpojo sendinvi;
  final NameFocus = FocusNode();
  final EmailotherFocus = FocusNode();
  final MobileFocus = FocusNode();
  final SubjectFocus = FocusNode();
  final MessageFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  String _emailother, _name, _mobile, _subject, _descriptionother;
  String currentSelectedValue;
  int currentid = 0;
  String showpost;
  String currentSelectedValueprivacy;
  String Date, EndDate;
  String formattedDate = "2021-07-07";
  String formattedEndDate = "2021-07-07";
  int currentPageValue = 0;
  get_createProjectPojo sendgift;
  var productlist_length;
  var imageslist_length;
  bool resultvalue = true;
  String link;
  String linkdocuments;
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

  static List<String> videoList = [null];
  static List<String> newvideoList = [null];
  static List<String> newdocList = [null];
  static List<String> docList = [null];

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
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    setState(() {
      Date = picked.toString();
      formattedDate = DateFormat('yyyy-MM-yy').format(picked);
      print("onDate: " + formattedDate.toString());
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

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(a);

        setState(() {
          internet = true;
        });
      } else {
        setState(() {
          internet = false;
        });
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }

  void getData(int id) async {
    Map data = {
      'id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.get_create_project, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        Fluttertoast.showToast(
          msg: jsonDecode(val)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        sendgift = new get_createProjectPojo.fromJson(jsonResponse);
        print("Json User Details: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = sendgift.projectData;
            imageslist_length = sendgift.projectImagesdata;
            ProjectNameController.text =
                sendgift.projectData.projectName.toString();
            DescriptionController.text =
                sendgift.projectData.description.toString();
            formattedDate = sendgift.projectData.projectStartdate;
            formattedEndDate = sendgift.projectData.projectEnddate;
            EnterRequiredAmountController.text =
                sendgift.projectData.requiredAmount.toString();
            TotalBudgetController.text = sendgift.projectData.budget.toString();
            for (int i = 0; i < sendgift.projectData.videoLink.length; i++) {
              print(
                  "link: " + sendgift.projectData.videoLink.elementAt(i).vlink);
              link = sendgift.projectData.videoLink.elementAt(i).vlink;
              print(": " + link);
              newvideoList.add(link);
            }
            videoList = [
              for (var i in newvideoList)
                if (i != null) i
            ];
            // _selectlink.add(link);

            final input = videoList.toString();
            final removedBrackets = input.substring(1, input.length - 1);
            final parts = removedBrackets.split(',');
            vidoname = parts.map((part) => "$part").join(',').trim();

            print("videoname: " + vidoname.toString());

            // VideoController.text = vidoname;
            for (int i = 0; i < sendgift.projectData.documents.length; i++) {
              print("link: " +
                  sendgift.projectData.documents.elementAt(i).documents);
              linkdocuments =
                  sendgift.projectData.documents.elementAt(i).documents;
              docList.add(linkdocuments);
            }
            newdocList = [
              for (var i in docList)
                if (i != null) i
            ];

            final input3 = newdocList.toString();
            final removedBrackets3 = input3.substring(1, input3.length - 1);
            final parts3 = removedBrackets3.split(',');
            catname = parts3.map((part) => "$part").join(',').trim();

            print("Docname: " + catname.toString());

            TermsController.text =
                sendgift.projectData.termsAndCondition != null ||
                        sendgift.projectData.termsAndCondition != ""
                    ? sendgift.projectData.termsAndCondition.toString()
                    : "";
            //  basename = sendgift.projectData.documents.toString();
            currentid = int.parse(sendgift.projectData.viewType);
            if (currentid == 1) {
              showpost = "Anyone";
            } else if (currentid == 2) {
              showpost = "Connections only";
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

  EndDateView(BuildContext context) async {
    final DateTime picke = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    setState(() {
      EndDate = picke.toString();
      formattedEndDate = DateFormat('yyyy-MM-yy').format(picke);
      print("onDate: " + formattedEndDate.toString());
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
        if (_documentList.length < 2) {
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
          print("Docname: " + catname.toString());
        } else {
          Fluttertoast.showToast(
            msg: "upload upto 2 documents",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
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
        final imageFile =
            await ImagePicker.pickImage(source: imageSource, imageQuality: 25);
        setState(() {
          _imageFile = imageFile;

          if (_imageList.length < 3) {
            _imageList.add(_imageFile);
            for (int i = 0; i < _imageList.length; i++) {
              print("ListImages:" + _imageList[i].toString());
            }
          } else {
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
          if (_imageList.length < 3) {
            _imageList.add(_imageFile);
            for (int i = 0; i < _imageList.length; i++) {
              print("ListImages:" + _imageList[i].toString());
            }
          } else {
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
                        StringConstant.editnewproject,
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
              productlist_length != null
                  ? Expanded(
                      child: Container(
                        child: SingleChildScrollView(
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 100,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: <Widget>[
                                          PageView.builder(
                                            physics: ClampingScrollPhysics(),
                                            itemCount:
                                                imageslist_length.length == null
                                                    ? 0
                                                    : imageslist_length.length,
                                            onPageChanged: (int page) {
                                              getChangedPageAndMoveBar(page);
                                            },
                                            controller: PageController(
                                                initialPage: currentPageValue,
                                                keepPage: true,
                                                viewportFraction: 1),
                                            itemBuilder: (context, ind) {
                                              return Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    100,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    25,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Network.BaseApiProject +
                                                              sendgift
                                                                  .projectImagesdata
                                                                  .elementAt(
                                                                      ind)
                                                                  .imagePath,
                                                        ),
                                                        fit: BoxFit.fill)),
                                              );
                                            },
                                          ),
                                          Stack(
                                            alignment: AlignmentDirectional
                                                .bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        2),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    for (int i = 0;
                                                        i <
                                                            imageslist_length
                                                                .length;
                                                        i++)
                                                      if (i ==
                                                          currentPageValue) ...[
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
                                            top: SizeConfig.blockSizeVertical *
                                                3,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3),
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
                                          left: SizeConfig.blockSizeHorizontal *
                                              6,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  6),
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
                                                  (BuildContext context,
                                                      int index) {
                                                return Dismissible(
                                                    key: Key(_imageList[index]
                                                        .toString()),
                                                    direction: DismissDirection
                                                        .vertical,
                                                    onDismissed: (direction) {
                                                      setState(() {
                                                        _imageList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.topCenter,
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
                                                            alignment: Alignment
                                                                .topCenter,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            width: 60,
                                                            height: 60,
                                                            child: Image.file(
                                                              _imageList
                                                                  .elementAt(
                                                                      index),
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
                                              TextSelection.fromPosition(
                                                  TextPosition(offset:
                                                  DescriptionController.text.length)
                                              );
                                        },
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              bottom:
                                                  SizeConfig.blockSizeVertical *
                                                      2,
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 50,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    2),
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
                                                  SizeConfig.blockSizeVertical *
                                                      8,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      1),
                                              padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
                                                right: SizeConfig
                                                        .blockSizeVertical *
                                                    1,
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
                                                        formattedDate,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            letterSpacing: 1.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                'Poppins-Regular',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          5,
                                                      child: Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        color:
                                                            AppColors.greyColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 50,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2),
                                              child: Text(
                                                StringConstant.enddate,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'Poppins-Bold'),
                                              ),
                                            ),
                                            Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    8,
                                                margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                ),
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  right: SizeConfig
                                                          .blockSizeVertical *
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
                                                        alignment:
                                                            Alignment.center,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            30,
                                                        padding: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1),
                                                        child: Text(
                                                          formattedEndDate,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  'Poppins-Regular',
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            5,
                                                        child: Icon(
                                                          Icons
                                                              .calendar_today_outlined,
                                                          color: AppColors
                                                              .greyColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 42,
                                      height: SizeConfig.blockSizeVertical * 7,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                                  SizeConfig.blockSizeVertical *
                                                      7,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8)),
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
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
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
                                                focusNode:
                                                    EnterRequiredAmountFocus,
                                                controller:
                                                    EnterRequiredAmountController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (val) {
                                                  if (val.length == 0)
                                                    return "Please enter required amount";
                                                  else
                                                    return null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          TotalBudgetFocus);
                                                },
                                                onSaved: (val) =>
                                                    _requiredamount = val,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 42,
                                      height: SizeConfig.blockSizeVertical * 7,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    7,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8)),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.theme1color,
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
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
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
                                                  controller:
                                                      TotalBudgetController,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (val) {
                                                    if (val.length == 0)
                                                      return "Please enter total buget";
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
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          'Poppins-Regular',
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          'Poppins-Regular',
                                                      fontSize: 15,
                                                      decoration:
                                                          TextDecoration.none,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 70,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    60,
                                                child: Text(
                                                  catname != null
                                                      ? catname.toString()
                                                      : "",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 10,
                                                    color: AppColors.black,
                                                  ),
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                getPdfAndUpload();
                                              },
                                              child: Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
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
                                          showpost == null
                                              ? "please select"
                                              : showpost,
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
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            'Poppins-Bold'),
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
                                            if (currentSelectedValue ==
                                                "Anyone") {
                                              currentid = 1;
                                            } else if (currentSelectedValue ==
                                                "Connections only") {
                                              currentid = 2;
                                            } else if (currentSelectedValue ==
                                                "Invite") {
                                              currentid = 3;
                                            } else if (currentSelectedValue ==
                                                "Others") {
                                              currentid = 4;
                                            }
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              currentSelectedValue.toString().toLowerCase() ==
                                      "invite"
                                  ? inviteView(context)
                                  : currentSelectedValue
                                              .toString()
                                              .toLowerCase() ==
                                          "others"
                                      ? otherOptionview(context)
                                      : Container(),
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
                                  if (_imageList != null &&
                                      documentPath != null) {
                                    final input2 = videoList.toString();
                                    final removedBrackets =
                                        input2.substring(1, input2.length - 1);
                                    final parts = removedBrackets.split(',');
                                    vidoname = parts
                                        .map((part) => "$part")
                                        .join(',')
                                        .trim();
                                    print("Vidoname: " + vidoname.toString());

                                    createproject(
                                        context,
                                        ProjectNameController.text,
                                        DescriptionController.text,
                                        formattedDate,
                                        formattedEndDate,
                                        TermsController.text,
                                        EnterRequiredAmountController.text,
                                        TotalBudgetController.text,
                                        vidoname,
                                        _imageList,
                                        _documentList);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please Select Images/documents",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                    );
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
                                      right:
                                          SizeConfig.blockSizeHorizontal * 25),
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
                        ),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: internet == true
                            ? CircularProgressIndicator()
                            : SizedBox(),
                      ),
                    ),
            ],
          )),
    );
  }

  otherOptionview(BuildContext context2) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            child: TextFormField(
              autofocus: false,
              focusNode: NameFocus,
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter name";
                else if (val.length < 3)
                  return "Name must be more than 2 charater";
                else
                  return null;
              },
              onSaved: (val) => _name = val,
              onFieldSubmitted: (v) {
                FocusScope.of(context2).requestFocus(MobileFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Your Name*",
                labelStyle: TextStyle(
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
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1,
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            child: TextFormField(
              autofocus: false,
              focusNode: MobileFocus,
              controller: mobileController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter mobile number";
                else if (val.length < 10)
                  return "Your mobile number should be 10 char long";
                else
                  return null;
              },
              onSaved: (val) => _mobile = val,
              onFieldSubmitted: (v) {
                FocusScope.of(context2).requestFocus(EmailotherFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Phone Number*",
                labelStyle: TextStyle(
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
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1,
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            child: TextFormField(
              autofocus: false,
              focusNode: EmailotherFocus,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter email";
                else if (!regex.hasMatch(val))
                  return "Please enter valid email";
                else
                  return null;
              },
              onSaved: (val) => _emailother = val,
              onFieldSubmitted: (v) {
                FocusScope.of(context2).requestFocus(MessageFocus);
              },
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Your Email*",
                labelStyle: TextStyle(
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
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2),
            child: TextFormField(
              autofocus: false,
              maxLines: 6,
              focusNode: MessageFocus,
              controller: messageController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (val) {
                if (val.length == 0)
                  return "Please enter message";
                else if (val.length < 3)
                  return "message must be more than 2 charater";
                else
                  return null;
              },
              onSaved: (val) => _descriptionother = val,
              onFieldSubmitted: (v) {
                MessageFocus.unfocus();
              },
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Your Message",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins-Regular',
                  decoration: TextDecoration.none,
                ),
              ),
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
                    if (_imageFile != null) {
                      sendInvitation(
                          context2,
                          emailController.text,
                          nameController.text,
                          mobileController.text,
                          messageController.text);
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
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
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
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () {}),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  inviteView(BuildContext context1) {
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
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
              ),
              child: Text(
                //catname!=null?catname.toString():category_names.toString(),
                catFollowingname != null
                    ? catFollowingname.toString()
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3,
                ),
                child: Text(
                  "Search contact",
                  style: TextStyle(
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
                        child: new Icon(
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
        expandFlag0 == true ? ExpandedInvitationview0(context1) : Container(),
      ],
    );
  }

  ExpandedInvitationview0(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        height: SizeConfig.blockSizeVertical * 30,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              itemCount: categoryfollowinglist == null
                  ? 0
                  : categoryfollowinglist.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: AppColors.theme1color,
                  value: _selecteFollowing
                      .contains(categoryfollowinglist[index]['sender_id']),
                  onChanged: (bool selected) {
                    _onCategoryFollowingSelected(
                        selected,
                        categoryfollowinglist[index]['sender_id'],
                        categoryfollowinglist[index]['full_name']);
                  },
                  title: Text(
                    categoryfollowinglist[index]['full_name'],
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 3,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat-Bold'),
                  ),
                );
              }),
        ));
  }

  void _onCategoryFollowingSelected(bool selected, category_id, category_name) {
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
    followingvalues = followingcatid.replaceAll(" ", "");
    print(followingvalues);
    print("CatFollowName: " + catFollowingname);
  }

  sendInvitation(BuildContext context, String emal, String name, String mobile,
      String descr) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "userid": userid.toString(),
      "name": name,
      "message": descr,
      "email": emal,
      "mobile": mobile,
    };
    print("Data: " + data.toString());
    var jsonResponse = null;
    var response =
        await http.post(Network.BaseApi + Network.invitation, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        sendinvi = new sendinvitationpojo.fromJson(jsonResponse);
        String jsonProfile = jsonEncode(sendinvi);
        print(jsonProfile);
        SharedUtils.saveProfile(jsonProfile);
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
            emailController.text = "";
            nameController.text = "";
            mobileController.text = "";
            messageController.text = "";
          });
          final RenderBox box1 = _formKey.currentContext.findRenderObject();
          Share.share(
              "Let's join on Kontribute! Get it at " + sendinvi.invitationlink,
              subject: "Kontribute",
              sharePositionOrigin: box1.localToGlobal(Offset.zero) & box1.size);
          Fluttertoast.showToast(
            msg: sendinvi.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
            //   isLoading = false;
          });
          Fluttertoast.showToast(
            msg: sendinvi.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonResponse["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
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
      List images,
      List documentList) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest(
        "POST", Uri.parse(Network.BaseApi + Network.edit_create_project));
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
    request.fields["id"] = a.toString();

    print("Request: " + request.fields.toString());
    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile(
          "fileimages[]",
          http.ByteStream(DelegatingStream.typed(images[i].openRead())),
          await images[i].length(),
          filename: path.basename(images[i].path),
        ),
      );
    }
    for (int i = 0; i < documentList.length; i++) {
      request.files.add(
        http.MultipartFile(
          "file[]",
          http.ByteStream(DelegatingStream.typed(documentList[i].openRead())),
          await documentList[i].length(),
          filename: path.basename(documentList[i].path),
        ),
      );
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
            videoList.clear();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => projectfunding()),
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

  /// get friends text-fields
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
}
