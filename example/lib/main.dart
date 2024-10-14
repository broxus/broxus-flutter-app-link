import 'package:flutter/material.dart';
import 'dart:async';
import 'package:broxus_app_links/broxus_app_links.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = BroxusAppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Uri? _uri;

  @override
  void initState() {
    _linkSubscription = _appLinks.uriStream.listen(_handleLink);
    super.initState();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Url = $_uri'),
        ),
      ),
    );
  }

  void _handleLink(Uri uri) {
    setState(() {
      _uri = uri;
    });
  }
}
