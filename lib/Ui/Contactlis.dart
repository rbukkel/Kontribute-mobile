import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:kontribute/MyConnections/ContactsPage.dart';
import 'package:kontribute/MyConnections/PeopleYouMay.dart';
import 'package:kontribute/MyConnections/app-contact.class.dart';
import 'package:kontribute/MyConnections/contact-avatar.dart';
import 'package:kontribute/Ui/ContactFromKontribute.dart';
import 'package:kontribute/Ui/selectlangauge.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Pojo/UserlistingPojo.dart';
import 'package:sms_maintained/sms.dart';

class Contactlis extends StatefulWidget {

  @override
  _ContactlisState createState() => _ContactlisState();
}

class _ContactlisState extends State<Contactlis>
{
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<AppContact> _contacts = (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return new AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.info.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (
        (isSearching == true && contactsFiltered.length > 0) ||
            (isSearching != true && contacts.length > 0)
    );
    return Scaffold(
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
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PeopleYouMay()), (route) => false);
            },
            child: Container(
                alignment: Alignment.topRight,
                width: SizeConfig.blockSizeHorizontal * 90,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                child: Text("Skip",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        letterSpacing: 1.0))),
          ),
          Container(
            margin: EdgeInsets.only(
              top:  SizeConfig.blockSizeVertical *2,
                left: SizeConfig.blockSizeHorizontal *5,right: SizeConfig.blockSizeHorizontal *5),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: 'Search...',
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: AppColors.black
                      )
                  ),
                  prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.black
                  ),
              ),
            ),
          ),
          contactsLoaded == true ?  // if the contacts have not been loaded yet
          listItemsExist == true ?  // if we have contacts to show
          ContactFromKontribute(
            reloadContacts: ()
            {
              getAllContacts();
            },
            contacts: isSearching == true ? contactsFiltered : contacts,
          ) :
          Container(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                isSearching ?'No search results to show' : 'No contacts exist',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
          ) :
          Container(  // still loading contacts
            padding: EdgeInsets.only(top: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }



}