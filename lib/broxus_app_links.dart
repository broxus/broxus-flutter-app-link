import 'broxus_app_links_platform_interface.dart';

class BroxusAppLinks {
  BroxusAppLinks._();

  factory BroxusAppLinks() {
    return _instance ??= BroxusAppLinks._();
  }

  static BroxusAppLinks get instance => _instance ?? BroxusAppLinks();

  static BroxusAppLinks? _instance;

  final _platform = BroxusAppLinksPlatform.instance;

  Stream<Uri> get uriStream => _platform.uriStream;
}
