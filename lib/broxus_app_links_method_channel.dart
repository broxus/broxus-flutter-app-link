import 'dart:async';

import 'package:broxus_app_links/mapping/transformers.dart';
import 'package:broxus_app_links/methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'broxus_app_links_platform_interface.dart';

/// An implementation of [BroxusAppLinksPlatform] that uses method channels.
class MethodChannelBroxusAppLinks extends BroxusAppLinksPlatform {
  /// The method channel used to interact with the native platform.
  MethodChannelBroxusAppLinks();

  static const _methodChannelName = 'broxus_app_links/methods';

  @visibleForTesting
  late final methodChannel = const MethodChannel(_methodChannelName)
    ..setMethodCallHandler(_onNativeData);

  late final _uriController = StreamController<Uri>();

  @override
  late final Stream<Uri> uriStream = _uriController.stream.asBroadcastStream();

  Future<void> _onNativeData(MethodCall call) async {
    final payload = call.arguments;

    Uri? link;

    print('!!! Methods ${Methods.newUri.equals(call.method)}');

    if (Methods.newUri.equals(call.method)) {
      link = transformToUri(payload);
    }
    print('!!! link $link ${link == null}');
    if (link == null) {
      return;
    }

    print('!!! onNativeData');
    _uriController.add(link);
  }
}
