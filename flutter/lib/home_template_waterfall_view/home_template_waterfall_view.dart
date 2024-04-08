import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'custom_empty_view.dart';
import 'template_view_model_extension.dart';
import './template_view_cell.dart';
import '.caches/home_template_waterfall_view.api.dart';
import '.caches/home_template_waterfall_view.base.dart';

/// 首页 - 模版瀑布流视图
///
/// AUTO LAYOUT
class HomeTemplateWaterfallView extends HomeTemplateWaterfallViewBase {
  /// 头部视图
  final Widget? headerView;

  /// 长按
  final Function(HomeTemplateWaterfallViewModel model)? onLongPress;

  const HomeTemplateWaterfallView({
    Key? key,
    EventBus? eventBus,
    HomeTemplateWaterfallViewConfigMaker? maker,
    Function(String trackName, int trackId, Map detailInfo)? windTrack,
    void Function()? onRefresh,
    void Function()? onLoad,
    Function(String url, Map parameters)? onOpenURL,
    this.headerView,
    this.onLongPress,
  }) : super(
          key: key,
          eventBus: eventBus,
          maker: maker,
          handleRefresh: onRefresh,
          handleLoad: onLoad,
          handleOpenURL: onOpenURL,
          windTrack: windTrack,
        );

  @override
  State<StatefulWidget> createState() {
    return _HomeTemplateWaterfallViewState();
  }
}

class _HomeTemplateWaterfallViewState
    extends HomeTemplateWaterfallViewStateBase {
  List<HomeTemplateWaterfallViewModel?> dataList = [];
  late ScrollController _scrollController;
  late EasyRefreshController _refreshController;
  var _refreshing = false, _loadingMore = false;

  HomeTemplateWaterfallView get self {
    return widget as HomeTemplateWaterfallView;
  }

  @override
  void initState() {
    super.initState();
    initListController();
  }

  void initListController() {
    _scrollController = ScrollController();
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: EasyRefresh.builder(
        refreshOnStart: true,
        controller: _refreshController,
        onRefresh: () {
          if (!_refreshing) {
            _refreshing = true;
            handleRefresh();
          }
          return false;
        },
        onLoad: () {
          if (!_loadingMore) {
            _loadingMore = true;
            handleLoad();
          }
          return false;
        },
        childBuilder: (BuildContext content, ScrollPhysics physics) {
          return CustomScrollView(
            physics: physics,
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: _headerView(),
              ),
              !_refreshing && dataList.isEmpty
                  ? emptyView
                  : SliverPadding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 12, right: 12),
                      sliver: _gridView(),
                    ),
            ],
          );
        },
      ),
    );
  }

  @override
  void updateCurrentLocale(Locale locale) {
    setState(() {});
  }

  @override
  void loadData(bool success, List<HomeTemplateWaterfallViewModel?> data) {
    if (_refreshing) {
      setState(() {
        _refreshing = false;
      });
      _refreshController.finishRefresh(
          success ? IndicatorResult.success : IndicatorResult.fail);
      _refreshController.resetFooter();
    }
    if (_loadingMore) {
      setState(() {
        _loadingMore = false;
      });
      _refreshController.finishLoad(
        success
            ? data.isEmpty
                ? IndicatorResult.noMore
                : IndicatorResult.success
            : IndicatorResult.fail,
      );
    }
    if (success) {
      setState(() {
        dataList.addAll(data);
      });
    }
  }

  @override
  void clear() {
    setState(() {
      dataList.clear();
    });
  }

  @override
  void scrollTo(double scrollY, bool animate) {
    if (animate) {
      _scrollController.animateTo(
        scrollY,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _scrollController.jumpTo(scrollY);
    }
  }

  // LAYOUT

  Widget _headerView() {
    return (widget as HomeTemplateWaterfallView).headerView ?? Container();
  }

  Widget _gridView() {
    double spacing = 8;

    return SliverMasonryGrid.count(
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      crossAxisCount: 3,
      childCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        var model = dataList[index]!;
        return TemplateViewCell(
          model: model,
          size: model.imageDisplaySize(maker.screenWidth!),
          onClickItem: () {
            _handleSelect(model);
          },
          onLongPress: () {
            if (self.onLongPress != null) {
              self.onLongPress!(model);
            }
          },
          onExposure: (bool exposure) {},
        );
      },
    );
  }

  _handleSelect(HomeTemplateWaterfallViewModel model) {
    if (model.schemeUrl != null && model.schemeUrl!.isNotEmpty) {
      handleOpenURL(model.schemeUrl!, {});
      return;
    }
    if (model.isMarketAdvert != null && model.isMarketAdvert!) {
      return;
    }
    Map<String, Object> params = {
      "material_from": "创作页-信息流",
    };
    if (model.isH5) {
      params["isH5Template"] = true;
    }
    handleOpenURL("ttxs://template/${model.materialId}", params);
  }
}
