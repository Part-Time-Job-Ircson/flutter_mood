import 'package:flutter/cupertino.dart';
import 'package:gtads/gtads.dart';
import 'package:gtads_csj/gtads_csj.dart';
import 'package:gtads_ylh/gtads_ylh.dart';

class AdUtils {
  static const String csjIosAppId = "5336122";
  static const String csjIosSplashKey = "888161429";
  static const String csjAndroidSplashKey = "888161429";
  static const String csjIosRewardKey = "951648841";
  static const String csjAndroidRewardKey = "951648841";
  static const String csjAlias = "csj";

  static const String ylhIosAppId = "1202126139";
  static const String ylhIosRewardKey = "6015021881720408";
  static const String ylhAndroidRewardKey = "6015021881720408";
  static const String ylhAlias = "ylh";

  static const int splashTimeout = 3;
  static const int rewardTimeout = 3;

  static List<GTAdsProvider> provider = [
    GTAdsCsjProvider(csjAlias, null, csjIosAppId, appName: "韩圈心情"),
    GTAdsYlhProvider(ylhAlias, null, ylhIosAppId),
  ];

  static List<GTAdsCode> splashAd = [
    GTAdsCode(alias: csjAlias, probability: 5, androidId: csjAndroidSplashKey, iosId: csjIosSplashKey),
  ];

  static List<GTAdsCode> rewardAd = [
    GTAdsCode(alias: csjAlias, probability: 5, androidId: csjAndroidRewardKey, iosId: csjIosRewardKey),
    GTAdsCode(alias: ylhAlias, probability: 5, androidId: ylhAndroidRewardKey, iosId: ylhIosRewardKey),
  ];

  static List<GTAdsCode> rewardAd1 = [
    GTAdsCode(alias: ylhAlias, probability: 5, androidId: '7095933526633342', iosId: '7095933526633342'),
  ];

  static Future showRewardAd(ValueChanged<bool> onVerify) async {
    bool isFinish = false;
    await GTAds.rewardAd(
      codes: rewardAd,
      //超时时间 当广告失败后会依次重试其他广告 直至所有广告均加载失败 设置超时时间可提前取消
      timeout: rewardTimeout,
      callBack: GTAdsCallBack(
        onVerify: (code, verify, transId, rewardName, rewardAmount) {
          isFinish = verify;
        },
        onClose: (_) => onVerify(isFinish),
      ),
    );
  }

  static Future showRewardAd1(ValueChanged<bool> onVerify) async {
    bool isFinish = false;
    await GTAds.rewardAd(
      codes: rewardAd1,
      //超时时间 当广告失败后会依次重试其他广告 直至所有广告均加载失败 设置超时时间可提前取消
      timeout: rewardTimeout,
      callBack: GTAdsCallBack(
        onVerify: (code, verify, transId, rewardName, rewardAmount) {
          isFinish = verify;
        },
        onClose: (_) => onVerify(isFinish),
      ),
    );
  }
}
