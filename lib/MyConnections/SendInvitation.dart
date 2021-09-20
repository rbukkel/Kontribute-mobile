import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontribute/Drawer/drawer_Screen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class SendInvitation extends StatefulWidget{
  @override
  SendInvitationState createState() => SendInvitationState();
}

class SendInvitationState extends State<SendInvitation>{
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
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child:
        Form(
          key:_formKey,
            child: SingleChildScrollView(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                        right: SizeConfig.blockSizeHorizontal*2),
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical *20,
                        left: SizeConfig.blockSizeHorizontal*2,
                        right: SizeConfig.blockSizeHorizontal*2),

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
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal*2,
                        right: SizeConfig.blockSizeHorizontal*2),
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical *2,
                        left: SizeConfig.blockSizeHorizontal*2,
                        right: SizeConfig.blockSizeHorizontal*2),

                    child:
                    TextFormField(
                      autofocus: false,
                      maxLines:6,
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
                            top: SizeConfig.blockSizeVertical * 5,
                            bottom: SizeConfig.blockSizeVertical * 5,
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
                            Text(StringConstant.sharelink,
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
                  ),

               //   paymentdetails_length!=null?
                  Container(
                    alignment: Alignment.topLeft,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,  // remove whitespace from top of listview
                        itemCount: 8,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int idex) {
                          return Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical *3),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          72,
                                                      alignment: Alignment
                                                          .topLeft,
                                                      padding:
                                                      EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical *1,
                                                        left: SizeConfig
                                                            .blockSizeHorizontal *
                                                            1,
                                                      ),
                                                      child: Text(
                                                        "Sem",
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: Colors
                                                                .black87,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          20,
                                                      alignment: Alignment
                                                          .topRight,
                                                      padding:
                                                      EdgeInsets.only(
                                                        top: SizeConfig.blockSizeVertical *1,
                                                        left: SizeConfig
                                                            .blockSizeHorizontal *
                                                            1,
                                                        right: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3,
                                                      ),
                                                      child: Text(
                                                        "Status",
                                                        textAlign:
                                                        TextAlign
                                                            .right,
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color:
                                                            AppColors
                                                                .black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                         72,
                                                      alignment: Alignment
                                                          .topLeft,
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              1,
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              3,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      child: Text(
                                                        "9878675645",
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: Colors
                                                                .black87,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ),
                                                    //projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status=="0"?
                                                    Container(
                                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          20,
                                                      alignment: Alignment
                                                          .topRight,
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          bottom: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              20),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .orange)),
                                                      child: Text(
                                                        "Pending".toUpperCase(),
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: AppColors
                                                                .orange,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    )
                                                 /*       :projectdetailspojo.commentsdata.projectpaymentdetails.elementAt(idex).status=="1"?
                                                    Container(
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          20,
                                                      alignment: Alignment
                                                          .center,
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          bottom: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              20),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .orange)),
                                                      child: Text(
                                                        "Done".toUpperCase(),
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: AppColors
                                                                .orange,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    ):
                                                    Container(
                                                      width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          20,
                                                      alignment: Alignment
                                                          .topRight,
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          bottom: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                          top: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              20),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .orange)),
                                                      child: Text(
                                                        "Pending".toUpperCase(),
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            letterSpacing:
                                                            1.0,
                                                            color: AppColors
                                                                .orange,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'Poppins-Regular'),
                                                      ),
                                                    )*/
                                                  ],
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      72,
                                                  alignment: Alignment
                                                      .topLeft,
                                                  padding:
                                                  EdgeInsets.only(
                                                    bottom: SizeConfig.blockSizeVertical *1,
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),
                                                  child: Text(
                                                    "sem@gmail.com",
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.0,
                                                        color: Colors
                                                            .black87,
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight
                                                            .normal,
                                                        fontFamily:
                                                        'Poppins-Regular'),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                )),
                          );
                        }),
                  )
                    /*  :Container()*/


                ],
              ),
            ),
        ),
      ),
    );
  }

}