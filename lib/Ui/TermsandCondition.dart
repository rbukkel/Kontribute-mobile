import 'package:flutter/material.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'dart:async';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsandCondition extends StatefulWidget {
  @override
  TermsandConditionState createState() => TermsandConditionState();
}

class TermsandConditionState extends State<TermsandCondition> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 12,
        title:  Container(
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

        centerTitle: true,
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 12,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: ()
              {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *1,right: SizeConfig.blockSizeHorizontal *1),
                child: Icon(Icons.menu,color: Colors.white,),
              ),
            )
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),
      body:  Builder(builder: (BuildContext context) {
        return
          WebView(
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
          );
      }),
    );

  }
}