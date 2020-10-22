import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:insta_html_parser/insta_html_parser.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MyApp1 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;
  FlutterInsta flutterInsta = FlutterInsta();
  String username, followers = " ", following, bio, website, profileimage;
  bool pressed = false;
  bool downloading = false;
  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        print("valuessssssssssssss$value");
        _sharedText = value;
        print("Shared: $_sharedText");
      });
      main(_sharedText);
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        print("valuewwwwwwwwwwwwwwwwww$value");
        _sharedText = value;
        print("Shared: $_sharedText");
      });
      getInstadData(_sharedText);
//      printDetails(_sharedText);
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Shared files:", style: textStyleBold),
              Text(_sharedFiles
                      ?.map((f) =>
                          "{Path: ${f.path}, Type: ${f.type.toString().replaceFirst("SharedMediaType.", "")}\n")
                      ?.join(",") ??
                  ""),
              SizedBox(height: 100),
              Text("Shared urls/text:", style: textStyleBold),
              Text(_sharedText ?? "")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> main(_sharedFiles) async {
    var yt = YoutubeExplode();
    var video = await yt.videos.get(_sharedFiles);

    print('Title: ${video.title}');
    print('duration: ${video.duration}');
    print('description: ${video.description}');

    // Close the YoutubeExplode's http client.
    yt.close();
  }

  getInstadData(_sharedText) async {
//    List<Widget> _widgetsList = [];
    print(InstaParser.postsUrlsFromProfile('$_sharedText').then((item) {
      print("item$item");
    }));
//    Map<String, String> _userData = await InstaParser.userDataFromProfile(
//        'www.instagram.com/p/CF1iEQ9lpeB/');
//    print(_userData);
////    print(_widgetsList);
  }

  Future printDetails(username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileimage = flutterInsta.imgurl; // Profile picture URL
      print(followers);
    });
  }
}



//#t=XmYs
