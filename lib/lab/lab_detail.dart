import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/login/ui/boarding_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get_storage/get_storage.dart';

import 'model/lab_model.dart';

class TestDetail extends StatefulWidget {
  // final LabModel labModel;

  Tests data;
  Function()? refresh;

  TestDetail({required this.data, this.refresh});

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  final pageItemList = [
    PageItemModel("images/girl_shooping_two.jpg",
        "Be yourself, Everything else is already taken"),
  ];

  final PageController pageController = PageController();

  String? quantity = "1";
  String? subtotal;
  String? finalamount = "0";
  var itemFound = false;

  DashboardController dashboardController = Get.find();

  var orderItems = GetStorage().read(Constant.items);

  @override
  void initState() {
    super.initState();

    quantity = widget.data.quantity;
    subtotal = widget.data.subtotal;
    if (orderItems == null) {
      orderItems = <Orderitem>[];
    }
  }

  Orderitem? orderitem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          widget.refresh!();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "${widget.data.testname}",
            ),
          ),
          body: Container(
            height: size.height,
            child: Stack(
              children: [
                /*

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: size.height * .5,
                          child: buildTopUi(size.height * .5, size, context)),
                      Obx(
                            () =>
                            Container(
                                margin: EdgeInsets.only(bottom: 50),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 4),
                                        child: getScreen()),
                                  ],
                                )),
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(

                              color: Colors.white,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                        color: Constant.hexToColor(
                                            Constant.appBlueColor),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(

                              color: Constant.hexToColor(Constant.appBlueColor),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Buy Now",
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottom: 0,
                )
            */
                Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: buildProductSummaryNew()),
                Positioned(
                    bottom: 0,
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 4),
                        width: size.width,
                        child: buildPriceAndProceed()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopUi(double size, Size width, BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "images/lab_1.jpg",
            scale: 2,
            width: width.width,
          ),
          Container(
              margin: EdgeInsets.all(4),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blueGrey,
                    size: 15,
                  ))),
          // Positioned(
          //     bottom: 0,
          //     child: Container(
          //         height: size * .2, width: width.width, child: BottomBar()))
        ],
      ),
    );
  }

  Widget buildProductSummaryNew() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    height: 340,
                    child: buildProductPages(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, bottom: 12, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 200,
                              margin: EdgeInsets.only(top: 24, left: 5),
                              child: Text("${widget.data.testname}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start),
                            ),
                            Container(
                              width: 210,
                              margin: EdgeInsets.only(top: 12),
                              child: Text(widget.data.categoryname ?? '',
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(right: 12),
                        //   width: 120,

                        InkWell(
                          onTap: () {
                            if (int.parse(quantity!) >= 1) {
                              // Constant.showToast("Test already in cart");
                              Constant.showToast("Remove from the cart");
                              setState(() {
                                quantity = "0";
                              });
                              orderItems.removeWhere(
                                  (item) => item.id == widget.data.id);
                              GetStorage().write(Constant.items, orderItems);
                              dashboardController.cartCount.value =
                                  orderItems.length;
                            } else {
                              int incre = int.parse(quantity!) + 1;

                              orderItems
                                  .add(getOrderItem(widget.data, "${incre}"));
                              GetStorage().write(Constant.items, orderItems);
                              dashboardController.cartCount.value =
                                  orderItems.length;
                              setState(() {
                                quantity = "${incre}";
                              });
                              // setState(() {
                              //   itemInCart = true;
                              // });
                              Constant.showToast("Test added to cart");
                            }

                            // var itemfound = false;
                            // if (orderItems.length > 0) {
                            //   orderItems.forEach((element) {
                            //     if (element.id ==
                            //         data.data!.data![index].id) {
                            //       var preQua = int.parse(
                            //           data.data!.data![index].quantity!);
                            //       if (preQua > 1) {
                            //         var preQuantity = int.parse(data.data!
                            //                 .data![index].quantity!) -
                            //             1;
                            //         element.quantity = "${preQuantity}";
                            //         element.subtotal =
                            //             "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                            //         element.finalamount =
                            //             "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                            //         setState(() {
                            //           data.data!.data![index].quantity =
                            //               "${preQuantity}";
                            //           data.data!.data![index].subtotal =
                            //               "${element.subtotal}";
                            //         });
                            //       }
                            //       itemfound = true;
                            //       return;
                            //     }
                            //   });
                            //
                            //   GetStorage()
                            //       .write(Constant.items, orderItems);
                            //   dashboardController.cartCount.value =
                            //       orderItems.length;
                            // }
                            //
                            // if (!itemfound) {
                            //   int incre = int.parse(
                            //           data.data!.data![index].quantity!) +
                            //       1;
                            //
                            //   orderItems.add(getOrderItem(
                            //       data.data!.data![index], "${incre}"));
                            //   GetStorage()
                            //       .write(Constant.items, orderItems);
                            //   dashboardController.cartCount.value =
                            //       orderItems.length;
                            // }
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: int.parse(quantity!) >= 1
                                      ? Colors.green
                                      : Constant.hexToColor(
                                          Constant.primaryBlue)),
                              child: Center(
                                  child: int.parse(quantity!) >= 1
                                      ? RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Done ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              WidgetSpan(
                                                child: Icon(Icons.check,
                                                    size: 14,
                                                    color: Colors.white),
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
                                                          FontWeight.w600,
                                                      color: Colors.white)),
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.add,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )

                                  // Text(
                                  //   int.parse(quantity!) >= 1 ? "Added" : "Add",
                                  //   style:int.parse(quantity!) >= 1 ? TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       color: Colors.white):TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       color: Colors.white),
                                  //   // style: TextStyle(
                                  //   //     fontWeight: FontWeight.w600,
                                  //   //     color: Colors.white),
                                  // ),
                                  ),
                            ),

                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Container(
                            //       decoration: BoxDecoration(
                            //           borderRadius:
                            //               BorderRadius.circular(12),
                            //           color: Colors.lightBlueAccent
                            //               .withOpacity(.2)),
                            //       child: Icon(Icons.remove),
                            //     ),
                            //     Container(
                            //       margin: EdgeInsets.only(
                            //           left: 12, right: 12),
                            //       child: Text(
                            //           "${data.data!.data![index].quantity}"),
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         var itemfound = false;
                            //         if (orderItems.length > 0) {
                            //           orderItems.forEach((element) {
                            //             if (element.id ==
                            //                 data.data!.data![index].id) {
                            //               var preQuantity = int.parse(data
                            //                       .data!
                            //                       .data![index]
                            //                       .quantity!) +
                            //                   1;
                            //               element.quantity =
                            //                   "${preQuantity}";
                            //               element.subtotal =
                            //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                            //               element.finalamount =
                            //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                            //
                            //               setState(() {
                            //                 data.data!.data![index]
                            //                         .quantity =
                            //                     "${preQuantity}";
                            //                 data.data!.data![index]
                            //                         .subtotal =
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
                            //           int incre = int.parse(data.data!
                            //                   .data![index].quantity!) +
                            //               1;
                            //           setState(() {
                            //             data.data!.data![index].quantity =
                            //                 "${incre}";
                            //           });
                            //           orderItems.add(getOrderItem(
                            //               data.data!.data![index],
                            //               "${incre}"));
                            //           GetStorage().write(
                            //               Constant.items, orderItems);
                            //           dashboardController.cartCount
                            //               .value = orderItems.length;
                            //         }
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

                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {
                        //         var itemfound = false;
                        //         if (orderItems.length > 0) {
                        //           orderItems.forEach((element) {
                        //             if (element.id == widget.data.id) {
                        //               var preQua =
                        //                   int.parse(widget.data.quantity!);
                        //               if (preQua >= 1) {
                        //                 var preQuantity =
                        //                     int.parse(widget.data.quantity!) - 1;
                        //
                        //
                        //                 if(preQuantity==0){
                        //                   orderItems.remove(element);
                        //
                        //                   GetStorage()
                        //                       .write(Constant.items, orderItems);
                        //                   dashboardController.cartCount.value =
                        //                       orderItems.length;
                        //
                        //                   setState(() {
                        //                     widget.data.quantity =
                        //                     "${preQuantity}";
                        //                     widget.data.subtotal =
                        //                     "${element.subtotal}";
                        //                   });
                        //                 }else{
                        //                   element.quantity = "${preQuantity}";
                        //                   element.subtotal =
                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                        //                   element.finalamount =
                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                        //                   setState(() {
                        //                     widget.data.quantity =
                        //                     "${preQuantity}";
                        //                     widget.data.subtotal =
                        //                     "${element.subtotal}";
                        //                   });
                        //
                        //                   GetStorage()
                        //                       .write(Constant.items, orderItems);
                        //                   dashboardController.cartCount.value =
                        //                       orderItems.length;
                        //                 }
                        //
                        //
                        //
                        //
                        //                 }
                        //
                        //               itemfound = true;
                        //
                        //
                        //               return;
                        //             }
                        //           });
                        //
                        //
                        //         }
                        //
                        //         if (!itemfound) {
                        //           var preQua = int.parse(widget.data.quantity!);
                        //           if (preQua >= 1) {
                        //
                        //             int incre = int.parse(widget.data.quantity!) - 1;
                        //
                        //             setState(() {
                        //               widget.data.quantity = "${incre}";
                        //             });
                        //             orderItems.add(getOrderItem(widget.data, "${incre}"));
                        //
                        //             GetStorage()
                        //                 .write(Constant.items, orderItems);
                        //             dashboardController.cartCount.value =
                        //                 orderItems.length;
                        //           }
                        //
                        //         }
                        //       },
                        //       icon: Icon(
                        //         Icons.remove_circle_outline,
                        //         size: 30,
                        //         color:
                        //             Constant.hexToColor(Constant.primaryBlue),
                        //       ),
                        //     ),
                        //     Container(
                        //       child: Text(
                        //         widget.data.quantity!,
                        //         style: TextStyle(
                        //             color: Constant.hexToColor(
                        //                 Constant.primaryBlue)),
                        //       ),
                        //     ),
                        //     IconButton(
                        //       onPressed: () {
                        //         // var updatedQuantity= int.parse(quantity!) + 1;
                        //         //
                        //         // setState(() {
                        //         //   quantity = "${updatedQuantity}";
                        //         //
                        //         // });
                        //         var itemFound = false;
                        //
                        //         if (orderItems.length > 0) {
                        //           orderItems.forEach((element) {
                        //             if (element.id == widget.data.id) {
                        //               var preQuantity =
                        //                   int.parse(widget.data.quantity!) +
                        //                       1;
                        //               element.quantity = "${preQuantity}";
                        //               element.subtotal =
                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                        //               element.finalamount =
                        //                   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                        //               setState(() {
                        //                 widget.data.quantity =
                        //                     "${preQuantity}";
                        //                 widget.data.subtotal =
                        //                     "${element.subtotal}";
                        //               });
                        //
                        //               itemFound = true;
                        //               GetStorage()
                        //                   .write(Constant.items, orderItems);
                        //               dashboardController.cartCount.value =
                        //                   orderItems.length;
                        //
                        //               return;
                        //             }
                        //           });
                        //
                        //
                        //         }
                        //         if (!itemFound) {
                        //           int incre =
                        //               int.parse(widget.data.quantity!) + 1;
                        //
                        //           setState(() {
                        //             widget.data.quantity = "${incre}";
                        //           });
                        //
                        //           orderItems.add(
                        //               getOrderItem(widget.data, "${incre}"));
                        //
                        //           GetStorage()
                        //               .write(Constant.items, orderItems);
                        //           dashboardController.cartCount.value =
                        //               orderItems.length;
                        //         }
                        //       },
                        //       icon: Icon(
                        //         Icons.add_circle_outline_sharp,
                        //         size: 30,
                        //         color:
                        //             Constant.hexToColor(Constant.primaryBlue),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text("${widget.data.description}")),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPriceAndProceed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                "₹ ${widget.data.displayPrice}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                "₹ ${widget.data.totalPrice}",
                style: TextStyle(
                    fontSize: 20, decoration: TextDecoration.lineThrough),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Get.to(CartList(() {
              var sorderItems =
                  GetStorage().read(Constant.items) as List<Orderitem>;
              sorderItems.forEach((element) {
                if (element.id == widget.data.id) {
                  setState(() {
                    widget.data.quantity = element.quantity;
                    widget.data.subtotal = element.subtotal;
                  });
                  return;
                }
              });
            }));
          },
          child: Container(
            margin: EdgeInsets.only(right: 12),
            height: 45,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: int.parse(widget.data.quantity!) >= 1
                    ? Colors.green
                    : Colors.deepOrangeAccent),
            child: Center(
              child: Text(
                int.parse(widget.data.quantity!) >= 1
                    ? "(Done) Go to cart"
                    : "Go to Cart",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildProductPages() {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 320,
                child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (c, index) {
                    if (widget.data.image?.isNotEmpty == true) {
                      return Image.network(
                        widget.data.testimage!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Image.asset(
                        "images/lab_1.jpg",
                        fit: BoxFit.cover,
                      );
                    }
                  },
                  itemCount: 4,
                ),
              ),
              // Positioned(
              //     top: 0,
              //     right: 0,
              //     child: Container(
              //         margin: EdgeInsets.all(8),
              //         child: Icon(
              //           Icons.favorite,
              //           color: Colors.redAccent,
              //         )))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 4,
            child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: 1,
                effect: SlideEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.grey,
                    activeDotColor: Constant.hexToColor(Constant.primaryBlue)),
                onDotClicked: (index) {}),
          ),
        ],
      ),
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
      ..testname = test.testname
      ..description = test.description
      ..status = test.status
      ..addedon = DateTime.now().toString()
      ..addedby = "1"
      ..updatedOn = DateTime.now().toString()
      ..updatedBy = "1"
      ..appClientId = "1"
      ..image = ""
      ..categoryname = test.categoryname
      ..subcategoryname = test.subcategoryname;
  }
}
