import 'package:flutter/material.dart';
import 'package:flutter_mood/utils/values/ad_utils.dart';
import 'package:gtads/gtads.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GTAdsSplashWidget(
        codes: AdUtils.splashAd,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //超时时间 当广告失败后会依次重试其他广告 直至所有广告均加载失败 设置超时时间可提前取消
        timeout: AdUtils.splashTimeout,
        callBack: GTAdsCallBack(
          onShow: (code) {},
          onClick: (code) {},
          onFail: (code, message) {},
          onClose: (code) {
            Navigator.pop(context);
          },
          onTimeout: () {
            Navigator.pop(context);
          },
          onEnd: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
