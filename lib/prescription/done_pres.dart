import 'package:flutter/material.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DonePrescription extends StatefulWidget {
  @override
  State<DonePrescription> createState() => _DonePrescriptionState();
}

class _DonePrescriptionState extends State<DonePrescription> {



  DashboardController dashboardController = Get.find(
  );


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(HomeBottomBar(0));
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/checked.png",
              height: 50,
              width: 50,
            ),
            Container(
              margin: EdgeInsets.only(top: 12,left: 20,right: 20),
              child: Text(
                "Your Prescription is updated successfully.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 12),
            //   child: Text("Recepit #med3547777"),
            // ),
            // Container(
            //   margin: EdgeInsets.only(top: 16),
            //   child: Text(
            //     "We will be sending you an confirmation by sms or call",
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: CustomButton(
                  label: "Done",
                  color: Constant.hexToColor(Constant.primaryBlue),
                  textColor: Colors.white,
                  borderColor: Constant.hexToColor(Constant.primaryBlue),
                  onPressed: () {
                    Get.offAll(HomeBottomBar(0));
                  },
                  fontSize: 16,
                  padding: 8,
                  height: 45,
                  width: 150),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    GetStorage().remove(Constant.items);
    GetStorage().remove(Constant.Order);

    print("ssssssssssss ${GetStorage().read(Constant.USERID)}");

  }
}
