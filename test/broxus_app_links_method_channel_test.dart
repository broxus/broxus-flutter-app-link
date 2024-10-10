import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:broxus_app_links/broxus_app_links_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBroxusAppLinks platform = MethodChannelBroxusAppLinks();
  const MethodChannel channel = MethodChannel('broxus_app_links');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
