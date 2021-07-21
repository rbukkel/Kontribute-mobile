import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';

class SearchbarSendreceived extends StatefulWidget{
  final String data;

  const SearchbarSendreceived({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  SearchbarSendreceivedState createState() => SearchbarSendreceivedState();

}

class SearchbarSendreceivedState extends State<SearchbarSendreceived>{
  Widget appBarTitle = new Text("Search...", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  String data1;

  SearchbarSendreceivedState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    data1 = widget.data;
   // init();

  }

  void init() {
    _list = List();
    _list.add("Google");
    _list.add("IOS");
    _list.add("Andorid");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
     /* body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),*/
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact))
          .toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String  name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact))
          .toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.white,
        flexibleSpace: Image(
          height: SizeConfig.blockSizeVertical * 13,
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Search...", style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new   Expanded(
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical * 2),
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
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                    SizeConfig.blockSizeHorizontal * 72,
                                    margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal *
                                            2),
                                    child: Text(
                                      StringConstant.receivegift,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins-Bold',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        right:
                                        SizeConfig.blockSizeHorizontal *
                                            2),
                                    child: Text(
                                      "01-01-2020",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 8),
                                    ),
                                  ),
                                  GestureDetector(
                                   /* onTapDown: (TapDownDetails details) {
                                      _tapDownPosition =
                                          details.globalPosition;
                                    },
                                    onTap: () {
                                      _showPopupMenu();
                                    },*/
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: SizeConfig
                                              .blockSizeHorizontal *
                                              2),
                                      child: Image.asset(
                                          "assets/images/menudot.png",
                                          height: 15,
                                          width: 20),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height:
                                    SizeConfig.blockSizeVertical * 12,
                                    width:
                                    SizeConfig.blockSizeVertical * 12,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical *
                                            1,
                                        bottom:
                                        SizeConfig.blockSizeVertical *
                                            1,
                                        right:
                                        SizeConfig.blockSizeHorizontal *
                                            1,
                                        left:
                                        SizeConfig.blockSizeHorizontal *
                                            2),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: new AssetImage(
                                              "assets/images/userProfile.png"),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig
                                                .blockSizeHorizontal *
                                                45,
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),
                                            child: Text(
                                              "Sam Miller",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                            /*  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          viewdetail_sendreceivegift()));*/
                                            },
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.only(
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    1,
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    3,
                                              ),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: AppColors.green,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontFamily:
                                                    'Poppins-Regular'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                        SizeConfig.blockSizeHorizontal *
                                            70,
                                        alignment: Alignment.topLeft,
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
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                                          maxLines: 2,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily:
                                              'Poppins-Regular'),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    1,
                                                top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              "Amount- ",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    3,
                                                top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              "\$100",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors
                                                      .lightBlueAccent,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                    .blockSizeHorizontal *
                                                    1,
                                                top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              "Collection Target- ",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                right: SizeConfig
                                                    .blockSizeHorizontal *
                                                    3,
                                                top: SizeConfig
                                                    .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              "\$1000",
                                              style: TextStyle(
                                                  letterSpacing: 1.0,
                                                  color: Colors
                                                      .lightBlueAccent,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily:
                                                  'Poppins-Regular'),
                                            ),
                                          )
                                        ],
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
                )
              ],
            )
            ;
          }),
    );
  }

}