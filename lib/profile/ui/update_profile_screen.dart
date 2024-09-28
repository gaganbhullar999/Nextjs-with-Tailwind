import 'package:flutter/material.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Container(
          margin: EdgeInsets.all(12),
          child: buildProfileUI()),
    );
  }

  Widget buildProfileUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            child: CustomTitleTextfield("Name", "Enter Name", (v) {}),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: CustomTitleTextfield("12", "Enter Age", (v) {}),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 12),
            child: RadioGroup<String>.builder(
              direction: Axis.horizontal,
              groupValue: "Male",
              onChanged: (value) {},
              items: ["Male", "Female"],
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: CustomTitleTextfield("Email", "Enter Email", (v) {}),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: CustomTitleTextfield("Address", "Enter Address", (v) {}),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: CustomTitleTextfield(
                "Medical Condition", "Enter Medical Condition", (v) {}),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline_sharp)),
                    Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Upload Prescription",
                          style: TextStyle(fontSize: 14),
                        ))
                  ],
                ),
              ),
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      width: 1,
                      color: Constant.hexToColor(Constant.primaryBlueMin))),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      label: "Update",
                      color: Constant.hexToColor(Constant.primaryBlue),
                      textColor: Colors.white,
                      borderColor: Constant.hexToColor(Constant.primaryBlue),
                      onPressed: () {
                        Constant.showToast("Your profile updated successfully");
                        // Get.to(HomeBottomBar());
                      },
                      fontSize: 12,
                      padding: 8,
                      height: 45,
                      width: 120),
                  CustomButton(
                      label: "Skip",
                      color: Constant.hexToColor(Constant.primaryBlue),
                      textColor: Colors.white,
                      borderColor: Constant.hexToColor(Constant.primaryBlue),
                      onPressed: () {
                        // Get.to(HomeBottomBar());
                      },
                      fontSize: 12,
                      padding: 8,
                      height: 45,
                      width: 120),
                ],
              )),
        ],
      ),
    );
  }
}
