import 'package:flutter_weather/commom_import.dart';

class ChannelUtil {
  /// 平台通道工具
  static final _platform = MethodChannel(_ChannelTag.CHANNEL_NAME);

  /// 获取位置
  static Future<String> getLocation() async {
    String result;

    if (isIOS) return null;

    try {
      result = await _platform.invokeMethod(_ChannelTag.START_LOCATION);
    } on PlatformException catch (e) {
      _doError(e);
    }

    return result;
  }

  static void _doError(PlatformException e) =>
      debugPrint("=====>通道错误：${e.toString()}");
}

/// 平台通道的名字和方法
abstract class _ChannelTag {
  static const CHANNEL_NAME = "flutter_weather_channel";

  static const START_LOCATION = "startLocation";
}
