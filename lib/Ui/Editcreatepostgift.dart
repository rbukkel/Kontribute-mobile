import 'package:flutter/material.dart';
import 'package:kontribute/Common/fab_bottom_app_bar.dart';
import 'package:kontribute/Ui/AddScreen.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/NotificationScreen.dart';
import 'package:kontribute/Ui/SettingScreen.dart';
import 'package:kontribute/Ui/WalletScreen.dart';
import 'package:kontribute/Ui/sendrequestgift/Createpool.dart';
import 'package:kontribute/Ui/sendrequestgift/EditRequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/EditSendIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/RequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/SendIndividaul.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class Editcreatepostgift extends StatefulWidget {
  final String indexvalue;
  final String data;

  const Editcreatepostgift({Key key, @required this.indexvalue,@required this.data})
      : super(key: key);
  @override
  EditcreatepostgiftState createState() => EditcreatepostgiftState();
}

class EditcreatepostgiftState extends State<Editcreatepostgift> {
  String tabvalue = "Request";
  bool request = false;
  bool send = false;
  bool create = false;
  int tabIndex;
  String data1;
  String indexvalue1;

  @override
  void initState() {
    super.initState();

    data1 = widget.data;
    indexvalue1 = widget.indexvalue;
    print("ID: "+data1);
    print("indexvalue: "+indexvalue1);
   if(indexvalue1 =="request")
     {
       tabIndex = 0;
     } else if(indexvalue1 =="pool")
   {
     tabIndex = 2;
   }
   else if(indexvalue1 =="send")
   {
     tabIndex = 1;
   }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 3,
      initialIndex: tabIndex,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Container(
            child: Text(
              StringConstant.createnewgift,
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

          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/sendindividaul.png",
                          color: AppColors.whiteColor,
                          width: 18,
                          height: 18,
                        ),
                        Text(StringConstant.requestindividaul,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 10))
                      ],
                    )),
              ),
              Tab(
                child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/sendindividaul.png",
                          color: AppColors.whiteColor,
                          width: 18,
                          height: 18,
                        ),
                        Text(StringConstant.sendindividaul,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 10))
                      ],
                    )),
              ),
              Tab(
                child: Container(
                  alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/createpost.png",
                          color: AppColors.whiteColor,
                          width: 18,
                          height: 18,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(StringConstant.createpool,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 10)),
                        )

                      ],
                    )),
              ),
            ],
          ),
        ),

          body: Container(
              height: double.infinity,
             color: AppColors.whiteColor,
              child:
              TabBarView(
                children:[
                  EditRequestIndividaul(data: data1),
                  EditSendIndividaul(data: data1),
                  Createpool()
                ],
              ),

            ) ,

      ),
    );
  }
  Widget backgroundBGContainer() {
    return Container(
      color: AppColors.whiteColor,
    );
  }

}
