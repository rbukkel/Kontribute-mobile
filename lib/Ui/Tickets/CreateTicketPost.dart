import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/sendinvitationpojo.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class CreateTicketPost extends StatefulWidget {
  @override
  CreateTicketPostState createState() => CreateTicketPostState();
}

class CreateTicketPostState extends State<CreateTicketPost> {
  File _imageFile;
  bool image_value = false;
  final EventNameFocus = FocusNode();
  final LocationFocus = FocusNode();
  final LocationDetailsFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final TermsFocus = FocusNode();
  final DateFocus = FocusNode();
  final TimeFocus = FocusNode();
  final ContactNoFocus = FocusNode();
  final EmailFocus = FocusNode();
  final SearchPostFocus = FocusNode();
  final CostofTicketFocus = FocusNode();
  final MaximumNoofquantityFocus = FocusNode();
  final VideoFocus = FocusNode();
  var file1;
  String searchvalue="";
  var documentPath;
  FileType fileType;
  var basename=null;
  var catname=null;
  final TextEditingController searchpostController = new TextEditingController();
  final TextEditingController EventNameController = new TextEditingController();
  final TextEditingController LocationController = new TextEditingController();
  final TextEditingController LocationDetailsController = new TextEditingController();
  final TextEditingController DescriptionController = new TextEditingController();
  final TextEditingController DateController = new TextEditingController();
  final TextEditingController TimeController = new TextEditingController();
  final TextEditingController ContactNoController = new TextEditingController();
  final TextEditingController CostofTicketController = new TextEditingController();
  final TextEditingController MaximumNoofquantityController = new TextEditingController();
  final TextEditingController EmailController = new TextEditingController();
  final TextEditingController TermsController = new TextEditingController();
  final documentsFocus = FocusNode();
  final TextEditingController documentsController = new TextEditingController();
  final TextEditingController VideoController = new TextEditingController();
  String _Video;
  String _documents;
  String selectedTime = "";
  String selectedEndTime = "";
  String _hour, _minute, _tim;
  String _hourend, _minuteend, _timend;
  TimeOfDay selecteTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selecteEndTime = TimeOfDay(hour: 00, minute: 00);
  DateTime currentDate = DateTime.now();
  DateTime currentEndDate = DateTime.now();
  DateTime timeframedate = DateTime.now();
  String dateTime;
  String _eventName;
  String _location;
  String _locationdetails;
  String _description;
  String _terms;
  String _date;
  String _time;
  String _contactno;
  String _email;
  String _searchpost;
  String _costofTicket;
  String _maximumNoofquantity;
  List<File> _imageList = [];
  List<File> _documentList = [];
  List _selecteName = List();
  final List<String> _dropdownCategoryValues = [
    "Anyone",
    "Connections only",
    "Invite",
    "Others"
  ];
  final List<String> _dropdownprivecyvalue = ["Private", "Public"];

  changeText(String valu) {
    setState(() {
      textHolder = valu;
    });
  }

