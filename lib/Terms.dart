import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaign.dart';
import 'package:kontribute/Ui/Donation/SearchbarDonation.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/Events/SearchbarEvent.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/register.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/Ui/ProjectFunding/SearchbarProject.dart';
import 'package:kontribute/Ui/Tickets/SearchbarTicket.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Ui/ProjectFunding/OngoingProject.dart';

class Terms extends StatefulWidget {
  final String data;

  const Terms({Key key, @required this.data}) : super(key: key);

  @override
  TermsState createState() => TermsState();
}

class TermsState extends State<Terms> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showvalue = false;
  String data1;
  bool internet = false;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    Internet_check().check().then((intenet) {
      if (intenet != null && intenet) {
        data1 = widget.data;
        print("receiverComing: " + data1.toString());

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


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          child: Text(
            'termsandcondition'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: "Poppins-Regular",
                color: Colors.white),
          ),
        ),
        //Text("heello", textAlign:TextAlign.center,style: TextStyle(color: Colors.black)),
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 22,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 7,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/images/back.png",
                    color: AppColors.whiteColor,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            )),
      ),
      body:  Builder(builder: (BuildContext context) {
        return


        Container(


          child:Column(
            children: [
              Container(
                height: SizeConfig.blockSizeHorizontal*130,
                child:WebView(
                  initialUrl: "https://kontribute.biz/public/html/t&c.html",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) => _controller.complete(webViewController),
                  /*  navigationDelegate: (NavigationRequest request) {
                      print(request);
                      print(request.url);
                      if (request.url.startsWith('http://kontribute.biz/paypal_status')) {
                        Fluttertoast.showToast(
                            msg: "Payment Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1
                        );
                        Future.delayed(Duration(seconds: 1),()
                        {
                          Navigator.of(context).pop();
                        });


                      } else if (request.url.startsWith('http://kontribute.biz/paypal_statusfail'))
                      {
                        Fluttertoast.showToast(
                            msg: "Payment Fail",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1
                        );
                        Future.delayed(Duration(seconds: 1),()
                        {
                          Navigator.of(context).pop();
                        });

                      }
                      return NavigationDecision.navigate;
                    },*/
                ),
              ),


              CheckTems()
            ],


          )


        );


      }),
     // bottomNavigationBar: CheckTems()

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
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left:10,right: 10,top: 20,bottom: 10),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
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

  CheckTems() {
    return
      Container(


        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: SizeConfig.blockSizeHorizontal * 100,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 2,
                top: SizeConfig.blockSizeVertical * 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      value: showvalue,
                      onChanged: (bool value) {
                        setState(() {
                          showvalue = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text('ihavereadandagreedtothe'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Montserrat')),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      child: Text(" " + 'termsconditions'.tr,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 11,
                              fontFamily: 'Montserrat')),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (showvalue) {
                  setState(() {
                    SharedUtils.writeTerms("Terms", true);
                    if(data1=="Project")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingProject()));
                    }else if(data1=="SearchProject")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchbarProject()));
                    }else if(data1=="Donation")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingCampaign()));
                    }else if(data1=="SearchDonation")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchbarDonation()));
                    }else if(data1=="Event")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingEvents()));
                    }else if(data1=="SearchEvent")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchbarEvent()));
                    }else if(data1=="Ticket")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TicketOngoingEvents()));
                    }else if(data1=="SearchTicket")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchbarTicket()));
                    }else if(data1=="Gift")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OngoingSendReceived()));
                    }else if(data1=="Notification")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationScreen()));
                    }else if(data1=="Register")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => register()));

                    }
                  });
                } else {
                  errorDialog('pleasechecktermscondition'.tr);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical * 10,
                padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  bottom: SizeConfig.blockSizeVertical * 2,
                  left: SizeConfig.blockSizeHorizontal * 12,
                  right: SizeConfig.blockSizeHorizontal * 12,
                ),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/btn.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text('done'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins-Regular',
                      fontSize: 15,
                    )),
              ),
            ),
          ],
        ),
      );
  }

}