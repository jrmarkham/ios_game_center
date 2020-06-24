import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ios_game_center/ios_game_center.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignInResult _results;

  @override
  void initState() {
    super.initState();
    signIn();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> signIn() async {
    SignInResult results;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      results = await IOSGameCenter.signIn;
      debugPrint('_signIn');
    } on PlatformException {
      results = null;
    }
    if (!mounted) return;

    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Sign On: ${_results!=null? _results.toString():'not connected'}'),

        ),
      ),
    );
  }
}
