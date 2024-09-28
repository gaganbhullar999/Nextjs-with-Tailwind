import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'dart:convert';

import 'package:medilabs/category/repository/model/get_category_response.dart';
import 'package:medilabs/category/repository/model/get_package_response.dart';
import 'package:medilabs/dashboard/repository/model/city_list_response.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/dashboard/repository/model/state_list_response.dart';
import 'package:medilabs/helper/ap_constant.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/state_city_dialog.dart';

class DashboardController extends GetxController {
  var loading = false.obs;
  var cartCount = 0.obs;
  var orderItems = GetStorage().read(Constant.items);
  var minimumAmountValue = 0;

  final _selectedCity = 'Select City'.obs;
  get selectedCity => this._selectedCity.value;
  set selectedCity(value) => this._selectedCity.value = value;

  @override
  void onReady() {
    super.onReady();

    final cityModel =
        cityModelFromJson(GetStorage().read(Constant.SELECTED_CITY));
    selectedCity = cityModel?.name ?? 'Select City';

    if (cityModel == null) {
      Get.dialog(StateCityDialog(), barrierDismissible: false);
    }
  }

  void setupCartList() {
    if (orderItems == null) {
      orderItems = <Orderitem>[].obs;
    } else {
      orderItems = GetStorage().read(Constant.items).obs;
    }
  }

  Future<GetCategoryResponse> getCategories() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.CATEGORIES}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetCategoryResponse registerLoginResponse =
        GetCategoryResponse.fromJson(response.data);

    return registerLoginResponse;
  }

  Future<GetPackageResponse> getPackages() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.PACKAGES}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetPackageResponse registerLoginResponse =
        GetPackageResponse.fromJson(response.data);

    return registerLoginResponse;
  }

  Future<GetPackageResponse> getPackagesbyType(String typeId) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.PACKAGES}", queryParameters: {
      'package_type': typeId,
    });

    GetPackageResponse registerLoginResponse =
        GetPackageResponse.fromJson(response.data);

    return registerLoginResponse;
  }

  Future<GetHomeDataResponse> getHomeData() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.HOMEAPI}").catchError((e) {
      print("Errrrrr ${e}");
    });
    print("dattttt home  ${response.data.toString()}");
    GetHomeDataResponse getHomeDataResponse =
        GetHomeDataResponse.fromJson(response.data);

    // List<Categories> categories = [];
    //
    // getHomeDataResponse.categories!.forEach((element) {
    //   categories.add(element);
    // });
    //
    // print("ctaaaaaaaa ${categories.toString()}");

    GetStorage().write(Constant.CATEGORIES,
        getHomeDataResponse.categories! as List<Categories>);
    GetStorage().write(
        Constant.PACKAGES, getHomeDataResponse.packages! as List<Packages>);
    GetStorage()
        .write(Constant.TESTS, getHomeDataResponse.tests! as List<Tests>);
    GetStorage().write(
        Constant.ALLCITES, getHomeDataResponse.workingcities! as List<String>);
    GetStorage().write(
        Constant.minimumAmountValue, getHomeDataResponse.minimumAmountValue!);

    print("dataaaaaaa ${getHomeDataResponse.tests.toString()}");

    return getHomeDataResponse;
  }

  Future<GetAllTestResponse> getAllTests() async {
    var dio = Dio();

    final response = await dio.get("${ApiConstant.ALL_TEST}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetAllTestResponse getAllTestResponse =
        GetAllTestResponse.fromJson(response.data);

    return getAllTestResponse;
  }

  Future<LoginResponse> getProfile(String userID) async {
    var dio = Dio();
    final response =
        await dio.get("${ApiConstant.GET_PROFILE}${userID}").catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });

    print("nnnnnn ${userID}");

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    if (loginResponse.success!) {
      GetStorage().write(Constant.PROFILE, loginResponse.data);
    }
    print("ressssss ${loginResponse.toString()}");

    return loginResponse;
  }

  Future<void> updateProfile(LoginData sloginResponse) async {
    print("update ${sloginResponse.toString()}");

    var dio = Dio();
    final response = await dio
        .post("${ApiConstant.UPDATE_PROFILE}", data: sloginResponse.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });
    print("Errrrrr ${response.data}");

    // LoginResponse mloginResponse = LoginResponse.fromJson(response.data);
  }

  Future<void> updatePrescription(LoginData sloginResponse) async {
    print("update ${sloginResponse.toString()}");

    var dio = Dio();
    final response = await dio
        .post("${ApiConstant.UPDATE_Prescription}",
            data: sloginResponse.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });
    print("Errrrrr ${response.data}");

    // LoginResponse mloginResponse = LoginResponse.fromJson(response.data);
  }

  Future<GetAllTestResponse> getAllTestsByCategory(String categoryID) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.GET_TEST_BY_CATEGORY}${categoryID}")
        .catchError((e) {
      print("Errrrrr ${e}");
    });

    GetAllTestResponse getAllTestResponse =
        GetAllTestResponse.fromJson(response.data);

    return getAllTestResponse;
  }

  Future<GetAllTestResponse> getAllTestsByType(String typeID) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.TESTS}", queryParameters: {'test_type': typeID});

    GetAllTestResponse getAllTestResponse =
        GetAllTestResponse.fromJson(response.data);

    return getAllTestResponse;
  }

  // Future<Map<String, dynamic>> startPayUPayment(String txnID,String phone, String email,
  //     String amount,String productName, String firstName, PayuMoneyFlutter payuMoneyFlutter) async {
  //   // Generating hash from php server
  //   var dio = Dio();
  //
  //   var res =
  //   await dio.post("http://server_url.com", data: {
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
  //   Map<String, dynamic> response = await payuMoneyFlutter.startPayment(
  //       txnid: txnID,
  //       amount: amount,
  //       name: firstName,
  //       email: email,
  //       phone: phone,
  //       productName: productName,
  //       hash: hash);
  //   print("EROROWROIWEURIWUERIUWRIOEU : $response");
  //
  //
  //   return response;
  //
  // }
  Future<StateListResponse> getAllStates() async {
    var dio = Dio();
    final response =
        await dio.post("${ApiConstant.STATE_LIST}").catchError((e) {
      print("Errrrrr ${e}");
    });

    return StateListResponse.fromJson(response.data);
  }

  Future<CityListResponse> getCities(String? stateId) async {
    var dio = Dio();
    final response = await dio.post("${ApiConstant.CITY_LIST}",
        data: {'state_id': stateId}).catchError((e) {
      print("Errrrrr ${e}");
    });

    return CityListResponse.fromJson(response.data);
  }
}
