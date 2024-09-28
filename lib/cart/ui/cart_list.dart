import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/ui/patient_details_screen.dart';
import 'package:medilabs/cart/ui/select_address_list.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/lab/model/lab_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../couponmodel.dart';
import 'widgets/cart_card.dart';

class CartList extends StatefulWidget {
  Function() refreshData;

  CartList(this.refreshData);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Orderitem> orderItems = GetStorage().read(Constant.items);
  double totalSubtotal = 0.0;
  late SharedPreferences sharedPreferences;
  DashboardController dashboardController = Get.find();
  var minimumAmountValue = GetStorage().read(Constant.minimumAmountValue);

  MakeOrderModel makeOrderModel = MakeOrderModel();
  bool cartEmpty = false;
  bool useriD = false;
  String couponcodeid = "";
  String couponcode = "";
  String user_couponcode = "";
  String amounttype = "";
  double couponamount = 0.0;
  double coupondiscountamount = 0.0;
  double doctorCommissionAmount = 0.0;
  double coupon_price = 0.0;
  double amountwithoutcoupon = 0.0;
  double finalamount = 0.0;
  String idd = '1';
  String? rate;
  CartController cartController = CartController();
  @override
  void initState() {
    super.initState();

    if (orderItems == null) {
      orderItems = <Orderitem>[];

      setState(() {
        cartEmpty = true;
      });
    } else {
      if (orderItems.length > 0) {
        orderItems.forEach((element) {
          totalSubtotal += double.parse(element.displayPrice!);
        });
        finalamount = totalSubtotal;
        CoupenModel? cmodel = GetStorage().read(Constant.APPLIED_COUPON);

        setState(() {
          couponcode = cmodel?.coupendate?.coupon_code ?? '';
        });
        checkcoupen(context, isRecheck: true);
        //applyCoupon();
      } else {
        setState(() {
          cartEmpty = true;
        });
      }
    }
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (orderItems.length > 0) {
          widget.refreshData();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Cart",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: !cartEmpty
              ? Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 170),
                          child: buildCartItemList()),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: 150,
                            child: !cartEmpty
                                ? buildSubtotal(context)
                                : Container())),
                    cartEmpty
                        ? Center(child: Text("You cart is empty..."))
                        : Container()
                  ],
                )
              : Center(child: Text("You cart is empty...")),
        ),
      ),
    );
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
              user_couponcode != ''
                  ? Container(
                      margin: EdgeInsets.only(top: 4, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coupon ${user_couponcode}",
                            style: TextStyle(
                                color:
                                    Constant.hexToColor(Constant.primaryBlue),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.green),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () => removecoupon(context),
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 08,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ),
                          _isCouponChecking
                              ? SizedBox(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                  height: 24,
                                  width: 24,
                                )
                              : Text(
                                  "₹ ${coupondiscountamount}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue)),
                                )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () => showCouponBar(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Apply Coupon",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      if (!kDebugMode &&
                          finalamount < int.parse(minimumAmountValue)) {
                        showMinimumAmountAlert(context);
                      } else {
                        if (orderItems != null) {
                          makeOrderModel = MakeOrderModel()
                            ..orderitem = orderItems as List<Orderitem>
                            ..subtotal = "${totalSubtotal}"
                            ..couponcodeid = "${couponcodeid}"
                            ..couponcode = "${user_couponcode}"
                            ..couponamount = "${couponamount.toInt()}"
                            ..coupondiscountamount =
                                "${coupondiscountamount.toInt()}"
                            ..amountwithoutcoupon =
                                "${amountwithoutcoupon.toInt()}"
                            ..amounttype = "${amounttype}"
                            ..finalamount = "${finalamount.toInt()}";
                          GetStorage().write(Constant.Order, makeOrderModel);
                        }

                        print("lllllll ${GetStorage().read(Constant.USERID)}");
                        if (useriD) {
                          Get.to(PatientDetailsScreen());
                        } else {
                          GetStorage().write(Constant.SCREEN, LOGINSCREEN.CART);
                          Get.to(LoginScreen());
                        }
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
                            "₹ ${finalamount}",
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

  Widget buildCartItemList() {
    // return Container();

    if (orderItems != null && orderItems.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (c, index) {
            return Container(
              child: CartCard(orderItems[index], () {
                setState(() {
                  totalSubtotal = 0.0;
                  orderItems.forEach((element) {
                    totalSubtotal += double.parse(element.subtotal!);
                  });
                  finalamount = totalSubtotal;
                  if (totalSubtotal > 0) {
                    //applyCoupon();
                    checkcoupen(context, isRecheck: true);
                    // setState(() {
                    //     orderItems==null;
                    // });
                  }
                });
                dashboardController.cartCount.value = orderItems.length;
              }),
            );
          },
          itemCount: orderItems.length);
    } else {
      setState(() {
        cartEmpty = true;
      });
      return Container();
    }
  }

  void showCouponBar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextField(
                          decoration: InputDecoration(labelText: "CODE"),
                          onChanged: (v) {
                            couponcode = v;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () {
                            checkcoupen(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 24, left: 12),
                //   child: Text(
                //     "Coupon Applied Successfully",
                //     style: TextStyle(
                //         color: Colors.green, fontWeight: FontWeight.w600),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   margin: EdgeInsets.only(top: 12, left: 12),
                //   child: Text(
                //     "Get 50% off on any order, Valid only for new users",
                //     style: TextStyle(color: Colors.green, fontSize: 18),
                //   ),
                // )
              ],
            ),
          );
        });
  }

  Future<bool> getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(Constant.USERID) == null) {
      useriD = false;
      return false;
    } else {
      useriD = true;
      idd = sharedPreferences.getString(Constant.USERID) == null
          ? "1"
          : sharedPreferences.getString(Constant.USERID)!;
      return true;
    }
  }

  void removecoupon(BuildContext context) {
    Constant.showToast("Coupon Successfully apply");
    setState(() {
      user_couponcode = '';
      couponcodeid = '';
      amounttype = '';
      rate = '';
      couponamount = 0.0;
      coupon_price = 0.0;
      coupondiscountamount = 0.0;
      finalamount = totalSubtotal;
      // amountwithoutcoupon=;
      // finalamount=;
      calfinalamount();
    });
  }

  void calfinalamount() {
    setState(() {
      if (coupon_price > 0) {
        finalamount = double.parse(finalamount.toStringAsFixed(2));
        coupondiscountamount = double.parse(coupon_price.toStringAsFixed(2));
      } else {
        if (rate?.isNotEmpty == true) {
          final dRate = double.tryParse(rate!) ?? 0.0;
          coupondiscountamount = ((finalamount * dRate) / 100);
          finalamount = finalamount - coupondiscountamount;
        }
      }
    });
  }

  void applyCoupon() async {
    CoupenModel? cmodel = GetStorage().read(Constant.APPLIED_COUPON);
    setState(() {
      if (cmodel != null) {
        couponcodeid = cmodel.coupendate!.coupon_id!;
        user_couponcode = cmodel.coupendate!.coupon_code!;
        amounttype = cmodel.coupendate!.discounttype ?? '';
        coupon_price = cmodel.coupendate!.coupon_price ?? 0.0;
        finalamount = cmodel.coupendate!.total_price ?? 0.0;
        rate = cmodel.coupendate!.rate;
      }

      calfinalamount();
    });
  }

  bool _isCouponChecking = false;

  void checkcoupen(BuildContext context, {bool isRecheck = false}) async {
    // Constant.showToast(
    //     "On getpaymenttokan");

    // CartController cartController = CartController();
    setState(() {
      _isCouponChecking = true;
    });
    await cartController
        .checkcouponcode(couponcode, idd, finalamount)
        .then((value) {
      try {
        // print(value);
        CoupenModel cmodel = value;
        if (cmodel != null) {
          if (cmodel.success!) {
            if (!isRecheck) {
              Navigator.of(context, rootNavigator: true)
                  .pop(); //close the dialoge
            }

            print(orderItems);
            bool hasPackage = orderItems
                    .where((element) => element.itemtype == 'Package')
                    .length >
                0;
            if (cmodel.coupendate?.coupon_for == 'doctor' && hasPackage) {
              Constant.showToast(
                  "This coupon can not be used for package! Remove Package");
              return;
            }
            if (!isRecheck) {
              Constant.showToast("Coupon Successfully apply");
            }

            GetStorage().write(Constant.APPLIED_COUPON, cmodel);
            applyCoupon();
          } else {
            Constant.showToast("${cmodel.message}");
          }
        } else {}
        setState(() {
          _isCouponChecking = false;
        });
      } on Exception catch (exception) {
        setState(() {
          _isCouponChecking = false;
        });
        Constant.showToast("Exception- $exception");
      } catch (error) {
        setState(() {
          _isCouponChecking = false;
        });
        Constant.showToast("Error- $error");
      }
    }).catchError((onError) {
      setState(() {
        _isCouponChecking = false;
      });
      // Navigator.of(context,rootNavigator: true).pop();//close the dialoge
      debugPrint("Error1 $onError");
      Constant.showToast("Error $onError");
    });
  }

  showMinimumAmountAlert(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      },
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
        // redeem();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(
          "To continue, minimum order amount should be ${minimumAmountValue} Rs."),
      actions: [
        // cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ProductModel {
  final String title;
  final String image;
  final String price;
  int quantity;

  ProductModel(this.title, this.image, this.price, this.quantity);
}
