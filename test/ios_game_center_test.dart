import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_game_center/ios_game_center.dart';

void main() {
  const MethodChannel channel = MethodChannel('plugin.markhamenterprises.com/ios_game_center');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getSignIn', () async {
    expect(await IOSGameCenter.signIn, '42');
  });
}
