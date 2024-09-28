import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

class Constant {
  static String primaryBlue = "#10529E";

  static String primaryBlueMin = "#10529F";
  static String primaryRed = "#E21D26";
  static String lightGrey = "#F9F9F9";
  static String lightGreen = "#E9FF3";

  static String SPLASHDATA = "splash_data";

  static String USERID = "userID";
  static bool USERLOGGEDIN = false;
  static String welcomescreen = "welcomescreen";
  static bool iswelcomescreen = false;

  static String userlat = "";
  static String userlng = "";
  static String useraddress = "";

  static List<Orderitem> orderItems = [];

  static String items = "items";
  static String minimumAmountValue = "minimumAmountValue";

  static String Order = "orderrr";

  static String PROFILE = "profile";

  static String CATEGORIES = "categoriessss";
  static String PACKAGES = "packages";
  static String ALLCITES = "allcity";
  static String SELECTED_STATE = "SELECTED_STATE";
  static String SELECTED_CITY = "SELECTED_CITY";
  static String APPLIED_COUPON = "APPLIED_COUPON";

  static String TESTS = "testsssss";
  static String ALLTESTS = "alltestsssss";

  static String SCREEN = "screens";
  static String CASHFREE_APP_ID = "1955857e2663d536fae5e0824a585591"; //live
  static String CASHFREE_APP_ID_SANDBOX =
      "146500edc00267a71948a3f6c0005641"; //test
  static final environment = CFEnvironment.PRODUCTION;
  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static void showToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  // showLoading() => dialogService().showCustomDialog(customData: DialogType.Loading,);
}
