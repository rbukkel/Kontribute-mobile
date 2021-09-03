import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Pojo/request_sendpojo.dart';
import 'package:kontribute/Pojo/searchsendreceivedpojo.dart';
import 'package:kontribute/Ui/sendrequestgift/EditCreatepool.dart';
import 'package:kontribute/Ui/sendrequestgift/EditRequestIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/EditSendIndividaul.dart';
import 'package:kontribute/Ui/sendrequestgift/viewdetail_sendreceivegift.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/Network.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class SearchbarSendreceived extends StatefulWidget {
  final String data;

  const SearchbarSendreceived({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  SearchbarSendreceivedState createState() => SearchbarSendreceivedState();
}

class SearchbarSendreceivedState extends State<SearchbarSendreceived> {
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Offset _tapDownPosition;
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  String data1;
  bool search = true;
  bool internet = false;
  String val;
  String userid;

  var storelist_length;
  request_sendpojo requestpojo;
  bool resultvalue = true;
  String searchvalue = "";

  List<searchsendreceivedpojo> searchproductListing =
      new List<searchsendreceivedpojo>();

  SearchbarSendreceivedState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
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
    SharedUtils.readloginId("UserId").then((val) {
      print("UserId: " + val);
      userid = val;
      getData(userid, "");
      print("Login userid: " + userid.toString());
    });
    _IsSearching = false;
    data1 = widget.data;
  }

  void getData(String user_id, String search) async {
    Map data = {
      'search': search,
      'user_id': userid.toString(),
    };

    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http
        .post(Network.BaseApi + Network.send_receive_gifts, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["success"] == false) {
        setState(() {
          storelist_length = null;
          resultvalue = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        requestpojo = new request_sendpojo.fromJson(jsonResponse);
        print("Json User" + jsonResponse.toString());
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if (requestpojo.result.data.isEmpty) {
              resultvalue = false;
            } else {
              resultvalue = true;
              print("SSSS");
              storelist_length = requestpojo.result.data;
            }
          });
        } else {
          Fluttertoast.showToast(
              msg: requestpojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
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
        body: Container(
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              storelist_length != null
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: storelist_length.length == null
                              ? 0
                              : storelist_length.length,
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
                                              bottom:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig
                                                                .blockSizeHorizontal *
                                                            2),
                                                    child: Text(
                                                      requestpojo.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .status ==
                                                              "request"
                                                          ? "Request Received from:"
                                                          : requestpojo.result
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .status ==
                                                                  "sent"
                                                              ? "Send to:"
                                                              : requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .status ==
                                                                      "group"
                                                                  ? "Group Request:"
                                                                  : "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Poppins-Bold',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        right: SizeConfig
                                                                .blockSizeHorizontal *
                                                            2),
                                                    child: Text(
                                                      requestpojo.result.data
                                                          .elementAt(index)
                                                          .postedDate
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTapDown: (TapDownDetails
                                                        details) {
                                                      _tapDownPosition = details
                                                          .globalPosition;
                                                    },
                                                    onTap: () {
                                                      requestpojo.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .status ==
                                                              "request"
                                                          ? _showPopupMenu(
                                                              index, "request")
                                                          : requestpojo.result
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .status ==
                                                                  "sent"
                                                              ? _showPopupMenu(
                                                                  index, "send")
                                                              : requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .status ==
                                                                      "group"
                                                                  ? _showPopupMenu(
                                                                      index,
                                                                      "pool")
                                                                  : _showPopupMenu(
                                                                      index,
                                                                      "");
                                                    },
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
                                                  requestpojo.result.data.elementAt(index).profilePic == null ||
                                                          requestpojo.result.data
                                                                  .elementAt(
                                                                      index)
                                                                  .profilePic ==
                                                              ""
                                                      ? requestpojo.result.data
                                                                      .elementAt(
                                                                          index)
                                                                      .giftPicture ==
                                                                  null ||
                                                              requestpojo.result.data
                                                                      .elementAt(
                                                                          index)
                                                                      .giftPicture ==
                                                                  ""
                                                          ? Container(
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  12,
                                                              width: SizeConfig.blockSizeVertical *
                                                                  12,
                                                              alignment: Alignment
                                                                  .center,
                                                              margin: EdgeInsets.only(
                                                                  top: SizeConfig.blockSizeVertical * 1,
                                                                  bottom: SizeConfig.blockSizeVertical * 1,
                                                                  right: SizeConfig.blockSizeHorizontal * 1,
                                                                  left: SizeConfig.blockSizeHorizontal * 2),
                                                              decoration: BoxDecoration(
                                                                image:
                                                                    new DecorationImage(
                                                                  image: new AssetImage(
                                                                      "assets/images/account_circle.png"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ))
                                                          : Container(
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  14,
                                                              width: SizeConfig
                                                                      .blockSizeVertical *
                                                                  12,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets.only(
                                                                  top: SizeConfig
                                                                          .blockSizeVertical *
                                                                      1,
                                                                  bottom: SizeConfig
                                                                          .blockSizeVertical *
                                                                      1,
                                                                  right: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      2),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        Network.BaseApigift +
                                                                            requestpojo.result.data.elementAt(index).giftPicture,
                                                                      ),
                                                                      fit: BoxFit.fill)),
                                                            )
                                                      : Container(
                                                          height: SizeConfig
                                                                  .blockSizeVertical *
                                                              14,
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              12,
                                                          alignment:
                                                              Alignment.center,
                                                          margin: EdgeInsets.only(
                                                              top: SizeConfig
                                                                      .blockSizeVertical *
                                                                  1,
                                                              bottom: SizeConfig
                                                                      .blockSizeVertical *
                                                                  1,
                                                              right: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              left: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                    Network.BaseApigift +
                                                                        requestpojo
                                                                            .result
                                                                            .data
                                                                            .elementAt(index)
                                                                            .giftPicture,
                                                                  ),
                                                                  fit: BoxFit.fill)),
                                                        ),
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
                                                                45,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                            child: Text(
                                                              requestpojo.result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .groupName !=
                                                                      null
                                                                  ? requestpojo
                                                                      .result
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .groupName
                                                                  : requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .fullName !=
                                                                          null
                                                                      ? requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .fullName
                                                                      : "",
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              callNext(
                                                                  viewdetail_sendreceivegift(
                                                                      data: requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .id
                                                                          .toString(),
                                                                      coming:"Search"),
                                                                  context);
                                                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyForm()));
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
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
                                                                    letterSpacing:
                                                                        1.0,
                                                                    color: AppColors
                                                                        .green,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontFamily:
                                                                        'Poppins-Regular'),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            70,
                                                        alignment:
                                                            Alignment.topLeft,
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
                                                          requestpojo
                                                              .result.data
                                                              .elementAt(index)
                                                              .message
                                                              .toString(),
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  'Poppins-Regular'),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
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
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding: EdgeInsets.only(
                                                                right: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3,
                                                                top: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2),
                                                            child: Text(
                                                              requestpojo.result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .price !=
                                                                      null
                                                                  ? "\$" +
                                                                      requestpojo
                                                                          .result
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .price
                                                                  : requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(
                                                                                  index)
                                                                              .minCashByParticipant !=
                                                                          null
                                                                      ? "\$" +
                                                                          requestpojo
                                                                              .result
                                                                              .data
                                                                              .elementAt(index)
                                                                              .minCashByParticipant
                                                                      : "",
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .lightBlueAccent,
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding: EdgeInsets.only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                                top: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2),
                                                            child: Text(
                                                              "",
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins-Regular'),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding: EdgeInsets.only(
                                                                right: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3,
                                                                top: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2),
                                                            child: Text(
                                                              "",
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.0,
                                                                  color: Colors
                                                                      .lightBlueAccent,
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
                            );
                          }),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 150),
                      alignment: Alignment.center,
                      child: resultvalue == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Image.asset("assets/images/empty.png",
                                  height: SizeConfig.blockSizeVertical * 50,
                                  width: SizeConfig.blockSizeVertical * 50),
                            ),
                    )
            ],
          ),
        ));
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact)).toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact)).toList();
    }
  }

  _showPopupMenu(int index, String valu) async {
    print("Index: " + index.toString());
    print("VALues: " + valu.toString());
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,
      ),
      items: [
        PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                //Navigator.of(context).pop();
                if (valu == "request") {
                  callNext(
                      EditRequestIndividaul(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "pool") {
                  callNext(
                      EditCreatepool(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                } else if (valu == "send") {
                  callNext(
                      EditSendIndividaul(
                          data: requestpojo.result.data
                              .elementAt(index)
                              .id
                              .toString()),
                      context);
                }
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 8, 1),
                    child: Icon(Icons.edit),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
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
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        getData(userid, value);
                      });
                    },
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        // hintText: "Search here...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle =
          new Text("", style: new TextStyle(color: Colors.white));
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
    return new Expanded(
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
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
                                    width: SizeConfig.blockSizeHorizontal * 72,
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 2),
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
                                            SizeConfig.blockSizeHorizontal * 2),
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
                                          right:
                                              SizeConfig.blockSizeHorizontal *
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
                                    height: SizeConfig.blockSizeVertical * 12,
                                    width: SizeConfig.blockSizeVertical * 12,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 2),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Poppins-Regular'),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              /*
                                             Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          viewdetail_sendreceivegift()));
                                                          */
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
                                            SizeConfig.blockSizeHorizontal * 70,
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                            top:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                                          maxLines: 2,
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Colors.black87,
                                              fontSize: 8,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Poppins-Regular'),
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
                                                  fontWeight: FontWeight.normal,
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
                                                  color: Colors.lightBlueAccent,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
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
                                                  fontWeight: FontWeight.normal,
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
                                                  color: Colors.lightBlueAccent,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
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
            );
          }),
    );
  }
}
