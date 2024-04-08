import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/scale_animate_button.dart';
import '../utils/color_utils.dart';
import '.caches/home_template_waterfall_view.api.dart';
import './template_view_model_extension.dart';

class TemplateViewCell extends StatelessWidget {
  final HomeTemplateWaterfallViewModel model;
  final Size size;
  final void Function() onClickItem;
  final void Function()? onLongPress;
  final void Function(bool exposure) onExposure;

  const TemplateViewCell({
    Key? key,
    required this.model,
    required this.size,
    required this.onClickItem,
    required this.onExposure,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ScaleAnimateButton(
        scale: 0.05,
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onClickItem();
        },
        onLongPress: onLongPress,
        child: Stack(
          children: stackContainer(),
        ),
      ),
    );
  }

  List<Widget> stackContainer() {
    List<Widget> list = [];
    list.add(imageView());
    if (model.isVideo) {
      list.add(videoTipView());
    } else if (model.type == "plog") {
      list.add(plogView());
    }
    if (model.vipTipImagePath != null) {
      list.add(vipTipView());
    }
    return list;
  }

  Widget imageView() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: CachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
        imageUrl: model.imageUrl!,
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 0),
        fadeOutDuration: const Duration(milliseconds: 0),
        placeholder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              color: ColorUtils.colorFromString(
                  model.backgroundColor ?? "0xfff6f7f9"),
              //背景色
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
        placeholderFadeInDuration: const Duration(milliseconds: 0),
        errorWidget: (context, url, error) {
          return const Text("加载失败");
        },
      ),
    );
  }

  Widget videoTipView() {
    return Positioned(
      top: 5,
      left: 5,
      child: Image.asset(
        'assets/tag_video.png',
        width: 28,
        height: 22,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget vipTipView() {
    return Positioned(
      right: 4,
      bottom: 4,
      child: Image.asset(
        model.vipTipImagePath!,
        width: 28,
        height: 16,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget plogView() {
    return Positioned(
      left: 8,
      top: 8,
      child: Image.asset(
        'assets/tag_plog_icon.png',
        width: 33,
        height: 14,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
