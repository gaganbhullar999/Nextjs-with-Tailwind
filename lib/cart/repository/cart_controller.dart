import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:medilabs/book/repository/model/get_all_order_response.dart';
import 'package:medilabs/cart/repository/model/get_medical_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/tokenmodel.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/helper/ap_constant.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import '../couponmodel.dart';
import 'model/create_order_response.dart';

class CartController extends GetxController {
  Future<GetMedicalResponse> getMedicalForm() async {
    var dio = Dio();
    final response =
        await dio.get("${ApiConstant.MEDICAL_FORM}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetMedicalResponse getMedicalResponse =
        GetMedicalResponse.fromJson(response.data);
    return getMedicalResponse;
  }

  Future<GetMedicalResponse> getavailabletime(String date) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.MEDICAL_FORM}&date=${date}")
        .catchError((e) {
      print("Errrrrr ${e}");
    });

    GetMedicalResponse getMedicalResponse =
        GetMedicalResponse.fromJson(response.data);
    return getMedicalResponse;
  }

  Future<LoginResponse> updateOrderPrescription(
      LoginData sloginResponse) async {
    print("update ${sloginResponse.toString()}");

    var dio = Dio();
    final response = await dio
        .post("${ApiConstant.UPDATE_OREDER_Prescription}",
            data: sloginResponse.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });
    print("Errrrrr ${response.data}");

    LoginResponse mloginResponse = LoginResponse.fromJson(response.data);
    return mloginResponse;
  }

  Future<CreateOrderResponse> createOrder(MakeOrderModel makeOrderModel) async {
    var dio = Dio();
    print("makeOrderModel final-  ${makeOrderModel}");
    final response = await dio
        .post("${ApiConstant.BOOK_TEST}", data: makeOrderModel.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
    });

    print("Orderrrrrr ${makeOrderModel.toString()}");

    CreateOrderResponse loginResponse =
        CreateOrderResponse.fromJson(response.data);

    return loginResponse;
  }

  Future<TokenModel> getcashfreetoken(String amount, String userid) async {
    var dio = Dio();
    final response = await dio
        .post("${ApiConstant.CASHFREE_TOKEN}&amount=${amount}&userid=${userid}")
        .catchError((e) {
      print("Errrrrr ${e}");
    });
    print("tokan ${response.toString()}");
    TokenModel tmodel = TokenModel.fromJson(response.data);
    return tmodel;
  }

  Future verifyPayment(String orderId) async {
    var dio = Dio();
    String url;
    Map<String, String> headers = {};
    headers['x-api-version'] = '2022-09-01';
    headers['Accept'] = 'application/json';
    if (Constant.environment == CFEnvironment.SANDBOX) {
      url = 'https://sandbox.cashfree.com/pg/orders/$orderId/payments';
      headers['x-client-id'] = '146500edc00267a71948a3f6c0005641';
      headers['x-client-secret'] =
          'TEST99ab86002f6c7b4223b2bfc4cc350412933e209b';
    } else {
      url = 'https://api.cashfree.com/pg/orders/$orderId/payments';
      headers['x-client-id'] = '1955857e2663d536fae5e0824a585591';
      headers['x-client-secret'] = '855134613ee9a207abeca059036182aeda5bb4c3';
    }
    try {
      final response = await dio.get(url, options: Options(headers: headers));
      final list = (response.data as List);
      if (list.isNotEmpty) {
        return list.last;
      }
      print('verifyPayment $response');
    } catch (e) {
      print("error verifyPayment $e");
    }
  }

  Future<TokenModel> setRating(String rating, String comment, String orderid,
      String vendororderid, String vendorid, String userid) async {
    var dio = Dio();
    final response = await dio
        .post(
            "${ApiConstant.SET_RATING}&rating=${rating}&comment=${comment}&orderid=${orderid}&vendororderid=${vendororderid}&vendorid=${vendorid}&userid=${userid}")
        .catchError((e) {
      print("Errrrrr ${e}");
    });
    print("tokan ${response.toString()}");
    TokenModel tmodel = TokenModel.fromJson(response.data);
    return tmodel;
  }

  Future<CoupenModel> checkcouponcode(
      String code, String userid, double ordertotal) async {
    print("code ${code}");
    var dio = Dio();
    print(
        "${ApiConstant.CHECK_COUPON_CODE}&coupencode=${code}&userid=${userid}&ordertotal=$ordertotal");
    final response = await dio
        .post(
            "${ApiConstant.CHECK_COUPON_CODE}&coupencode=${code}&userid=${userid}&ordertotal=$ordertotal")
        .catchError((e) {
      print("Errrrrr ${e}");
    });
    print("tokansssss ${response.data.toString()}");
    CoupenModel cmodel = CoupenModel.fromJson(response.data);
    return cmodel;
  }

  Future<GetAllOrderResponse> getAllOrders(String userId) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.GET_ALL_BOOK_TEST}${userId}")
        .catchError((e) {
      print("Errrrrr ${e}");
    });
    print("orderlist  user ${userId}");
    print("data order list ${response.data.toString()}");

    GetAllOrderResponse getAllOrderResponse =
        GetAllOrderResponse.fromJson(response.data);

    return getAllOrderResponse;
  }
}
