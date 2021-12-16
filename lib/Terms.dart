import 'package:flutter/material.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaign.dart';
import 'package:kontribute/Ui/Donation/SearchbarDonation.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/Events/SearchbarEvent.dart';
import 'package:kontribute/Ui/ProjectFunding/SearchbarProject.dart';
import 'package:kontribute/Ui/Tickets/SearchbarTicket.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

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
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,

          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'termsandcondition'.tr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins-Regular",
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
                  alignment: Alignment.centerLeft,
                  width: SizeConfig.blockSizeHorizontal *90,
                  child: Text(
                    '© 2016-2021 Dairy Management.All rights reserved.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal *90,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
                  child: Text(
                    'Dairy and the Dairy management logo are either registered trademarks or trademarks of Dairy in the United States and/or other countries. ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal *90,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
                  child: Text(
                    'Third Party notices, terms and conditions pertaining to third party software can be found at http://www.adobe.com/go/thirdparty_eula/ and are incorporated by reference. ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal *90,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
                  child: Text(
                    'Fonts will be sent to your device(s) when you preview on mobile. Please be aware that certain font vendors do not allow for the transfer, display and distribution of their fonts. You are responsible for ensuring that you respect the font license agreement between you and the applicable font vendor.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal *90,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,left: SizeConfig.blockSizeHorizontal *4,right: SizeConfig.blockSizeHorizontal *3),
                  child: Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
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
                        onTap: () {},
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
                      top: SizeConfig.blockSizeVertical * 5,
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
          ),


      ),
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

}