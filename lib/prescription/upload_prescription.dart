import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/helper/widgets/text_styles.dart';
import 'package:medilabs/lab/lab_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield_new.dart';

import 'package:medilabs/helper/widgets/custom_button.dart';

import '../helper/widgets/gender_select.dart';

class UploadPrescription extends StatefulWidget {
  bool cateogoryTest = false;
  String? categoryId;

  // AllTest({required this.cateogoryTest, this.categoryId});

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  DashboardController dashboardController = Get.find();
  String groupGenderValue = "Male";
  bool ismale = true;
  bool isfemal = false;
  bool isOther = false;
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

    getPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Prescription"),
      ),
      body: Container(
          margin: EdgeInsets.all(12),
          child: profileUpdate ? buildProfileUI() : buildProfileUI()),
    );
  }

  Widget buildUploadPrescription() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: prescriptionImage.path.isNotEmpty?Center(child: Container(margin:EdgeInsets.symmetric(vertical: 8),child: Image.file(prescriptionImage,fit: BoxFit.cover,))):Center(
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
          // buildProfileImage(context),
          FutureBuilder(
              future: dashboardController.getProfile(id),
              builder: (context, AsyncSnapshot<LoginResponse> snapshot) {
                profileUpdate = false;

                if (snapshot.hasData) {
                   if (loginResponse == null) {
                    loginResponse = snapshot.data!.data!;

                    if (loginResponse!
                        .gender
                        .toString()
                        .isEmpty) {
                      groupGenderValue = "Male";
                    } else {}
                   }else{
                     // loginResponse = LoginData();
                   }

                  loginData = snapshot.data!.data!;

                  // if (loginData!.image!.isNotEmpty) {
                    //setState(() {
                      // imageAddress = loginData!.image!;
                    //});
                  // }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name : ', style: TSB.semiBoldSmall(),),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Name",
                            loginData!.name!.isEmpty
                                ? "Name"
                                : loginData!.name!, (v) {
                          loginResponse!.name = v;
                        }, ""),
                      ),
                      Text('Age : ', style: TSB.semiBoldSmall(),),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "12",
                            loginData!.age!.isEmpty
                                ? "age"
                                : loginData!.age, (v) {
                          loginResponse!.age = v;
                        }, ""),
                      ),

                      //
                      // Text('Gender : ', style: TSB.semiBoldSmall(),),
                      // Container(
                      //   margin: EdgeInsets.only(top: 12),
                      //   child: Row(
                      //     children: [
                      //       Text("Gender"),
                      //       RadioGroup<String>.builder(
                      //         direction: Axis.horizontal,
                      //         groupValue: groupGenderValue,
                      //         onChanged: (value) {
                      //           loginResponse!.gender = value;
                      //           setState(() {
                      //             groupGenderValue = value!;
                      //           });
                      //         },
                      //         items: ["Male", "Female", "Other"],
                      //         itemBuilder: (item) =>
                      //             RadioButtonBuilder(
                      //               item,
                      //             ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text('Mobile : ', style: TSB.semiBoldSmall(),),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Mobile",
                            loginData!.mobile!.isEmpty
                                ? "Mobile"
                                : loginData!.mobile!, (v) {
                          loginResponse!.mobile = v;
                        }, ""),
                      ),
                      Text('Email : ', style: TSB.semiBoldSmall(),),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Email",
                            loginData!.email!.isEmpty
                                ? "E-mail"
                                : loginData!.email!, (v) {
                          loginResponse!.email = v;
                        }, ""),
                      ),
                      Text('Address : ', style: TSB.semiBoldSmall(),),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: CustomTitleTextfieldNew(
                            "Address",
                            loginData!.address!.isEmpty
                                ? "address"
                                : loginData!.address!, (v) {
                          loginResponse!.address = v;
                        }, ""),
                      ),
                      Text('Prescription : ', style: TSB.semiBoldSmall(),),
                      buildUploadPrescription(),

                      Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                  label: "Upload Prescription",
                                  color:
                                  Constant.hexToColor(Constant.primaryBlue),
                                  textColor: Colors.white,
                                  borderColor:
                                  Constant.hexToColor(Constant.primaryBlue),
                                  onPressed: () {
                                    updateProfile();


                                    // Get.to(HomeBottomBar());
                                  },
                                  fontSize: 12,
                                  padding: 8,
                                  height: 45,
                                  width: 250),

                            ],
                          )),
                    ],
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }

  void updateProfile() async {
    loginResponse!.gender = groupGenderValue;
    loginResponse!.id = loginData!.id;

    if(loginResponse!.name == null && loginResponse!.name==""){
      Constant.showToast("Please enter your name");
    }
    else if(loginResponse!.mobile == null && loginResponse!.mobile==""){
      Constant.showToast("Please enter your mobile number");
    }else if(loginResponse!.image == null && loginResponse!.image==""){
      Constant.showToast("Please add your prescription file");
    }else {
      print("loginResponse ${loginResponse}");
      await dashboardController.updatePrescription(loginResponse!);
      Constant.showToast(
          "Your Prescription is updated successfully");
      setState(() {
        profileUpdate = true;
      });
    }
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
                            ? Image.network(imageAddress!, width: 150,
                          height: 125,)
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
    try {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 10, maxWidth: 480, maxHeight: 600);

    if (pickedFile != null) {
      setState(() {
        if (imageuser == IMAGEUSER.PROFILE) {
          image = File(pickedFile.path);
          loginResponse!.image = getConvertIntoBase64(pickedFile.path);
          image = File(pickedFile.path);
          imageBase64 = getConvertIntoBase64(pickedFile.path);
          loginResponse!.image = getConvertIntoBase64(pickedFile.path);
        } else {
          prescriptionImage = File(pickedFile.path);
          prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
          image = File(pickedFile.path);
          imageBase64 = getConvertIntoBase64(pickedFile.path);
          prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
          loginResponse!.image = getConvertIntoBase64(pickedFile.path);
          List<String> pieces = pickedFile.path.split("/");
          String last = pieces[pieces.length - 1];


          loginResponse!.image = "sourabh:image/"+last+";base64,"+getConvertIntoBase64(pickedFile.path);

        }
      });
    } else {
      print('No image selected.');
    }
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
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
          image = File(pickedFile.path);
          imageBase64= getConvertIntoBase64(pickedFile.path);
        } else {
      prescriptionImage = File(pickedFile.path);
      prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
          image = File(pickedFile.path);
          imageBase64 = getConvertIntoBase64(pickedFile.path);
          prescriptionImageBase64 = getConvertIntoBase64(pickedFile.path);
      List<String> pieces = pickedFile.path.split("/");
      String last = pieces[pieces.length - 1];


          loginResponse!.image = "sourabh:image/"+last+";base64,"+getConvertIntoBase64(pickedFile.path);

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
