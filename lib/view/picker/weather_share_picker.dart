import 'package:flutter_weather/commom_import.dart';

class WeatherSharePicker extends StatefulWidget {
  final Weather weather;
  final AirNowCity air;
  final String city;

  WeatherSharePicker(
      {@required this.weather, @required this.air, @required this.city});

  @override
  State createState() => _WeatherPickState();

  /// 分享天气
  static void share(BuildContext context,
      {@required Weather weather,
      @required AirNowCity air,
      @required String city}) {
    showDialog(
      context: context,
      builder: (context) =>
          WeatherSharePicker(weather: weather, air: air, city: city),
    );
  }
}

class _WeatherPickState extends PageState<WeatherSharePicker> {
  @override
  Widget build(BuildContext context) {
    final now = widget.weather?.now;
    WeatherDailyForecast today;
    WeatherDailyForecast tomorrow;
    if (widget?.weather?.dailyForecast?.isNotEmpty == true) {
      today = widget.weather.dailyForecast.first;
      if (widget.weather.dailyForecast.length >= 2) {
        tomorrow = widget.weather.dailyForecast[1];
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      // 这玩意的实际表现跟Android的.9.png不太一样
      // Android的是中间拉伸，四周不变形
      // 这玩意是中间不变形，四周拉伸。。。无语
      // 所以只能暂时用三段图片合成
      body: Center(
        child: RepaintBoundary(
          key: boundaryKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "images/hammer_share1.jpg",
                width: getScreenWidth(context),
              ),
              Stack(
                children: <Widget>[
                  Image.asset(
                    "images/hammer_share2.jpg",
                    height: 200,
                    fit: BoxFit.fill,
                    width: getScreenWidth(context),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 24, top: 6),
                      child: Text(
                        '''${widget.city}天气：
                        \n${widget.weather?.update?.loc} 发布：
                        \n${now?.condTxt}，${now?.tmp}℃
                        \nPM2.5：${widget.air?.pm25}，${widget.air?.qlty}
                        \n今天：${today?.tmpMin}℃ ~ ${today?.tmpMax}℃，${today?.condTxtD}
                        \n明天：${tomorrow?.tmpMin}℃ ~ ${tomorrow?.tmpMax}℃，${tomorrow?.condTxtD}
                        ''',
                        style:
                            TextStyle(fontSize: 13, color: AppColor.colorText2),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                "images/hammer_share3.jpg",
                width: getScreenWidth(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}