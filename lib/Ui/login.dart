import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/LoginResponse.dart';
import 'package:kontribute/Pojo/loginotp.dart';

import 'package:kontribute/Ui/forget_screen.dart';
import 'package:kontribute/Ui/register.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/InternetCheck.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:kontribute/MyConnections/ContactsPage.dart';
import 'package:kontribute/Ui/loginOTPScreen.dart';
import 'package:store_redirect/store_redirect.dart';

class login extends StatefulWidget{
  @override
  loginState createState() => loginState();
}

class loginState extends State<login>{
  final _formKey = GlobalKey<FormState>();
  final EmailFocus = FocusNode();
  final PwdFocus = FocusNode();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _showPassword = false;
  String _email;
  String _password;
  String token;
  var facebookLogin = FacebookLogin();
  bool isLoggedIn = false;
  bool isLoading = false;
  var profileData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth _authtwitter = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User user;
  String message;
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging();

 /* final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'VLHZDyBzZN4jCtWivu0gsrF5v',
    consumerSecret: 'giMJBSteIpjBr6SpD0O4KxLm3OXZX7EEjmNFt4xavaRBxrHXem',
  );*/



  @override
  void initState() {
    super.initState();
    gettoken();

    SharedUtils.readToken("Token").then((val) {
      print("Token: " + val);
      token = val;
      print("Login token: " + token.toString());
    });
  }

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
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/welcome_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 5,
                  bottom: SizeConfig.blockSizeVertical * 1),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 5,
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      StringConstant.signin,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                          color: AppColors.black,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                    ),
                    child: Text(
                      StringConstant.welcometokontribute,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          color: AppColors.black,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 13,
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      top: SizeConfig.blockSizeVertical *7,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      bottom: SizeConfig.blockSizeVertical *1,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/registerbtn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                   /* decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                    ),*/
                    child: TextFormField(
                      autofocus: false,
                      focusNode: EmailFocus,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val.length == 0)
                          return "Please enter email";
                        else if (!regex.hasMatch(val))
                          return "Please enter valid email";
                        else
                          return null;
                      },
                      onFieldSubmitted: (v)
                      {
                        FocusScope.of(context).requestFocus(PwdFocus);
                      },
                      onSaved: (val) => _email = val,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.emailaddres,
                      ),
                    )

                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical *1,
                          ),
                          alignment: Alignment.centerLeft,
                          height: SizeConfig.blockSizeVertical *18,
                          width: SizeConfig.blockSizeHorizontal *18,
                          child:  ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.mail_outline_sharp, color: AppColors.iconcolor),
                            style: ElevatedButton.styleFrom(
                              shadowColor: AppColors.iconcolor,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              primary: Colors.white, // <-- Button color
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal *60,
                          child:
                          TextFormField(
                            autofocus: false,
                            focusNode: EmailFocus,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val.length == 0)
                                return "Please enter email";
                              else if (!regex.hasMatch(val))
                                return "Please enter valid email";
                              else
                                return null;
                            },
                            onFieldSubmitted: (v)
                            {
                              FocusScope.of(context).requestFocus(PwdFocus);
                            },
                            onSaved: (val) => _email = val,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 10,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins-Regular',  fontSize: 10,
                                decoration: TextDecoration.none,
                              ),
                              hintText: StringConstant.emailaddres,
                            ),
                          )
                        )

                      ],
                    ),*/
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 13,
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 3,
                      top: SizeConfig.blockSizeVertical *1,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 5,
                     // bottom: SizeConfig.blockSizeVertical *1,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/registerbtn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextFormField(
                      autofocus: false,
                      focusNode: PwdFocus,
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val.length == 0)
                          return "Please enter password";
                        else if (val.length <= 4)
                          return "Your password should be more then 5 char long";
                        else
                          return null;
                      },
                      onFieldSubmitted: (v) {
                        PwdFocus.unfocus();
                      },
                      onSaved: (val) => _password = val,
                      obscureText: !this._showPassword,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(letterSpacing: 1.0,   fontSize: 14, fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',color: Colors.black),
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',  fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                        hintText: StringConstant.password,
                        suffixIcon:  InkWell(
                          onTap: (){
                            setState(() => this._showPassword = !this._showPassword);
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                       /* Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical *1,
                              ),
                              alignment: Alignment.centerLeft,
                              height: SizeConfig.blockSizeVertical *18,
                              width: SizeConfig.blockSizeHorizontal *18,
                              child:  ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.lock, color: AppColors.iconcolor),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: AppColors.iconcolor,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  primary: Colors.white, // <-- Button color
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal *60,
                              child:TextFormField(
                                autofocus: false,
                                focusNode: PwdFocus,
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  if (val.length == 0)
                                    return "Please enter password";
                                  else if (val.length <= 4)
                                    return "Your password should be more then 5 char long";
                                  else
                                    return null;
                                },
                                onFieldSubmitted: (v) {
                                  PwdFocus.unfocus();
                                },
                                onSaved: (val) => _password = val,
                                obscureText: !this._showPassword,
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(letterSpacing: 1.0,   fontSize: 10, fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',color: Colors.black),
                                decoration: InputDecoration(

                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',  fontSize: 10,
                                    decoration: TextDecoration.none,
                                  ),
                                  hintText: StringConstant.password,
                                  suffixIcon:  InkWell(
                                    onTap: (){
                                      setState(() => this._showPassword = !this._showPassword);
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        )*/


                  ),
                  GestureDetector(
                    onTap: () {

                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Internet_check().check().then((intenet) {
                          if (intenet != null && intenet) {
                          signIn(emailController.text, passwordController.text,token);
                           /* StoreRedirect.redirect(
                                androidAppId: "com.eghil.eghil",
                              //  iOSAppId: "585027354"
                            );*/
                          } else {
                           errorDialog("No Internet Connection");
                          }
                          // No-Internet Case
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical * 9,
                      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 12,
                        right: SizeConfig.blockSizeHorizontal * 12,
                      ),
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/btn.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(StringConstant.signin,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forget_screen()));
                          },
                          child: Container(
                            child: Text(StringConstant.forgetpwd,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 15,
                                    )),
                          ),
                        ),
                        Container(
                            height: 20,
                            child: VerticalDivider(
                                thickness: 1, color: AppColors.black,)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register()));
                          },
                          child: Container(
                            child: Text(StringConstant.register,
                                style: TextStyle(
                                  color: AppColors.black,
                                    fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins-Regular',)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                    width: 300,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                     Container(
                       width:80,
                       child:  Divider(
                         color: Colors.grey,
                         thickness: 1,
                       ),
                     ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text(StringConstant.or,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins-Regular',)),
                      ),
                      Container(
                        width:80,
                        child:  Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                left:SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 3),
                            child: Image.asset(
                              "assets/images/gmail.png",
                              height: SizeConfig.blockSizeVertical *20,
                              width:SizeConfig.blockSizeHorizontal * 20,
                            ),
                          ),
                          onTap: () {
                            signInWithGoogle();
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child: Image.asset(
                              "assets/images/facebook.png",
                              height: SizeConfig.blockSizeVertical *20,
                              width:SizeConfig.blockSizeHorizontal * 20,
                            ),
                          ),
                          onTap: ()
                          {
                            loginmethod();
                          },
                        ),

                       /* GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child: Image.asset(
                              "assets/images/twitter.png",
                             height: SizeConfig.blockSizeVertical *20,
                              width:SizeConfig.blockSizeHorizontal * 20,

                            ),
                          ),
                          onTap: () {
                           // signInWithTwitter();
                          },
                        ),*/

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      setState(() {
        SharedUtils.readloginData("login", true);
        fetchData(user.displayName, user.email, user.uid, user.photoURL);
        SharedUtils.writeloginId("login_type", "google");
      });
      return '$user';
    } else {
      print('Already Login: $user');
    }
    return null;
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

  void loginmethod() {
    Internet_check().check().then((intenet) async {
      if (intenet != null && intenet) {
        initiateFacebookLogin();
      } else {
        errorDialog("No Internet Connection");
      }
    });
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    switch (facebookLoginResult.status) {

      case FacebookLoginStatus.error:
        print("Facebook error: ");
        onLoginStatusChanged(false);
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("Facebook cancel");
        onLoginStatusChanged(false);
        break;

      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        print("ProfileEmail" + profile['email'].toString());
        print("ProfileID: " + profile['id'].toString());
        print("ProfileName: " + profile['name'].toString());
        print(profile['picture']['data']['url']);
        onLoginStatusChanged(true, profileData: profile);
        SharedUtils.readloginData("login", true);
        fetchData(
            profile['name'].toString(),
            profile['email'].toString(),
            profile['id'].toString(),
            profile['picture']['data']['url'].toString(),
            );
        SharedUtils.writeloginId("login_type", "facebook");
        // Navigator.of(context).pop();
        break;
    }
  }


  fetchData(String name, String email, String id, String photoURL) async {
    print("email: " + email.toString());
    print("name: " + name.toString());
    print("id: " + id.toString());
    print("photoURL: " + photoURL.toString());
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      'email': email.toString(),
      'full_name': name.toString(),
      'mobile_token': token.toString(),
      'facebook_id': id.toString(),
      'profile_pic': photoURL.toString(),
    };
    print("Social: "+data.toString());
    var jsonResponse = null;
    var response =
    await http.post(Network.BaseApi + Network.socailLogin, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        LoginResponse login = new LoginResponse.fromJson(jsonResponse);
        String jsonProfile = jsonEncode(login);
        print(jsonProfile);
        SharedUtils.saveProfile(jsonProfile);
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });
          SharedUtils.readloginData("login",true);
          SharedUtils.saveDate("Token", login.resultPush.mobileToken);
          SharedUtils.writeloginId("UserId", login.resultPush.userId.toString());
          SharedUtils.writeloginId("Usename", login.resultPush.fullName);
          errorDialog(login.message);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => selectlangauge()), (route) => false);
          /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContactsPage()),
                  (route) => false);*/
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
            //   isLoading = false;
          });
          errorDialog(login.message);
        }
      }
    }
    else {

      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);
    }
  }

 /* void signInWithTwitter() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;
    if (result.status == TwitterLoginStatus.loggedIn) {
     // _signInWithTwitter(result.session.token, result.session.secret);
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      newMessage = 'Login cancelled by user.';
    } else {
      newMessage = result.errorMessage;
    }
    setState(() {
      message = newMessage;
    });
  }*/

 /* void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token, authTokenSecret: secret);
    await _authtwitter.signInWithCredential(credential);
  }*/

  signIn(String emal,String pass,String token) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    Map data = {
      "email":emal,
      "password":pass,
      "mobile_token":token,
      };
    print("Data: "+data.toString());
    var jsonResponse = null;
    var response = await http.post(Network.BaseApi + Network.loginrequest, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse["success"] == false) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        errorDialog(jsonResponse["message"]);
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        loginotp login = new loginotp.fromJson(jsonResponse);
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });
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
                        login.message,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        callNext1(loginOTPScreen(data:emal.toString(),pass:pass.toString()), context);

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

        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          setState(() {
            Navigator.of(context).pop();
            //   isLoading = false;
          });
          errorDialog(login.message);
        }
      }
    }
    else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      errorDialog(jsonResponse["message"]);
    }
  }


}