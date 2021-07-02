import 'package:flutter/material.dart';
import 'package:kontribute/Ui/afterwelcome.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';


class Carousel extends StatefulWidget {
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();

  bool descTextShowFlag = false;
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Container(height: SizeConfig.blockSizeVertical * 60,
      width: SizeConfig.blockSizeHorizontal*60,
      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal* 10,
          right: SizeConfig.blockSizeHorizontal*10,
          top: SizeConfig.blockSizeVertical * 5 ),
      child: Image.asset(
        "assets/images/welcome1.png",
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal*60,
        fit: BoxFit.fill,
      ),
    ),
    Container(height: SizeConfig.blockSizeVertical * 60,
      width: SizeConfig.blockSizeHorizontal*60,
      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal* 10,right: SizeConfig.blockSizeHorizontal*10,top: SizeConfig.blockSizeVertical * 4 ),
      child: Image.asset(
        "assets/images/welcome2.png",
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal*60,
        fit: BoxFit.fill,
      ),
    ),
    Container(height: SizeConfig.blockSizeVertical * 60,
      width: SizeConfig.blockSizeHorizontal*60,
      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal* 10,right: SizeConfig.blockSizeHorizontal*10 ,top: SizeConfig.blockSizeVertical * 4),
      child: Image.asset(
        "assets/images/welcome3.png",
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal*60,
        fit: BoxFit.fill,
      ),
    ),
  ];

  Widget circleText(int i,String text) {
    var parts = text.split(',');
    var FirstText = parts[0].trim();
    var SecondText = parts[1].trim();
    var ThirdText = parts[2].trim();
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      //margin: EdgeInsets.symmetric(horizontal: 8),
       child: i==0?Container(
         margin:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             GestureDetector(
               onTap: (){
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => afterwelcome()),
                         (route) => false);
               },
               child: Container(
                   alignment: Alignment.topRight,
                   width: SizeConfig.blockSizeHorizontal * 90,
                   child: Text("Skip",textAlign:TextAlign.right,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                     fontWeight: FontWeight.normal,
                     fontSize: 16,
                     letterSpacing: 1.0,),)) ,
             ),
             Container(
               width: SizeConfig.blockSizeHorizontal * 90,
               alignment: Alignment.topCenter,
               margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*4),
               child: Text(StringConstant.letsgetstarted,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                 fontWeight: FontWeight.bold,
                 fontSize: 24,
                 letterSpacing: 2.0,),),),
             Container(
               margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
               width: SizeConfig.blockSizeHorizontal * 90,
               alignment: Alignment.topCenter,
                 child: Text(FirstText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),),),
             Container(
               alignment: Alignment.topCenter,
                 width: SizeConfig.blockSizeHorizontal * 90,
               margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
                 child: Text(SecondText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
             Container(
               alignment: Alignment.topCenter,
                 width: SizeConfig.blockSizeHorizontal * 90,
                 margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
                 child: Text(ThirdText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
           ],
         ),
       ):
       i==1?Container(
         margin:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             GestureDetector(
               onTap: (){
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => afterwelcome()),
                         (route) => false);
               },
               child: Container(
                   alignment: Alignment.topRight,
                   width: SizeConfig.blockSizeHorizontal * 90,
                   child: Text("Skip",textAlign:TextAlign.right,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                     fontWeight: FontWeight.normal,
                     fontSize: 16,
                     letterSpacing: 1.0,),)) ,
             ),
             Container(
               width: SizeConfig.blockSizeHorizontal * 90,
               alignment: Alignment.topCenter,
               margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*4),
               child: Text(StringConstant.letsgetstarted,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                 fontWeight: FontWeight.bold,
                 fontSize: 24,
                 letterSpacing: 2.0,),),),
             Container(
               margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
               alignment: Alignment.topCenter,
                width: SizeConfig.blockSizeHorizontal * 90,
               child: Text(FirstText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                 fontWeight: FontWeight.normal,
                 fontSize: 16,
                 letterSpacing: 1.0,),),),
             Container(
               alignment: Alignment.topCenter,
                width: SizeConfig.blockSizeHorizontal * 90,
               margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
                 child: Text(SecondText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
             Container(
               alignment: Alignment.topCenter,
                  width: SizeConfig.blockSizeHorizontal * 90,
                 margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
                 child: Text(ThirdText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
           ],
         ),
       ):
       Container(
         margin:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             GestureDetector(
               onTap: (){
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => afterwelcome()),
                         (route) => false);
               },
               child: Container(
                   alignment: Alignment.topRight,
                   width: SizeConfig.blockSizeHorizontal * 90,
                   child: Text("Next",textAlign:TextAlign.right,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                     fontWeight: FontWeight.normal,
                     fontSize: 16,
                     letterSpacing: 1.0,),)) ,
             ),
             Container(
               width: SizeConfig.blockSizeHorizontal * 90,
               alignment: Alignment.topCenter,
               margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*4),
               child: Text(StringConstant.letsgetstarted,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                 fontWeight: FontWeight.bold,
                 fontSize: 24,
                 letterSpacing: 2.0,),),),
             Container(
               margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
               alignment: Alignment.topCenter,
                width: SizeConfig.blockSizeHorizontal * 90,
               child: Text(FirstText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                 fontWeight: FontWeight.normal,
                 fontSize: 16,
                 letterSpacing: 1.0,),),),
             Container(
               alignment: Alignment.topCenter,
                  width: SizeConfig.blockSizeHorizontal * 90,
                 margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
                 child: Text(SecondText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
             Container(
               alignment: Alignment.topCenter,
                  width: SizeConfig.blockSizeHorizontal * 90,
                 margin:  EdgeInsets.only(top: SizeConfig.blockSizeVertical*1,),
                 child: Text(ThirdText,textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontFamily: 'Poppins-Bold',
                   fontWeight: FontWeight.normal,
                   fontSize: 16,
                   letterSpacing: 1.0,),)),
           ],
         ),
       ),
    );
  }
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.black :AppColors.greyColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
       color: AppColors.whiteColor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
                    child: new SingleChildScrollView(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5),
                                  child: Row(
                                    children: <Widget>[
                                      for (int i = 0; i < introWidgetsList.length; i++)
                                        if (i == currentPageValue) ...[
                                          i==0?circleText(i,'Receive Birthday Gifts in cash from ,Friends and also send Gifts them..., '):
                                          i==1?circleText(i,'Collect Cash to support entrepreneurs ,in their projects or ask for support,in their own projects...'):
                                          i==2?circleText(i,'Collect Cash for Social,Events as a Gift...,'):SizedBox()
                                        ]


                                    ],
                                  ),
                                ),
                                Container(
                                  height: SizeConfig.blockSizeVertical*40,
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*38),
                                  child: PageView.builder(
                                    physics: ClampingScrollPhysics(),
                                    itemCount: introWidgetsList.length,
                                    onPageChanged: (int page) {
                                      getChangedPageAndMoveBar(page);
                                    },
                                    controller: PageController(
                                        initialPage: currentPageValue,
                                        keepPage: true,
                                        viewportFraction: 1),
                                    itemBuilder: (context, index) {
                                      return introWidgetsList[index];
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*85),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (int i = 0; i < introWidgetsList.length; i++)
                                        if (i == currentPageValue) ...[
                                          circleBar(true)
                                        ] else
                                          circleBar(false),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }






 /* @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/bg.png",height: SizeConfig.blockSizeVertical*100,width: SizeConfig.blockSizeHorizontal*100,fit: BoxFit.fill,),
          ),
          *//*Center(
            child: Text('Page 1'),
          ),*//*
          Center(
            child: Text('Page 2'),
          ),
          Center(
            child: Text('Page 3'),
          ),
        ],
      ),
      *//*bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: previousPage,
            child: Text('Previous'),
          ),
          RaisedButton(
            onPressed: nextPage,
            child: Text('Next'),
          )
        ],
      ),*//*
    );
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page.toInt() + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page.toInt() - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
  }*/
}
/*
class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "SCHOOL",
        styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
        "Aenean massa.",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage:  "assets/images/bg.png",
         widthImage: SizeConfig.blockSizeHorizontal*100,heightImage: SizeConfig.blockSizeVertical*100
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Ye indulgence ",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/bg.png",widthImage: SizeConfig.blockSizeHorizontal*100,heightImage: SizeConfig.blockSizeVertical*100,
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/photo_coffee_shop.png",widthImage: SizeConfig.blockSizeHorizontal*100,heightImage: SizeConfig.blockSizeVertical*100,
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),
      renderNextBtn: this.renderNextBtn(),
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),
      colorDot: Color(0xffffcc5c),
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      scrollPhysics: BouncingScrollPhysics(),
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
*/








