import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/ReportTicketPojo.dart';
import 'package:kontribute/Ui/Donation/donation.dart';
import 'package:kontribute/Ui/Tickets/tickets.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class TicketReport extends StatefulWidget {
  final String data;

  const TicketReport({Key key, @required this.data})
      : super(key: key);
  @override
  TicketReportState createState() => TicketReportState();
}

class TicketReportState extends State<TicketReport> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  final CommentFocus = FocusNode();
  final TextEditingController CommentController = new TextEditingController();
  String _Comment;
  String id;
  String userid;
  bool internet = false;
  String valPost;
  ReportTicketPojo reportcommentPojo;

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
        id = widget.data;
        print("ID: "+id);
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
                    createUpperBar(context, "Report"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child:Form(
                    key: _formKey,
                    child:  Column(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            "Add Comments: ",
                            maxLines: 2,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black26,
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular'),
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
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeVertical * 1,
                            right: SizeConfig.blockSizeVertical * 1,
                          ),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            autofocus: false,
                            focusNode: CommentFocus,
                            controller: CommentController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            validator: (val) {
                              if (val.length == 0)
                                return "Please enter comment";
                              else
                                return null;
                            },
                            onFieldSubmitted: (v) {
                              CommentFocus.unfocus();
                            },
                            onSaved: (val) => _Comment = val,
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
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 12,
                                decoration: TextDecoration.none,
                              ),
                              hintText: "Add a comment...",
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
                          onTap: ()
                          {
                           addReport(CommentController.text);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 5,
                                top: SizeConfig.blockSizeVertical * 1),
                            child: Text(
                              "Post",
                              maxLines: 2,
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: AppColors.themecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              )
            ],
          )
      ),
    );
  }


  Future<void> addReport(String post) async {
    Map data = {
      'userid': userid.toString(),
      'ticket_id': id.toString(),
      'comment': post.toString(),
    };

    Dialogs.showLoadingDialog(context, _keyLoader);
    print("projectPOst: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.reportticket, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valPost = response.body; //store response as string
      if (jsonDecode(valPost)["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Fluttertoast.showToast(
          msg: jsonDecode(valPost)["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        reportcommentPojo = new ReportTicketPojo.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          Fluttertoast.showToast(
            msg: reportcommentPojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          CommentController.text =null;
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => tickets()));
        } else {
          Fluttertoast.showToast(
            msg: reportcommentPojo.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonDecode(valPost)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }


}
