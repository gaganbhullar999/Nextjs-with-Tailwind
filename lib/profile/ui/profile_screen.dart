import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield_new.dart';
import 'package:medilabs/login/repository/login_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DashboardController dashboardController = Get.find();
  String groupGenderValue = "Male";

  LoginData? loginData;
  Map<String, dynamic> updatedProfileData = Map();
  bool profileUpdate = false;
  var image = File("");
  var imageBase64 = "";
  final picker = ImagePicker();
  String? imageAddress = "";
  String? prescriptionImageAddress = "";
  var prescriptionImage = File("");
  var prescriptionImageBase64 = "";
  LoginData? loginResponse;
  late SharedPreferences sharedPreferences;
  String id = "1";

  @override
  void initState() {
    // if (GetStorage().read(Constant.USERID) != null) {
    //   // Get.to(PatientDetailsScreen());
    // } else {
    //   GetStorage().write(Constant.SCREEN, LOGINSCREEN.PROFILE);
    //   Get.to(LoginScreen());
    // }

    loginResponse = LoginData();
    getPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
          margin: EdgeInsets.all(12),
          child: profileUpdate ? buildProfileUI() : buildProfileUI()),
    );
  }

  Widget buildUploadPrescription() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: prescriptionImage.path.isNotEmpty
          ? Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Image.file(
                    prescriptionImage,
                    fit: BoxFit.cover,
                  )))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _showPicker(context, IMAGEUSER.PRESCRIPTION);
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 40,
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        "Upload Prescription",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              width: 1, color: Constant.hexToColor(Constant.primaryBlueMin))),
    );
  }

  Widget buildProfileUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildProfileImage(context),
          FutureBuilder(
              future: dashboardController.getProfile(id),
              builder: (context, AsyncSnapshot<LoginResponse> snapshot) {
                profileUpdate = false;

                if (snapshot.hasData) {
                  if (loginResponse == null) {
                    loginResponse = snapshot.data!.data!;

                    if (loginResponse!.gender.toString().isEmpty) {
                      groupGenderValue = "Male";
                    } else {}
                  }

                  loginData = snapshot.data!.data!;

                  if (loginData!.image!.isNotEmpty) {
                    setState(() {
                      imageAddress = loginData!.image!;
                    });
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Name",
                            loginData!.name!.isEmpty
                                ? "Name"
                                : "${loginData!.name}", (v) {
                          loginResponse!.name = v;
                        }, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "12",
                            loginData!.age!.isEmpty
                                ? "age"
                                : "${loginData!.age}", (v) {
                          loginResponse!.age = v;
                        }, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Text("Gender"),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: groupGenderValue,
                              onChanged: (value) {
                                loginResponse!.gender = value;
                                setState(() {
                                  groupGenderValue = value!;
                                });
                              },
                              items: ["Male", "Female"],
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Mobile",
                            loginData!.mobile!.isEmpty
                                ? "9999999999"
                                : loginData!.mobile!, (v) {
                          loginResponse!.mobile = v;
                        }, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Email",
                            loginData!.email!.isEmpty
                                ? "test@gmail.com"
                                : loginData!.email!, (v) {
                          loginResponse!.email = v;
                        }, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Address",
                            loginData!.address!.isEmpty
                                ? "full address"
                                : loginData!.address!, (v) {
                          loginResponse!.address = v;
                        }, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "City",
                            loginData!.city!.isEmpty
                                ? "City"
                                : loginData!.city!, (v) {
                          loginResponse!.city = v;
                        }, ""),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "State",
                            loginData!.state!.isEmpty
                                ? "State"
                                : loginData!.state!, (v) {
                          loginResponse!.state = v;
                        }, ""),
                      ),

                      // Container(
                      //   margin: EdgeInsets.only(top: 12),
                      //   child: Container(
                      //     child: Center(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           IconButton(
                      //               onPressed: () {},
                      //               icon: Icon(Icons.add_circle_outline_sharp)),
                      //           // Container(
                      //           //     margin: EdgeInsets.only(top: 12),
                      //           //     child: Text(
                      //           //       "Upload Prescription",
                      //           //       style: TextStyle(fontSize: 14),
                      //           //     ))
                      //         ],
                      //       ),
                      //     ),
                      //     height: 80,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(18),
                      //         border: Border.all(
                      //             width: 1,
                      //             color: Constant.hexToColor(Constant.primaryBlueMin))),
                      //   ),
                      // ),

                      buildUploadPrescription(),

                      Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                  label: "Update",
                                  color:
                                      Constant.hexToColor(Constant.primaryBlue),
                                  textColor: Colors.white,
                                  borderColor:
                                      Constant.hexToColor(Constant.primaryBlue),
                                  onPressed: () {
                                    updateProfile();

                                    Constant.showToast(
                                        "Your profile updated successfully");
                                    // Get.to(HomeBottomBar());
                                  },
                                  fontSize: 12,
                                  padding: 8,
                                  height: 45,
                                  width: 120),
                              // CustomButton(
                              //     label: "Skip",
                              //     color: Constant.hexToColor(Constant.primaryBlue),
                              //     textColor: Colors.white,
                              //     borderColor: Constant.hexToColor(Constant.primaryBlue),
                              //     onPressed: () {
                              //       Get.to(HomeBottomBar());
                              //     },
                              //     fontSize: 12,
                              //     padding: 8,
                              //     height: 45,
                              //     width: 120),
                            ],
                          )),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Shivam", "Symon", (v) {}, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew("12", "48", (v) {}, ""),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 12),
                        child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          groupValue: groupGenderValue,
                          onChanged: (value) {
                            setState(() {
                              groupGenderValue = value!;
                            });
                          },
                          items: ["Male", "Female"],
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Email", "symonmail45@gmail.com", (v) {}, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew("Address",
                            "vinod naka , gali 86, bhopal", (v) {}, ""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Medical Condition", "Sugar", (v) {}, ""),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 12),
                      //   child: Container(
                      //     child: Center(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           IconButton(
                      //               onPressed: () {},
                      //               icon: Icon(Icons.add_circle_outline_sharp)),
                      //           // Container(
                      //           //     margin: EdgeInsets.only(top: 12),
                      //           //     child: Text(
                      //           //       "Upload Prescription",
                      //           //       style: TextStyle(fontSize: 14),
                      //           //     ))
                      //         ],
                      //       ),
                      //     ),
                      //     height: 80,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(18),
                      //         border: Border.all(
                      //             width: 1,
                      //             color: Constant.hexToColor(Constant.primaryBlueMin))),
                      //   ),
                      // ),

                      buildUploadPrescription(),

                      Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                  label: "Update",
                                  color:
                                      Constant.hexToColor(Constant.primaryBlue),
                                  textColor: Colors.white,
                                  borderColor:
                                      Constant.hexToColor(Constant.primaryBlue),
                                  onPressed: () {
                                    Constant.showToast(
                                        "Your profile updated successfully");
                                    // Get.to(HomeBottomBar());
                                  },
                                  fontSize: 12,
                                  padding: 8,
                                  height: 45,
                                  width: 120),
                              // CustomButton(
                              //     label: "Skip",
                              //     color: Constant.hexToColor(Constant.primaryBlue),
                              //     textColor: Colors.white,
                              //     borderColor: Constant.hexToColor(Constant.primaryBlue),
                              //     onPressed: () {
                              //       Get.to(HomeBottomBar());
                              //     },
                              //     fontSize: 12,
                              //     padding: 8,
                              //     height: 45,
                              //     width: 120),
                            ],
                          )),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }

  void updateProfile() async {
    loginResponse!.gender = groupGenderValue;
    loginResponse!.id = id;
    await dashboardController.updateProfile(loginResponse!);
    setState(() {
      profileUpdate = true;
    });
  }

  Widget buildProfileImage(BuildContext context) {
    return Container(
      height: 150,
      width: 130,
      child: Stack(
        children: [
          InkWell(
              child: Container(
            height: 150,
            width: 125,
            child: CircleAvatar(
                child: ClipOval(
                    child: imageAddress!.isNotEmpty
                        ? Image.network(
                            imageAddress!,
                            width: 150,
                            height: 125,
                          )
                        : image.path.isNotEmpty
                            ? Image.file(
                                image,
                                width: 150,
                                height: 125,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "images/logo.png",
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ))),
          )
              // : Image.file(
              //     profileController.image.value,
              //     height: 70,
              //     width: 70,
              //     fit: BoxFit.cover,
              //   ),
              ),
          //
          // CustomButton("Select Image", Colors.white,
          //     Colors.black54, Colors.white30, () {
          //       // Navigator.push(
          //       //           context,
          //       //           MaterialPageRoute(builder: (context) => LoginScreen()),
          //       //         );
          //     }),

          Container(
            child: Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    _showPicker(context, IMAGEUSER.PROFILE);
                  },
                )),
          )
        ],
      ),
    );
  }

  void _showPicker(context, IMAGEUSER imageuser) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imgFromGallery(imageuser);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(imageuser);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  imgFromCamera(IMAGEUSER imageuser) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      setState(() {
        if (imageuser == IMAGEUSER.PROFILE) {
          image = File(pickedFile.path);
          loginResponse!.image = getConvertIntoBase64(pickedFile.path);
        } else {
          prescriptionImage = File(pickedFile.path);
          prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
        }
      });
    } else {
      print('No image selected.');
    }
  }

  imgFromGallery(IMAGEUSER imageuser) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      setState(() {
        if (imageuser == IMAGEUSER.PROFILE) {
          image = File(pickedFile.path);
          loginResponse!.image = getConvertIntoBase64(pickedFile.path);
        } else {
          prescriptionImage = File(pickedFile.path);
          prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
        }
      });
    } else {
      print('No image selected.');
    }
  }

  String getConvertIntoBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  Future<String?> getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString(Constant.USERID) == null
          ? "1"
          : sharedPreferences.getString(Constant.USERID)!;
    });

    return "";
  }
}

enum IMAGEUSER { PROFILE, PRESCRIPTION }
