import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'broxus_app_links_method_channel.dart';

abstract class BroxusAppLinksPlatform extends PlatformInterface {
  /// Constructs a BroxusAppLinksPlatform.
  BroxusAppLinksPlatform() : super(token: _token);

  static final Object _token = Object();

  static BroxusAppLinksPlatform _instance = MethodChannelBroxusAppLinks();

  /// The default instance of [BroxusAppLinksPlatform] to use.
  ///
  /// Defaults to [MethodChannelBroxusAppLinks].
  static BroxusAppLinksPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BroxusAppLinksPlatform] when
  /// they register themselves.
  static set instance(BroxusAppLinksPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<Uri> get uriStream;
}
