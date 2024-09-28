
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield.dart';
import 'package:medilabs/login/repository/login_controller.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:medilabs/login/ui/otp_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/helper/widgets/Dialogs.dart';

class LoginScreen extends StatelessWidget {
  var mobileController = TextEditingController();

  LoginController loginController = Get.find();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      //   if(GetStorage().read(Constant.SCREEN)!=null){
      //
      //     if(GetStorage().read(Constant.SCREEN)==LOGINSCREEN.ORDER||GetStorage().read(Constant.SCREEN)==LOGINSCREEN.PROFILE){
      //       Get.offAll(() => HomeBottomBar(0));
      //       print("ggggggggggg profile");
      //        // Get.offAll(HomeBottomBar(0));
      //       // Navigator.pushAndRemoveUntil(
      //       //   context,
      //       //   MaterialPageRoute(
      //       //     builder: (BuildContext context) => HomeBottomBar(),
      //       //   ),
      //       //       (route) => false,
      //       // );
      //
      //
      //       return false;
      //     }else {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => CartList(),
      //         ),
      //             (route) => false,
      //       );
      //       return false;
      //     }
      //
      // }else {
      //     return true;

        // }
        return true;
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Constant.hexToColor(Constant.primaryBlue),
          title: Text(
            "Sign in",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 12, right: 12,top: 48),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "images/logo.png",
                          width: 120,
                          height: 75,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTitleTextfield("9584322255", "Mobile Number", (v) {
                        mobileController.text = v;
                      }),
                      SizedBox(
                        height: 12,
                      ),
                      CustomButton(
                          label: "Proceed",
                          color: Constant.hexToColor(Constant.primaryBlue),
                          textColor: Colors.white,
                          borderColor: Constant.hexToColor(Constant.primaryBlue),
                          onPressed: () {


                            if(mobileController.text.isEmpty || mobileController.text.length<10) {

                              Constant.showToast("PLease enter valid mobile number");

                            }else {
                              Dialogs.showLoadingDialog(context, _keyLoader);
                              login(context,mobileController.text);

                            }


                          },
                          fontSize: 16,
                          padding: 8,
                          height: 45,
                          width: 150)
                    ],
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }

  void login(BuildContext context,String text) async {

    LoginResponse loginResponse = await loginController.login(text);


    if(loginResponse.success!){
      Navigator.of(context,rootNavigator: true).pop();//close the dialoge
      Constant.showToast("One time password has been sent successfully to your number");
      // Get.off(OtpScreen(text, loginResponse.data!.id!));
      Get.to(OtpScreen(text, loginResponse.data!.id!));



    }else {
      Navigator.of(context,rootNavigator: true).pop();//close the dialoge
      Constant.showToast("Server error occured, Please try later");

    }


  }
}
