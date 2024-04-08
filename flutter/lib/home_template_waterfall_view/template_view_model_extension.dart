import 'dart:math';

import 'package:flutter/rendering.dart';
import '.caches/home_template_waterfall_view.api.dart';

extension HomeTemplateWaterfallViewModelExtension
    on HomeTemplateWaterfallViewModel {
  /// 是否是长图
  bool get isLongPicture {
    return templateType == "h5_bargraph";
  }

  /// 是否是视频
  bool get isVideo {
    return type == "movie";
  }

  /// 是否是 H5 模版
  bool get isH5 {
    return ["h5_bargraph", "web_page", "odyssey"].contains(type);
  }

  /// 图片显示尺寸
  Size imageDisplaySize(double screenWidth) {
    var width = screenWidth / 3.0 - 28;
    if (isLongPicture) {
      var ratio = 0.51;
      var height = width / ratio + 9;
      return Size(width, height);
    } else {
      if (imageHeight == null) {
        assert(imageWidth == null);
        return const Size(0, 0);
      }
      var ratio = imageHeight! / imageWidth!;
      var height = max((width * ratio), (width * 0.5)) + 9;
      return Size(width, height);
    }
  }

  /// VIP 图片标志
  String? get vipTipImagePath {
    if (schemeUrl != null && schemeUrl!.isNotEmpty) {
      return null;
    }
    if (paymentTag == null || paymentTag!.isEmpty) {
      if (userOverRole == null || userOverRole == 0) {
        return price != null && price! > 0
            ? "assets/tag_price.png"
            : "assets/tag_free_icon.png";
      }
    } else {
      if (paymentTag == "FREE") {
        return "assets/tag_free_icon.png";
      } else if (paymentTag == "PAY") {
        return "assets/tag_price.png";
      }
    }
    return null;
  }
}
