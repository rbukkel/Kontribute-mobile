import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/TicketValidate.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class ScanQR extends StatefulWidget {
  final String data;

  const ScanQR(
      {Key key, @required this.data})
      : super(key: key);

  @override
  ScanQRState createState() => ScanQRState();
}

class ScanQRState extends State<ScanQR> {
  bool internet = false;
  String data1;
  String qrCodeResult = "Not Yet Scanned";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TicketValidate postcom;
  String valPost;

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
        setState(()
        {
          internet = false;
        });
        errorDialog('nointernetconnection'.tr);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themecolor,
        title: Text('scanqrcode'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              'result'.tr,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15),
              onPressed: () async {
                String codeSanner = await BarcodeScanner.scan(); //barcode scanner
                setState(() {
                  qrCodeResult = codeSanner;
                  print("Result: "+qrCodeResult.toString());
                });
              },
              child: Text('openscanner'.tr,style: TextStyle(color: AppColors.themecolor)),
              //Button having rounded rectangle border
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.themecolor),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          qrCodeResult=="Not Yet Scanned"?Container():
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 3),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                onPressed: () async {
                  setState(() {
                    validate(qrCodeResult.toString());
                  });
                },
                child: Text('validate'.tr,style: TextStyle(color: AppColors.themecolor),),
                //Button having rounded rectangle border
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.themecolor),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> validate(String tickt) async {
    Map data = {
      'ticket_no': tickt.toString(),
    };
    Dialogs.showLoadingDialog(context, _keyLoader);
    print("projectPost: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.ticket_authenticate, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      valPost = response.body; //store response as string
      if (jsonDecode(valPost)["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
       errorDialog(jsonDecode(valPost)["message"]);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        postcom = new TicketValidate.fromJson(jsonResponse);
        print("Json UserLike: " + jsonResponse.toString());
        if (jsonResponse != null) {
          print("responseLIke: ");
          errorDialog(postcom.message);

        } else {
          errorDialog(postcom.message);
        }
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonDecode(valPost)["message"]);
    }
  }
}
