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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  height: SizeConfig.blockSizeVertical *12,
                    child: Image.asset("assets/images/contactus.png",color:AppColors.whiteColor,width:SizeConfig.blockSizeHorizontal *12,height: SizeConfig.blockSizeVertical *12,),
                    ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,right: SizeConfig.blockSizeHorizontal*5,top: SizeConfig.blockSizeVertical*2),
                        height: SizeConfig.blockSizeVertical*170,
                        child: Card(
                          child: Form(
                            key:_formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    focusNode: Namefocus,
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
                                    onSaved: (val) => _fullname= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(Emailfocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Your Name",
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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    readOnly:true,
                                    focusNode: Emailfocus,
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
                                      FocusScope.of(context).requestFocus(Mobilefocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Your Email",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Mobile number",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:  TextFormField(
                                    autofocus: false,
                                    focusNode: Mobilefocus,
                                    controller: MobileController,
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
                                      FocusScope.of(context).requestFocus(StoreNamefocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Your Mobile",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Store name",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    focusNode: StoreNamefocus,
                                    controller: StoreNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter store name";
                                      else if (val.length < 3)
                                        return "Store name must be more than 2 charater";
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _storename= val,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(ShippigFeesfocus);
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Name of your store",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Shipping charges",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:  TextFormField(
                                    autofocus: false,
                                    focusNode: ShippigFeesfocus,
                                    controller: ShippigFeesController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter shipping charges";
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _shippigFees= val,
                                    onFieldSubmitted: (v) {
                                      ShippigFeesfocus.unfocus();

                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Shipping Charges",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal*2,
                                    ),
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                        left: SizeConfig.blockSizeHorizontal*2,
                                        right: SizeConfig.blockSizeHorizontal*2),
                                    //  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                    height: SizeConfig.blockSizeVertical*11 ,
                                    width: SizeConfig.blockSizeHorizontal*80,
                                    decoration:
                                    BoxDecoration(
                                      color: AppColors
                                          .whiteColor,
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      border:
                                      Border.all(
                                        color:
                                        AppColors.appBar,
                                        style:
                                        BorderStyle.solid,
                                        width:
                                        2.0,
                                      ),
                                    ),

                                    child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,

                                          height: SizeConfig.blockSizeVertical*11 ,
                                          width: SizeConfig.blockSizeHorizontal*66,
                                          child:
                                          TextFormField(
                                            autofocus: false,
                                            focusNode: Addressfocus,
                                            controller: AddressController,
                                            maxLines: 3,
                                            keyboardType: TextInputType.streetAddress,
                                            textInputAction: TextInputAction.done,
                                            validator: (val) {
                                              if (val.length == 0)
                                                return "Please enter address";
                                              else
                                                return null;
                                            },
                                            onSaved: (val) => _address= val,
                                            onFieldSubmitted: (v) {
                                              Addressfocus.unfocus();
                                            },
                                            textAlign: TextAlign.left,
                                            style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: Colors.black26,
                                                decoration: TextDecoration.none,
                                              ),
                                              hintText: "Your Address",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: ()
                                          {
                                            // hasPermission();
                                            _getCurrentLocation();
                                          },
                                          child: Container(
                                            color: AppColors.themecolor,
                                            height: SizeConfig.blockSizeVertical*11,
                                            width: SizeConfig.blockSizeHorizontal*10.86,
                                            child:Icon(Icons.add_location,color: AppColors.whiteColor),
                                          ),
                                        ),
                                      ],
                                    )
                                  /*Row(
                                  children: [
                                    Icon(Icons.add_location,color: AppColors.appBar),
                                    _currentAddress!=null?Text(_currentAddress,style:  TextStyle(fontSize: SizeConfig.blockSizeVertical*2)):Text("Address")
                                  ],
                                )*/
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Timing",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal*2,
                                    ),
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *1,
                                        left: SizeConfig.blockSizeHorizontal*2,
                                        right: SizeConfig.blockSizeHorizontal*2),
                                    //  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2),
                                    height: SizeConfig.blockSizeVertical*7 ,
                                    width: SizeConfig.blockSizeHorizontal*80,
                                    decoration:
                                    BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: AppColors.appBar,
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                      ),
                                    ),

                                    child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: SizeConfig.blockSizeVertical*9 ,
                                          width: SizeConfig.blockSizeHorizontal*66,
                                          child:
                                          TextFormField(
                                            autofocus: false,
                                            focusNode: Timerfocus,
                                            controller: TimerController,
                                            maxLines: 2,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.done,
                                            validator: (val) {
                                              if (val.length == 0)
                                                return "Please enter time";
                                              else
                                                return null;
                                            },
                                            onSaved: (val) => _timer= val,
                                            onFieldSubmitted: (v) {
                                              Timerfocus.unfocus();
                                            },
                                            textAlign: TextAlign.left,
                                            style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: Colors.black26,
                                                decoration: TextDecoration.none,
                                              ),
                                              hintText: "Store Timing",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: ()
                                          {
                                            TimeRangePicker.show(
                                              context: context,
                                              unSelectedEmpty: false,
                                              startTime: TimeOfDay(hour: 19, minute: 45),
                                              endTime: TimeOfDay(hour: 21, minute: 22),
                                              onSubmitted: (TimeRangeValue value) {
                                                setState(() {
                                                  _startTime = value.startTime;
                                                  _endTime = value.endTime;
                                                  TimerController.text ="${_timeFormated(_startTime)}"+" to "+"${_timeFormated(_endTime)}";
                                                });
                                              },
                                            );
                                          },
                                          child: Container(
                                            color:AppColors.themecolor,
                                            height: SizeConfig.blockSizeVertical*9 ,
                                            width: SizeConfig.blockSizeHorizontal*10.86,
                                            child:Icon(Icons.timer,color: AppColors.whiteColor),
                                          ),
                                        ),
                                      ],)




                                  /*Row(
                                  children: [
                                    Icon(Icons.add_location,color: AppColors.appBar),
                                    _currentAddress!=null?Text(_currentAddress,style:  TextStyle(fontSize: SizeConfig.blockSizeVertical*2)):Text("Address")
                                  ],
                                )*/
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal*80,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical *2,
                                      left: SizeConfig.blockSizeHorizontal*2,
                                      right: SizeConfig.blockSizeHorizontal*2),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.bold,
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
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .whiteColor,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border:
                                    Border.all(
                                      color:
                                      AppColors.appBar,
                                      style:
                                      BorderStyle.solid,
                                      width:
                                      2.0,
                                    ),
                                  ),
                                  child:
                                  TextFormField(
                                    autofocus: false,
                                    maxLines: 3,
                                    focusNode: StoreDescriptionfocus,
                                    controller: StoreDescriptionController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val.length == 0)
                                        return "Please enter store description";
                                      else if (val.length < 3)
                                        return "Store description must be more than 2 charater";
                                      else
                                        return null;
                                    },
                                    onSaved: (val) => _storeDescription= val,
                                    onFieldSubmitted: (v) {
                                      StoreDescriptionfocus.unfocus();
                                    },
                                    textAlign: TextAlign.left,
                                    style: TextStyle(letterSpacing: 1.0, color: Colors.black87,fontSize: 12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.none,
                                      ),
                                      hintText: "Store Description",
                                    ),
                                  ),
                                ),

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