  String textHolder = "Please Select";
  final List<String> _dropdownEventCategory = [
    "New year",
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
  String currentSelectedValue;
  int currentid = 0;
  String currentSelectedValueprivacy;
  String userid;
  String username;
  String Date, EndDate;
  String formattedDate = "07-07-2021";
  String formattedEndDate = "07-07-2021";
  sendinvitationpojo sendinvi;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool expandFlag0 = false;
  final _formmainKey = GlobalKey<FormState>();
  static List<String> videoList = [null];
  var vidoname=null;
  var myFormat = DateFormat('yyyy/MM/dd');
  var myFormatEndDate = DateFormat('yyyy/MM/dd');
  var myFormatTimeFrameDate = DateFormat('yyyy/MM/dd');
  var categoryfollowinglist;
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
  Position _currentPosition;
  String _currentAddress;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  String _emailother, _name, _mobile, _subject, _descriptionother;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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


  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() async {
        _currentPosition = position;
        final coordinates = new Coordinates(_currentPosition.latitude,_currentPosition.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        setState(() {
          print("Locality: "+first.locality.toString()+ " subLocality:"+ first.subLocality.toString()+" addressLine:"+ first.addressLine.toString()
              +" adminArea:"+ first.adminArea.toString()+" featureName:"+ first.featureName.toString()+" subAdminArea:"+ first.subAdminArea.toString());
          _currentAddress = first.addressLine.toString();
          LocationDetailsController.text = _currentAddress.toString();
          LocationController.text = first.locality.toString();
        });
      });


    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getData(String a,String search) async {
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
       // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
      //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (jsonResponse != null) {
          setState(() {
            categoryfollowinglist = jsonResponse['result'];
          });
        } else {
        //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Fluttertoast.showToast(
              msg: jsonResponse["message"],
              backgroundColor: Colors.black,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              timeInSecForIosWeb: 1,
            );
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



  Timeframe(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: timeframedate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != timeframedate)
      setState(() {
        timeframedate = picked;
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
      },);
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
        if(selectedTime=="")
          {
            selectedTime = TimeOfDay.now().toString().substring(10, 15);
          }
        else
          {
            selectedTime = _tim;
          }

      });
  }

  Future<void> _showEndTimePicker() async {
    final TimeOfDay picked = await showTimePicker(
      context: context, initialTime: TimeOfDay.now(),builder: (BuildContext context, Widget child) {
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


        if(selectedEndTime=="")
        {
          selectedEndTime = TimeOfDay.now().toString().substring(10, 15);
        }
        else
        {
          selectedEndTime = _timend;
        }
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

            errorDialog("upload upto 3 images");
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ],
      //here you can add any of extention what you need to pick
    );

    if (file != null) {
      setState(() {
        file1 = file;
        //file1 is a global variable which i created
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
          documentsController.text =catname;
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


  void createproject(
      BuildContext context,
      String projectname,
      String description,
      String startdate,
      String enddate,
      String starttime,
      String endtime,
      String location,
      String locationdetails,
      String ticketcontct,
      String ticketemail,
      String timeframedate,
      String cost,
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
    var request = http.MultipartRequest("POST", Uri.parse(Network.BaseApi + Network.create_ticket));
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["event_name"] = projectname.toString();
    request.fields["description"] = description.toString();
    request.fields["event_startdate"] = startdate.toString();
    request.fields["event_enddate"] = enddate;
    request.fields["event_starttime"] = starttime.toString();
    request.fields["event_endtime"] = endtime.toString();
    request.fields["ticket_email"] = ticketemail.toString();
    request.fields["timeframe_for_sale"] = timeframedate;
    request.fields["ticket_cost"] = cost;
    request.fields["who_can_see"] = currentid.toString();
    request.fields["video_link"] = video.toString();
    request.fields["special_terms_conditions"] = terms.toString();
    request.fields["userid"] = userid.toString();
    request.fields["members"] = connection.toString();
    request.fields["name"] = name.toString();
    request.fields["email"] = email.toString();
    request.fields["mobile"] = mobile.toString();
    request.fields["conatact_number"] = ticketcontct.toString();
    request.fields["maximum_qty_sold"] = maxparti.toString();
    request.fields["location"] = location.toString();
    request.fields["location_details"] = locationdetails.toString();
    request.fields["message"] = message.toString();
    request.fields["sendername"] = username.toString();

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
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TicketOngoingEvents()), (route) => false);
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
      }else if (response.statusCode == 422) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonData["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
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
                                      TicketOngoingEvents()));
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
                        StringConstant.createnewticket,
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
                      child:
                    Column(
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
                                  showAlert();
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
                            StringConstant.eventname,
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
                                return "Please enter event name";
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
                            StringConstant.eventdescription,
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
                                      return "Please enter event description";
                                    else
                                      return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(DateFocus);
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
                                                  3,
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
                                                    3,
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
                                                    5,
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
                                                    5,
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
                                                    myFormatEndDate.format(currentEndDate),
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            top: SizeConfig.blockSizeVertical *
                                                2),
                                        child: Text(
                                          StringConstant.starttime,
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
                                          _showTimePicker();
                                        },
                                        child: Container(
                                          height:
                                              SizeConfig.blockSizeVertical * 8,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                1,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
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
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    33,
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1),
                                                child: Text(
                                                  selectedTime == ""
                                                      ? TimeOfDay.now().toString().substring(10, 15)
                                                      : selectedTime,
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
                                                  Icons.alarm,
                                                  color: AppColors.greyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
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
                                          StringConstant.endtime,
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
                                          _showEndTimePicker();
                                        },
                                        child: Container(
                                          height:
                                              SizeConfig.blockSizeVertical * 8,
                                          margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical * 1,
                                            left: SizeConfig.blockSizeHorizontal * 2,
                                            right: SizeConfig.blockSizeHorizontal * 3,
                                          ),
                                          padding: EdgeInsets.only(
                                            left: SizeConfig.blockSizeVertical * 1,
                                            right: SizeConfig.blockSizeVertical * 1,
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
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    33,
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1),
                                                child: Text(
                                                  selectedEndTime ==""
                                                      ? TimeOfDay.now().toString().substring(10, 15)
                                                      : selectedEndTime,
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
                                                  Icons.alarm,
                                                  color: AppColors.greyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
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
                        GestureDetector(
                          onTap: (){
                            _getCurrentLocation();
                          },
                          child: Container(
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
                                    StringConstant.location,
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
                                      left: SizeConfig.blockSizeHorizontal *
                                          3,
                                      right:
                                      SizeConfig.blockSizeHorizontal *
                                          2,
                                      top:
                                      SizeConfig.blockSizeVertical * 1),
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
                                    focusNode: LocationFocus,
                                    controller: LocationController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                    TextInputType.streetAddress,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter location";
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(
                                          LocationDetailsFocus);
                                    },
                                    onSaved: (val) => _location = val,
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
                          ),
                        ),
                        Container(
                           // width: SizeConfig.blockSizeHorizontal * 50,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 2),
                                  child: Text(
                                    StringConstant.locationdetails,
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
                                    left:
                                    SizeConfig.blockSizeVertical * 1,
                                    right:
                                    SizeConfig.blockSizeVertical * 1,
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
                                  child: TextFormField(
                                    autofocus: false,
                                    focusNode: LocationDetailsFocus,
                                    controller: LocationDetailsController,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 3,
                                    keyboardType:
                                    TextInputType.streetAddress,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter location details";
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(ContactNoFocus);
                                    },
                                    onSaved: (val) =>
                                    _locationdetails = val,
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
                            )),
                       /* Container(
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
                                        StringConstant.location,
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
                                          left: SizeConfig.blockSizeHorizontal *
                                              3,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                          top:
                                              SizeConfig.blockSizeVertical * 1),
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
                                        focusNode: LocationFocus,
                                        controller: LocationController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: (val) {
                                          if (val.length == 0)
                                            return "Please enter location";
                                          else
                                            return null;
                                        },
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context).requestFocus(
                                              LocationDetailsFocus);
                                        },
                                        onSaved: (val) => _location = val,
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
                                          StringConstant.locationdetails,
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
                                          left: SizeConfig.blockSizeHorizontal *
                                              2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                        padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.blockSizeVertical * 1,
                                          right:
                                              SizeConfig.blockSizeVertical * 1,
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
                                        child: TextFormField(
                                          autofocus: false,
                                          focusNode: LocationDetailsFocus,
                                          controller: LocationDetailsController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          validator: (val) {
                                            if (val.length == 0)
                                              return "Please enter location details";
                                            else
                                              return null;
                                          },
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(ContactNoFocus);
                                          },
                                          onSaved: (val) =>
                                              _locationdetails = val,
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
                                  ))
                            ],
                          ),
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
                                          right:SizeConfig.blockSizeHorizontal * 2,
                                          top: SizeConfig.blockSizeVertical * 2),
                                      child: Text(
                                        StringConstant.contactno,
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
                                          left: SizeConfig.blockSizeHorizontal * 3,
                                          right: SizeConfig.blockSizeHorizontal * 2,
                                          top: SizeConfig.blockSizeVertical * 1),
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
                                        focusNode: ContactNoFocus,
                                        controller: ContactNoController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
                                        validator: (val) {
                                          if (val.length == 0)
                                            return "Please enter mobile number";
                                          else if (val.length != 10)
                                            return "Please enter valid mobile number";
                                          else
                                            return null;
                                        },
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context).requestFocus(EmailFocus);
                                        },
                                        onSaved: (val) => _contactno = val,
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
                                          StringConstant.email,
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
                                          left: SizeConfig.blockSizeHorizontal *
                                              2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                        padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.blockSizeVertical * 1,
                                          right:
                                              SizeConfig.blockSizeVertical * 1,
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
                                        child: TextFormField(
                                          autofocus: false,
                                          focusNode: EmailFocus,
                                          controller: EmailController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (val) {
                                            if (val.length == 0)
                                              return "Please enter email";
                                            else if (!regex.hasMatch(val))
                                              return "Please enter valid email";
                                            else
                                              return null;
                                          },
                                          onFieldSubmitted: (v) {
                                            EmailFocus.unfocus();
                                          },
                                          onSaved: (val) => _email = val,
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
                                StringConstant.timeframeforsale,
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
                                    Timeframe(context);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 30,
                                        child: Text(
                                          myFormatTimeFrameDate.format(timeframedate),
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
                                        width:
                                            SizeConfig.blockSizeHorizontal * 5,
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
                                StringConstant.costofticket,
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
                                        child: TextFormField(
                                          autofocus: false,
                                          focusNode: CostofTicketFocus,
                                          controller: CostofTicketController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val.length == 0)
                                              return "Please enter cost of ticket";
                                            else
                                              return null;
                                          },
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context).requestFocus(
                                                MaximumNoofquantityFocus);
                                          },
                                          onSaved: (val) => _costofTicket = val,
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
                                StringConstant.maximumquatity,
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
                                focusNode: MaximumNoofquantityFocus,
                                controller: MaximumNoofquantityController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter Muximum qty";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(VideoFocus);
                                },
                                onSaved: (val) => _maximumNoofquantity = val,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  top: SizeConfig.blockSizeVertical * 2),
                              width: SizeConfig.blockSizeHorizontal * 15,
                              child: Text(
                                StringConstant.video,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                           /* Container(
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
                              child:

                              TextFormField(
                                autofocus: false,
                                focusNode: VideoFocus,
                                controller: VideoController,
                                maxLines: 6,
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
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 4,
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            "videos link with comma(,) seprated, without space",
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
                                  onTap: ()
                                  {

                                  },
                                  child: Row(
                                    children: [
                                     /* Container(
                                        width: SizeConfig.blockSizeHorizontal * 60,
                                        child:
                                       *//* Text(
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
                                        ),*//*
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
                                        )
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
                                                          "Remove",
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
                                      GestureDetector(
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
                                      )
                                    ],
                                  ),
                                )
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
                                StringConstant.showpostevent,
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
                                      if (currentSelectedValue == "Anyone") {
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
                            ? inviteView()
                            : currentSelectedValue.toString().toLowerCase() ==
                                    "others"
                                ? otherOptionview()
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
                          /*  final input2 = videoList.toString();
                            final removedBrackets = input2.substring(1, input2.length - 1);
                            final parts = removedBrackets.split(',');
                            vidoname = parts.map((part) => "$part").join(',').trim();
                            print("Vidoname: "+vidoname.toString());*/


                            if (_formmainKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Internet_check().check().then((intenet) {
                                if (intenet != null && intenet) {
                                  if(_imageList.isNotEmpty)
                                  {
                                    if(followingvalues ==null)
                                    {
                                      createproject(
                                          context,
                                          EventNameController.text,
                                          DescriptionController.text,
                                          myFormat.format(currentDate),
                                          myFormatEndDate.format(currentEndDate),
                                          selectedTime,
                                          selectedEndTime,
                                          LocationController.text,
                                          LocationDetailsController.text,
                                          ContactNoController.text,
                                          EmailController.text,
                                          myFormatTimeFrameDate.format(timeframedate),
                                          CostofTicketController.text,
                                          MaximumNoofquantityController.text,
                                          TermsController.text,
                                          emailController.text,
                                          nameController.text,
                                          mobileController.text,
                                          messageController.text,
                                          "",
                                          VideoController.text,
                                          _imageList,
                                          _documentList);
                                    }
                                    else{
                                      createproject(
                                          context,
                                          EventNameController.text,
                                          DescriptionController.text,
                                          myFormat.format(currentDate),
                                          myFormatEndDate.format(currentEndDate),
                                          selectedTime,
                                          selectedEndTime,
                                          LocationController.text,
                                          LocationDetailsController.text,
                                          ContactNoController.text,
                                          EmailController.text,
                                          myFormatTimeFrameDate.format(timeframedate),
                                          CostofTicketController.text,
                                          MaximumNoofquantityController.text,
                                          TermsController.text,
                                          emailController.text,
                                          nameController.text,
                                          mobileController.text,
                                          messageController.text,
                                          followingvalues.toString(),
                                          VideoController.text,
                                          _imageList,
                                          _documentList
                                      );
                                    }
                                  }
                                  else {
                                    errorDialog("Please Select Ticket Images");
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
                    )),
                  ),
                ),
              )
            ],
          )),
    );
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
          GestureDetector(
            onTap: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                Internet_check().check().then((intenet) {
                  if (intenet != null && intenet) {
                    if (_imageFile != null) {
                      sendInvitation(emailController.text, nameController.text,
                          mobileController.text, messageController.text);
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

  sendInvitation(String emal, String name, String mobile, String descr) async {
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
                  width: SizeConfig.blockSizeHorizontal * 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        getData(userid, value);
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
                        hintText: "Search..."),
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
                      .contains(categoryfollowinglist[index]['connection_id']),
                  onChanged: (bool selected) {
                    _onCategoryFollowingSelected(
                        selected,
                        categoryfollowinglist[index]['connection_id'],
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
        ));
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
  Widget build(BuildContext context)
  {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = CreateTicketPostState.videoList[widget.index] ??'';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => CreateTicketPostState.videoList[widget.index] = v,
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
        if (v.trim().isEmpty)
          return 'Please enter something';
        return null;
      },
    );
  }
}