import 'package:flutter/material.dart';
import 'package:kontribute/Common/Sharedutils.dart';
import 'package:kontribute/Ui/HomeScreen.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:get/get.dart';

class selectlangauge extends StatefulWidget {
  @override
  selectlangaugeState createState() => selectlangaugeState();
}

class selectlangaugeState extends State<selectlangauge> {
  var languageselect = 1;
  String lang="English";

  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(true, 'English'));
    sampleData.add(new RadioModel(false, 'Arabic'));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/languag_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 5,
                bottom: SizeConfig.blockSizeVertical * 1),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 8,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(
                    StringConstant.appname,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: AppColors.whiteColor,
                        fontSize: 30),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: Text(
                    StringConstant.selectlanguage,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins-Regular',
                        color: AppColors.light_grey,
                        fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: new ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: sampleData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        //margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*3,left: 30,right: 30),
                        child: Column(
                          children: [
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    sampleData.forEach((element) => element.isSelected = false);
                                    sampleData[index].isSelected = true;
                                    print(sampleData[index].text);
                                    if (sampleData[index].text == "English") {
                                      lang = 'English';
                                      print("Langauge: "+lang.toString());
                                    } else if (sampleData[index].text == "Arabic") {
                                      lang = 'Arabic';
                                      print("Langauge: "+lang.toString());
                                    }
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          sampleData[index].text,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                          child: new RadioItem(sampleData[index])),
                                    ]),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.white,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (lang == 'English') {
                        var locale = Locale('en', 'US');
                         SharedUtils.saveLangaunage("Langauge", lang);
                        Get.updateLocale(locale);
                      } else if (lang == 'Arabic') {
                        var locale = Locale('ar', 'SA');
                         SharedUtils.saveLangaunage("Langauge", lang);
                        Get.updateLocale(locale);
                      }
                    });
                    print("LangaugeHome: "+lang.toString());

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: SizeConfig.blockSizeVertical * 10,
                    padding:
                    EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical * 1),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 6,
                      left: SizeConfig.blockSizeHorizontal * 12,
                      right: SizeConfig.blockSizeHorizontal * 12,
                    ),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/btn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Text(StringConstant.done,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 15,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 30.0,
            width: 30.0,
            decoration: new BoxDecoration(
              image: _item.isSelected
                  ? new DecorationImage(
                      image:
                          new ExactAssetImage('assets/images/click_radio.png'),
                      fit: BoxFit.cover,
                    )
                  : new DecorationImage(
                      image: new ExactAssetImage('assets/images/not_click.png'),
                      fit: BoxFit.cover,
                    ),
              // color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: new Border.all(
                width: 1.0,

                //    color: _item.isSelected ? Colors.blueAccent : Colors.grey
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
