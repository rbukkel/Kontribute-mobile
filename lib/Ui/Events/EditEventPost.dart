import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/get_EventCreate.dart';
import 'package:kontribute/Pojo/sendinvitationpojo.dart';
import 'package:kontribute/Pojo/EventCategoryPojo.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class EditEventPost extends StatefulWidget {
  final String data;

  const EditEventPost({Key key, @required this.data}) : super(key: key);

  @override
  EditEventPostState createState() => EditEventPostState();
}

class EditEventPostState extends State<EditEventPost> {
  File _imageFile;
  bool image_value = false;
  final EventNameFocus = FocusNode();
  final LocationFocus = FocusNode();
  final LocationDetailsFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final DateFocus = FocusNode();
  final TimeFocus = FocusNode();
  final ContactNoFocus = FocusNode();
  final EmailFocus = FocusNode();
  final SearchPostFocus = FocusNode();
  final CostofTicketFocus = FocusNode();
  final VideoFocus = FocusNode();
  final TextEditingController VideoController = new TextEditingController();
  String _Video;
  final TermsFocus = FocusNode();
  var vidoname = null;
  List _selecteName = List();
  var productlist_length;
  var imageslist_length;
  final TextEditingController TermsController = new TextEditingController();
  final TextEditingController searchpostController =
      new TextEditingController();
  final TextEditingController EventNameController = new TextEditingController();
  final TextEditingController LocationController = new TextEditingController();
  final TextEditingController LocationDetailsController =
      new TextEditingController();
  final TextEditingController DescriptionController =
      new TextEditingController();
  final TextEditingController DateController = new TextEditingController();
  final TextEditingController TimeController = new TextEditingController();
  final TextEditingController ContactNoController = new TextEditingController();
  final TextEditingController CostofTicketController =
      new TextEditingController();
  final TextEditingController MaximumNoofquantityController =
      new TextEditingController();
  final TextEditingController EmailController = new TextEditingController();
  List<File> _imageList = [];
  List<File> _documentList = [];
  String _eventName;
  String _terms;
  String _location;
  String _locationdetails;
  String _description;
  String _date;
  String _time;
  String _contactno;
  String _email;
  String _searchpost;
  String _costofTicket;
  String _video;
  String val;
  bool resultvalue = true;
  var storelist_length;
  String textHolder = 'pleaseselect'.tr;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only",
    "Invite"
  ];
  bool resultfolowvalue = true;
  get_EventCreate sendgift;
  FileType fileType;
  var basename = null;
  var catname = null;
  bool expandFlag0 = false;
  var categoryfollowinglist;
  String link;
  String linkdocuments;
  static List<String> videoList = [null];
  static List<String> newvideoList = [null];
  static List<String> newdocList = [null];
  static List<String> docList = [null];
  String showpost;
  List _selecteFollowing = List();
  List _selecteFollowingName = List();
  var followingcatid;
  var followingvalues;
  var catFollowingname = null;
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
  String _emailother, _name, _mobile, _subject, _descriptionother;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  sendinvitationpojo sendinvi;
  var file1;
  var documentPath;
  final List<String> _dropdownEventCategory = [
    "New year",
    "Valentine's Day",
    "Mother's Day",
    "Father's Day",
    "Easter",
    "Thanksgiving",
    "Eid",
    "Diwali",
    "Christmas",
    "Halloween",
    "Anniversary",
    "Bridal Shower",
    "Baby Shower",
    "Bachelor Party",
    "Bachelorette Party",
    "Party",
    "Lunch",
    "Dinner",
    "Graduation",
    "Other"
  ];

  final List<String> _dropdownprivecyvalue = ["Private", "Public"];
  String selectedTime = "";
  String selectedEndTime = "";
  String _hour, _minute, _tim;
  String _hourend, _minuteend, _timend;
  TimeOfDay selecteTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selecteEndTime = TimeOfDay(hour: 00, minute: 00);
  String currentSelectedValue;
  int currentid = 0;
  String currentSelectedEventValue;
  String currentSelectedValueprivacy;
  String Date, EndDate;
  String formattedDate = "2021/07/07";
  String formattedEndDate = "2021/07/07";
  final EnterRequiredAmountFocus = FocusNode();
  final MaximumnoparticipantFocus = FocusNode();
  final TextEditingController EnterRequiredAmountController =
      new TextEditingController();
  final TextEditingController Maximumnoparticipantcontroller =
      new TextEditingController();
  String _requiredamount;
  String _Maximumnoparticipant;
  String userid;
  String username;
  int catid;
  String searchvalue="";
  EventCategoryPojo listing;
  DateTime currentDate = DateTime.now();
  var myFormat = DateFormat('yyyy/MM/dd');
  bool internet = false;
  DateTime currentEndDate = DateTime.now();
  var myFormatEndDate = DateFormat('yyyy/MM/dd');
  String data1;
  int a;


  DateView(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime.now(),
        lastDate: DateTime(2050));
    setState(() {
      Date = picked.toString();
      formattedDate = DateFormat('yyyy-MM-yy').format(picked);
      print("onDate: " + formattedDate.toString());
    });
  }

  EndDateView(BuildContext context) async {
    final DateTime picke = await showDatePicker(
        context: context,
        initialDate:DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2050));
    setState(() {
      EndDate = picke.toString();
      formattedEndDate = DateFormat('yyyy-MM-yy').format(picke);
      print("onDate: " + formattedEndDate.toString());

      if(formattedDate.compareTo(formattedEndDate)>0)
      {
        print('date is befor');
        //peform logic here.....
        errorDialog('enddateshouldbeafterstartdate'.tr);

      }
      else {
        EndDate = picke.toString();
        print('date is after');
      }
    });
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
                    'ok'.tr,
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
  void initState() {
    super.initState();
    SharedUtils.readloginId("UserId").then((vals) {
      print("UserId: " + vals);
      userid = vals;
      getFollowData(userid,searchvalue);
      print("Login userid: " + userid.toString());
    });
    SharedUtils.readloginId("Usename").then((val) {
      print("username: " + val);
      username = val;
      print("Login username: " + username.toString());
    });

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        getEventCategory();
        data1 = widget.data;
        a = int.parse(data1);
        print("receiverComing: " + a.toString());
        getData(userid, a);

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

  Future<void> _showTimePicker() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    /*if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }*/
    if (picked != null)
      setState(() {
        selecteTime = picked;
        _hour = selecteTime.hour.toString();
        _minute = selecteTime.minute.toString();
        _tim = _hour + ':' + _minute;
        if (selectedTime == "") {
          selectedTime = TimeOfDay.now().toString().substring(10, 15);
        } else {
          selectedTime = _tim;
        }
      });
  }


  Future<void> _showEndTimePicker() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    /*if (picked != null) {
      setState(() {
        selectedEndTime = picked.format(context);
      });
    }*/
    if (picked != null)
      setState(() {
        selecteEndTime = picked;
        _hourend = selecteEndTime.hour.toString();
        _minuteend = selecteEndTime.minute.toString();
        _timend = _hourend + ':' + _minuteend;
        if (selectedEndTime == "") {
          selectedEndTime = TimeOfDay.now().toString().substring(10, 15);
        } else {
          selectedEndTime = _timend;
        }
      });
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: MediaQuery.of(context).size.height * 80,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/images/bg_img.png"),
                  fit: BoxFit.fill,
                )), //could change this to Color(0xFF737373),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 5,
                                right: SizeConfig.blockSizeHorizontal * 3,
                                top: SizeConfig.blockSizeVertical * 2),
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: Text(
                              'eventyype'.tr,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 3,
                                  bottom: SizeConfig.blockSizeVertical * 3,
                                  right: SizeConfig.blockSizeHorizontal * 5),
                              child: Image.asset(
                                "assets/images/close.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ]),
                    Expanded(
                      child: ListView.builder(
                          itemCount: storelist_length.length == null
                              ? 0
                              : storelist_length.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  catid =
                                      listing.resultPush.elementAt(index).catId;
                                  print("categoryid: " + catid.toString());
                                  print("categoryname: " +
                                      listing.resultPush
                                          .elementAt(index)
                                          .categoryName
                                          .toString());
                                  changeText(listing.resultPush
                                      .elementAt(index)
                                      .categoryName
                                      .toString());
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  padding: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * 3,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 1,
                                    bottom: SizeConfig.blockSizeVertical * 1,
                                    left: SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    listing.resultPush
                                        .elementAt(index)
                                        .categoryName
                                        .toString(),
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Lato-Bold',
                                        color: AppColors.black,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ));
          });
        });
  }

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

  void getEventCategory() async {
    var response = await http
        .get(Uri.encodeFull(Network.BaseApi + Network.categorylisting));
    var jsonResponse = null;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == false) {
        setState(() {
          resultvalue = false;
        });

      } else {
        listing = new EventCategoryPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (listing.resultPush.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = listing.resultPush;
            }
          });
        } else {
          errorDialog(listing.message);
        }
      }
    } else {
      errorDialog(jsonDecode(val)["message"]);

    }
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
            errorDialog('uploadupto3images'.tr);
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
            errorDialog('uploadupto3images'.tr);
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  changeText(String valu) {
    setState(() {
      textHolder = valu;
    });
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
                                      OngoingEvents()));
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
                        'editevent'.tr,
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
                                                          Network.BaseApievent +
                                                              sendgift
                                                                  .eventImagesdata
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
                                  'eventname'.tr,
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
                                  focusNode: EventNameFocus,
                                  controller: EventNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return 'pleaseentereventname'.tr;
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(DescriptionFocus);
                                  },
                                  onSaved: (val) => _eventName = val,
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
                                  'eventdescription'.tr,
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
                                            return 'pleaseentereventdescription'.tr;
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
                                                  TextPosition(
                                                      offset:
                                                          DescriptionController
                                                              .text.length));
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
                                // width: SizeConfig.blockSizeHorizontal * 50,
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
                                        'events'.tr,
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins-Bold'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _modalBottomSheetMenu();
                                      },
                                      child: Container(
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
                                        alignment: Alignment.centerLeft,
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
                                        child: Text(
                                          textHolder,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Bold'),
                                        ),
                                        /*  child:
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("please select",style: TextStyle(fontSize: 12),),
                                          items: _dropdownEventCategory
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
                                          value: currentSelectedEventValue,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              currentSelectedEventValue = newValue;
                                              print(currentSelectedEventValue.toString()
                                                  .toLowerCase());
                                            });
                                          },
                                          isExpanded: true,
                                        ),
                                      ),*/
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                                'eventstarttime'.tr,
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
                                                      3,
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
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
                                                    _showTimePicker();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            33,
                                                        padding: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1),
                                                        child: Text(
                                                          selectedTime == ""
                                                              ? TimeOfDay.now()
                                                              .toString()
                                                              .substring(10, 15)
                                                              : selectedTime,
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
                                                          Icons.alarm,
                                                          color: AppColors
                                                              .greyColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        )),
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
                                                'eventendtime'.tr,
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
                                                    _showEndTimePicker();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            33,
                                                        padding: EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1),
                                                        child: Text(
                                                          selectedEndTime == ""
                                                              ? TimeOfDay.now()
                                                              .toString()
                                                              .substring(10, 15)
                                                              : selectedEndTime,
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
                                                          Icons.alarm,
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
                                                          33,
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
                                                      alignment:
                                                          Alignment.center,
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
                                                'enddate'.tr,
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
                                                    EndDateView(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            33,
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
                                      'entryfees'.tr,
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
                                                    return 'pleaseenterrequiredamount'.tr;
                                                  else
                                                    return null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          MaximumnoparticipantFocus);
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
                                      'maximumnumberofparticipant'.tr,
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
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: TextFormField(
                                      autofocus: false,
                                      focusNode: MaximumnoparticipantFocus,
                                      controller:
                                          Maximumnoparticipantcontroller,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val.length == 0)
                                          return 'pleaseentermaximumnoofparticipant'.tr;
                                        else
                                          return null;
                                      },
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(VideoFocus);
                                      },
                                      onSaved: (val) =>
                                          _Maximumnoparticipant = val,
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
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    child: Text(
                                      'video'.tr,
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins-Bold'),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 65,
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
                                    child: TextFormField(
                                      autofocus: false,
                                      focusNode: VideoFocus,
                                      controller: VideoController,
                                      maxLines: 6,
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
                                          hintText:
                                              "https://www.youtube.com/watch?v=HFX6AZ5bDDo"),
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
                                            /*  Container(
                                        width: SizeConfig.blockSizeHorizontal * 60,
                                        child:
                                       */ /* Text(
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
                                        ),*/ /*
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
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      25,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  59,
                                              child: ListView.builder(
                                                  itemCount: _documentList
                                                              .length ==
                                                          null
                                                      ? 0
                                                      : _documentList.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int inde) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          top: SizeConfig
                                                                  .blockSizeVertical *
                                                              3,
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3,
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                25,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              _documentList
                                                                  .elementAt(
                                                                      inde)
                                                                  .toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _documentList
                                                                    .removeAt(
                                                                        inde);
                                                                print(inde
                                                                    .toString());
                                                                print("Docname: " +
                                                                    _documentList
                                                                        .length
                                                                        .toString());
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: SizeConfig
                                                                        .blockSizeVertical *
                                                                    1,
                                                              ),
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  20,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'remove'.tr,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontFamily:
                                                                        'Poppins-Regular'),
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
                                      'whocanseethisevent'.tr,
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
                                              ? 'pleaseselect'.tr
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
                                            if (currentSelectedValue ==
                                                "Anyone") {
                                              currentid = 1;
                                            } else if (currentSelectedValue ==
                                                "Connections only") {
                                              currentid = 2;
                                            } else if (currentSelectedValue ==
                                                "Invite") {
                                              currentid = 3;
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
                                          "invite" ||
                                      showpost.toString().toLowerCase() ==
                                          "invite"
                                  ? inviteView()
                                  : currentSelectedValue
                                                  .toString()
                                                  .toLowerCase() ==
                                              "anyone" ||
                                          showpost.toString().toLowerCase() ==
                                              "anyone"
                                      ? emptybox()
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
                                      return 'pleaseaddyourspecialtermscondition'.tr;
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
                                  final removedBrackets =
                                      input2.substring(1, input2.length - 1);
                                  final parts = removedBrackets.split(',');
                                  vidoname = parts
                                      .map((part) => "$part")
                                      .join(',')
                                      .trim();
                                  print("Vidoname: " + vidoname.toString());


                                  if(formattedDate.compareTo(formattedEndDate)>0)
                                  {
                                    print('date is befor');
                                    //peform logic here.....
                                    errorDialog('Theenddatemustbeafterthestartdate'.tr);

                                  }
                                  else{
                                    if (followingvalues == null) {
                                      createproject(
                                          context,
                                          EventNameController.text,
                                          DescriptionController.text,
                                          catid,
                                          selectedTime,
                                          selectedEndTime,
                                          formattedDate,
                                          formattedEndDate,
                                          EnterRequiredAmountController.text,
                                          Maximumnoparticipantcontroller.text,
                                          TermsController.text,
                                          emailController.text,
                                          nameController.text,
                                          mobileController.text,
                                          messageController.text,
                                          "",
                                          VideoController.text,
                                          _imageList,
                                          _documentList);
                                    } else {
                                      createproject(
                                          context,
                                          EventNameController.text,
                                          DescriptionController.text,
                                          catid,
                                          selectedTime,
                                          selectedEndTime,
                                          formattedDate,
                                          formattedEndDate,
                                          EnterRequiredAmountController.text,
                                          Maximumnoparticipantcontroller.text,
                                          TermsController.text,
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
                                  child: Text('editnow'.tr,
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

  Future getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx',
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
          errorDialog('uploadupto2documents'.tr);

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
              Expanded(child: videoTextFields(i)),
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
      int cate,
      String starttime,
      String endtime,
      String startdate,
      String enddate,
      String enterrequiredamount,
      String maxparti,
      String terms,
      String email,
      String name,
      String mobile,
      String message,
      String connection,
      String video,
      List images,
      List documentList) async {
    var jsonData = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    var request = http.MultipartRequest(
        "POST", Uri.parse(Network.BaseApi + Network.edit_events));
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["event_name"] = projectname.toString();
    request.fields["description"] = description.toString();
    request.fields["event_startdate"] = startdate.toString();
    request.fields["event_enddate"] = enddate;
    request.fields["event_starttime"] = starttime.toString();
    request.fields["event_endtime"] = endtime.toString();
    request.fields["category_id"] = cate.toString();
    request.fields["maximum_participant"] = maxparti;
    request.fields["entry_fee"] = enterrequiredamount;
    request.fields["who_can_see"] = currentid.toString();
    request.fields["video_link"] = video.toString();
    request.fields["special_terms_conditions"] = terms.toString();
    request.fields["userid"] = userid.toString();
    request.fields["members"] = connection.toString();
    request.fields["name"] = name.toString();
    request.fields["email"] = email.toString();
    request.fields["mobile"] = mobile.toString();
    request.fields["message"] = message.toString();
    request.fields["sendername"] = username.toString();
    request.fields["event_id"] = a.toString();

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
        if (jsonData["success"] == false) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          errorDialog(jsonData["message"]);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (jsonData != null) {
            setState(() {
              isLoading = false;
            });

            videoList.clear();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OngoingEvents()),
                (route) => false);
          } else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            setState(() {
              Navigator.of(context).pop();
              //   isLoading = false;
            });
            errorDialog(jsonData["message"]);
          }
        }
      } else if (response.statusCode == 422) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonData["message"]);
      } else if (response.statusCode == 500) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog('internalservererror'.tr);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog('somethingwentwrong'.tr);
      }
    });
  }

  otherOptionview() {
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
                FocusScope.of(context).requestFocus(MobileFocus);
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
                FocusScope.of(context).requestFocus(EmailotherFocus);
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
                FocusScope.of(context).requestFocus(MessageFocus);
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
        ],
      ),
    );
  }

  Future<void> getFollowData(String a,String search) async {
    setState(() {
      categoryfollowinglist =null;
    });
    // Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {'receiver_id': a.toString(), 'search': search.toString(),};
    print("Data: " + data.toString());
    var jsonResponse = null;
    var response =
    await http.post(Network.BaseApi + Network.followlisting, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("Json User" + jsonResponse.toString());
      if (jsonResponse["success"] == false) {
        //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {
          resultfolowvalue = false;
          categoryfollowinglist = null;
        });
      } else {
        // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          setState(() {
            categoryfollowinglist = jsonResponse['result'];
          });
        } else {
          // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            errorDialog(jsonResponse["message"]);
          });
        }
      }
    }
  }


  void getData(String user, int id) async {
    Map data = {
      'userid': user.toString(),
      'event_id': id.toString(),
    };
    print("receiver: " + data.toString());
    var jsonResponse = null;
    http.Response response =
        await http.post(Network.BaseApi + Network.get_event, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body; //store response as string
      if (jsonDecode(val)["success"] == false) {
        errorDialog(jsonDecode(val)["message"]);

      } else {
        sendgift = new get_EventCreate.fromJson(jsonResponse);
        print("Json User Details: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            productlist_length = sendgift.eventData;
            imageslist_length = sendgift.eventImagesdata;
            EventNameController.text = sendgift.eventData.eventName.toString();
            DescriptionController.text =
                sendgift.eventData.description.toString();
            selectedTime = sendgift.eventData.eventStarttime;
            selectedEndTime = sendgift.eventData.eventEndtime;
            formattedDate = sendgift.eventData.eventStartdate;
            formattedEndDate = sendgift.eventData.eventEnddate;
            EnterRequiredAmountController.text =
                sendgift.eventData.entryFee.toString();
            Maximumnoparticipantcontroller.text =
                sendgift.eventData.maximumParticipant.toString();
            TermsController.text =
                sendgift.eventData.termsAndCondition.toString();
            textHolder = sendgift.eventData.categoryName;
            catid = int.parse(sendgift.eventData.categoryId);
            if (sendgift.invitationdata == null) {
              nameController.text = "";
              emailController.text = "";
              messageController.text = "";
              mobileController.text = "";
            } else {
              nameController.text = sendgift.invitationdata.name.toString();
              emailController.text = sendgift.invitationdata.email.toString();
              messageController.text =
                  sendgift.invitationdata.message.toString();
              mobileController.text = sendgift.invitationdata.mobile.toString();
            }

            for (int i = 0; i < sendgift.eventData.videoLink.length; i++) {
              print("link: " + sendgift.eventData.videoLink.elementAt(i).vlink);
              link = sendgift.eventData.videoLink.elementAt(i).vlink;
              print(": " + link);

            }
            newvideoList.add(link);
            currentid = int.parse(sendgift.eventData.viewType);
            if (currentid == 1) {
              showpost = "Anyone";
            } else if (currentid == 2) {
              showpost = "Connections only";
            } else if (currentid == 3) {
              showpost = "Invite";
            } else if (currentid == 4) {
              showpost = "Others";
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
            VideoController.text = vidoname;
            for (int i = 0; i < sendgift.eventData.documents.length; i++) {
              print("link: " +
                  sendgift.eventData.documents.elementAt(i).documents);
              linkdocuments =
                  sendgift.eventData.documents.elementAt(i).documents;

            }
            docList.add(linkdocuments);
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
                sendgift.eventData.termsAndCondition != null ||
                        sendgift.eventData.termsAndCondition != ""
                    ? sendgift.eventData.termsAndCondition.toString()
                    : "";
            //  basename = sendgift.projectData.documents.toString();
            currentid = int.parse(sendgift.eventData.viewType);
            if (currentid == 1) {
              showpost = "Anyone";
            } else if (currentid == 2) {
              showpost = "Connections only";
            } else if (currentid == 3) {
              showpost = "Invite";
            } else if (currentid == 4) {
              showpost = "Others";
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

  emptybox() {
    return Container(
        height: SizeConfig.blockSizeVertical * 2,
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 1,
              child: Text(""),
            )
          ],
        ));
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
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
              ),
              child: Text(
                //catname!=null?catname.toString():category_names.toString(),
                catFollowingname != null
                    ? catFollowingname.toString()
                    : 'pleaseselectcontact'.tr,
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
                  width: SizeConfig.blockSizeHorizontal * 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        getFollowData(userid, value);
                      });
                    },
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat-Bold'),
                        hintText: 'search'.tr),
                  )),
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
        expandFlag0 == true ? ExpandedInvitationview0() : Container(),
      ],
    );
  }

  ExpandedInvitationview0() {
    return categoryfollowinglist!=null?
      Container(
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
        )): Container(
        alignment: Alignment.center,
        child: resultfolowvalue == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Text(
            'nosearchresultstoshow'.tr,
            style: TextStyle(
                letterSpacing: 1.0,
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular'),
          ),
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
}

class ItemLists {
  String title;

  ItemLists({this.title});
}

class videoTextFields extends StatefulWidget {
  final int index;

  videoTextFields(this.index);

  @override
  _videoTextFieldsState createState() => _videoTextFieldsState();
}

class _videoTextFieldsState extends State<videoTextFields> {
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
      _nameController.text = EditEventPostState.videoList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => EditEventPostState.videoList[widget.index] = v,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins-Regular',
        fontSize: 10,
      ),
      decoration: InputDecoration(
          hintText: 'Enter video link',
          hintStyle: TextStyle(
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
