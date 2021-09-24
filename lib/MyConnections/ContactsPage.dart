import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:share/share.dart';

class ContactsPage extends StatefulWidget {

  @override
  _ContactsPageState createState() => _ContactsPageState();

}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;
  String userid;
  UserlistingPojo followlistpojo;
  String followval;
  bool resultfollowvalue = true;
  var followlist_length;
  List common;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState()
  {
    checkper();
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      print("Login userid: " + userid.toString());
      getUseLIst(userid);
    });
    super.initState();
  }

 /* Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }*/

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void getUseLIst(String user_id) async {
    Map data = {
      'userid': user_id.toString(),
    };
    print("receiver_id: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(Network.BaseApi + Network.username_listing, body: data);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      followval = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          resultfollowvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(followval)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        followlistpojo = new UserlistingPojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(followlistpojo.data.isEmpty)
            {
              resultfollowvalue = false;
            }
            else
            {
              resultfollowvalue = true;
              print("SSSS");
              followlist_length = followlistpojo.data;
              common = followlistpojo.data;
              print("List: "+common.toString());
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: followlistpojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(followval)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: (Text('Contacts')),
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 12,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:
                      (context) => selectlangauge()),
                      (route) => false);
            },
            child: Container(
                alignment: Alignment.topRight,
                width: SizeConfig.blockSizeHorizontal * 90,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2),
                child: Text("Skip",
                    textAlign:TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Bold',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  letterSpacing: 1.0)
                )
            ),
          ),
          _contacts != null ?
          Expanded(child:
          ListView.builder(
            itemCount: _contacts?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = _contacts?.elementAt(index);
              return Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 5,
                  left: SizeConfig.blockSizeHorizontal * 5,
                  top: SizeConfig.blockSizeVertical *2,
                  bottom: SizeConfig.blockSizeVertical *2,
                ),
                  child: Row(
                      children: [
                        (contact.avatar != null && contact.avatar.isNotEmpty) ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.avatar)) :
                        CircleAvatar(
                          child: Text(contact.initials()),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2),
                          width: SizeConfig.blockSizeHorizontal *64,
                          child: Text(contact.displayName ??''),
                        ),
                        _contacts.first.phones.toString()==followlistpojo.data.first.mobile.toString()?
                        Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical *2,
                              bottom:  SizeConfig.blockSizeVertical *2),
                          height: SizeConfig.blockSizeVertical *5,
                          width: SizeConfig.blockSizeVertical * 5,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical * 1,
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/appicon_circular.png"),
                                fit: BoxFit.fill,
                              ),
                            )
                        ):
                        InkWell(
                          onTap: ()
                          {
                            final RenderBox box1 = _globalKey.currentContext.findRenderObject();
                            Share.share("Let's join on Kontribute! Get it at "+Network.sharelink,
                                subject: "Kontribute",
                                sharePositionOrigin: box1.localToGlobal(Offset.zero) & box1.size);
                          },
                          child:Container(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical *2,
                                  bottom:  SizeConfig.blockSizeVertical *2),
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeVertical * 5,
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 1,
                                  top: SizeConfig.blockSizeVertical * 1,
                                  left: SizeConfig.blockSizeHorizontal * 1),
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage(
                                      "assets/images/share.png"),
                                  fit: BoxFit.fill,
                                ),
                              )
                          ),
                        ),
                      ]
                  ));
            })
          ) : Center(child: const CircularProgressIndicator()),
                  ],
                ),
              );
  }

  void checkper() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted)
    {
      getContacts();
    }
    else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              CupertinoAlertDialog(
            title: Text('Permissions error'),
            content: Text('Please enable contacts access'
                'permission in system settings'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

}