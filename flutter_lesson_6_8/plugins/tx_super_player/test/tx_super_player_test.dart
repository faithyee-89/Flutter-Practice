// @dart = 2.7

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tx_super_player/super_player.dart.bak';

void main() {
  const MethodChannel channel = MethodChannel('tx_super_player');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SuperPlayerPlugin.platformVersion, '42');
  });
}
