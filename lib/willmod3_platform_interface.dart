import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'willmod3_method_channel.dart';

abstract class Willmod3Platform extends PlatformInterface {
  /// Constructs a Willmod3Platform.
  Willmod3Platform() : super(token: _token);

  static final Object _token = Object();

  static Willmod3Platform _instance = MethodChannelWillmod3();

  /// The default instance of [Willmod3Platform] to use.
  ///
  /// Defaults to [MethodChannelWillmod3].
  static Willmod3Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Willmod3Platform] when
  /// they register themselves.
  static set instance(Willmod3Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
