import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// ENUM for Signi
enum SignInResultType {
  SUCCESS,
  ERROR,
  ERROR_NOT_SIGN_IN,
  ERROR_ANDROID
}

SignInResultType getSignType(String text)=> SignInResultType.values.firstWhere((SignInResultType type) => describeEnum(type)== text);

class Account {
  String id;
  String displayName;
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
  static const MethodChannel _channel = const MethodChannel('plugin.markhamenterprises.com/ios_game_center');

  static Future<SignInResult> get signIn async {
    final Map<dynamic, dynamic> _response = await _channel.invokeMethod('getSignIn');
    final SignInResultType type = getSignType(_response['response']);
    debugPrint ('response ${_response['response']}');
    debugPrint ('type ${type.toString()}');

    SignInResult result = new SignInResult()..type = type;
    result.message =  _response['message'];

    if(result.type == SignInResultType.SUCCESS) {
      result.account = Account (
      )
        ..id = _response['id']
        ..displayName = _response['displayName'];
      // TO DO ADD IMAGE CONNECTION

    }
    return result;
     }

  // LEADERBOARD
  static Future<bool> showLeaderboard(String id) async => await _channel
      .invokeMethod('showLeaderboard', {'id': id}) == "success";

  static Future<bool> submitScore({@required String id, @required int score}) async => await _channel.invokeMethod(
        'submitScore', {'id': id, 'score': score}) == "success";


  // ACHIEVEMENTS
  static Future<bool> showAchievements() async => await _channel.invokeMethod('showAchievements') == "success";
  static Future<bool> unlockAchievement(String id) async => await _channel.invokeMethod(
  'unlockAchievement', {'id': id}) == "success";

  static Future<bool> setPercentAchievement({@required String id, @required double percent}) async {
    return await _channel
        .invokeMethod('setPercentAchievement', {'id': id, 'percent': percent}) == "success";
  }








}
