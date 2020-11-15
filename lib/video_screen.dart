import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VideoScreen extends StatefulWidget {
  static const String id = 'video_screen';
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  VideoPlayerController _videoController;
  VoidCallback listener;
  int _playbackTime = 0;
  double _volume = 0.5;

  void _initPlayer() async {
    _videoController = VideoPlayerController.asset(
        'images/dhoni.mp4');
    await _videoController.initialize();
    setState(() {});
  }
  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser;
      if (user != null){
        loggedInUser = user as FirebaseUser;
        print(loggedInUser.email);

      }}
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _initPlayer();
    _videoController.addListener(() {
      setState(() {
        _playbackTime = _videoController.value.position.inSeconds;
        _volume = _videoController.value.volume;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          FlatButton(
          onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          },
          child: Text('Sign Out'),)
        ],
        title: Text('Yellow Play'),),
      backgroundColor: Colors.amberAccent,
      body:
      SingleChildScrollView(child: _videoController.value.initialized  ? _playerWidget() : Container()),

      floatingActionButton: Row(
    mainAxisSize: MainAxisSize.min,
          children: [
    FloatingActionButton(
      hoverColor: Colors.red,
        foregroundColor: Colors.redAccent,
        splashColor: Colors.blue,
        onPressed: () {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
          setState(() {});
        },
      focusColor: Colors.red,
          child: _videoController.value.isPlaying
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
        ),
      ],),
    );
  }
  @override
  void deactivate() {
    _videoController.setVolume(0.0);
    _videoController.removeListener(listener);
    super.deactivate();
  }


  Widget _playerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16/9, //_videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
        Slider(
          value: _playbackTime.toDouble(),
          max: _videoController.value.duration.inSeconds.toDouble(),
          min: 0,
          onChanged: (v) {
            _videoController.seekTo(Duration(seconds: v.toInt()));
          },
        ),
        Text('Video Scrub'),
        Slider(
          value: _volume,
          max: 1,
          min: 0,
          onChanged: (v) {
            _videoController.setVolume(v);
          },
        ),
        Text('Volume'),
        Icon(Icons.volume_up, color: Colors.lightBlueAccent,),
        FlatButton(
          onPressed: () {
            AutoOrientation.landscapeAutoMode();
          },
          child: Padding(
            child: Text("Click Here to Full Screen (Landscape)"),
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
        FlatButton(
          onPressed: () {
            AutoOrientation.portraitAutoMode();
          },
          child: Padding(
            child: Text("Back to Portrait"),
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ],
    );
  }
}
