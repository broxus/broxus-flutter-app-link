import 'package:flutter_test/flutter_test.dart';
import 'package:broxus_app_links/broxus_app_links.dart';
import 'package:broxus_app_links/broxus_app_links_platform_interface.dart';
import 'package:broxus_app_links/broxus_app_links_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBroxusAppLinksPlatform
    with MockPlatformInterfaceMixin
    implements BroxusAppLinksPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BroxusAppLinksPlatform initialPlatform = BroxusAppLinksPlatform.instance;

  test('$MethodChannelBroxusAppLinks is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBroxusAppLinks>());
  });

  test('getPlatformVersion', () async {
    BroxusAppLinks broxusAppLinksPlugin = BroxusAppLinks();
    MockBroxusAppLinksPlatform fakePlatform = MockBroxusAppLinksPlatform();
    BroxusAppLinksPlatform.instance = fakePlatform;

    expect(await broxusAppLinksPlugin.getPlatformVersion(), '42');
  });
}
