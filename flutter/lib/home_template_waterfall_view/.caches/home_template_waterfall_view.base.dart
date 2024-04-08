// AUTO GENERATE API
//
// NOTES: 自动生成，无需手动修改.

import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
export 'package:event_bus/event_bus.dart';
import 'home_template_waterfall_view.api.dart';

/// Event: 清理数据
class ClearEvent {
  ClearEvent();
}

/// Event: 加载数据
class LoadDataEvent {
  bool success;
  List<HomeTemplateWaterfallViewModel?> datas;
  LoadDataEvent(this.success, this.datas);
}

/// Event: 滚动位置
class ScrollToEvent {
  double scrollY;
  bool animate;
  ScrollToEvent(this.scrollY, this.animate);
}

/// Event: 「通用」更新埋点补充信息
class UpdateWindSupplementaryInfoEvent {
  Map<String?, Object?> windSupplementaryInfo;
  UpdateWindSupplementaryInfoEvent(this.windSupplementaryInfo);
}

class HomeTemplateWaterfallViewConfigMaker {
  /// 是否是在多引擎中运行
  static bool runByMutiEngines = false;

  HomeTemplateWaterfallViewConfigMaker({
    this.categoryName,
    this.currentLocale,
    this.screenWidth = 320,
    this.screenHeight = 480,
  });

  /// 分类名称
  String? categoryName;

  /// 「通用」当前环境语言<lang:, country:>
  Map? currentLocale;

  /// 「通用」屏幕宽度(pt)
  double? screenWidth;

  /// 「通用」屏幕高度(pt)
  double? screenHeight;
}

/// 首页 - 模版瀑布流视图-基类
abstract class HomeTemplateWaterfallViewBase extends StatefulWidget {
  const HomeTemplateWaterfallViewBase({
    Key? key,
    this.eventBus,
    this.windTrack,
    this.maker,
    this.handleRefresh,
    this.handleLoad,
    this.handleOpenURL,
    this.handleScroll,
  }) : super(key: key);

  final HomeTemplateWaterfallViewConfigMaker? maker;
  final EventBus? eventBus;
  final Function(
          String trackName, int trackId, Map<dynamic, dynamic> detailInfo)?
      windTrack;

  /// 刷新
  final void Function()? handleRefresh;

  /// 加载更多
  final void Function()? handleLoad;

  /// 回调打开 URL
  final void Function(String url, Map parameters)? handleOpenURL;

  /// 滚动回调
  final void Function(double scrollY)? handleScroll;
}

class HomeTemplateWaterfallViewFlutterAPIHandle
    extends HomeTemplateWaterfallViewFlutterAPI {
  final void Function(HomeTemplateWaterfallViewConfigMaker maker) makerCallback;

  final void Function() clearCallback;

  final void Function(bool success, List<HomeTemplateWaterfallViewModel?> datas)
      loadDataCallback;

  final void Function(double scrollY, bool animate) scrollToCallback;

  final void Function(Map<String?, Object?> windSupplementaryInfo)
      updateWindSupplementaryInfoCallback;

  HomeTemplateWaterfallViewFlutterAPIHandle({
    required this.makerCallback,
    required this.clearCallback,
    required this.loadDataCallback,
    required this.scrollToCallback,
    required this.updateWindSupplementaryInfoCallback,
  });

  @override
  void config(HomeTemplateWaterfallViewConfig maker) {
    var item = HomeTemplateWaterfallViewConfigMaker(
      categoryName: maker.categoryName!,
      currentLocale: maker.currentLocale!,
      screenWidth: maker.screenWidth!,
      screenHeight: maker.screenHeight!,
    );
    makerCallback(item);
  }

  @override
  void clear() {
    return clearCallback();
  }

  @override
  void loadData(bool success, List<HomeTemplateWaterfallViewModel?> datas) {
    return loadDataCallback(success, datas);
  }

  @override
  void scrollTo(double scrollY, bool animate) {
    return scrollToCallback(scrollY, animate);
  }

  @override
  void updateWindSupplementaryInfo(
      Map<String?, Object?> windSupplementaryInfo) {
    return updateWindSupplementaryInfoCallback(windSupplementaryInfo);
  }
}

