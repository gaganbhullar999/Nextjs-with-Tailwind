import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilabs/book/ui/order_confirm.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:medilabs/cart/repository/model/create_order_response.dart';
import 'package:medilabs/cart/repository/model/get_medical_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/tokenmodel.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/size_config.dart';
import 'package:medilabs/helper/widgets/Dialogs.dart';
import 'package:medilabs/helper/widgets/cart_progress_ui.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield_new.dart';
import 'package:medilabs/helper/widgets/selector_radio.dart';
import 'package:medilabs/helper/widgets/gender_select.dart';
import 'package:medilabs/helper/widgets/text_styles.dart';
import 'package:medilabs/lab/web_view.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardlistener.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardwidget.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcard.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcardpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbanking.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbankingpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupi.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupipayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfupi/cfupiutils.dart';
import 'cart_list.dart';

class PatientDetailsScreen extends StatefulWidget {
  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late SharedPreferences sharedPreferences;
  bool agree = false;

  String id = "1";
  DashboardController dashboardController = Get.find();
  String groupGenderValue = "Male";
  String groupSelfValue = "Self";
  bool onlineSelected = true;
  bool offlineSelected = false;
  bool selfSelected = false;
  bool otherSelected = false;
  bool ismale = true;
  bool isfemal = false;
  bool isother = false;
  var presCripimage = File("");
  var presimageBase64 = "";
  final presPicker = ImagePicker();

  var previousReportimage = File("");
  var previousReportBase64 = "";
  final previousReportPicker = ImagePicker();

  var medicalReportimage = File("");
  var medicalReportBase64 = "";
  final medicalReportPicker = ImagePicker();

  var otherReportimage = File("");
  var otherReportBase64 = "";
  final otherReportPicker = ImagePicker();
  late MakeOrderModel makeOrderModel;
  late LoginData userprofile;

  // late Map<String, dynamic> userprofile;
  CartController cartController = CartController();
  Map familyBool = Map();
  Map personalBool = Map();
  Map allergiesBool = Map();

  var familyHistory = <Family_history>[];
  var personalHistory = <Personal_history>[];
  var allergiesHistory = <Allergies>[];

  List<TimeSlot> timesslot = [];

  int orderStep = 0;

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool dateSelected = false;
  bool showloader = false;
  bool showCalender = true;

  bool morningTimeSelected = false;
  bool afternoonTimeSelected = false;
  bool eveningTimeSelected = false;

  String selectedData = "";
  String selectedtime = "";

  String phone = "9584322255";
  String email = "gmail@gmail.com";
  String productName = "Product Name";
  String firstName = "";
  String txnID = "";
  String amount = "1.0";

  bool isshowbtn = true;

  String selectedcity = "Indore";

  var citylist = [];

  final cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    makeOrderModel = GetStorage().read(Constant.Order);
    makeOrderModel.orderfor = "Self";
    makeOrderModel.paymentMode = "Online";
    makeOrderModel.gender = "Male";
    makeOrderModel.bookby_name = "";
    makeOrderModel.bookby_mobile = "";
    makeOrderModel.bookby_email = "";
    citylist = GetStorage().read(Constant.ALLCITES);

    getPrefs();
    // userprofile= json.decode(json.encode(GetStorage().read(Constant.PROFILE))) as Map<String, dynamic>;

