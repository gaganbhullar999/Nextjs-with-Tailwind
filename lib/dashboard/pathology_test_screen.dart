import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:medilabs/all_test/ui/all_test.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/cart/ui/patient_details_screen.dart';
import 'package:medilabs/category/ui/all_categpries.dart';
import 'package:medilabs/category/ui/all_packages.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/dashboard/search_screen.dart';
import 'package:medilabs/dashboard/widgets/search_bar.dart';
import 'package:medilabs/dashboard/widgets/state_city_dialog.dart';
import 'package:medilabs/drawer/custom_drawer.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/size_config.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/lab/lab_detail.dart';
import 'package:medilabs/lab/model/lab_model.dart';
import 'package:medilabs/lab/package_detail.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:medilabs/prescription/upload_prescription.dart';
import 'package:medilabs/profile/ui/profile_screen.dart';
import 'package:medilabs/reports/repository/report_model.dart';
import 'package:medilabs/reports/ui/report_detail.dart';
import 'package:medilabs/reports/ui/widgets/report_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import '../category/repository/model/get_category_response.dart';
import '../prescription/new_upload_prescription.dart';
import 'widgets/sample_search_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PathologyTestScreen extends StatefulWidget {
  @override
  State<PathologyTestScreen> createState() => _PathologyTestScreenState();
}

double totalSubtotal = 0.0;

class _PathologyTestScreenState extends State<PathologyTestScreen> {
  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late Position _currentPosition;
  bool _permissionCheck = false;
  DashboardController dashboardController = Get.find();
  String userlocaton = "";
  final reportsList = [
    ReportModel("DDiatest Test", "diabetes test for all ages", "20/12/2021",
        "images/diabetes.jpg"),
    ReportModel("Blood Sugar Test", "sugar test for all ages", "21/12/2021",
        "images/diabetes.jpg"),
    ReportModel("Cholestrol level test", "cholestrol level for all ages",
        "21/12/2021", "images/diabetes.jpg"),
    ReportModel("Full body test", "full body test for all ages", "22/12/2021",
        "images/diabetes.jpg"),
    ReportModel("Hairfall Test", "hairfall test for all ages", "23/12/2021",
        "images/diabetes.jpg"),
    ReportModel("DDiatest Test", "diabetes test for all ages", "20/12/2021",
        "images/diabetes.jpg")
  ];

  final catList = [
    CategoryModel("Mom & Baby", Colors.blue),
    CategoryModel("Fighting the infection", Colors.deepPurple),
    CategoryModel("Diabetes", Colors.pinkAccent),
    CategoryModel("Antibiotics", Colors.redAccent)
  ];

  final labotoryImages = [
    "images/lab_1.jpg",
    "images/lab_2.jpg",
    "images/lab_3.jpg",
    "images/lab_4.png",
    "images/lab_5.jpg",
    "images/lab_7.jpg",
    "images/lab_8.jpg"
  ];

  final titleList = [
    "Home",
    "Lab Tests",
    "Healthcare",
    "Notifications",
    "Account"
  ];

  final iconList = const [
    "images/home.png",
    "images/chemistry.png",
    "images/sanitizer.png",
    "images/notification.png",
    "images/user.png"
  ];

  final testList = [
    LabModel("Diabites Test", "Selected from best labs", "65 in stock",
        "images/lab_1.jpg", "₹19", "₹35"),
    LabModel("Blood Sugar Test", "Selected from best labs", "48 in stock",
        "images/lab_2.jpg", "₹25", "₹55"),
    LabModel("Full Body Checkup", "Selected from best labs", "30 in stock",
        "images/lab_3.jpg", "₹31", "₹60"),
    LabModel("Nutrition Test", "Selected from best labs", "5 in stock",
        "images/lab_4.png", "₹12", "₹25"),
    LabModel("Heart Checkup", "Selected from best labs", "11 in stock",
        "images/lab_5.jpg", "₹25", "₹35"),
  ];

  var orderItems = GetStorage().read(Constant.items);

  bool categoriesFound = false;
  bool testsFound = false;
  bool packagesFound = false;
  String currentLocation = "Sourabh";
  String _currentAddress = "";

  @override
  void initState() {
    super.initState();
    getPrefs();
    if (GetStorage().read(Constant.useraddress) != null) {
      print(GetStorage().read(Constant.useraddress) != null);
      _currentAddress = (GetStorage().read(Constant.useraddress).toString());
    }
    // _checkLocationPermission3();
    _checkCameraPermission3();

    if (orderItems == null) {
      orderItems = <Orderitem>[];
    }
    if (orderItems.length > 0) {
      orderItems.forEach((element) {
        totalSubtotal += double.parse(element.displayPrice!);
      });
    }

    final DashboardController dashboardController = Get.find();
    dashboardController.getAllTestsByType("0").then((value) {
      testsFound = value.data?.isNotEmpty == true;
    }).catchError((err) {});
    dashboardController.getPackagesbyType("0").then((value) {
      packagesFound = value.data?.isNotEmpty == true;
    }).catchError((err) {});
  }

