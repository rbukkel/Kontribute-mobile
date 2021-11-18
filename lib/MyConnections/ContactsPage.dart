import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:kontribute/MyConnections/PeopleYouMay.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:sms_maintained/sms.dart';
import 'package:kontribute/MyConnections/app-contacts.class.dart';

class ContactsPage extends StatefulWidget {

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<AppContacts> _contacts;
  List<AppContacts>  newlist;
  bool contactsLoaded = false;
  var result;
  String userid;
  UserlistingPojo followlistpojo;
  String followval;
  bool resultfollowvalue = true;
  var followlist_length;
  List common;
  final GlobalKey _globalKey = GlobalKey();
  bool _firstSearch = true;
  String _query = "";
  List<String> commonlisting = new List<String>();
  List<String> commlisting = new List<String>();
 // List<String> phonecontactlisting = new List<String>();
  List<String> userlisting = new List<String>();
  List<dynamic> values = new List<dynamic>();
  String mobil;
  var phonecontactlisting;

  TextEditingController searchController = new TextEditingController();

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

   // comparelidst();
    super.initState();
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> getContacts() async {
    List<AppContacts> contacts = (await ContactsService.getContacts()).map((contact) {
      return new AppContacts(info: contact);
    }).toList();

    setState(() {
      _contacts = contacts;
      contactsLoaded = true;
    });

     for(int i=0;i<followlistpojo.data.length;i++)
    {
      for(int j=0;j<_contacts.length;j++)
      {
        // name compare
        print("POhoneNmae: "+_contacts[j].info.displayName);
        print("POhoneNmae3: "+followlistpojo.data[i].fullName.toString());

        if(followlistpojo.data[i].fullName.toString()==_contacts[j].info.displayName.toString())
        {
          print("Api Name: "+followlistpojo.data[i].fullName.toString());
         // newlist.add(_contacts[j].info.displayName);
        }
        else{
          print("Contct Name: "+_contacts[j].info.displayName);
        }

       // number compare
        print("POhone1: "+_contacts[j].info.phones.elementAt(j).value);
        print("POhone3: "+followlistpojo.data[i].mobile.toString());
        if(followlistpojo.data[i].mobile==_contacts[j].info.phones.elementAt(j).value)
        {
          print("Api Mobile: "+followlistpojo.data[i].mobile.toString());
        }
        else{
          print("Contct Mobile: "+_contacts[j].info.phones.elementAt(j).value.toString());
        }
      }

   /* List<AppContact>  contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _contacts.first.phones.forEach((phone) => print("${phone.label}: ${phone.value}"));

      newlist.
      phonecontactlisting =_contacts;
    });*/

    }
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
      if (jsonResponse["status"] == false) {
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
              values = followlistpojo.data;
              print("PrintResult: "+values.length.toString());


              print("Result>: "+result.toString());
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

  Widget _createSearchView() {
    return new Container(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2,
            right: SizeConfig.blockSizeHorizontal *2),
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *2,
            left: SizeConfig.blockSizeHorizontal*5,
            right: SizeConfig.blockSizeHorizontal*5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0)
        ),
        child: new
        TextField(
          onChanged: (value){
            setState(() {
             // getData(value);
            });
          },
          decoration: new InputDecoration(
              hintStyle: TextStyle(color: Colors.white), hintText: 'Search...'),
        )
    );
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
                      (context) => PeopleYouMay()),
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

              AppContacts contact = _contacts[index];
              return Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 5,
                  left: SizeConfig.blockSizeHorizontal * 5,
                  top: SizeConfig.blockSizeVertical *2,
                  bottom: SizeConfig.blockSizeVertical *2,
                ),
                  child:
                  Row(
                      children: [
                        (contact.info.avatar != null && contact.info.avatar.isNotEmpty) ?
                        CircleAvatar(backgroundImage: MemoryImage(contact.info.avatar)) :
                        CircleAvatar(
                          child: Text(contact.info.initials()),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal *2),
                          width: SizeConfig.blockSizeHorizontal *64,
                          child: Text(contact.info.displayName ??''),
                        ),
                        InkWell(
                          onTap: ()
                          {

                            SmsSender sender = SmsSender();
                           String address = contact.info.phones.first.value;
                            print("no. "+address);
                           // sender.sendSms(new SmsMessage("8950409624", "Let's join on Kontribute! Get it at "+Network.sharelink));
                            SmsMessage message = SmsMessage(address, "Let's join on Kontribute! Get it at "+Network.sharelink);
                            message.onStateChanged.listen((state) {
                              if (state == SmsMessageState.Sent) {
                                print("SMS is sent!");
                                Fluttertoast.showToast(
                                    msg: "Sms sent successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                              } else if (state == SmsMessageState.Delivered) {
                                print("SMS is delivered!");
                                Fluttertoast.showToast(
                                    msg: "Sms delivered successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                              }
                            });
                            sender.sendSms(message);

                        /*   final RenderBox box1 = _globalKey.currentContext.findRenderObject();
                            Share.share("Let's join on Kontribute! Get it at "+Network.sharelink,
                                subject: "Kontribute",
                                sharePositionOrigin: box1.localToGlobal(Offset.zero) & box1.size);*/
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

  void comparelidst() {
  }



}