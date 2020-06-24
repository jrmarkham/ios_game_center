import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


enum SigninResultType {
  SUCCESS,
  NOT_SIGNED_IN,
  ERROR_SIGNIN,
  ERROR_FETCH_PLAYER_PROFILE,
  ERROR_NOT_SIGNED_IN,
  ERROR_IOS,
  ERROR_SIGN_OUT
}

class Account {
  String id;
  String displayName;
  String email;
//  String hiResImageUri;
//  String iconImageUri;
//
//  Future<Image> get hiResImage async =>
//      await _fetchToMemory(await _channel.invokeMethod('getHiResImage'));
//
//  Future<Image> get iconImage async =>
//      await _fetchToMemory(await _channel.invokeMethod('getIconImage'));
}


class SigninResult {
  SigninResultType type;
  Account account;
  String message;

  bool get success => type == SigninResultType.SUCCESS;
}



class IOSGameCenter {
  static const MethodChannel _channel =
      const MethodChannel('plugin.markhamenterprises.com/ios_game_center');

  static Future<SigninResult> get signIn async {
    final Map<dynamic, dynamic> _response = await _channel.invokeMethod('getSignIn');

    if( _response['response'] != 'success') {
      final SigninResultType type =  SigninResultType.NOT_SIGNED_IN;
      SigninResult result = new SigninResult()..type = type;
      result.message =  _response['message'];
      return result;
    }

    final SigninResultType type =  SigninResultType.SUCCESS;
    SigninResult result = new SigninResult()..type = type;
    result.account = Account()
      ..id =  _response['id']
    ..displayName =  _response['displayName']
    ..email =  _response['email'];

    result.message =  _response['message'];



     return result;
  }
}
