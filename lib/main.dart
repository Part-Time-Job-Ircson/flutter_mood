import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mood/home/home_view.dart';
import 'package:flutter_mood/home/splash_view.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/utils/storage.dart';
import 'package:flutter_mood/utils/ui/loading.dart';
import 'package:flutter_mood/utils/values/ad_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gtads/gtads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage().init();
  Loading();
  initializeDateFormatting().then((_) => runApp(const MainView()));
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    initAd().then((value) {
      CommonRoute.open(const SplashPage());
    });
  }

  Future<List<Map<String, bool>>> initAd() async {
    GTAds.addProvider(AdUtils.provider);
    return await GTAds.init(isDebug: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: const HomePage(),
    );
  }
}
