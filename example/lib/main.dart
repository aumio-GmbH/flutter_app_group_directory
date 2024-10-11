import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app_group_directory/flutter_app_group_directory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Directory? _appGroup;

  Future<void> getAppGroup() async {
    Directory? appGroup;

    try {
      appGroup = await FlutterAppGroupDirectory.getAppGroupDirectory(
        'group.dimitridessus.flutter_app_group_directory',
      );
    } catch (_) {
      appGroup = null;
    }

    if (!mounted) return;

    setState(() {
      _appGroup = appGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  key: const Key('getAppGroupButton'),
                  onPressed: getAppGroup,
                  child: const Text('Get app group path'),
                ),
                const SizedBox(height: 10),
                if (_appGroup != null)
                  Text(
                    'App group path: ${_appGroup?.path}',
                    key: const Key('appGroupPath'),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
