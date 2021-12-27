import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:kontribute/MyConnections/app-contact.class.dart';
import 'package:kontribute/MyConnections/contact-avatar.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:share/share.dart';
import 'package:sms_maintained/sms.dart';

class ContactFromKontribute extends StatelessWidget {
  List<AppContact> contacts;
  Function() reloadContacts;

  ContactFromKontribute({Key key, this.contacts, this.reloadContacts}) : super(key: key);

  Iterable<Contact> _contacts;
  String userid;
  UserlistingPojo followlistpojo;
  String followval;
  bool resultfollowvalue = true;
  var followlist_length;
  List common;
  final GlobalKey _globalKey = GlobalKey();
  bool _firstSearch = true;
  String _query = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts[index];
          return contact.info.phones.isNotEmpty?
            ListTile(
            onTap: () {
              Share.share( "Let's join on Kontribute! Get it at http://kontribute.knickglobal.com/signup");
              /* SmsSender sender = SmsSender();
              String address = contact.info.phones.first.value.toString();
              print("no. "+ address);
              // sender.sendSms(new SmsMessage("8950409624", "Let's join on Kontribute! Get it at "+Network.sharelink));
              SmsMessage message = SmsMessage(address,
                  "Let's join on Kontribute! Get it at http://kontribute.knickglobal.com/signup");
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
              sender.sendSms(message);*/
            },
            title: Text(contact.info.displayName),
            subtitle: Text(contact.info.phones.length > 0
                ? contact.info.phones.elementAt(0).value
                : ''),
            leading: ContactAvatar(contact, 36),
            trailing:  Container(
              width: SizeConfig.blockSizeHorizontal *20,
              height:  SizeConfig.blockSizeVertical *5,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal *2,
              ),
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  left: SizeConfig.blockSizeHorizontal * 2,
                  bottom: SizeConfig.blockSizeHorizontal * 1,
                  top: SizeConfig.blockSizeHorizontal * 1),
              decoration: BoxDecoration(
               // color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.themecolor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Invite",
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: AppColors.themecolor,
                    fontSize:12,
                    fontWeight:
                    FontWeight.normal,
                    fontFamily:
                    'Poppins-Regular'),
              ),
            ),
          ):Container();
        },
      ),
    );
  }

}
