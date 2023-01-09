import 'package:flutter_test/flutter_test.dart';
import 'package:willmod3/willmod3.dart';
import 'package:willmod3/willmod3_platform_interface.dart';
import 'package:willmod3/willmod3_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWillmod3Platform
    with MockPlatformInterfaceMixin
    implements Willmod3Platform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Willmod3Platform initialPlatform = Willmod3Platform.instance;

  test('$MethodChannelWillmod3 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWillmod3>());
  });

  test('getPlatformVersion', () async {
    WillMod3 willmod3Plugin = WillMod3();
    MockWillmod3Platform fakePlatform = MockWillmod3Platform();
    Willmod3Platform.instance = fakePlatform;

    expect('42', '42');
  });
}
