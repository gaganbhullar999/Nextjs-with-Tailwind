import 'dart:async';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/login/repository/login_controller.dart';
import 'package:medilabs/login/ui/boarding_screen.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/repository/dashboard_controller.dart';
import 'helper/constant.dart';
import 'helper/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = Get.find();
  final DashboardController dashboardController = Get.find();

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image.asset(
            "images/logo.png",
            height: 250,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(GetStorage().read(Constant.welcomescreen));
    getPrefs();
    GetStorage().remove(Constant.items);
    GetStorage().remove(Constant.CATEGORIES);
    GetStorage().remove(Constant.APPLIED_COUPON);

    getHomeData();
    getBoardingData();
    // checklogin(context);

    // var userID = GetStorage().read(Constant.USERID);
    //
    // if(userID!=null){
    //   userID.toString().isEmpty? getBoardingData():Get.to(HomeBottomBar());
    //
    // }else {
    // }
  }

  Future<void> getBoardingData() async {
    await loginController.getSplashData();
    //      // .then((value) =>
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //
    // }).then((value) {
    //
    //
    // }));
  }

  Future<void> getHomeData() async {
    await dashboardController.getHomeData();
    if (GetStorage().read(Constant.welcomescreen) == null) {
      GetStorage().write(Constant.welcomescreen, true);
      Get.offAll(BoardingScreen());
    } else {
      if (GetStorage().read(Constant.welcomescreen)) {
        Get.offAll(HomeBottomBar(0));
      } else {
        GetStorage().write(Constant.welcomescreen, true);
        Get.offAll(BoardingScreen());
      }
    }
    // if(Constant.iswelcomescreen){
    //
    // }else {
    //   print("xxxxxxxyyyyyyyyyyyyy");
    //   GetStorage().write(Constant.welcomescreen, true);
    //   // GetStorage().
    //   print("yyyyyyyyyyyyydddddd");
    //   print(GetStorage().read(Constant.welcomescreen));
    //
    //
    // }

    // checklogin();
  }

  void checklogin(BuildContext context) {
    if (getPrefs() != null) {
      // Get.to(PatientDetailsScreen());
      // Get.offAll(HomeBottomBar(0));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeBottomBar(0)));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BoardingScreen()));
    }
  }

  Future<void> getPrefs() async {
    print(GetStorage().read(Constant.welcomescreen));
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Constant.welcomescreen) == null) {
      Constant.iswelcomescreen = false;
    } else {
      Constant.iswelcomescreen = true;
    }

    // sharedPreferences.setBool(Constant.iswelcomescreen, true);
    // if(sharedPreferences.getString(Constant.USERID)==null){
    //   Constant.USERLOGGEDIN = false;
    // }else {
    //   Constant.USERLOGGEDIN = true;
    // }
  }
}
