import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'willmod3_platform_interface.dart';

/// An implementation of [Willmod3Platform] that uses method channels.
class MethodChannelWillmod3 extends Willmod3Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('willmod3');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
