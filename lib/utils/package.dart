import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtils {
  PackageInfo? info;

  Future _getInfo() async {
    info ??= await PackageInfo.fromPlatform();
  }

  Future<String> getAppName() async {
    await _getInfo();
    return info!.appName;
  }

  Future<String> getVersion() async {
    await _getInfo();
    return info!.version;
  }
}
