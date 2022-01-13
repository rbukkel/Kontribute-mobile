import 'dart:convert';
import 'package:kontribute/Ui/Donation/OngoingCampaignDetailsscreen.dart';
import 'package:kontribute/Ui/Events/OngoingEventsDetailsscreen.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEventsDetailsscreen.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Ui/CustomIndicator.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/LocaleString.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProjectDetailsscreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double percent = 0.0;
  String token = '';
  int _counter=0;
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging();
  String product_id;
  bool isId=false;
  bool Project=false;
  bool Donation=false;
  bool Event = false;
  bool Ticket = false;

  String _appBadgeSupported = 'Unknown';

  gettoken() {
    _firebaseMessaging.getToken().then((onValue) {
      setState(() {
        token = onValue;
        SharedUtils.saveToken("Token", token);

        print(token);
      });
    }).catchError((onError) {
      token = onError.toString();
      setState(() {});
    });
   // FlutterAppBadger.updateBadgeCount(1);
  }


  @override
  void initState() {
    gettoken();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        FlutterAppBadger.updateBadgeCount(1);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        FlutterAppBadger.removeBadge();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NotificationScreen()), (route) => false);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    super.initState();

    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("token: " + token.toString());
    });

    initPlatformState();
    Timer timer;
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        percent += 1;
        if (percent >= 2) {
          timer.cancel();
          getVersionCode();

        }
      });
    });
    //callSharedData();
  }

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }




  void nextScreen() {
    SharedUtils.writeloginData("login").then((result){
      if(result!=null){
        if(result){
          print("trueValue");
          initDynamicLinks();
          Future.delayed(Duration(seconds: 3),()
          {
            print('hereid'+isId.toString());
                 if(isId){

                   print("Project: "+Project.toString());
                   print("Donation: "+Donation.toString());
                   if(Project == true)
                   {
                     print("Product");
                     callNext(
                         OngoingProjectDetailsscreen(
                             data:
                             product_id
                                 .toString(),
                             coming:"main"
                         ), context);
                   }
                   else if(Donation == true)
                   {
                     print("Donation");

                     callNext(
                         OngoingCampaignDetailsscreen(
                           data: product_id.toString(),
                           coming: "main",
                         ), context);
                   } else if(Event == true)
                   {
                     print("Event");

                     callNext(OngoingEventsDetailsscreen(
                           data: product_id.toString(),
                           coming: "main",
                         ), context);
                   }else if(Ticket == true)
                   {
                     print("Ticket");

                     callNext(TicketOngoingEventsDetailsscreen(
                           data: product_id.toString(),
                           coming: "main",
                         ), context);
                   }

                 }
                 else {
                  /* if (lang == 'English') {
                     var locale = Locale('en', 'US');
                     SharedUtils.saveLangaunage("Langauge", lang);
                     Get.updateLocale(locale);
                   } else if (lang == 'Arabic') {
                     var locale = Locale('ar', 'SA');
                     SharedUtils.saveLangaunage("Langauge", lang);
                     Get.updateLocale(locale);
                   }*/

                   SharedUtils.readLangaunage("Langauge").then((val) {
                    // print("Langauge: " + val);

                     if(val == null || val =="")
                       {
                         var locale = Locale('en', 'US');
                         Get.updateLocale(locale);
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                       }
                     else{
                       String langu = val;
                       print("Login Langauge: " + langu.toString());
                       if(langu =="Arabic")
                       {
                         var locale = Locale('ar', 'SA');
                         Get.updateLocale(locale);
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                       }
                       else if(langu =="English")
                       {
                         var locale = Locale('en', 'US');
                         Get.updateLocale(locale);
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                       }
                       else
                       {
                         var locale = Locale('en', 'US');
                         Get.updateLocale(locale);
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                       }
                     }
                   });
                 }
         //
          });
        }else{
          print("falseValue");
          Future.delayed(Duration(seconds: 3),()
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CustomIndicator()), (route) => false);
          });
        }
      }else{
        print("falseValue");
        Future.delayed(Duration(seconds: 3),()
        {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CustomIndicator()), (route) => false);
        });
      }
    });
  }

  void initDynamicLinks() async {
    print('new deep link onLink******');
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink.link;
          if (deepLink != null) {
            print('new deep link onLink******${deepLink}');
            List<String> product_id_list = split(deepLink.toString(), "/");
            print("URL: "+deepLink.toString());
            print("URLid: "+product_id_list.toString());

            setState(() {

              product_id = product_id_list.elementAt(5);
              isId=true;

              print('product_id1'+product_id);
            });
            String linked = deepLink.toString();
            print("linked: "+linked);
            if(linked.contains("https://kontribute.biz/api/sharedproduct/"))
            {
              setState(() {
                Project= true;
                Donation= false;
                Event= false;
                Ticket= false;
              });
              print("Product");
            }
            else if(linked.contains("https://kontribute.biz/api/shareddonation/")) {
              setState(() {
                Project = false;
                Donation = true;
                Event= false;
                Ticket= false;
              });
              print("donation");
            }else if(linked.contains("https://kontribute.biz/api/sharedevent/")) {
              setState(() {
                Project = false;
                Donation = false;
                Event= true;
                Ticket= false;
              });
              print("Events");
            }else if(linked.contains("https://kontribute.biz/api/sharedticket/")) {
              setState(() {
                Project = false;
                Donation = false;
                Event= false;
                Ticket= true;
              });
              print("Tickets");
            }

          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });



    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    if(data.link!=null)
      {
        final Uri deepLink = data.link;
        if (deepLink != null) {
          print('---new deep found************************************************${deepLink}');
          List<String> product_id_list = split(deepLink.toString(), "/");
          print("URLid: "+product_id_list.toString());
          print("URL: "+deepLink.toString());
          setState(() {
            product_id = product_id_list.elementAt(5);
            isId=true;

            print('product_id2'+product_id);
          });
          String linked = deepLink.toString();
          print("linked: "+linked);
          if(linked.contains("https://kontribute.biz/api/sharedproduct/"))
          {
            setState(() {
              Project= true;
              Donation= false;
              Event= false;
              Ticket= false;
            });
            print("Product");
          }
          else if(linked.contains("https://kontribute.biz/api/shareddonation/"))
          {
            setState(() {
              Project= false;
              Donation= true;
              Event= false;
              Ticket= false;
            });
            print("donation");
          }else if(linked.contains("https://kontribute.biz/api/sharedevent/")) {
            setState(() {
              Project = false;
              Donation = false;
              Event= true;
              Ticket= false;
            });
            print("Events");
          }else if(linked.contains("https://kontribute.biz/api/sharedticket/")) {
            setState(() {
              Project = false;
              Donation = false;
              Event= false;
              Ticket= true;
            });
            print("Tickets");
          }

        }
      }
  }

  List<String> split(String string, String separator, {int max = 0}) {
    var result = List<String>();
    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }
      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));*/
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en','US'),
      home: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.whiteColor,
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                height: 450,
                width: 250,
              ),
              Container(
                margin:
                EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 15,
                    right: SizeConfig.blockSizeHorizontal * 15),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 10.0,
                  animationDuration: 3000,
                  percent: 1.0,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  linearGradient:  LinearGradient(
                    colors: <Color>[AppColors.green, AppColors.parentgreen],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    checkVersion(version);
    print("VersionCode: "+version.toString());
    print("Code: "+code.toString());
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


  checkVersion(String version1) async {
    Map data = {
      'version': version1.toString(),
    };
    print("Social: "+data.toString());
    var jsonResponse = null;
    var response =
    await http.post(Network.BaseApi + Network.versioncheck, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["success"] == false) {

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
                      jsonResponse["message"],
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      StoreRedirect.redirect(
                        androidAppId: "com.kont.kontribute",
                        //  iOSAppId: "585027354"
                      );
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
      else {
        if (jsonResponse != null) {
          nextScreen();
        //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => selectlangauge()), (route) => false);
        } else {
          errorDialog(jsonResponse["message"]);
        }
      }
    }
    else {
      errorDialog(jsonResponse["message"]);
    }
  }


}
