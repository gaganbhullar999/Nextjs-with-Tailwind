import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:medilabs/book/ui/order_list.dart';
import 'package:medilabs/cart/ui/patient_details_screen.dart';
import 'package:medilabs/cart/ui/patient_test_date_selection.dart';
import 'package:medilabs/dashboard/dashboard_screen.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:get/get.dart';
import 'package:medilabs/login/repository/login_controller.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/profile/ui/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medilabs/helper/widgets/Dialogs.dart';

import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String userID;
  OtpScreen(this.mobileNumber,this.userID);


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  LoginController loginController = Get.find();
  late SharedPreferences sharedPreferences;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 8,right: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/logo.png",
                  width: 120,
                  height: 75,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12,bottom: 12),
                child: Text(
                  "Enter your OTP sent to ${widget.mobileNumber}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Constant.hexToColor(Constant.primaryBlueMin)),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                height: 45,
                child: OtpTextField(
                  numberOfFields: 4,
                  disabledBorderColor: Colors.grey ,
                  enabledBorderColor: Constant.hexToColor(Constant.primaryBlue),
                  borderColor: Constant.hexToColor(Constant.primaryBlue),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {

                    Dialogs.showLoadingDialog(context, _keyLoader);

                    checkOtp(verificationCode,context);




                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text('Code entered is $verificationCode'),
                    //       );
                    //     });
                  }, // end onSubmit
                ),
              ),
        InkWell(
          onTap: (){
            // Get.off(LoginScreen());
            Navigator.of(context).pop(true);
          },

          child: Container(
            margin: EdgeInsets.only(top: 12,bottom: 12),
            child: Text(
              "Change number",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Constant.hexToColor(Constant.primaryBlueMin)),
            ),),
        ),     InkWell(
                onTap: (){
                  login(widget.mobileNumber);
                },

                child: Container(
                  margin: EdgeInsets.only(top: 12,bottom: 12),
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Constant.hexToColor(Constant.primaryRed)),
                  ),),
              )

            ],
          ),
        ),
      ),
    );
  }


  void login(String text) async {

    LoginResponse loginResponse = await loginController.login(text);
    if(loginResponse.success!){
      Constant.showToast("One time password has been sent successfully to your number");
    }else {
      Constant.showToast("Server error occured, Please try later");
    }


  }

  void checkOtp(String code,BuildContext context) async {


    LoginResponse loginResponse = await loginController.checkOtp(widget.userID, code);


    if(loginResponse!=null){


      if(loginResponse.success!){
        Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Constant.showToast("One time password verified successfully");
        setPrefs(loginResponse.data!.id.toString());


        var switchScreen = GetStorage().read(Constant.SCREEN);

        if(switchScreen!=null){

          switch(switchScreen){

            case LOGINSCREEN.ORDER:

              Constant.USERLOGGEDIN=true;

              Get.off(HomeBottomBar(0));
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => PatientDetailsScreen(),
              //   ),
              //       (route) => false,
              // );
              break;
            case LOGINSCREEN.PROFILE:

              Constant.USERLOGGEDIN=true;

              Get.off(HomeBottomBar(0));

              break;
            case LOGINSCREEN.CART:
              Constant.USERLOGGEDIN=true;


                Get.off(PatientDetailsScreen());

              break;
          }

        }else {
          Constant.USERLOGGEDIN=true;
          Get.offAll(HomeBottomBar(0));

        }


      }else {
        Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Constant.showToast("Please enter valid OTP");

      }


    }



  }

  Future<void> setPrefs(String id) async {

    sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.setString(Constant.USERID,id);


  }

}
