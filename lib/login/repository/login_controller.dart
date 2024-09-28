import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilabs/helper/ap_constant.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:medilabs/login/repository/model/splash_response.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/login/ui/login_screen.dart';

class LoginController extends GetxController {
  var loading = false.obs;

  Future<SplashResponse> getSplashData() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.SPLASHAPI}").catchError((e) {
      print("Errrrrr ${e}");
      Constant.showToast("Server Error");
      // Get.to(LoginScreen());
    });

    SplashResponse splashResponse = SplashResponse.fromJson(response.data);
    GetStorage().write(Constant.SPLASHDATA, splashResponse);

    return splashResponse;
  }

  Future<LoginResponse> login(String number) async {
    var dio = Dio();
    final response =
        await dio.get("${ApiConstant.SIGNIN}${number}").catchError((e) {
      print("Errrrrr ${e}");
      Get.to(LoginScreen());
    });

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.success!) {
    } else {}
    return loginResponse;
  }

  Future<LoginResponse> checkOtp(String userID, String otp) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.CHECK_OTP_USER}${userID}${ApiConstant.OTP}${otp}")
        .catchError((e) {
      print("Errrrrr ${e}");
      Get.to(LoginScreen());
    });

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.success!) {
      GetStorage().write(Constant.USERID, loginResponse.data!.id.toString());
    }

    return loginResponse;
  }
}