/*
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  final List<Widget> pages;
  final VoidCallback onIntroCompleted;

  const IntroScreen({
    Key key,
    @required this.pages,
    @required this.onIntroCompleted,
  })  : assert(pages != null),
        assert(onIntroCompleted != null),
        super(key: key);

  @override
  _MyIntroViewState createState() => _MyIntroViewState();
}

class _MyIntroViewState extends State<IntroScreen> {
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener<ScrollEndNotification>(
          onNotification: (x) {
            setState(() {
              _currentPage = _pageController.page.round();
            });
            return false;
          },
          child: PageView(
            children: widget.pages,
            controller: _pageController,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomButtons(),
        ),
      ],
    );
  }

  bool get _isFinalPage => _currentPage == widget.pages.length - 1;

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Opacity(
            opacity: _isFinalPage ? 0.0 : 1.0,
            child: _buildButton("SKIP", _gotoLastPage),
          ),
          _buildNavIndicator(),
          _isFinalPage
              ? _buildButton("DONE", widget.onIntroCompleted)
              : _buildButton("NEXT", _gotoNextPage),
        ],
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback callback) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: callback,
    );
  }

  void _gotoLastPage() {
    _pageController.animateToPage(
      widget.pages.length - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  void _gotoNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildNavIndicator() {
    final indicatorList = <Widget>[];
    for (int i = 0; i < widget.pages.length; i++)
      indicatorList.add(_buildIndicator(i == _currentPage));
    return Row(children: indicatorList);
  }

  Widget _buildIndicator(bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.white : Colors.white30,
        ),
        child: SizedBox(width: 8, height: 8),
      ),
    );
  }
}*/
