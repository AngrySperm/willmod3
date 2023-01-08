import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:willmod3/willmod3_method_channel.dart';

void main() {
  MethodChannelWillmod3 platform = MethodChannelWillmod3();
  const MethodChannel channel = MethodChannel('willmod3');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
