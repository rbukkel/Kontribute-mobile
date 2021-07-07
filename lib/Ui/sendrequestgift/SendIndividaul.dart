import 'package:flutter/material.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class SendIndividaul extends StatefulWidget{
  @override
  SendIndividaulState createState() => SendIndividaulState();

}

class SendIndividaulState extends State<SendIndividaul>{
  final SearchContactFocus = FocusNode();
  final requiredamountFocus = FocusNode();
  final DescriptionFocus = FocusNode();
  final TextEditingController searchcontactController =
  new TextEditingController();
  final TextEditingController requiredamountController =
  new TextEditingController();
  final TextEditingController DescriptionController =
  new TextEditingController();
  String _searchcontact;
  String _requiredamount;
  String _Description;
  bool showvalue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 45,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/banner1.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // showAlert();
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 21,
                              right: SizeConfig.blockSizeHorizontal*2),
                          child: Image.asset(
                            "assets/images/camera.png",
                            width:50,
                            height: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical * 2),
                      width: SizeConfig.blockSizeHorizontal * 32,
                      child: Text(
                        StringConstant.searchcontact,
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Bold'),
                      ),
                    ),
                    Container(
                        width: SizeConfig.blockSizeHorizontal * 60,
                        height: SizeConfig.blockSizeVertical * 7,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 2,
                            right: SizeConfig.blockSizeHorizontal * 2),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: TextFormField(
                                autofocus: false,
                                maxLines: 2,
                                focusNode: SearchContactFocus,
                                controller: searchcontactController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter search contact";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  SearchContactFocus.unfocus();
                                },
                                onSaved: (val) => _searchcontact = val,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 5,
                              child: Icon(
                                Icons.search,
                                color: AppColors.greyColor,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      top: SizeConfig.blockSizeVertical * 2),
                  child: Text(
                    StringConstant.message,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeVertical * 1,
                    right: SizeConfig.blockSizeVertical * 1,
                  ),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                  ),
                  child: TextFormField(
                    autofocus: false,
                    focusNode: DescriptionFocus,
                    maxLines: 4,
                    controller: DescriptionController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.length == 0)
                        return "Please enter message";
                      else
                        return null;
                    },
                    onFieldSubmitted: (v) {
                      DescriptionFocus.unfocus();
                    },
                    onSaved: (val) => _Description = val,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 15,
                        color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                      hintText: "Type here message...",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Text(StringConstant.receivenotification,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',
                            )),
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
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeVertical * 6,
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 3,
                        bottom: SizeConfig.blockSizeVertical * 3,
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 5),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/sendbutton.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Text(StringConstant.invite,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 15,
                        )),
                  ),
                )
              ],
            ),
          )),
    );
  }}