import 'package:flutter/widgets.dart';

/// 颜色的工具类
class ColorUtils {
  /// 字符串转颜色（0x 或 # 或都不带）
  static Color? colorFromString(String? code) {
    if (code == null) {
      return null;
    }
    Color? color;
    if (code.startsWith("0x") || code.startsWith("#")) {
      code = code.replaceFirst("0x", "").replaceFirst("#", "");
      try {
        color = Color(int.parse(code, radix: 16) +
            (code.length == 8 ? 0x00000000 : 0xFF000000));
      } catch (e) {
        debugPrint(e.toString());
      }
    } else if (code.indexOf(",") > 0) {
      var codeArray = code.split(",");
      if (codeArray.length == 4) {
        color = Color.fromRGBO(
          int.parse(codeArray[0]),
          int.parse(codeArray[1]),
          int.parse(codeArray[2]),
          double.parse(codeArray[3]),
        );
      } else if (codeArray.length == 3) {
        color = Color.fromRGBO(
          int.parse(codeArray[0]),
          int.parse(codeArray[1]),
          int.parse(codeArray[2]),
          1,
        );
      }
    }
    return color;
  }

  /// 将16进制字符串成对应的 Color，如 “#ffffffff”，转换成 Color(0xffffffff)
  static Color? hexToColor(String? code) {
    if (code == null || code.isEmpty) {
      return null;
    }
    if (code.length == 7 || code.length == 9) {
      if (!code.startsWith("#")) {
        return null;
      }
      code = code.substring(1, code.length);
    }
    if (code.length != 6 && code.length != 8) {
      return null;
    }
    Color? color;
    try {
      color = Color(int.parse(code, radix: 16) +
          (code.length == 8 ? 0x00000000 : 0xFF000000));
    } catch (e) {
      debugPrint(e.toString());
    }
    return color;
  }

  /// 将指定颜色转换为禁用色
  /// 根据和产品确认，目前所有的禁用色为原色 + alpha 0.4
  /// ps: 蓝湖设计图不准确，以此为准
  static Color toDisabledColor(Color color) {
    return color.withAlpha((color.alpha * 0.4).toInt());
  }

  /// 将16进制色值(如0xffffffff)转换成对应的禁用色
  static Color toDisabledColorWithHex(int hex) {
    return ColorUtils.toDisabledColor(Color(hex));
  }
}
