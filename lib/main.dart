import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/splash_screen.dart';

import 'dashboard/repository/dashboard_controller.dart';
import 'dashboard/widgets/state_city_dialog.dart';
import 'login/repository/login_controller.dart';

void main() async {
  await GetStorage.init();
  final loginController = Get.put(LoginController());
  final dashboardController = Get.put(DashboardController());
  Get.put(StateCityDialogController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TestNMeds',
      theme: ThemeData(
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
