import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:broxus_app_links/broxus_app_links_platform_interface.dart';
import 'package:broxus_app_links/broxus_app_links_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBroxusAppLinksPlatform
    with MockPlatformInterfaceMixin
    implements BroxusAppLinksPlatform {
  late final _uriController = StreamController<Uri>();

  @override
  late final Stream<Uri> uriStream = _uriController.stream.asBroadcastStream();
}

void main() {
  final BroxusAppLinksPlatform initialPlatform =
      BroxusAppLinksPlatform.instance;

  test('$MethodChannelBroxusAppLinks is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBroxusAppLinks>());
  });
}