    // userprofile= new Map<String, dynamic>.from(json.decode(GetStorage().read(Constant.PROFILE)));
    // print(userprofile['id']);
    // print(userprofile['name']);
    // makeOrderModel.bookby_name=userprofile['name'];
    // makeOrderModel.bookby_mobile=userprofile['mobile'];
    // makeOrderModel.bookby_email=userprofile['email'];
    //
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (orderStep == 4) {
          setState(() {
            orderStep = 3;
          });
          return false;
        } else if (orderStep == 3) {
          setState(() {
            orderStep = 2;
          });
          return false;
        } else if (orderStep == 2) {
          setState(() {
            orderStep = 1;
          });
          return false;
        } else if (orderStep == 1) {
          setState(() {
            orderStep = 0;
          });
          return false;
        } else {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => CartList(),
          //   ),
          //   (route) => false,
          // );
          var switchScreen = GetStorage().read(Constant.SCREEN);

          if (switchScreen != null) {
            switch (switchScreen) {
              case LOGINSCREEN.CART:
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => PatientDetailsScreen(),
                //   ),
                //       (route) => false,
                // );
                Get.off(CartList(() {}));
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => PatientDetailsScreen(),
                //   ),
                //       (route) => false,
                // );
                break;
            }
          } else {
            Get.offAll(HomeBottomBar(0));
          }

          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Enter Patient Details"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Container(
                color: Colors.white,
                height: 90,
                child: orderStep == 0
                    ? CartProgressUI(1)
                    : orderStep == 1
                        ? CartProgressUI(2)
                        : orderStep == 2
                            ? CartProgressUI(3)
                            : CartProgressUI(4)),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(12),
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 90),
                    child: orderStep == 0
                        ? buildProfileUI()
                        : orderStep == 1
                            ? buildDetailsUI()
                            : orderStep == 2
                                ? buildPatientTestDate()
                                : buildPaymentUI()),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.all(24),
                      child: CustomButton(
                          label: "Proceed",
                          color: Constant.hexToColor(Constant.primaryBlue),
                          textColor: Colors.white,
                          borderColor:
                              Constant.hexToColor(Constant.primaryBlue),
                          onPressed: () {
                            if (orderStep == 0) {
                              // if(!selfSelected){
                              //   if(!otherSelected){
                              //     Constant.showToast("Please Select Book For");
                              //   }
                              // }
                              if (!selfSelected && !otherSelected) {
                                Constant.showToast("Please Select Book For");
                              } else if (makeOrderModel.name == null &&
                                  makeOrderModel.name == "") {
                                Constant.showToast("Please enter your name");
                              } else if (makeOrderModel.age == null) {
                                Constant.showToast("Please enter your age");
                                // } else if (makeOrderModel.email == null) {
                                //   Constant.showToast("Please enter your email");
                              } else if (makeOrderModel.address == null) {
                                Constant.showToast(
                                    "Please enter patient address");
                              } else if (makeOrderModel.mobile == null) {
                                Constant.showToast("Please enter your mobile");
                              } else if (makeOrderModel.pincode == null) {
                                Constant.showToast(
                                    "Please enter patient address pincode");
                                // } else if (!makeOrderModel.email!.contains("@")) {
                                //   Constant.showToast(
                                //       "Please enter valid email addresss");
                                // }
                              } else if (makeOrderModel.mobile!.length != 10) {
                                Constant.showToast(
                                    "Please enter valid mobile number");
                              } else if (!agree) {
                                Constant.showToast(
                                    "Please accept terms and conditions");
                              } else {
                                _getPlace(makeOrderModel.address!);
                              }
                            } else if (orderStep == 1) {
                              if (allergiesHistory.length == 0) {
                                makeOrderModel.allergies = <Allergies>[];
                              } else {
                                makeOrderModel.allergies = allergiesHistory;
                              }

                              if (familyHistory.length == 0) {
                                makeOrderModel.familyHistory =
                                    <Family_history>[];
                              } else {
                                makeOrderModel.familyHistory = familyHistory;
                              }

                              if (personalHistory.length == 0) {
                                makeOrderModel.personalHistory =
                                    <Personal_history>[];
                              } else {
                                makeOrderModel.personalHistory =
                                    personalHistory;
                              }
                              GetStorage()
                                  .write(Constant.Order, makeOrderModel);

                              setState(() {
                                orderStep = 2;
                              });
                            } else if (orderStep == 2) {
                              if (makeOrderModel.colletiondate == null ||
                                  makeOrderModel.colletiondate == "") {
                                Constant.showToast(
                                    "Please select sample collection date");
                              } else if (makeOrderModel.colletiontime == null ||
                                  makeOrderModel.colletiontime == "") {
                                Constant.showToast(
                                    "Please select sample collection time");
                              } else {
                                setState(() {
                                  orderStep = 3;
                                });
                              }
                            } else {
                              if (selfSelected) {
                                makeOrderModel.orderfor = "Self";
                              } else {
                                makeOrderModel.orderfor = "Other";
                              }
                              if (onlineSelected) {
                                makeOrderModel.paymentMode = "Online";
                              } else {
                                makeOrderModel.paymentMode = "Offline";
                              }

                              makeOrderModel.gender = groupGenderValue;

                              if (makeOrderModel.paymentMode == "Offline") {
                                print("sdfsdf");
                                Dialogs.showLoadingDialog(context, _keyLoader);
                                makeOrder(context);
                              } else {
                                // setupPayment();
                                Dialogs.showLoadingDialog(context, _keyLoader);
                                getpaymenttokan(
                                    makeOrderModel.finalamount!, context);
                              }
                            }

                            // print("popppppp ${orderStep}");
                          },
                          fontSize: 16,
                          padding: 8,
                          height: 45,
                          width: 150),
                    )),
              ],
            )),
      ),
    );
  }

  Widget buildPaymentUI() {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SelectorRadio(
              selected: onlineSelected,
              title: "Online",
              icon: Icons.credit_card,
              onClicked: (v) {
                setState(() {
                  onlineSelected = true;
                  offlineSelected = false;
                });
              }),
          SelectorRadio(
              selected: offlineSelected,
              title: "Offline",
              icon: Icons.credit_card,
              onClicked: (v) {
                setState(() {
                  onlineSelected = false;
                  offlineSelected = true;
                });
              }),
        ],
      ),
    );
  }

  Widget buildProfileUI() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Book By",
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Name : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomTitleTextfieldNew(
              "",
              makeOrderModel.bookby_name != null
                  ? makeOrderModel.bookby_name!
                  : "", (v) {
            makeOrderModel.bookby_name = v;
          }, makeOrderModel.bookby_name!),
        ),
        Text(
          'Mobile : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomTitleTextfieldNew(
              "",
              makeOrderModel.bookby_mobile != null
                  ? makeOrderModel.bookby_mobile!
                  : "", (v) {
            makeOrderModel.bookby_mobile = v;
          }, makeOrderModel.bookby_mobile!),
        ),
        Text(
          'Email : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomTitleTextfieldNew(
              "",
              makeOrderModel.bookby_email != null
                  ? makeOrderModel.bookby_email!
                  : "", (v) {
            makeOrderModel.bookby_email = v;
          }, makeOrderModel.bookby_email!),
        ),

        Text(
          "Book For",
          style: TextStyle(fontSize: 24),
        ),
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectorRadio(
                selected: selfSelected,
                title: "Self",
                icon: Icons.person,
                onClicked: (v) {
                  setState(() {
                    selfSelected = true;
                    otherSelected = false;
                    makeOrderModel.name = makeOrderModel.bookby_name;
                    makeOrderModel.mobile = makeOrderModel.bookby_mobile;
                    makeOrderModel.email = makeOrderModel.bookby_email;
                  });
                },
              ),
              SelectorRadio(
                  selected: otherSelected,
                  title: "Other",
                  icon: Icons.people,
                  onClicked: (v) {
                    setState(() {
                      selfSelected = false;
                      otherSelected = true;
                      makeOrderModel.name = '';
                      makeOrderModel.mobile = '';
                      makeOrderModel.email = '';
                    });
                  }),
            ],
          ),
        ),
        Text(
          'Patient Name : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomTitleTextfieldNew(
              "Name", makeOrderModel.name != null ? makeOrderModel.name! : "",
              (v) {
            makeOrderModel.name = v;
          }, makeOrderModel.name != null ? makeOrderModel.name! : ""),
        ),
        Text(
          'Patient Mobile : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          //942568893
          child: CustomTitleTextfieldNew(
              "", makeOrderModel.mobile != null ? makeOrderModel.mobile! : "",
              (v) {
            makeOrderModel.mobile = v;
          }, makeOrderModel.mobile != null ? makeOrderModel.mobile! : ""),
        ),

        // Container(
        //   margin: EdgeInsets.only(top: 12),
        //   //942568893
        //   child: otherSelected ? CustomTitleTextfieldNew("9584322255",
        //       makeOrderModel.mobile != null ? makeOrderModel.mobile! : "Other Mobile Number",
        //           (v) {
        //         makeOrderModel.othermobile = v;
        //       },"") : null,
        // ),
        Text(
          'Patient Age : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child: CustomTitleTextfieldNew(
              "48", makeOrderModel.age != null ? makeOrderModel.age! : "", (v) {
            makeOrderModel.age = v;
          }, ""),
        ),
        Text(
          "Patient Gender",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenderRadio(
                selected: ismale,
                title: "Male",
                icon: Icons.male,
                onClicked: (v) {
                  setState(() {
                    ismale = true;
                    isfemal = false;
                    isother = false;
                    groupGenderValue = 'Male';
                    makeOrderModel.gender = 'Male';
                  });
                },
              ),
              GenderRadio(
                  selected: isfemal,
                  title: "Female",
                  icon: Icons.female,
                  onClicked: (v) {
                    setState(() {
                      ismale = false;
                      isfemal = true;
                      isother = false;
                      groupGenderValue = 'Female';
                      makeOrderModel.gender = 'Female';
                    });
                  }),
              GenderRadio(
                  selected: isother,
                  title: "Other",
                  icon: Icons.transgender,
                  onClicked: (v) {
                    setState(() {
                      ismale = false;
                      isfemal = false;
                      isother = true;
                      groupGenderValue = 'Other';
                      makeOrderModel.gender = 'Other';
                    });
                  }),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 8),
        //   child: Row(
        //     children: [
        //       Text(
        //         "Patient Gender",
        //         style: TextStyle(fontWeight: FontWeight.w600),
        //       ),
        //       Container(
        //         height: 150,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             GenderRadio(
        //               selected: selfSelected,
        //               title: "Male",
        //               icon: Icons.person,
        //               onClicked: (v) {
        //                 setState(() {
        //                   selfSelected = true;
        //                   otherSelected = false;
        //                   makeOrderModel.name=makeOrderModel.bookby_name;
        //                   makeOrderModel.mobile=makeOrderModel.bookby_mobile;
        //                   makeOrderModel.email=makeOrderModel.bookby_email;
        //                 });
        //               },
        //             ),
        //             GenderRadio(
        //                 selected: otherSelected,
        //                 title: "Female",
        //                 icon: Icons.people,
        //                 onClicked: (v) {
        //                   setState(() {
        //                     selfSelected = false;
        //                     otherSelected = true;
        //                     makeOrderModel.name='';
        //                     makeOrderModel.mobile='';
        //                     makeOrderModel.email='';
        //                   });
        //                 }),
        //           ],
        //         ),
        //       ),
        //       // RadioGroup<String>.builder(
        //       //   direction: Axis.horizontal,
        //       //   groupValue: groupGenderValue,
        //       //   onChanged: (value) {
        //       //     makeOrderModel.gender = value;
        //       //
        //       //     setState(() {
        //       //       groupGenderValue = value!;
        //       //     });
        //       //   },
        //       //   items: ["Male", "Female"],
        //       //   itemBuilder: (item) => RadioButtonBuilder(
        //       //     item,
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
        Text(
          'Email : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child: CustomTitleTextfieldNew(
              "", makeOrderModel.email != null ? makeOrderModel.email! : "",
              (v) {
            makeOrderModel.email = v;
          }, makeOrderModel.email != null ? makeOrderModel.email! : ""),
        ),
        _getCityView(),
        Text(
          'Full Address : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: CustomTitleTextfieldNew(
              "", makeOrderModel.address != null ? makeOrderModel.address! : "",
              (v) {
            makeOrderModel.address = v;
          }, ""),
        ),
        Text(
          'Land Mark : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: CustomTitleTextfieldNew("",
              makeOrderModel.landmark != null ? makeOrderModel.landmark! : "",
              (v) {
            makeOrderModel.landmark = v;
          }, ""),
        ),
        Text(
          'Pin Code : ',
          style: TSB.semiBoldSmall(),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child: CustomTitleTextfieldNew(
              "", makeOrderModel.pincode != null ? makeOrderModel.pincode! : "",
              (v) {
            makeOrderModel.pincode = v;
          }, ""),
        ),
        Container(
            margin: EdgeInsets.only(top: 16, bottom: 12),
            child: Text(
              "Upload any reference file",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),

        Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  _showPicker(context, IMAGEFILETYPE.PRESCRIPTIONFILE);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      child: presCripimage.path.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.add_box_outlined,
                                      size: 30,
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    child: Text(
                                      "Upload \nPrescription",
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            )
                          : Image.file(File(presCripimage.path)),
                    ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     _showPicker(context, IMAGEFILETYPE.PREREPORTFILE);
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width*.4,
              //     child: Card(
              //       elevation: 10,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(18)),
              //       child: Container(
              //         child: previousReportimage.path.isEmpty
              //             ? Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Container(
              //                       margin: EdgeInsets.all(8),
              //                       child: Icon(
              //                         Icons.add_box_outlined,
              //                         size: 30,
              //                         color: Constant.hexToColor(
              //                             Constant.primaryBlue),
              //                       )),
              //                   Container(
              //                       margin: EdgeInsets.all(8),
              //                       child: Text(
              //                         "Upload \nPrevious Report",
              //                         style: TextStyle(fontSize: 12),
              //                         textAlign: TextAlign.center,
              //                       ))
              //                 ],
              //               )
              //             : Image.file(
              //                 File(previousReportimage.path),
              //                 width: 120,
              //                 height: 120,
              //               ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 12),
          //
          // // height: 120,
          // // width: MediaQuery.of(context).size.width,
          // child: RichText(
          //   text: TextSpan(
          //     style: defaultStyle,
          //     children: <TextSpan>[
          //       TextSpan(text: 'By clicking Proceed, you agree to our '),
          //       TextSpan(
          //           text: 'Terms of Service',
          //           style: linkStyle,
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               Get.to(AppWebView(typewebview: 3));
          //             }),
          //       TextSpan(text: ' and that you have read our '),
          //       TextSpan(
          //           text: 'Privacy Policy',
          //           style: linkStyle,
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               Get.to(AppWebView(typewebview: 2));
          //             }),
          //     ],
          //   ),
          // ),
          child: Row(
            children: [
              Material(
                child: Checkbox(
                  value: agree,
                  onChanged: (value) {
                    setState(() {
                      agree = value ?? false;
                    });
                  },
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  // margin: EdgeInsets.only(top: 16,bottom: 12),
                  child: Column(children: [
                    RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'By clicking Proceed, you agree to our '),
                          TextSpan(
                              text: 'Terms of Service',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(AppWebView(typewebview: 3));
                                }),
                          TextSpan(text: ' and that you have read our '),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(AppWebView(typewebview: 2));
                                }),
                        ],
                      ),
                    ),
                  ]))
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 8),
        //   height: 120,
        //   width: MediaQuery.of(context).size.width,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           _showPicker(context, IMAGEFILETYPE.MEDICALFILE);
        //         },
        //         child: Container(
        //           width: MediaQuery.of(context).size.width*.4,
        //           child: Card(
        //             elevation: 10,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(18)),
        //             child: Container(
        //               child: medicalReportimage.path.isEmpty
        //                   ? Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Container(
        //                             margin: EdgeInsets.all(8),
        //                             child: Icon(
        //                               Icons.add_box_outlined,
        //                               size: 30,
        //                               color: Constant.hexToColor(
        //                                   Constant.primaryBlue),
        //                             )),
        //                         Container(
        //                             margin: EdgeInsets.all(8),
        //                             child: Text(
        //                               "Upload \nMedical Report",
        //                               style: TextStyle(fontSize: 12),
        //                               textAlign: TextAlign.center,
        //                             ))
        //                       ],
        //                     )
        //                   : Image.file(
        //                       File(medicalReportimage.path),
        //                       width: 120,
        //                       height: 120,
        //                     ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       InkWell(
        //         onTap: () {
        //           _showPicker(context, IMAGEFILETYPE.OTHERFILE);
        //         },
        //         child: Container(
        //           width: MediaQuery.of(context).size.width*.4,
        //           child: Card(
        //             elevation: 10,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(18)),
        //             child: Container(
        //               child: otherReportimage.path.isEmpty
        //                   ? Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Container(
        //                             margin: EdgeInsets.all(8),
        //                             child: Icon(
        //                               Icons.add_box_outlined,
        //                               size: 30,
        //                               color: Constant.hexToColor(
        //                                   Constant.primaryBlue),
        //                             )),
        //                         Container(
        //                             margin: EdgeInsets.all(8),
        //                             child: Text(
        //                               "Upload \nOther Report",
        //                               style: TextStyle(fontSize: 12),
        //                               textAlign: TextAlign.center,
        //                             ))
        //                       ],
        //                     )
        //                   : Image.file(
        //                       File(otherReportimage.path),
        //                       width: 120,
        //                       height: 120,
        //                     ),
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),

        // Container(
        //   height: 150,
        //   width: 150,
        //   child: Card(
        //     elevation: 10,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(18)),
        //     child: Container(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //                   margin: EdgeInsets.all(8),
        //                   child: Icon(Icons.add_box_outlined,
        //                     size: 30,
        //                     color: Constant.hexToColor(Constant.primaryBlue),)),
        //            Container(
        //                   margin: EdgeInsets.all(8),
        //                   child: Text(
        //                     "Upload \nMedical Condition File",
        //                     style: TextStyle(fontSize: 12),
        //                     textAlign: TextAlign.center,
        //                   ))
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        //
        // Container(
        //   height: 150,
        //   width: 150,
        //   child: Card(
        //     elevation: 10,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(18)),
        //     child: Container(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //                   margin: EdgeInsets.all(8),
        //                   child: Icon(Icons.add_box_outlined,
        //                     size: 30,
        //                     color: Constant.hexToColor(Constant.primaryBlue),)),
        //            Container(
        //                   margin: EdgeInsets.all(8),
        //                   child: Text(
        //                     "Upload \nOther File",
        //                     style: TextStyle(fontSize: 12),
        //                     textAlign: TextAlign.center,
        //                   ))
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // Container(
        //     margin: EdgeInsets.only(top: 12),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         CustomButton(
        //             label: "Proceed",
        //             color: Constant.hexToColor(Constant.primaryBlue),
        //             textColor: Colors.white,
        //             borderColor: Constant.hexToColor(Constant.primaryBlue),
        //             onPressed: () {
        //               Constant.showToast("Your profile updated successfully");
        //               // Get.to(HomeBottomBar());
        //             },
        //             fontSize: 12,
        //             padding: 8,
        //             height: 45,
        //             width: 120),
        //
        //       ],
        //     )),
      ],
    ));
  }

  _getCityView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City : ',
          style: TSB.semiBoldSmall(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: Constant.hexToColor(Constant.primaryBlueMin),
                        width: 1,
                      ))),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.margin_padding_10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: selectedcity,
                      underline: Container(),
                      style: TSB.regularSmall(textColor: Colors.black),
                      icon: Container(),
                      onChanged: (val) {
                        selectedcity = val.toString();
                      },
                      items: citylist.map((e) {
                        return DropdownMenuItem(
                          child: Text(
                            e,
                            style: TSB.regularSmall(textColor: Colors.black),
                          ),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: SizeConfig.margin_padding_24,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  imgFromCamera(IMAGEFILETYPE imagefiletype) async {
    final pickedFile = await presPicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);

    switch (imagefiletype) {
      case IMAGEFILETYPE.PRESCRIPTIONFILE:
        if (pickedFile != null) {
          setState(() {
            presCripimage = File(pickedFile.path);
            presimageBase64 = getConvertIntoBase64(pickedFile.path);
            List<String> pieces = pickedFile.path.split("/");
            String last = pieces[pieces.length - 1];

            presimageBase64 = "sourabh:image/" +
                last +
                ";base64," +
                getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.PREREPORTFILE:
        if (pickedFile != null) {
          setState(() {
            previousReportimage = File(pickedFile.path);
            previousReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.MEDICALFILE:
        if (pickedFile != null) {
          setState(() {
            medicalReportimage = File(pickedFile.path);
            medicalReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.OTHERFILE:
        if (pickedFile != null) {
          setState(() {
            otherReportimage = File(pickedFile.path);
            otherReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
    }
  }

  imgFromGallery(IMAGEFILETYPE imagefiletype) async {
    final pickedFile = await presPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 10);

    switch (imagefiletype) {
      case IMAGEFILETYPE.PRESCRIPTIONFILE:
        if (pickedFile != null) {
          setState(() {
            presCripimage = File(pickedFile.path);
            presimageBase64 = getConvertIntoBase64(pickedFile.path);
            List<String> pieces = pickedFile.path.split("/");
            String last = pieces[pieces.length - 1];

            presimageBase64 = "sourabh:image/" +
                last +
                ";base64," +
                getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.PREREPORTFILE:
        if (pickedFile != null) {
          setState(() {
            previousReportimage = File(pickedFile.path);
            previousReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.MEDICALFILE:
        if (pickedFile != null) {
          setState(() {
            medicalReportimage = File(pickedFile.path);
            medicalReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
      case IMAGEFILETYPE.OTHERFILE:
        if (pickedFile != null) {
          setState(() {
            otherReportimage = File(pickedFile.path);
            otherReportBase64 = getConvertIntoBase64(pickedFile.path);
          });
        } else {
          print('No image selected.');
        }
        break;
    }
  }

  String getConvertIntoBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    // imageBase64 = img64;
    return img64;
  }

  void _showPicker(context, IMAGEFILETYPE imagefiletype) {
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
                        imgFromGallery(imagefiletype);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(imagefiletype);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildDetailsUI() {
    return FutureBuilder(
        future: cartController.getMedicalForm(),
        builder: (context, AsyncSnapshot<GetMedicalResponse> snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.familyHistory!.forEach((element) {
              familyBool.putIfAbsent(element.name, () => false);
            });

            snapshot.data!.personalHistory!.forEach((element) {
              personalBool.putIfAbsent(element.name, () => false);
            });

            snapshot.data!.allergies!.forEach((element) {
              allergiesBool.putIfAbsent(element.name, () => false);
            });

            timesslot = snapshot.data!.timeslot!;

            // loading
            //     ? Center(child: CircularProgressIndicator())
            //     : Container(),

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Family Medical History",
                  //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 4),
                  //   child: Column(
                  //     children: List.generate(
                  //         snapshot.data!.familyHistory!.length, (index) {
                  //       return CheckboxListTile(
                  //         title: Text(
                  //             "${snapshot.data!.familyHistory![index].name!}"),
                  //         value: familyBool[
                  //             snapshot.data!.familyHistory![index].name],
                  //         onChanged: (newValue) {
                  //           if (newValue!) {
                  //             familyHistory
                  //                 .add(snapshot.data!.familyHistory![index]);
                  //           } else {
                  //             if (familyHistory.contains(
                  //                 snapshot.data!.familyHistory![index])) {
                  //               familyHistory.remove(
                  //                   snapshot.data!.familyHistory![index]);
                  //             }
                  //           }
                  //
                  //           setState(() {
                  //             familyBool.update(
                  //                 snapshot.data!.familyHistory![index].name,
                  //                 (value) => newValue);
                  //           });
                  //         },
                  //         controlAffinity: ListTileControlAffinity
                  //             .leading, //  <-- leading Checkbox
                  //       );
                  //     }),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 12,
                  // ),
                  Text("Patient Medical History",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: List.generate(
                          snapshot.data!.personalHistory!.length, (index) {
                        return CheckboxListTile(
                          title: Text(
                              "${snapshot.data!.personalHistory![index].name}"),
                          value: personalBool[
                              snapshot.data!.personalHistory![index].name],
                          onChanged: (newValue) {
                            if (newValue!) {
                              personalHistory
                                  .add(snapshot.data!.personalHistory![index]);
                            } else {
                              if (personalHistory.contains(
                                  snapshot.data!.personalHistory![index])) {
                                personalHistory.remove(
                                    snapshot.data!.personalHistory![index]);
                              }
                            }
                            setState(() {
                              personalBool.update(
                                  snapshot.data!.personalHistory![index].name,
                                  (value) => newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text("Allergies History",
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  // Container(
                  //   margin: EdgeInsets.only(top: 4),
                  //   child: Column(
                  //     children: List.generate(snapshot.data!.allergies!.length,
                  //         (index) {
                  //       return CheckboxListTile(
                  //         title:
                  //             Text("${snapshot.data!.allergies![index].name}"),
                  //         value: allergiesBool[
                  //             snapshot.data!.allergies![index].name],
                  //         onChanged: (newValue) {
                  //           if (newValue!) {
                  //             allergiesHistory
                  //                 .add(snapshot.data!.allergies![index]);
                  //           } else {
                  //             if (allergiesHistory
                  //                 .contains(snapshot.data!.allergies![index])) {
                  //               allergiesHistory
                  //                   .remove(snapshot.data!.allergies![index]);
                  //             }
                  //           }
                  //
                  //           setState(() {
                  //             allergiesBool.update(
                  //                 snapshot.data!.allergies![index].name,
                  //                 (value) => newValue);
                  //           });
                  //         },
                  //         controlAffinity: ListTileControlAffinity
                  //             .leading, //  <-- leading Checkbox
                  //       );
                  //     }),
                  //   ),
                  // )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // return Column(
          //   children: [
          //     CustomTitleTextfield("12pm", "Enter Time", (v) {}),
          //     CustomTitleTextfield("20/12/2021", "Enter Date", (v) {}),
          //     CustomTitleTextfield("Home", "Enter Location", (v) {}),
          //   ],
          // );
        });
  }

  Widget buildPatientTestDate() {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                // showCalender = true;
                if (dateSelected) {
                  dateSelected = false;
                  showloader = false;
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 12),
              height: 60,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Container(
                  child: Center(
                    child: Text(
                      "Select Date",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
          showCalender ? buildCalender() : Container(),
          dateSelected
              ? buildSection(MediaQuery.of(context).size.width)
              : Container(),
          // showloader ?  Center(child: CircularProgressIndicator()):Container(),
        ],
      ),
    );
  }

  Widget buildCalender() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 7)),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;

                  dateSelected = true;
                  showloader = false;
                  // showCalender = false;
                  makeOrderModel.colletiondate = selectedDay.day.toString() +
                      "/" +
                      selectedDay.month.toString() +
                      "/" +
                      selectedDay.year.toString();
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
        ],
      ),
    );
  }

  Widget buildSection(double width) {
    return FutureBuilder(
        future: cartController.getavailabletime(makeOrderModel.colletiondate!),
        builder: (context, AsyncSnapshot<GetMedicalResponse> snapshot) {
          if (snapshot.hasData) {
            // snapshot.data!.familyHistory!.forEach((element) {
            //   familyBool.putIfAbsent(element.name, () => false);
            // });
            //
            // snapshot.data!.personalHistory!.forEach((element) {
            //   personalBool.putIfAbsent(element.name, () => false);
            // });
            //
            // snapshot.data!.allergies!.forEach((element) {
            //   allergiesBool.putIfAbsent(element.name, () => false);
            // });

            timesslot = snapshot.data!.timeslot!;

            if (timesslot.length == 0) {
              showloader = false;
              return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "No Time Slot Available.Please select other date",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ]),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Date " + makeOrderModel.colletiondate! != null
                          ? "Date " + makeOrderModel.colletiondate!
                          : "NA",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //   timesslot.forEach((element) {
                          // familyBool.putIfAbsent(element.name, () => false);
                          // });

                          for (var i = 0; i < timesslot.length; i++)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  // morningTimeSelected = true;
                                  // afternoonTimeSelected = false;
                                  // eveningTimeSelected = false;

                                  selectedtime = timesslot[i].time!;
                                  makeOrderModel.colletiontime = selectedtime;
                                });
                              },
                              // onTap: () => Get.to(AllTest(cateogoryTest: false)),
                              child: Container(
                                height: 130,
                                width: width * .3,
                                child: Card(
                                  color: (selectedtime == timesslot[i].time!)
                                      ? Colors.greenAccent.withOpacity(.9)
                                      : Colors.white,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(8),
                                            child: Text(
                                              timesslot[i].name!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 12),
                                            child: Text(
                                              timesslot[i].time!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                              textAlign: TextAlign.center,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       morningTimeSelected = false;
                          //       afternoonTimeSelected = true;
                          //       eveningTimeSelected = false;
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 130,
                          //     width: width * .3,
                          //     child: Card(
                          //       color: afternoonTimeSelected
                          //           ? Colors.greenAccent.withOpacity(.9)
                          //           : Colors.white,
                          //       elevation: 10,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(18)),
                          //       child: Container(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //                 margin: EdgeInsets.all(8),
                          //                 child: Text(
                          //                   "Afternoon",
                          //                   style: TextStyle(fontWeight: FontWeight.w600),
                          //                 )),
                          //             Container(
                          //                 margin: EdgeInsets.only(top: 12),
                          //                 child: Text(
                          //                   "1PM to 4PM",
                          //                   style: TextStyle(
                          //                       fontSize: 14, fontWeight: FontWeight.w300),
                          //                   textAlign: TextAlign.center,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       morningTimeSelected = false;
                          //       afternoonTimeSelected = false;
                          //       eveningTimeSelected = true;
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 130,
                          //     width: width * .3,
                          //     child: Card(
                          //       color: eveningTimeSelected
                          //           ? Colors.greenAccent.withOpacity(.9)
                          //           : Colors.white,
                          //       elevation: 10,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(18)),
                          //       child: Container(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //                 margin: EdgeInsets.all(8),
                          //                 child: Text(
                          //                   "Evening",
                          //                   style: TextStyle(fontWeight: FontWeight.w600),
                          //                 )),
                          //             Container(
                          //                 margin: EdgeInsets.only(top: 12),
                          //                 child: Text(
                          //                   "4PM to 8PM",
                          //                   style: TextStyle(
                          //                       fontSize: 14, fontWeight: FontWeight.w300),
                          //                   textAlign: TextAlign.center,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // return Column(
          //   children: [
          //     CustomTitleTextfield("12pm", "Enter Time", (v) {}),
          //     CustomTitleTextfield("20/12/2021", "Enter Date", (v) {}),
          //     CustomTitleTextfield("Home", "Enter Location", (v) {}),
          //   ],
          // );
        });
  }

  Future makeOrder(BuildContext context) async {
    // debugPrint("makeOrder");
    // Constant.showToast(
    //     "done makeOrder");
    CreateOrderResponse loginResponse =
        await cartController.createOrder(makeOrderModel);

    Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
    if (loginResponse != null) {
      if (loginResponse.success!) {
        print("order resp-- ${loginResponse}");
        dashboardController.cartCount.value = 0;
        // if(!presimageBase64.isEmpty){
        //   print("on image upload");
        //   Navigator.of(context,rootNavigator: true).pop();//close the dialoge
        //
        //   uploadimage(context,loginResponse.orderid!);
        // }else{
        Get.to(OrderConfirm());
        dashboardController.cartCount.value = 0;
        // }
      } else {
        Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
        Constant.showToast(
            "Error in Order Please try again " + loginResponse.toString());
        print("Book Order error " + loginResponse.toString());
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      Constant.showToast("Error in Order Please try again ");
    }
  }

  void uploadimage(BuildContext context, orderid) async {
    // debugPrint("makeOrder");
    // Constant.showToast(
    //     "done makeOrder");

    LoginData? dataa = LoginData();

    dataa!.id = orderid;
    dataa!.image = presimageBase64;
    print("Data- ${dataa}");
    LoginResponse loginResponse =
        await cartController.updateOrderPrescription(dataa);
    Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
    Get.to(OrderConfirm());
  }

  void getuserdata(context) async {
    // Constant.showToast(
    //     "On getpaymenttokan");
    // Dialogs.showLoadingDialog(context, _keyLoader);
    await dashboardController.getProfile(id).then((value) {
      try {
        //  Navigator.of(context,rootNavigator: true).pop('dialog');
        print("Book ssss ${value}");
        LoginResponse lmodel = value;
        print("Book ssss ${lmodel}");
        if (lmodel != null) {
          if (lmodel.success!) {
            userprofile = lmodel.data!;
            setState(() {
              // Navigator.of(context,rootNavigator: true).pop('dialog');
              print(userprofile.id!);
              print(userprofile.name!);
              makeOrderModel.bookby_name = userprofile.name!;
              makeOrderModel.bookby_mobile = userprofile.mobile!;
              makeOrderModel.bookby_email = userprofile.email!;

              // makeOrderModel.name=userprofile.name!;
              // makeOrderModel.mobile=userprofile.mobile!;
              // makeOrderModel.email=userprofile.email!;
            });
          } else {
            print("Book Order error " + lmodel.toString());
          }
        } else {
          print("Boo ");
        }
      } on Exception catch (exception) {
        //   Navigator.of(context,rootNavigator: true).pop('dialog');//close the dialoge
      } catch (error) {
        //    Navigator.of(context,rootNavigator: true).pop('dialog');//close the dialoge
      }
    }).catchError((onError) {
      //    Navigator.of(context,rootNavigator: true).pop('dialog');//close the dialoge
      debugPrint("getpaymenttokan onError " + onError);
    });
  }

  void getpaymenttokan(String amount, BuildContext context) async {
    // Constant.showToast(
    //     "On getpaymenttokan");
    await cartController.getcashfreetoken(amount, id).then((value) {
      try {
        TokenModel tmodel = value;
        // debugPrint("getpaymenttokan");
        // Constant.showToast(
        //     "done getpaymenttokan");
        if (tmodel != null) {
          if (tmodel.success!) {
            debugPrint("tokan-" + tmodel.ctoken);
            makeOrderModel.paymentorderid = tmodel.orderid;
            makeOrderModel.paymenttokan = tmodel.ctoken;

            dopayment(context);
          } else {
            // Constant.showToast(
            //     "tmodel eee"+tmodel.toString());
            // debugPrint("Book Order error " + tmodel.toString());
            Navigator.of(context, rootNavigator: true)
                .pop(); //close the dialoge
            print("Payment gateway error " + tmodel.toString());
          }
        } else {
          // Constant.showToast(
          //     "tmodel null");
          // debugPrint("Book Order erro1r ");
          Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
          Constant.showToast("Payment gateway Server Error Please try again");
        }
      } on Exception catch (exception) {
        Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
        Constant.showToast("Payment gateway Server Error Please try again");
        // Constant.showToast(
        //     "Exception- "+exception.toString());
      } catch (error) {
        Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
        Constant.showToast("Payment gateway Server Error Please try again");
        // Constant.showToast(
        //     "Errrrrrr- "+error.toString());
      }
    }).catchError((onError) {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      debugPrint("getpaymenttokan onError " + onError);
      Constant.showToast("Payment gateway Server Error Please try again");
      // Constant.showToast(
      //     "getpaymenttokan onError "+onError);
    });
  }

  Future<void> verifyPayment(String orderId) async {
    print("Verify Payment");
    final value = await cartController.verifyPayment(orderId);

    if (value != null && value!["payment_status"] == "SUCCESS") {
      makeOrderModel.transaction_id = value!["cf_payment_id"].toString();
      //makeOrderModel.payment_signature = value!["signature"];
      makeOrderModel.payment_status = "Paid";
      makeOrderModel.payment_by_id = id;
      makeOrderModel.payment_date = value!["payment_completion_time"];
      await makeOrder(context);
    } else {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      Constant.showToast("Payment gateway Server Error Please try again");
    }
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    print(errorResponse.getMessage());
    print("Error while making payment");
    Navigator.of(context, rootNavigator: true).pop();
  }

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(Constant.environment)
          .setOrderId(makeOrderModel.paymentorderid!)
          .setPaymentSessionId(makeOrderModel.paymenttokan!)
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  void dopayment(BuildContext context) {
    try {
      try {
        var session = createSession();
        var theme = CFThemeBuilder()
            .setNavigationBarBackgroundColorColor("#2196F3")
            .setNavigationBarTextColor("#ffffff")
            .build();
        var cfWebCheckout = CFWebCheckoutPaymentBuilder()
            .setSession(session!)
            .setTheme(theme)
            .build();
        cfPaymentGatewayService.doPayment(cfWebCheckout);
      } on CFException catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        print(e.message);
      }
    } on Exception catch (exception) {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge

      Constant.showToast("Exception payment- " + exception.toString());
    } catch (error) {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge

      Constant.showToast("Error payment- " + error.toString());
    }
  }

  Future<String?> getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString(Constant.USERID) == null
          ? "0"
          : sharedPreferences.getString(Constant.USERID)!;
    });
    getuserdata(context);
    return "";
  }

  // void setupPayuMoney() async{
  //   await setupPayment();
  //
  //
  //
  //
  //
  // }
  //
  // setupPayment() async {
  //
  //   bool response = await payuMoneyFlutter.setupPaymentKeys(
  //       merchantKey: "PFh4GE", merchantID: "6gLSzJB7nhvWfK3KKqufJ4kP78jq6HWF",
  //       isProduction: false, activityTitle: "Payment Screen Title", disableExitConfirmation: false);
  //
  //
  //
  //   if(response){
  //     await payuMoneyFlutter.startPayment(
  //         txnid: txnID,
  //         amount: amount,
  //         name: firstName,
  //         email: email,
  //         phone: phone,
  //         productName: productName,
  //         hash: "fffff");
  //
  //
  //   }
  // }

  // Future<Map<String, dynamic>> startPayment() async {
  //
  //   var dio = Dio();
  //   // Generating hash from php server
  //   var res =
  //   await dio.post("https://www.payumoney.com/sandbox/payment/payment/chkMerchantTxnStatus", data: {
  //     "txnid": txnID,
  //     "phone": phone,
  //     "email": email,
  //     "amount": amount,
  //     "productinfo": productName,
  //     "firstname": firstName,
  //   });
  //   var data = jsonDecode(res.data);
  //   print(data);
  //   String hash = data['params']['hash'];
  //   print(hash);
  //   var myResponse = await payuMoneyFlutter.startPayment(
  //       txnid: txnID,
  //       amount: amount,
  //       name: firstName,
  //       email: email,
  //       phone: phone,
  //       productName: productName,
  //       hash: hash);
  //   print("Message ${myResponse}");
  //
  //
  //   return myResponse;
  // }

  void _getPlace(String address) async {
    print("getplace");
    // List<Location> locations = await locationFromAddress(address).then((value){
    //
    // });
    address = address + " " + selectedcity;
    await locationFromAddress(address).then((value) {
      print(value);

      List<Location> locations = value;
      if (locations.length > 0) {
        Location location = locations.first;
        makeOrderModel.latitude = location.latitude.toString();
        makeOrderModel.longitude = location.longitude.toString();
        makeOrderModel.city = selectedcity;
        makeOrderModel.userid = id;

        makeOrderModel.prescriptionFile = presimageBase64;
        // print("presimageBase64- {$presimageBase64}");
        print(makeOrderModel.prescriptionFile);
        makeOrderModel.previousReportFile = previousReportBase64;
        makeOrderModel.medicalConditionFile = medicalReportBase64;
        makeOrderModel.otherFile = otherReportBase64;
        makeOrderModel.gender = groupGenderValue;
        makeOrderModel.orderfor = groupSelfValue;

        GetStorage().write(Constant.Order, makeOrderModel);
        // Get.to(SelectOtherInfo());

        setState(() {
          orderStep = 1;
        });
      } else {
        Constant.showToast("Please enter valid Address");
      }
    }).catchError((onError) {
      print(onError);
      Constant.showToast("Location Not FoundPlease enter valid Address");
    });
  }
}

enum IMAGEFILETYPE { PRESCRIPTIONFILE, PREREPORTFILE, MEDICALFILE, OTHERFILE }
