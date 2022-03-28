import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaign.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/MyActivity/MyActivities.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/sendrequestgift/OngoingSendReceived.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class payment extends StatefulWidget {
  final String data;
  final String amount;
  final String coming;
  final String backto;

  const payment(
      {Key key,
      @required this.data,
      @required this.amount,
      @required this.coming,
      @required this.backto})
      : super(key: key);

  @override
  _payment createState() => _payment();
}

class _payment extends State<payment> {
  var isFlutterInAppWebViewReady = false;

// InAppWebViewController _webViewController;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool internet = false;
  String data1;
  String amount1;
  String coming1;
  String backto1;
  String userid;
  String url;

  @override
  void initState() {
    super.initState();

    setState(() {
      SharedUtils.readloginId("UserId").then((val) {
        print("UserId: " + val);
        userid = val;
        data1 = widget.data;
        amount1 = widget.amount;
        coming1 = widget.coming;
        backto1 = widget.backto;
        print("receiverdata1: " + data1.toString());
        print("receiveramount1: " + amount1.toString());
        print("receivercoming1: " + coming1.toString());
        print("receiverbackto1: " + backto1.toString());
        print("UserId: " + userid);
        print("Payment details:-" +
            Network.payment +
            amount1 +
            "/" +
            data1 +
            "/" +
            coming1 +
            "/" +
            userid);
        setState(() {
          url = Network.payment +
              amount1 +
              "/" +
              data1 +
              "/" +
              coming1 +
              "/" +
              userid;
          print('url is : '+url);
        });

      });


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
  Widget build(BuildContext context) {
    //  print("Payment Url:-"+Network.BaseApiPayment+'paymentnid='+'D'+details.paymentnid+'&cust_phone='+details.custPhone+'&amount='+details.amount.toString()+'&orderno='+'EZ'+details.orderno.toString()+'&paymentdescription='+details.paymentdescription+'&cust_name='+details.custName+'&cust_email='+details.custEmail);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Payment'),
          backgroundColor: AppColors.themecolor,
        ),
        body: Builder(builder: (BuildContext context) {
          return


            WebView(
            initialUrl:  Network.payment +
                amount1.toString() +
                "/" +
                data1 +
                "/" +
                coming1 +
                "/" +
                userid,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) =>
                _controller.complete(webViewController),
            /*onPageFinished: (String url) {
              *//*if (url == Network.payment+amount1+"/"+data1+"/"+coming1+"/"+userid) {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
              }*//*
            },*/
            navigationDelegate: (NavigationRequest request) {
              print('request 1 : ' + request.toString());
              print('request  2 :' + request.url.toString());

              // if (request.url.startsWith('http://kontribute.biz/paypal_status')) {
              if (request.url
                  .startsWith('https://kontribute.biz/paypal_status')) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));

                Fluttertoast.showToast(
                    msg: "Payment Successful",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1);

                /*   Future.delayed(Duration(seconds: 1),()
                    {
                      Navigator.of(context).pop();
                    });*/

              }

              // else if (request.url.startsWith('http://kontribute.biz/paypal_statusfail'))
              else if (request.url
                  .startsWith('https://kontribute.biz/paypal_statusfail')) {
                Fluttertoast.showToast(
                    msg: "Payment Fail",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1);


           /*
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                });
                */



              }
              return NavigationDecision.navigate;
            },
          );
        }));

    /*  Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (coming1.toString() == "myactivity") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyActivities()));
                        } else if (coming1.toString() == "pjt") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingProject()));
                        } else if (coming1.toString() == "gift") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingSendReceived()));
                        }
                        else if (coming1.toString() == "dnt") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingCampaign()));
                        } else if (coming1.toString() == "evt") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingEvents()));
                        } else if (coming1.toString() == "tkt") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingEvents()));
                        }
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
                      'payment'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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

            Container(
              height: SizeConfig.blockSizeVertical *80,
              child:


              InAppWebView(
                  initialUrl: Network.payment+amount1+"/"+data1+"/"+coming1+"/"+userid,
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      debuggingEnabled: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;

                    controller.addJavaScriptHandler(handlerName: 'handlerFoo', callback: (args) async{
                      print(args.length.toString());
                      print("Arg: "+args.toString());
                    });
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    print("onLoadStart popup $url");
                  },
                  onLoadStop: (InAppWebViewController controller, String url) {
                    print("onLoadStop popup $url");

                  },
                  androidOnPermissionRequest: (InAppWebViewController controller,
                      String origin, List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  }),
            ),
          ],
        ),
      ),

    );*/
  }
}
