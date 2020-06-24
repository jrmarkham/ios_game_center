import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


enum SignInResultType {
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


class SignInResult {
  SignInResultType type;
  Account account;
  String message;

  bool get success => type == SignInResultType.SUCCESS;
}



class IOSGameCenter {
  static const MethodChannel _channel =
      const MethodChannel('plugin.markhamenterprises.com/ios_game_center');

  static Future<SignInResult> get signIn async {
    final Map<dynamic, dynamic> _response = await _channel.invokeMethod('getSignIn');

    if( _response['response'] != 'success') {
      final SignInResultType type =  SignInResultType.NOT_SIGNED_IN;
      SignInResult result = new SignInResult()..type = type;
      result.message =  _response['message'];
      return result;
    }

    final SignInResultType type =  SignInResultType.SUCCESS;
    SignInResult result = new SignInResult()..type = type;
    result.account = Account()
      ..id =  _response['id']
    ..displayName =  _response['displayName']
    ..email =  _response['email'];

    result.message =  _response['message'];



     return result;
  }
}
