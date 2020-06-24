import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class IOSGameCenter {
  static const MethodChannel _channel =
      const MethodChannel('plugin.markhamenterprises.com/ios_game_center');

  static Future<Map<dynamic, dynamic>> get signIn async {
    final Map<dynamic, dynamic> _results = await _channel.invokeMethod('getSignIn');
    return _results;
  }
}
