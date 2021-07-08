import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/Ui/sendreceivegifts.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class ContactUs extends StatefulWidget{
  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUs>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final NameFocus = FocusNode();
  final EmailFocus = FocusNode();
  final MobileFocus = FocusNode();
  final SubjectFocus = FocusNode();
  final DescriptionFocus = FocusNode();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();

  String _email,_name,_mobile,_subject,_description;
  bool showvalue = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Drawer_Screen(),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
        Container(
        height: SizeConfig.blockSizeVertical *12,
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
            width: 20,height: 20,
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top: SizeConfig.blockSizeVertical *2),
                child:
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/images/menu.png",color:AppColors.whiteColor,width: 20,height: 20,),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal *60,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                // margin: EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  "Contact Us", textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat",
                      color: Colors.white),
                ),
              ),
              Container(
                width: 25,height: 25,
                margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical *2),

              ),
            ],
          ),
        ),
            Expanded(
                child: SingleChildScrollView(
                  child:  Column(
                    children: [
                  Container(
                  height: SizeConfig.blockSizeVertical *30,
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *10,right: SizeConfig.blockSizeHorizontal *10,
                      top: SizeConfig.blockSizeVertical *2,),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/contct.png"),
                        fit: BoxFit.fill,
                      ),
                    ),

                    ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,
                            right: SizeConfig.blockSizeHorizontal*5,
                            top: SizeConfig.blockSizeVertical*2),
                        height: SizeConfig.blockSizeVertical*70,
                        child: Card(
                          child: Form(
                            key:_formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    focusNode: EmailFocus,
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
                                    onSaved: (val) => _email= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(NameFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: "Your Email*",
                                      labelStyle:TextStyle(
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
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:
                                  TextFormField(
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
                                    onSaved: (val) => _name= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(MobileFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: "Your Name*",
                                      labelStyle:TextStyle(
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
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*7 ,
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  child:  TextFormField(
                                    autofocus: false,
                                    focusNode: MobileFocus,
                                    controller: mobileController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter mobile number";
                                      else if (val.length <= 10)
                                        return "Your mobile number should be 10 char long";
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _mobile= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(SubjectFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                    fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: "Phone Number*",
                                      labelStyle:TextStyle(
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
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*10 ,
                                  width: SizeConfig.blockSizeHorizontal*80,

                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    maxLines:2,
                                    focusNode: SubjectFocus,
                                    controller: subjectController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter subject";
                                      else if (val.length < 3)
                                        return "subject must be more than 2 charater";
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _subject= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(DescriptionFocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: "Subject",
                                      labelStyle:TextStyle(
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
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  height: SizeConfig.blockSizeVertical*15 ,
                                  width: SizeConfig.blockSizeHorizontal*80,

                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    maxLines: 3,
                                    focusNode: DescriptionFocus,
                                    controller: descriptionController,
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
                                    onSaved: (val) => _description= val,
                                    onFieldSubmitted: (v) {
                                      DescriptionFocus.unfocus();
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0,  color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins-Regular',),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: "Your Message",
                                      labelStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins-Regular',
                                        decoration: TextDecoration.none,
                                      ),

                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *1,
                                      left: SizeConfig.blockSizeHorizontal*3,
                                      right: SizeConfig.blockSizeHorizontal*5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        color: Colors.white,
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
                                        child: Text(StringConstant.sendingmeesageyou,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',)),
                                      ),

                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                   /* Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => selectlangauge()),
                                            (route) => false);*/
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 38,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3,
                                      bottom: SizeConfig.blockSizeVertical * 2,
                                      left: SizeConfig.blockSizeHorizontal *5,
                                      right: SizeConfig.blockSizeHorizontal *5

                                    ),
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: new AssetImage("assets/images/sendbutton.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(StringConstant.send,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 15,
                                            )),
                                        Container(
                                          child:IconButton(icon: Icon(Icons.arrow_forward,color: AppColors.whiteColor,), onPressed: () {}),
                                        )

                                      ],
                                    )


                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )

            )
          ],
        ),
      ),
    );
  }

}