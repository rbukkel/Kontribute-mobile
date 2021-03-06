import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kontribute/Ui/Donation/OngoingCampaign.dart';
import 'package:kontribute/Ui/Events/OngoingEvents.dart';
import 'package:kontribute/Ui/ProjectFunding/OngoingProject.dart';
import 'package:kontribute/Ui/Tickets/TicketOngoingEvents.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/StringConstant.dart';
import 'package:kontribute/utils/screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class ProductVideoPlayerScreen extends StatefulWidget {
  final String data;
  final String comesfrom;

  const ProductVideoPlayerScreen({
    Key key,
    @required this.data, @required this.comesfrom,
  }) : super(key: key);

  @override
  _ProductVideoPlayerScreenState createState() => _ProductVideoPlayerScreenState();
}

class _ProductVideoPlayerScreenState extends State<ProductVideoPlayerScreen> {
   YoutubePlayerController _controller;
   TextEditingController _idController;
   TextEditingController _seekToController;

   PlayerState _playerState;
   YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  String urlLik;
  String come;

 /* final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];*/

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
                     'ok'.tr,
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


   @override
  void initState() {
    super.initState();
    urlLik =widget.data;
    come =widget.comesfrom;
    print("UrlLink: "+urlLik);
    print("COMES: "+come);

    String videoId;

    Future.delayed(Duration.zero, () {
      setState(()
      {
        videoId = YoutubePlayer.convertUrlToId(urlLik);

        if(videoId==null|| videoId=="")
          {
            errorDialog('videolinkisnotvalid'.tr);
            if(come=="Project")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OngoingProject()));
            }
            else if(come=="Ticket")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TicketOngoingEvents()));
            } else if(come=="Event")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OngoingEvents()));
            }else if(come=="Donation")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OngoingCampaign()));
            }
          }
        else{
          {
            print("ID: "+videoId);

            _controller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                mute: false,
                autoPlay: true,
                disableDragSeek: false,
                loop: false,
                isLive: false,
                forceHD: false,
                enableCaption: true,
              ),
            )..addListener(listener);
            _idController = TextEditingController();
            _seekToController = TextEditingController();
            _videoMetaData = const YoutubeMetaData();
            _playerState = PlayerState.unknown;
          }

        }
      });
    });

  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller!=null?
      YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.themecolor,
        topActions: <Widget>[
          const SizedBox(width: 8.0),

          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        /*onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },*/
      ),
      builder: (context, player) => Scaffold(
        /*appBar: AppBar(
          backgroundColor: AppColors.pink,
          centerTitle: true,

          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()
                {
                },
                child: Container(
                  child: Image.asset("assets/images/back.png",height: 10,width: 10),
                ),
              )
          ),

          title: const Text(
            'Product Video',
            style: TextStyle(color: Colors.white),
          ),
          */
        /*actions: [
            IconButton(
              icon: const Icon(Icons.video_library),


            ),
          ],*/
        /*
        ),*/
        body: Container(
          height: double.infinity,

          child: Column(
            children: [
              Container(
                height: SizeConfig.blockSizeVertical * 12,
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
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 6,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/images/back.png",
                            color: AppColors.whiteColor,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      alignment: Alignment.center,
                      margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                      // margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        'video'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins-Regular",
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical * 2),
                    ),
                  ],
                ),
              ),
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /* _space,
                  _text('Title', _videoMetaData.title),
                  _space,
                  _text('Channel', _videoMetaData.author),
                  _space,
                  _text('Video Id', _videoMetaData.videoId),
                  _space,
                  Row(
                    children: [
                      _text(
                        'Playback Quality',
                        _controller.value.playbackQuality ?? '',
                      ),
                      const Spacer(),
                      _text(
                        'Playback Rate',
                        '${_controller.value.playbackRate}x  ',
                      ),
                    ],
                  ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       /* IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: _isPlayerReady
                              ? () => _controller.load(_ids[
                          (_ids.indexOf(_controller.metadata.videoId) -
                              1) %
                              _ids.length])
                              : null,
                        ),*/
                        _space,
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                            setState(() {});
                          }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                          onPressed: _isPlayerReady
                              ? () {
                            _muted
                                ? _controller.unMute()
                                : _controller.mute();
                            setState(() {
                              _muted = !_muted;
                            });
                          }
                              : null,
                        ),
                        FullScreenButton(
                          controller: _controller,
                          color:  AppColors.themecolor,
                        ),
                        _space,
                       /* IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: _isPlayerReady
                              ? () => _controller.load(_ids[
                          (_ids.indexOf(_controller.metadata.videoId) +
                              1) %
                              _ids.length])
                              : null,
                        ),*/
                      ],
                    ),
                    _space,
                    Row(
                      children: <Widget>[
                         Text('volume'.tr,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.transparent,
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 10,
                            label: '${(_volume).round()}',
                            onChanged: _isPlayerReady
                                ? (value) {
                              setState(() {
                                _volume = value;
                              });
                              _controller.setVolume(_volume.round());
                            }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    _space,

                  ],
                ),
              ),
            ],
          ),
        )

      ),
    ):Container();
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);



}