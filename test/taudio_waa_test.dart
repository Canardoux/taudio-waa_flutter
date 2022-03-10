import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taudio_waa/taudio_waa.dart';

void main() {
  const MethodChannel channel = MethodChannel('taudio_waa');

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
    expect(await TaudioWaa.platformVersion, '42');
  });
}