abstract class HomeTemplateWaterfallViewStateBase
    extends State<HomeTemplateWaterfallViewBase> {
  late HomeTemplateWaterfallViewHostAPI hostAPI;

  late HomeTemplateWaterfallViewConfigMaker maker;

  final _loadStart = DateTime.now().millisecondsSinceEpoch;

  // MARK: LifeCircle

  @override
  void initState() {
    super.initState();
    hostAPI = HomeTemplateWaterfallViewHostAPI();
    _slsPushListener();
    maker = widget.maker ?? HomeTemplateWaterfallViewConfigMaker();
    _updateCurrentLocale(maker.currentLocale);

    widget.eventBus?.on<ClearEvent>().listen((event) {
      clear();
    });
    widget.eventBus?.on<LoadDataEvent>().listen((event) {
      loadData(event.success, event.datas);
    });
    widget.eventBus?.on<ScrollToEvent>().listen((event) {
      scrollTo(event.scrollY, event.animate);
    });
    widget.eventBus?.on<UpdateWindSupplementaryInfoEvent>().listen((event) {
      updateWindSupplementaryInfo(event.windSupplementaryInfo);
    });
    if (!HomeTemplateWaterfallViewConfigMaker.runByMutiEngines) {
      setupUI();
      return;
    }
    var that = this;
    HomeTemplateWaterfallViewFlutterAPI.setup(
        HomeTemplateWaterfallViewFlutterAPIHandle(
      makerCallback: (maker) {
        that.maker = maker;
        that._updateCurrentLocale(maker.currentLocale);
        // :autolayout
        setupUI();
      },
      clearCallback: () {
        that.clear();
      },
      loadDataCallback: (success, datas) {
        that.loadData(success, datas);
      },
      scrollToCallback: (scrollY, animate) {
        that.scrollTo(scrollY, animate);
      },
      updateWindSupplementaryInfoCallback: (windSupplementaryInfo) {
        that.updateWindSupplementaryInfo(windSupplementaryInfo);
      },
    ));
  }

  /// initMaker 后，启动 UI 布局时机
  void setupUI() {}

  @override
  void dispose() {
    widget.eventBus?.destroy();
    super.dispose();
  }

  /// 清理数据
  @protected
  void clear();

  /// 加载数据
  @protected
  void loadData(bool success, List<HomeTemplateWaterfallViewModel?> datas);

  /// 滚动位置
  @protected
  void scrollTo(double scrollY, bool animate);

  /// 刷新
  void handleRefresh() {
    if (widget.handleRefresh != null) {
      widget.handleRefresh!();
      return;
    }
    hostAPI.handleRefresh().catchError((error) {
      debugPrint("hostAPI handleRefresh no exists");
    });
  }

  /// 加载更多
  void handleLoad() {
    if (widget.handleLoad != null) {
      widget.handleLoad!();
      return;
    }
    hostAPI.handleLoad().catchError((error) {
      debugPrint("hostAPI handleLoad no exists");
    });
  }

  /// 回调打开 URL
  void handleOpenURL(String url, Map parameters) {
    if (widget.handleOpenURL != null) {
      widget.handleOpenURL!(url, parameters);
      return;
    }
    hostAPI.handleOpenURL(url, parameters).catchError((error) {
      debugPrint("hostAPI handleOpenURL no exists");
    });
  }

  /// 滚动回调
  void handleScroll(double scrollY) {
    if (widget.handleScroll != null) {
      widget.handleScroll!(scrollY);
      return;
    }
    hostAPI.handleScroll(scrollY).catchError((error) {
      debugPrint("hostAPI handleScroll no exists");
    });
  }
  // :autolayout

  // 「通用」i18n

  /// 更新当前语言
  @protected
  void updateCurrentLocale(Locale locale);

  void _updateCurrentLocale(Map? map) {
    map ??= {"lang": "en", "country": ""};
    updateCurrentLocale(Locale(
      map["lang"]!,
      map["country"]!,
    ));
  }

  // 「通用」埋点相关

  /// 补充埋点信息
  void updateWindSupplementaryInfo(Map windSupplementaryInfo) {
    _windSupplementaryInfo = windSupplementaryInfo;
  }

  /// 获取埋点信息
  Map? get windSupplementaryInfo {
    return _windSupplementaryInfo;
  }

  /// 触发埋点上报
  void windTrack(String trackName, int trackId, Map detailInfo) {
    if (_windSupplementaryInfo != null) {
      _windSupplementaryInfo!.forEach((key, value) {
        detailInfo[key] = value;
      });
    }
    _windTrackList.add({
      "trackName": trackName,
      "trackId": trackId,
      "detailInfo": detailInfo,
    });
    _windPush();
  }

  late Map? _windSupplementaryInfo;

  final List _windTrackList = [];
  bool _windIsPushing = false;

  void _windPush() async {
    if (_windTrackList.isEmpty || _windIsPushing) {
      return;
    }
    var data = _windTrackList[0];
    _windIsPushing = true;
    if (widget.windTrack != null) {
      widget.windTrack!(data["trackName"], data["trackId"], data["detailInfo"]);
    } else {
      try {
        await hostAPI.windTrack(
            data["trackName"], data["trackId"], data["detailInfo"]);
      } catch (e) {}
    }
    debugPrint("埋点触发：$data");
    _windTrackList.removeAt(0);
    _windIsPushing = false;
    _windPush();
  }

  void _slsPushListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await hostAPI.slsTrack({
          "flutter_engine_load": _loadStart.toString(),
          "render_duration":
              (DateTime.now().millisecondsSinceEpoch - _loadStart).toString(),
        });
      } catch (e) {}
    });
  }
}
