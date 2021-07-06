import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/Ui/ContactUs.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/Ui/mytranscation.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';

class Drawer_Screen extends StatefulWidget {
  @override
  _Drawer_ScreenState createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  bool imageUrl = false;
  bool _loading = false;
  String image;
  bool image_value = false;
  String username;
  String email;
  bool internet =false;
  int userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/nav_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Expanded(child: Stack(
             children: [

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Container(
                       margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,left: SizeConfig.blockSizeVertical*2),
                       child: Row(
                         children: [
                           Container(
                             alignment: Alignment.bottomLeft,
                             margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*1,left: SizeConfig.blockSizeHorizontal*1),
                             height: 70,width: 70,
                             child: Image.asset("assets/images/userProfile.png",height: 70,width: 70,),
                           ),
                         Container(
                               margin: EdgeInsets.only(left: SizeConfig.blockSizeVertical*2),
                               width:SizeConfig.blockSizeHorizontal*53,
                               child: Text("Micheal John",
                                 style: TextStyle(
                                     letterSpacing: 1.0,
                                     color: Colors.white,
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                     fontFamily: 'Poppins-Bold'),
                               ),),

                         ],
                       ),
                     ),
                     InkWell(
                       onTap: (){
                       drawer_function(1);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_home.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("Home",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         drawer_function(2);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_contactus.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("Contact Us",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                          drawer_function(3);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_invitation.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("Invitations",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         drawer_function(4);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_mytranscaton.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("My Transactions",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         //   drawer_function(1);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_faq.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("FAQ",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         //   drawer_function(1);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_termsconditon.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("Terms & Conditions",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         //   drawer_function(1);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/nav_share.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:20,),
                                 child: Text("Share",
                                   style: TextStyle(fontFamily: 'Poppins-Medium',color: AppColors.whiteColor),)),
                           ],
                         ),
                       ),
                     ),
                /*     InkWell(
                       onTap: (){
                         drawer_function(1);

                         // Navigator.pushReplacementNamed(context, pageRoutes.notification),
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *3,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/myprofile_nav.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left:10,),
                                 child: Text("My Profile",
                                   style: TextStyle(fontFamily: 'Poppins-Medium'),)),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         drawer_function(2);
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/cart_nav.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left: 10,),
                                 child: Text("Cart",style: TextStyle(fontFamily: 'Poppins-Medium'),)),
                           ],
                         ),
                       ),
                     ),


                     InkWell(
                       onTap: (){
                         drawer_function(3);
                       },
                       child: Container(
                         margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *4,
                             left:  SizeConfig.blockSizeVertical *5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               child: Image.asset(
                                 "assets/images/orderhistory_nav.png",
                                 height: 25,
                                 width: 25,
                               ),
                             ),
                             Container(
                               margin: EdgeInsets.only(left: 10,),
                               child: Text("Order History",style: TextStyle(fontFamily: 'Poppins-Medium'),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),*/
                   ],
                 ),

             ],
           ))
          ],
        ),
      ),
    );

  }
  void drawer_function(var next_screen) async{
    Navigator.pop(context);
    switch(next_screen){
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactUs(),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;
        case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mytranscation(),
          ),
        );
        break;
    }
  }
}