  _checkLocationPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.location].request();
      status = result[permissionHandler.Permission.location];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result =
          await [permissionHandler.Permission.locationWhenInUse].request();
      status = result[permissionHandler.Permission.locationWhenInUse];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      _getCurrentLocation();
      _checkCameraPermission3();
    } else {
      print('permi Nooooo');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Permission'),
          content:
              const Text('Please allow location permission from settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (Platform.isAndroid &&
                    status == permissionHandler.PermissionStatus.denied) {
                  _checkLocationPermission3();
                } else {
                  print('permi Nooooo Setting');
                  // AppSettings.openAppSettings();
                }
              },
              child: const Text('Ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );

      // showDialog2("Please allow location permission from settings.",
      //     okBtnClick: () async {
      //       navService().back();
      //       _permissionCheck = true;
      // if (Platform.isAndroid &&
      //     status == permissionHandler.PermissionStatus.denied) {
      //   _checkLocationPermission3();
      // } else {
      //   print('permi Nooooo Setting');
      // AppSettings.openAppSettings();
      // }
      //     }
      // );
    }
  }

  _checkCameraPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.camera].request();
      status = result[permissionHandler.Permission.camera];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.camera].request();
      status = result[permissionHandler.Permission.camera];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      // _getCurrentLocation();
      _checkSTORAGEPermission3();
    } else {
      print('permi Nooooo');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Camera Permission'),
          content: const Text('Please allow camera permission from settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (Platform.isAndroid &&
                    status == permissionHandler.PermissionStatus.denied) {
                  _checkLocationPermission3();
                } else {
                  print('permi Nooooo Setting');
                  // AppSettings.openAppSettings();
                }
              },
              child: const Text('Ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );

      // showDialog2("Please allow location permission from settings.",
      //     okBtnClick: () async {
      //       navService().back();
      //       _permissionCheck = true;
      // if (Platform.isAndroid &&
      //     status == permissionHandler.PermissionStatus.denied) {
      //   _checkLocationPermission3();
      // } else {
      //   print('permi Nooooo Setting');
      // AppSettings.openAppSettings();
      // }
      //     }
      // );
    }
  }

  _checkSTORAGEPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.storage].request();
      status = result[permissionHandler.Permission.storage];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.photos].request();
      status = result[permissionHandler.Permission.photos];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      // _getCurrentLocation();
    } else {
      print('permi Nooooo');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Read storage Permission'),
          content: const Text('Please allow storage permission from settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (Platform.isAndroid &&
                    status == permissionHandler.PermissionStatus.denied) {
                  _checkLocationPermission3();
                } else {
                  print('permi Nooooo Setting');
                  // AppSettings.openAppSettings();
                }
              },
              child: const Text('Ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );

      // showDialog2("Please allow location permission from settings.",
      //     okBtnClick: () async {
      //       navService().back();
      //       _permissionCheck = true;
      // if (Platform.isAndroid &&
      //     status == permissionHandler.PermissionStatus.denied) {
      //   _checkLocationPermission3();
      // } else {
      //   print('permi Nooooo Setting');
      // AppSettings.openAppSettings();
      // }
      //     }
      // );
    }
  }

  _getCurrentLocation() {
    print("OnLcation");
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: false)
        .then((Position position) {
      print("vvvvvvvvvvvssss");
      setState(() {
        _currentPosition = position;
        print("vvvvvvvvvvv");
        print(_currentPosition);
        userlocaton =
            "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}";
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print("eeeeeeeeeeeeeeee");
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    print("Onaddressssssssssss");
    try {
      print("Onaddress");
      GetStorage().write(Constant.userlat, _currentPosition.latitude);
      GetStorage().write(Constant.userlng, _currentPosition.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      GetStorage().write(Constant.useraddress,
          "${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}");
      setState(() {
        print(place);
        _currentAddress =
            "${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print("Onaddreseeeeeeeeeeeee");
      print(e);
    }
  }

  String? searchText;

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          floatingActionButton: orderItems.length > 0
              ? Container(
                  height: 80.0,
                  width: 80.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Stack(
                          children: [
                            Container(
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(CartList(() {
                                      var sorderItems =
                                          GetStorage().read(Constant.items);

                                      if (sorderItems != null) {
                                        setState(() {
                                          orderItems = sorderItems;
                                        });
                                      }
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  )),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  margin: EdgeInsets.only(right: 0),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Obx(() => Text(
                                        "${dashboardController.cartCount.value}")),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          key: _key,
          drawer: CustomDrawer(),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.sort,
                color: Constant.hexToColor(Constant.primaryBlue),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   "Sample Pickup from",
                        //   style: TextStyle(fontSize: 10),
                        // ),
                        InkWell(
                          onTap: () => _makePhoneCall("tel:8223901902"),
                          child: Image.asset(
                            'images/call.png',
                            width: 36,
                          ),
                        ),
                        if (_currentAddress != null)
                          Text(
                            _currentAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        Constant.USERLOGGEDIN
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(right: 4),
                                child: CustomButton(
                                    label: "Login",
                                    color: Constant.hexToColor(
                                        Constant.primaryBlue),
                                    textColor: Colors.white,
                                    borderColor: Constant.hexToColor(
                                        Constant.primaryBlue),
                                    onPressed: () {
                                      Get.to(LoginScreen());
                                    },
                                    fontSize: 10,
                                    padding: 4,
                                    height: 30,
                                    width: 90),
                              ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SearchScreen());
                    },
                    child: Container(
                      child: SampleSearchBar(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 12),
                child: Stack(
                  children: [
                    Container(
                      child: IconButton(
                          onPressed: () {
                            Get.to(CartList(() {
                              var sorderItems =
                                  GetStorage().read(Constant.items);

                              if (sorderItems != null) {
                                setState(() {
                                  orderItems = sorderItems;
                                });
                              }
                            }));

                            // pushNewScreen(
                            //   context,
                            //   screen: CartList(),
                            //   withNavBar: true, // OPTIONAL VALUE. True by default.
                            //   pageTransitionAnimation:
                            //       PageTransitionAnimation.cupertino,
                            // );
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Constant.hexToColor(Constant.primaryBlue),
                          )),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                              color: Colors.redAccent, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Obx(() =>
                                Text("${dashboardController.cartCount.value}")),
                          ),
                        ))
                  ],
                ),
              )
            ],
            backgroundColor: Colors.white,
            title: Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    "Pathology Test",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Constant.hexToColor(Constant.primaryBlueMin)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      " , ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(StateCityDialog(), barrierDismissible: false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Obx(
                        () => Text(
                          dashboardController.selectedCity,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // dashboardController.loading.value
                  //     ? buildLoadingBar()
                  //     : Container(),

                  //buildTopImages(),
                  SizedBox(
                    height: 12,
                  ),
                  buildSection(MediaQuery.of(context).size.width),

                  Container(
                    margin: EdgeInsets.only(bottom: 12, left: 12, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tests",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(AllTest(
                            cateogoryTest: false,
                            title: 'All Test',
                          )),
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Text(
                              "View all",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // buildRecentlySearchItems(),
                  buildTestsItems(),
                  Container(
                    margin: EdgeInsets.only(top: 24, left: 12, right: 12),
                    // child: buildUploadPrescription(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 12, left: 12, top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Packages",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(AllPackages(
                                  title: 'Packages',
                                )),
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // buildStageredSortProductList(200),
                        buildStageredSortPackageList(150),
                        // buildStageredSortCategoryList(150)
                      ],
                    ),
                  ),

                  // Positioned(bottom:0,left:0,right: 0,child: Container(
                  //     height: 150,
                  //     child:
                  //     dashboardController.cartCount >0 ? buildSubtotal(context) : Container()))
                  // Container(margin: EdgeInsets.only(top: 24,left: 12,right: 12),
                  //   child: buildReportsSection(),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopImages() {
    return FutureBuilder(
        future: dashboardController.getHomeData(),
        builder: (context, AsyncSnapshot<GetHomeDataResponse> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 200,
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (c, index) {
                      return Image.network(snapshot.data!.banner![index].image!,
                          fit: BoxFit.cover, loadingBuilder:
                              (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: Image.asset(
                          "images/logo.png",
                          height: 170,
                          width: 90,
                        ));
                      });
                    },
                    itemCount: snapshot.data!.banner!.length,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 4,
                  child: SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: snapshot.data!.banner!.length,
                      effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          dotColor: Colors.grey,
                          activeDotColor:
                              Constant.hexToColor(Constant.primaryBlue)),
                      onDotClicked: (index) {}),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildRecentlySearchItems() {
    return Container(
      height: 150,
      child: FutureBuilder(
          future: dashboardController.getHomeData(),
          builder: (BuildContext context,
              AsyncSnapshot<GetHomeDataResponse> snapshot) {
            if (snapshot.hasData) {
              List<Tests> filterList = [];
              List<Tests> savedList = snapshot.data!.tests!;

              if (searchText != null) {
                if (searchText!.length > 0) {
                  snapshot.data!.tests!.forEach((element) {
                    if (element.testname!.toLowerCase().contains(searchText!)) {
                      filterList.add(element);
                    } else {
                      if (filterList.contains(element)) {
                        filterList.remove(element);
                      }
                    }
                  });

                  if (filterList.length > 0) {
                    snapshot.data!.tests = filterList;
                  } else {
                    snapshot.data!.tests!.length = 0;
                  }
                } else {
                  snapshot.data!.tests = savedList;
                }
              }

              if (snapshot.data!.tests!.length > 0) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, index) {
                      if (orderItems != null) {
                        if (orderItems.length > 0) {
                          orderItems.forEach((element) {
                            if (element.id == snapshot.data!.tests![index].id) {
                              snapshot.data!.tests![index].quantity =
                                  "${element.quantity}";
                              snapshot.data!.tests![index].subtotal =
                                  "${element.subtotal}";
                            }
                          });
                        }
                      }
                      return InkWell(
                        onTap: () {
                          Get.to(TestDetail(
                              data: snapshot.data!.tests![index],
                              refresh: () {
                                var sorderItems =
                                    GetStorage().read(Constant.items);

                                setState(() {
                                  if (sorderItems != null) {
                                    orderItems = sorderItems;
                                  }
                                });
                              }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          child: Stack(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.tests![index].testname!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            snapshot.data!.tests![index]
                                                .description!,
                                            style: TextStyle(fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            "Category ${snapshot.data!.tests![index].categoryname!}",
                                            style: TextStyle(
                                                color: Constant.hexToColor(
                                                    Constant.primaryBlue)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text(snapshot
                                                        .data!
                                                        .tests![index]
                                                        .medilabsPrice!
                                                        .isEmpty
                                                    ? "₹ 0"
                                                    : int.parse(snapshot
                                                                .data!
                                                                .tests![index]
                                                                .quantity!) >=
                                                            1
                                                        ? "₹ ${snapshot.data!.tests![index].subtotal!}"
                                                        : "₹ ${snapshot.data!.tests![index].medilabsPrice!}"),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  snapshot.data!.tests![index]
                                                          .displayPrice!.isEmpty
                                                      ? "₹ 0"
                                                      : "₹ ${snapshot.data!.tests![index].displayPrice!}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Container(
                                                  color: Colors.redAccent,
                                                  child: Text(
                                                    snapshot
                                                            .data!
                                                            .tests![index]
                                                            .displayPrice!
                                                            .isEmpty
                                                        ? "0% OFF"
                                                        : "${snapshot.data!.tests![index].discount!}% OFF",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 120,
                                    height: 45,
                                    margin: EdgeInsets.only(right: 8, top: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            var itemfound = false;
                                            if (orderItems.length > 0) {
                                              orderItems.forEach((element) {
                                                if (element.id ==
                                                    snapshot.data!.tests![index]
                                                        .id) {
                                                  var preQua = int.parse(
                                                      snapshot
                                                          .data!
                                                          .tests![index]
                                                          .quantity!);
                                                  if (preQua > 1) {
                                                    var preQuantity = int.parse(
                                                            snapshot
                                                                .data!
                                                                .tests![index]
                                                                .quantity!) -
                                                        1;
                                                    element.quantity =
                                                        "${preQuantity}";
                                                    element.subtotal =
                                                        "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                                    element.finalamount =
                                                        "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                                    setState(() {
                                                      snapshot
                                                              .data!
                                                              .tests![index]
                                                              .quantity =
                                                          "${preQuantity}";
                                                      snapshot
                                                              .data!
                                                              .tests![index]
                                                              .subtotal =
                                                          "${element.subtotal}";
                                                    });
                                                  }
                                                  itemfound = true;
                                                  return;
                                                }
                                              });

                                              GetStorage().write(
                                                  Constant.items, orderItems);
                                              dashboardController.cartCount
                                                  .value = orderItems.length;
                                            }

                                            if (!itemfound) {
                                              int incre = int.parse(snapshot
                                                      .data!
                                                      .tests![index]
                                                      .quantity!) -
                                                  1;
                                              setState(() {
                                                snapshot.data!.tests![index]
                                                    .quantity = "${incre}";
                                              });
                                              orderItems.add(getOrderItem(
                                                  snapshot.data!.tests![index],
                                                  "${incre}"));
                                              GetStorage().write(
                                                  Constant.items, orderItems);
                                              dashboardController.cartCount
                                                  .value = orderItems.length;
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.lightBlueAccent
                                                    .withOpacity(.2)),
                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Text(
                                              "${snapshot.data!.tests![index].quantity}"),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            var itemfound = false;
                                            if (orderItems.length > 0) {
                                              orderItems.forEach((element) {
                                                if (element.id ==
                                                    snapshot.data!.tests![index]
                                                        .id) {
                                                  var preQuantity = int.parse(
                                                          snapshot
                                                              .data!
                                                              .tests![index]
                                                              .quantity!) +
                                                      1;
                                                  element.quantity =
                                                      "${preQuantity}";
                                                  element.subtotal =
                                                      "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                                  element.finalamount =
                                                      "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";

                                                  setState(() {
                                                    snapshot.data!.tests![index]
                                                            .quantity =
                                                        "${preQuantity}";
                                                    snapshot.data!.tests![index]
                                                            .subtotal =
                                                        "${element.subtotal}";
                                                  });

                                                  itemfound = true;
                                                  return;
                                                }
                                              });

                                              GetStorage().write(
                                                  Constant.items, orderItems);
                                              dashboardController.cartCount
                                                  .value = orderItems.length;
                                            }

                                            if (!itemfound) {
                                              int incre = int.parse(snapshot
                                                      .data!
                                                      .tests![index]
                                                      .quantity!) +
                                                  1;
                                              setState(() {
                                                snapshot.data!.tests![index]
                                                    .quantity = "${incre}";
                                              });
                                              orderItems.add(getOrderItem(
                                                  snapshot.data!.tests![index],
                                                  "${incre}"));
                                              GetStorage().write(
                                                  Constant.items, orderItems);
                                              dashboardController.cartCount
                                                  .value = orderItems.length;
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.lightBlueAccent
                                                    .withOpacity(.2)),
                                            child: Icon(Icons.add),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.tests!.length);
              } else {
                return Center(
                  child: Text("No test found"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildTestsItems() {
    var savedList = GetStorage().read(Constant.TESTS);

    // Constant.showToast("${orderItems.length}");
    // List<Tests> filterList = [];
    //
    // if (searchText != null) {
    //   if (searchText!.length > 0) {
    //     savedList.forEach((element) {
    //       if (element.testname!.toLowerCase().contains(searchText!)) {
    //         filterList.add(element);
    //       } else {
    //         if (filterList.contains(element)) {
    //           filterList.remove(element);
    //         }
    //       }
    //     });
    //
    //     if (filterList.length > 0) {
    //       // data.data!.categories = filterList;
    //       savedList = filterList;
    //     } else {
    //       // savedList.length=0;
    //       setState(() {
    //         testsFound = false;
    //       });
    //     }
    //   } else {}
    // } else {
    //   setState(() {
    //     testsFound = true;
    //   });
    // }

    if (savedList != null) {
      if (savedList.length > 0) {
        return Container(
            height: SizeConfig.margin_padding_100 * 1.6,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, index) {
                  var itemOnCart = false;

                  if (orderItems != null) {
                    if (orderItems.length > 0) {
                      orderItems.forEach((element) {
                        if (element.id == savedList[index].id) {
                          itemOnCart = true;
                          savedList[index].quantity = "${element.quantity}";
                          savedList[index].subtotal = "${element.subtotal}";
                        }
                      });
                    }
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(TestDetail(
                          data: savedList[index],
                          refresh: () {
                            var sorderItems = GetStorage().read(Constant.items);

                            setState(() {
                              if (sorderItems != null) {
                                orderItems = sorderItems;
                              }
                            });
                          }));
                    },
                    child: Container(
                      height: SizeConfig.margin_padding_85,
                      width: 230,
                      margin: EdgeInsets.only(right: 12),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              padding: EdgeInsets.only(left: 12, top: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(savedList[index].testname!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
                                      Text(
                                        savedList[index].description!,
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      // Text(
                                      //   "Category ${savedList[index].categoryname!}",
                                      //   style: TextStyle(
                                      //       color: Constant.hexToColor(
                                      //           Constant.primaryBlue)),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Text(savedList[index]
                                                    .displayPrice!
                                                    .isEmpty
                                                ? "₹ 0"
                                                : "₹ ${savedList[index].displayPrice!}"),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              savedList[index]
                                                      .totalPrice!
                                                      .isEmpty
                                                  ? "₹ 0"
                                                  : "₹ ${savedList[index].totalPrice!}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.redAccent,
                                        child: Text(
                                          savedList[index].discount!.isEmpty
                                              ? "0% OFF"
                                              : "${savedList[index].discount!}% OFF",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // if (!itemfound) {

                                      if (itemOnCart) {
                                        // Constant.showToast("Test already in cart");
                                        Constant.showToast(
                                            "Remove from the cart");
                                        setState(() {
                                          itemOnCart = false;
                                        });
                                        orderItems.removeWhere((item) =>
                                            item.id == savedList[index].id);
                                        GetStorage()
                                            .write(Constant.items, orderItems);
                                        dashboardController.cartCount.value =
                                            orderItems.length;
                                      } else {
                                        int incre = int.parse(
                                                savedList[index].quantity!) +
                                            1;

                                        setState(() {
                                          savedList[index].quantity =
                                              "${incre}";
                                        });

                                        orderItems.add(getOrderItem(
                                            savedList[index], "${incre}"));
                                        GetStorage()
                                            .write(Constant.items, orderItems);
                                        dashboardController.cartCount.value =
                                            orderItems.length;

                                        setState(() {
                                          itemOnCart = true;
                                        });
                                        Constant.showToast(
                                            "Test added to cart");
                                      }

                                      // }
                                    },
                                    child: Container(
                                        width: 90,
                                        height: SizeConfig.margin_padding_40,
                                        margin:
                                            EdgeInsets.only(right: 8, top: 12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: itemOnCart
                                                  ? Colors.green
                                                  : Constant.hexToColor(
                                                      Constant.primaryBlue)),
                                          child: Center(
                                              child: itemOnCart
                                                  ? RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "Done ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          WidgetSpan(
                                                            child: Icon(
                                                                Icons.check,
                                                                size: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text: "Book ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white)),
                                                          WidgetSpan(
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )

                                              // Text(
                                              //   itemOnCart?"Added":"Add",
                                              //   style: itemOnCart? TextStyle(
                                              //       fontWeight: FontWeight.w600,
                                              //       color: Colors.white):TextStyle(
                                              //       fontWeight: FontWeight.w600,
                                              //       color: Colors.white),
                                              // ),
                                              ),
                                        )

                                        // child: Row(
                                        //   mainAxisAlignment: MainAxisAlignment.end,
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: () {
                                        //         // var itemfound = false;
                                        //         // if (orderItems.length > 0) {
                                        //         //   orderItems.forEach((element) {
                                        //         //     if (element.id ==
                                        //         //         savedList[index].id) {
                                        //         //       var preQua = int.parse(
                                        //         //           savedList[index]
                                        //         //               .quantity!);
                                        //         //       if (preQua >= 1) {
                                        //         //         var preQuantity = int.parse(
                                        //         //                 savedList[index]
                                        //         //                     .quantity!) -
                                        //         //             1;
                                        //         //
                                        //         //         if (preQuantity == 0) {
                                        //         //           orderItems
                                        //         //               .remove(element);
                                        //         //           setState(() {
                                        //         //             savedList[index]
                                        //         //                 .quantity =
                                        //         //             "${preQuantity}";
                                        //         //             savedList[index]
                                        //         //                 .subtotal =
                                        //         //             "${element.subtotal}";
                                        //         //           });
                                        //         //
                                        //         //           // GetStorage().write(
                                        //         //           //     Constant.items, orderItems);
                                        //         //           // dashboardController.cartCount
                                        //         //           //     .value = orderItems.length;
                                        //         //
                                        //         //
                                        //         //         }
                                        //         //
                                        //         //         // else {
                                        //         //         //   element.quantity =
                                        //         //         //   "${preQuantity}";
                                        //         //         //   element.subtotal =
                                        //         //         //   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                        //         //         //   element.finalamount =
                                        //         //         //   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                        //         //         //   setState(() {
                                        //         //         //     savedList[index]
                                        //         //         //         .quantity =
                                        //         //         //     "${preQuantity}";
                                        //         //         //     savedList[index]
                                        //         //         //         .subtotal =
                                        //         //         //     "${element.subtotal}";
                                        //         //         //   });
                                        //         //         //
                                        //         //         // }
                                        //         //
                                        //         //         GetStorage().write(
                                        //         //             Constant.items, orderItems);
                                        //         //         dashboardController.cartCount
                                        //         //             .value = orderItems.length;
                                        //         //       }
                                        //         //
                                        //         //
                                        //         //       itemfound = true;
                                        //         //       return;
                                        //         //     }
                                        //         //   });
                                        //         //
                                        //         // }
                                        //
                                        //         // if (!itemfound) {
                                        //         //   var preQua = int.parse(
                                        //         //       savedList[index].quantity!);
                                        //         //   if (preQua >= 1) {
                                        //         //     int incre = int.parse(
                                        //         //             savedList[index]
                                        //         //                 .quantity!) -
                                        //         //         1;
                                        //         //     setState(() {
                                        //         //       savedList[index].quantity =
                                        //         //           "${incre}";
                                        //         //     });
                                        //         //     orderItems.add(getOrderItem(
                                        //         //         savedList[index],
                                        //         //         "${incre}"));
                                        //         //
                                        //         //     GetStorage().write(
                                        //         //         Constant.items, orderItems);
                                        //         //     dashboardController.cartCount
                                        //         //         .value = orderItems.length;
                                        //         //   }
                                        //         // }
                                        //
                                        //         Constant.showToast(
                                        //             "Test is remove from cart");
                                        //       },
                                        //       child: Container(
                                        //         decoration: BoxDecoration(
                                        //             borderRadius:
                                        //                 BorderRadius.circular(12),
                                        //             color: Colors.lightBlueAccent
                                        //                 .withOpacity(.2)),
                                        //         child: Icon(Icons.remove),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       margin: EdgeInsets.only(
                                        //           left: 12, right: 12),
                                        //       child: Text(
                                        //           "${savedList[index].quantity}"),
                                        //     ),
                                        //     InkWell(
                                        //       onTap: () {
                                        //         var itemfound = false;
                                        //         if (orderItems.length > 0) {
                                        //           orderItems.forEach((element) {
                                        //             if (element.id ==
                                        //                 savedList[index].id) {
                                        //               var preQuantity = int.parse(
                                        //                       savedList[index]
                                        //                           .quantity!) +
                                        //                   1;
                                        //               element.quantity =
                                        //                   "${preQuantity}";
                                        //               element.subtotal =
                                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                        //               element.finalamount =
                                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                                        //
                                        //               setState(() {
                                        //                 savedList[index].quantity =
                                        //                     "${preQuantity}";
                                        //                 savedList[index].subtotal =
                                        //                     "${element.subtotal}";
                                        //               });
                                        //
                                        //               itemfound = true;
                                        //               return;
                                        //             }
                                        //           });
                                        //
                                        //           GetStorage().write(
                                        //               Constant.items, orderItems);
                                        //           dashboardController.cartCount
                                        //               .value = orderItems.length;
                                        //         }
                                        //
                                        //         if (!itemfound) {
                                        //           int incre = int.parse(
                                        //                   savedList[index]
                                        //                       .quantity!) +
                                        //               1;
                                        //           setState(() {
                                        //             savedList[index].quantity =
                                        //                 "${incre}";
                                        //           });
                                        //           orderItems.add(getOrderItem(
                                        //               savedList[index],
                                        //               "${incre}"));
                                        //           GetStorage().write(
                                        //               Constant.items, orderItems);
                                        //           dashboardController.cartCount
                                        //               .value = orderItems.length;
                                        //         }
                                        //
                                        //         Constant.showToast(
                                        //             "Test added to cart");
                                        //       },
                                        //       child: Container(
                                        //         decoration: BoxDecoration(
                                        //             borderRadius:
                                        //                 BorderRadius.circular(12),
                                        //             color: Colors.lightBlueAccent
                                        //                 .withOpacity(.2)),
                                        //         child: Icon(Icons.add),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: savedList.length));
      } else {
        return Center(
          child: Text("No Tests found"),
        );
      }
    } else {
      return Center(
        child: Text("No Tests found"),
      );
    }
  }

  Widget buildUploadPrescription() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.add_circle_outline_sharp)),
            Container(
                margin: EdgeInsets.only(top: 12),
                child: Text(
                  "Upload Prescription",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              width: 1, color: Constant.hexToColor(Constant.primaryBlueMin))),
    );
  }

  Widget buildReportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12, left: 12, top: 12),
          child: Text(
            "Reports",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 220,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, index) {
                return InkWell(
                  onTap: () {
                    Get.to(ReportDetail(reportsList[index]));
                  },
                  child: ReportCard(175, 220, reportsList[index]),
                );
              },
              itemCount: reportsList.length),
        )
      ],
    );
  }

  Widget buildSection(double width) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                if (testsFound) {
                  Get.to(AllTest(
                    cateogoryTest: false,
                    title: 'Pathology Test',
                    categoryName: 'Pathology Test',
                    testType: '0',
                  ));
                }
              },
              child: Container(
                height: 110,
                width: width * .3,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: Image.asset(
                                  "images/9733529.png",
                                  height: 35,
                                  width: 35,
                                ))),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  "Pathology\nTest",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (packagesFound) {
                  Get.to(AllPackages(
                    title: 'Pathology Packages',
                    packageType: '0',
                  ));
                }
              },
              child: Container(
                height: 110,
                width: width * .3,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: Image.asset(
                                  "images/dignostic.png",
                                  height: 35,
                                  width: 35,
                                ))),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  "Pathology\nPackages",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.to(NewUploadPrescription()),
              // onTap: () => pushNewScreen(
              //   context,
              //   screen: ProfileScreen(),
              //   withNavBar: true, // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // ),
              child: Container(
                height: 110,
                width: width * .3,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: Image.asset(
                                  "images/gall.png",
                                  height: 35,
                                  width: 35,
                                ))),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                child: FittedBox(
                                  child: Text(
                                    "Upload \nPrescription",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.start,
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStageredSortProductList(double height) {
    print("xxxxxxxxxxxx");

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetHomeDataResponse> data) {
        if (data.hasData) {
          List<Categories> filterList = [];
          List<Categories> savedList = data.data!.categories!;

          if (searchText != null) {
            if (searchText!.length > 0) {
              data.data!.categories!.forEach((element) {
                if (element.name!.toLowerCase().contains(searchText!)) {
                  filterList.add(element);
                } else {
                  if (filterList.contains(element)) {
                    filterList.remove(element);
                  }
                }
              });

              if (filterList.length > 0) {
                // data.data!.categories = filterList;
                savedList = filterList;
              } else {
                setState(() {
                  categoriesFound = false;
                });
              }
            } else {}
          } else {
            // setState(() {
            categoriesFound = true;
            // });

          }

          if (savedList != null) {
            if (categoriesFound) {
              return Container(
                child: GridView.count(
                  childAspectRatio: 175 / height,
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 8,
                  children: List.generate(savedList.length, (index) {
                    return InkWell(
                      onTap: () => Get.to(AllTest(
                        cateogoryTest: true,
                        categoryId: savedList[index].id,
                        title: savedList[index].name ?? '',
                      )),
                      child: Container(
                        child: Center(
                          child: Text(
                            savedList[index].name!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    );
                  }),
                ),
              );
            } else {
              return Center(
                child: Text("No Categories found"),
              );
            }
          } else {
            return Center(
              child: Text("No Categories found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: dashboardController.getHomeData(),
    );
  }

  Widget buildStageredSortPackageList(double height) {
    print("xxxxxxxxxxxx");
    height = SizeConfig.blockSizeVertical * 25;
    double imgheight = SizeConfig.blockSizeVertical * 20;
    var savedList = GetStorage().read(Constant.PACKAGES);

    if (savedList != null) {
      if (savedList.length > 0) {
        return Container(
          child: GridView.count(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.6),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 2,
            // mainAxisSpacing: 24,
            // crossAxisSpacing: 8,
            children: List.generate(savedList.length, (index) {
              if (orderItems != null) {
                if (orderItems.length > 0) {
                  orderItems.forEach((element) {
                    if ("p" + element.id == "p" + savedList[index].id) {
                      savedList[index].quantity = "${element.quantity}";
                      // savedList[index].subtotal =
                      // "${element.subtotal}";
                    }
                  });
                }
              }
              return InkWell(
                // onTap: () => Get.to(AllTest(
                //     cateogoryTest: true, categoryId: savedList[index].id)),

                onTap: () {
                  Get.to(PackageDetail(
                      data: savedList[index],
                      refresh: () {
                        var sorderItems = GetStorage().read(Constant.items);

                        setState(() {
                          if (sorderItems != null) {
                            orderItems = sorderItems;
                          }
                        });
                      }));
                },
                child: Container(
                  child: Center(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            // width: 600,
                            height: imgheight,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: savedList[index].image!,
                            imageBuilder: (context, imageProvider) => Container(
                              height: SizeConfig.blockSizeVertical,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'images/logo.png',
                                height: imgheight,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'images/logo.png',
                                height: imgheight,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(savedList[index].package!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3)
                        ]),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                ),
              );
            }),
          ),
        );
      } else {
        return Center(
          child: Text("No Package found"),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetHomeDataResponse> data) {
        if (data.hasData) {
          List<Categories> filterList = [];
          List<Categories> savedList = data.data!.categories!;

          if (searchText != null) {
            if (searchText!.length > 0) {
              data.data!.categories!.forEach((element) {
                if (element.name!.toLowerCase().contains(searchText!)) {
                  filterList.add(element);
                } else {
                  if (filterList.contains(element)) {
                    filterList.remove(element);
                  }
                }
              });

              if (filterList.length > 0) {
                // data.data!.categories = filterList;
                savedList = filterList;
              } else {
                data.data!.categories!.length = 0;
              }
            } else {
              savedList = data.data!.categories!;
            }
          } else {
            savedList = data.data!.categories!;
          }

          if (savedList.length > 0) {
            return Container(
              child: GridView.count(
                childAspectRatio: 175 / height,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 8,
                children: List.generate(savedList.length, (index) {
                  return InkWell(
                    onTap: () => Get.to(
                      AllTest(
                        cateogoryTest: true,
                        categoryId: savedList[index].id,
                        title: savedList[index].name ?? '',
                      ),
                    ),
                    child: Container(
                      child: Center(
                        child: Text(
                          savedList[index].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: catList[index].color,
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: Text("No Categories found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: dashboardController.getHomeData(),
    );
  }

  Widget buildStageredSortCategoryList(double height) {
    print("xxxxxxxxxxxx");

    var savedList = GetStorage().read(Constant.CATEGORIES);
    // List<Categories> filterList = [];
    // print("xxxxxxxxxxxx " + savedList.toString());
    //
    // if (searchText != null) {
    //   if (searchText!.length > 0) {
    //     savedList.forEach((element) {
    //       if (element.name!.toLowerCase().contains(searchText!)) {
    //         filterList.add(element);
    //       } else {
    //         if (filterList.contains(element)) {
    //           filterList.remove(element);
    //         }
    //       }
    //     });
    //
    //     if (filterList.length > 0) {
    //       // data.data!.categories = filterList;
    //       savedList = filterList;
    //     } else {
    //       // savedList.length=0;
    //       setState(() {
    //         categoriesFound = false;
    //       });
    //     }
    //   } else {}
    // } else {
    //   setState(() {
    //     categoriesFound = true;
    //   });
    // }

    if (savedList != null) {
      if (savedList.length > 0) {
        return Container(
          child: GridView.count(
            childAspectRatio: 175 / height,
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 8,
            children: List.generate(savedList.length, (index) {
              return InkWell(
                onTap: () => Get.to(AllTest(
                  cateogoryTest: true,
                  categoryId: savedList[index].id,
                  title: savedList[index].name,
                )),
                child: Container(
                  child: Center(
                    child: Text(
                      savedList[index].name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(18)),
                ),
              );
            }),
          ),
        );
      } else {
        return Center(
          child: Text("No Categories found"),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetHomeDataResponse> data) {
        if (data.hasData) {
          List<Categories> filterList = [];
          List<Categories> savedList = data.data!.categories!;

          if (searchText != null) {
            if (searchText!.length > 0) {
              data.data!.categories!.forEach((element) {
                if (element.name!.toLowerCase().contains(searchText!)) {
                  filterList.add(element);
                } else {
                  if (filterList.contains(element)) {
                    filterList.remove(element);
                  }
                }
              });

              if (filterList.length > 0) {
                // data.data!.categories = filterList;
                savedList = filterList;
              } else {
                data.data!.categories!.length = 0;
              }
            } else {
              savedList = data.data!.categories!;
            }
          } else {
            savedList = data.data!.categories!;
          }

          if (savedList.length > 0) {
            return Container(
              child: GridView.count(
                childAspectRatio: 175 / height,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 8,
                children: List.generate(savedList.length, (index) {
                  return InkWell(
                    onTap: () => Get.to(AllTest(
                      cateogoryTest: true,
                      categoryId: savedList[index].id,
                      title: savedList[index].name ?? '',
                    )),
                    child: Container(
                      child: Center(
                        child: Text(
                          savedList[index].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: catList[index].color,
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: Text("No Categories found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: dashboardController.getHomeData(),
    );
  }

  Widget buildLoadingBar() {
    return LinearProgressIndicator(
      minHeight: 4,
      backgroundColor: Constant.hexToColor(Constant.primaryBlue),
    );
  }

  Orderitem getOrderItem(Tests test, String quantity) {
    return Orderitem()
      ..id = test.id!
      ..categoryId = test.categoryId!
      ..subcategoryId = test.subcategoryId!
      ..testname = test.testname!
      ..vendorPrice = test.vendorPrice!.isEmpty ? "0" : test.vendorPrice!
      ..medilabsPrice = test.medilabsPrice!.isEmpty ? "0" : test.medilabsPrice!
      ..totalPrice = test.totalPrice!.isEmpty ? "0" : test.totalPrice!
      ..discount = test.discount!
      ..displayPrice = test.displayPrice!.isEmpty ? "0" : test.displayPrice!
      ..quantity = quantity
      ..subtotal =
          "${double.tryParse(test.quantity!)! * double.tryParse(test.medilabsPrice!.isEmpty ? "0" : test.displayPrice!)!}"
      ..finalamount =
          "${double.tryParse(test.quantity!)! * double.tryParse(test.medilabsPrice!.isEmpty ? "0" : test.displayPrice!)!}"
      ..testname = test.testname!
      ..description = test.description!
      ..status = test.status!
      ..addedon = DateTime.now().toString()
      ..addedby = "1"
      ..updatedOn = DateTime.now().toString()
      ..updatedBy = "1"
      ..appClientId = "1"
      ..image = ""
      ..categoryname = test.categoryname!
      ..subcategoryname = test.subcategoryname!;
  }

  // _getAddressFromLatLng() async {
  // try {
  //   List<Placemark> p = await geolocator.(
  //       _currentPosition.latitude, _currentPosition.longitude);
  //   Placemark place = p[0];
  //   setState(() {
  //     _currentAddress =
  //     "${place.locality}, ${place.postalCode}, ${place.country}";
  //   });
  // } catch (e) {
  //   print(e);
  // }
  // }

// _getCurrentLocation() {
//   geolocator
//       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//       .then((Position position) {
//     setState(() {
//       _currentPosition = position;
//     });
//     _getAddressFromLatLng();
//   }).catchError((e) {
//     print(e);
//   });
// }
}

Future<bool> getPrefs() async {
  late SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString(Constant.USERID) == null) {
    Constant.USERLOGGEDIN = false;
    return false;
  } else {
    Constant.USERLOGGEDIN = true;
    return true;
  }
}

Widget buildSubtotal(BuildContext context) {
  return Container(
    child: Card(
      child: Container(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(
                        color: Constant.hexToColor(Constant.primaryBlue),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ ${totalSubtotal}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Constant.hexToColor(Constant.primaryBlue)),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "TAX (0%)",
            //         style: TextStyle(
            //             color: Constant.hexToColor(Constant.primaryBlue),
            //             fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         "₹ 0",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             color: Constant.hexToColor(Constant.primaryBlue)),
            //       )
            //     ],
            //   ),
            // ),

            Container(
              margin: EdgeInsets.only(top: 8),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    // if (orderItems != null) {
                    //   makeOrderModel = MakeOrderModel()
                    //     ..orderitem = orderItems as List<Orderitem>
                    //     ..subtotal = "${totalSubtotal}"
                    //     ..finalamount = "${totalSubtotal}";
                    //   GetStorage().write(Constant.Order, makeOrderModel);
                    // }

                    print("lllllll ${GetStorage().read(Constant.USERID)}");
                    if (Constant.USERLOGGEDIN) {
                      Get.to(PatientDetailsScreen());
                    } else {
                      GetStorage().write(Constant.SCREEN, LOGINSCREEN.CART);
                      Get.to(LoginScreen());
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Checkout",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      FittedBox(
                        child: Text(
                          "₹ ${totalSubtotal}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Constant.hexToColor(Constant.primaryBlue),
                  borderRadius: BorderRadius.circular(25)),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    ),
  );
}

Future<void> _makePhoneCall(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not make call'; // $url';
  }
}

class CategoryModel {
  final String title;
  final Color color;

  CategoryModel(this.title, this.color);
}
