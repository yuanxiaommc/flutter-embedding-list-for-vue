// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'home_template_waterfall_view/.caches/home_template_waterfall_view.api.dart';
import 'home_template_waterfall_view/.caches/home_template_waterfall_view.base.dart';
import 'home_template_waterfall_view/home_template_waterfall_view.dart';

import 'dart:js_interop' as js;
import 'dart:js_interop_unsafe' as js_util;

import 'utils/js_interop_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

@js.JSExport()
class _MyAppState extends State<MyApp> {
  final eventBus = EventBus();
  final _streamController = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    final export = js.createJSInteropWrapper(this);
    js.globalContext['_appState'] = export;
    broadcastAppEvent('flutter-initialized', export);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeTemplateWaterfallView(
        eventBus: eventBus,
        maker: HomeTemplateWaterfallViewConfigMaker(
          screenWidth: MediaQuery.of(context).size.width,
          screenHeight: MediaQuery.of(context).size.height,
        ),
        onLoad: () {
          broadcastAppEvent('flutter-list-load-more');
        },
        onRefresh: () {
          eventBus.fire(ClearEvent());
          broadcastAppEvent('flutter-list-refresh');
        },
        onOpenURL: (String url, Map parameters) {},
      ),
    );
  }

  @js.JSExport()
  void load(String listString) {
    List<HomeTemplateWaterfallViewModel> list = [];
    const JsonDecoder decoder = JsonDecoder();
    List<dynamic> jsonList = decoder.convert(listString);
    for (dynamic data in jsonList) {
      var model = HomeTemplateWaterfallViewModel.decode(data);
      list.add(model);
    }
    eventBus.fire(LoadDataEvent(true, list));
  }

  @js.JSExport()
  void clear() {
    eventBus.fire(ClearEvent());
  }
}
