import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/all_test/ui/all_test.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/category/ui/all_categpries.dart';
import 'package:medilabs/category/ui/all_packages.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/lab/lab_detail.dart';
import 'package:medilabs/lab/package_detail.dart';
import 'dashboard_screen.dart';
import 'repository/model/get_home_data_response.dart';
import 'widgets/search_bar.dart' as sb;
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var orderItems = GetStorage().read(Constant.items);
  bool categoriesFound = false;
  bool packageFound = false;
  bool testsFound = false;
  DashboardController dashboardController = Get.find();

  final catList = [
    CategoryModel("Mom & Baby", Colors.blue),
    CategoryModel("Fighting the infection", Colors.deepPurple),
    CategoryModel("Diabetes", Colors.pinkAccent),
    CategoryModel("Antibiotics", Colors.redAccent)
  ];
  @override
  void initState() {
    super.initState();

    if (orderItems == null) {
      orderItems = <Orderitem>[];
    }
  }

  String? searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    // setState(() {
                                    //   orderItems = sorderItems;
                                    // });
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
      appBar: AppBar(
        title: Text("Search"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            color: Colors.white,
            child: sb.SearchBar((v) {
              if (v.isNotEmpty) {
                setState(() {
                  searchText = v;
                });
              } else {
                setState(() {
                  searchText = null;
                });
              }
            }),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12, left: 12, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tests",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(AllTest(
                        cateogoryTest: false,
                        title: 'All Tests',
                      )),
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 12,
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
                      margin: EdgeInsets.only(bottom: 12, left: 12, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Packages",
                            style: TextStyle(
                              fontSize: 16,
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // buildStageredSortProductList(200),
                    // buildStageredSortCategoryList(150)
                    buildStageredSortPackageList(150)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTestsItems() {
    List<Tests> savedList = GetStorage().read(Constant.TESTS);
    List<Tests> filterList = [];

    if (searchText != null) {
      if (searchText!.length > 0) {
        savedList.forEach((element) {
          if (element.testname!.toLowerCase().contains(searchText!)) {
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
          // savedList.length=0;
          setState(() {
            testsFound = false;
          });
        }
      } else {}
    } else {
      setState(() {
        testsFound = true;
      });
    }

    if (savedList != null) {
      if (testsFound) {
        return Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, index) {
                  // if (orderItems != null) {
                  //   if (orderItems.length > 0) {
                  //     orderItems.forEach((element) {
                  //       if (element.id == savedList[index].id) {
                  //         savedList[index].quantity = "${element.quantity}";
                  //         savedList[index].subtotal = "${element.subtotal}";
                  //       }
                  //     });
                  //   }
                  // }
                  // return InkWell(
                  //   onTap: () {
                  //     Get.to(TestDetail(
                  //         data: savedList[index],
                  //         refresh: () {
                  //           var sorderItems = GetStorage().read(Constant.items);
                  //
                  //
                  //           setState(() {
                  //             if(sorderItems!=null){
                  //               orderItems = sorderItems;
                  //
                  //             }
                  //
                  //           });
                  //         }));
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(right: 12),
                  //     child: Stack(
                  //       children: [
                  //         Card(
                  //           elevation: 4,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(12)),
                  //           child: Container(
                  //             padding: EdgeInsets.all(24),
                  //             child: Column(
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   mainAxisAlignment:
                  //                   MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     Text(
                  //                       savedList[index].testname!,
                  //                       style: TextStyle(
                  //                           fontSize: 16,
                  //                           color: Colors.black87,
                  //                           fontWeight: FontWeight.w600),
                  //                     ),
                  //                     Text(
                  //                       savedList[index].description!,
                  //                       style: TextStyle(fontSize: 12),
                  //                       overflow: TextOverflow.ellipsis,
                  //                       maxLines: 1,
                  //                     ),
                  //                     Text(
                  //                       "Category ${savedList[index].categoryname!}",
                  //                       style: TextStyle(
                  //                           color: Constant.hexToColor(
                  //                               Constant.primaryBlue)),
                  //                     ),
                  //                     Container(
                  //                       margin: EdgeInsets.only(top: 8),
                  //                       child: Row(
                  //                         children: [
                  //                           Text(savedList[index]
                  //                               .medilabsPrice!
                  //                               .isEmpty
                  //                               ? "₹ 0"
                  //                               : "₹ ${savedList[index].medilabsPrice!}"),
                  //                           SizedBox(
                  //                             width: 2,
                  //                           ),
                  //                           Text(
                  //                             savedList[index]
                  //                                 .displayPrice!
                  //                                 .isEmpty
                  //                                 ? "₹ 0"
                  //                                 : "₹ ${savedList[index].displayPrice!}",
                  //                             style: TextStyle(
                  //                                 decoration:
                  //                                 TextDecoration.lineThrough),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 4,
                  //                           ),
                  //                           Container(
                  //                             color: Colors.redAccent,
                  //                             child: Text(
                  //                               savedList[index]
                  //                                   .displayPrice!
                  //                                   .isEmpty
                  //                                   ? "0% OFF"
                  //                                   : "${savedList[index].discount!}% OFF",
                  //                               style: TextStyle(
                  //                                   color: Colors.white),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Positioned(
                  //             right: 0,
                  //             bottom: 0,
                  //             child: Container(
                  //               width: 120,
                  //               height: 45,
                  //               margin: EdgeInsets.only(right: 8, top: 24),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   InkWell(
                  //                     onTap: () {
                  //                       var itemfound = false;
                  //                       if (orderItems.length > 0) {
                  //                         orderItems.forEach((element) {
                  //                           if (element.id ==
                  //                               savedList[index].id) {
                  //                             var preQua = int.parse(
                  //                                 savedList[index].quantity!);
                  //                             if (preQua > 1) {
                  //                               var preQuantity = int.parse(
                  //                                   savedList[index]
                  //                                       .quantity!) -
                  //                                   1;
                  //                               element.quantity =
                  //                               "${preQuantity}";
                  //                               element.subtotal =
                  //                               "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                  //                               element.finalamount =
                  //                               "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                  //                               setState(() {
                  //                                 savedList[index].quantity =
                  //                                 "${preQuantity}";
                  //                                 savedList[index].subtotal =
                  //                                 "${element.subtotal}";
                  //                               });
                  //                             }
                  //                             itemfound = true;
                  //                             return;
                  //                           }
                  //                         });
                  //
                  //                         GetStorage()
                  //                             .write(Constant.items, orderItems);
                  //                         dashboardController.cartCount.value =
                  //                             orderItems.length;
                  //                       }
                  //
                  //                       if (!itemfound) {
                  //                         int incre = int.parse(
                  //                             savedList[index].quantity!) -
                  //                             1;
                  //                         setState(() {
                  //                           savedList[index].quantity =
                  //                           "${incre}";
                  //                         });
                  //                         orderItems.add(getOrderItem(
                  //                             savedList[index], "${incre}"));
                  //                         GetStorage()
                  //                             .write(Constant.items, orderItems);
                  //                         dashboardController.cartCount.value =
                  //                             orderItems.length;
                  //                       }
                  //
                  //                       Constant.showToast("Test removed from cart");
                  //                     },
                  //                     child: Container(
                  //                       decoration: BoxDecoration(
                  //                           borderRadius:
                  //                           BorderRadius.circular(12),
                  //                           color: Colors.lightBlueAccent
                  //                               .withOpacity(.2)),
                  //                       child: Icon(Icons.remove),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     margin:
                  //                     EdgeInsets.only(left: 12, right: 12),
                  //                     child: Text("${savedList[index].quantity}"),
                  //                   ),
                  //                   InkWell(
                  //                     onTap: () {
                  //                       var itemfound = false;
                  //                       if (orderItems.length > 0) {
                  //                         orderItems.forEach((element) {
                  //                           if (element.id ==
                  //                               savedList[index].id) {
                  //                             var preQuantity = int.parse(
                  //                                 savedList[index]
                  //                                     .quantity!) +
                  //                                 1;
                  //                             element.quantity = "${preQuantity}";
                  //                             element.subtotal =
                  //                             "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                  //                             element.finalamount =
                  //                             "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                  //
                  //                             setState(() {
                  //                               savedList[index].quantity =
                  //                               "${preQuantity}";
                  //                               savedList[index].subtotal =
                  //                               "${element.subtotal}";
                  //                             });
                  //
                  //                             itemfound = true;
                  //                             return;
                  //                           }
                  //                         });
                  //
                  //                         GetStorage()
                  //                             .write(Constant.items, orderItems);
                  //                         dashboardController.cartCount.value =
                  //                             orderItems.length;
                  //                       }
                  //
                  //                       if (!itemfound) {
                  //                         int incre = int.parse(
                  //                             savedList[index].quantity!) +
                  //                             1;
                  //                         setState(() {
                  //                           savedList[index].quantity =
                  //                           "${incre}";
                  //                         });
                  //                         orderItems.add(getOrderItem(
                  //                             savedList[index], "${incre}"));
                  //                         GetStorage()
                  //                             .write(Constant.items, orderItems);
                  //                         dashboardController.cartCount.value =
                  //                             orderItems.length;
                  //                       }
                  //
                  //                       Constant.showToast("Test added to cart");
                  //
                  //                     },
                  //                     child: Container(
                  //                       decoration: BoxDecoration(
                  //                           borderRadius:
                  //                           BorderRadius.circular(12),
                  //                           color: Colors.lightBlueAccent
                  //                               .withOpacity(.2)),
                  //                       child: Icon(Icons.add),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  // );

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
                      height: 180,
                      width: 220,
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
                                      Text(
                                        savedList[index].testname!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        savedList[index].description!,
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Category ${savedList[index].categoryname!}",
                                        style: TextStyle(
                                            color: Constant.hexToColor(
                                                Constant.primaryBlue)),
                                      ),
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
                                            Container(
                                              color: Colors.redAccent,
                                              child: Text(
                                                savedList[index]
                                                        .discount!
                                                        .isEmpty
                                                    ? "0% OFF"
                                                    : "${savedList[index].discount!}% OFF",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // if (!itemfound) {

                                      if (itemOnCart) {
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
                                        height: 40,
                                        margin:
                                            EdgeInsets.only(right: 8, top: 8),
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
                                              //   itemOnCart? "Added":"Add",
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

  Widget buildStageredSortPackageList(double height) {
    print("xxxxxxxxxxxx");

    // var savedList = GetStorage().read(Constant.PACKAGES);
    List<Packages> savedList = GetStorage().read(Constant.PACKAGES);
    List<Packages> filterList = [];
    print("xxxxxxxxxxxx " + savedList.toString());

    if (searchText != null) {
      if (searchText!.length > 0) {
        savedList.forEach((element) {
          if (element.package!.toLowerCase().contains(searchText!)) {
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
          // savedList.length=0;
          setState(() {
            packageFound = false;
          });
        }
      } else {}
    } else {
      setState(() {
        packageFound = true;
      });
    }

    if (savedList != null) {
      if (packageFound) {
        // if (savedList != null) {
        //   if (savedList.length > 0) {
        return Container(
          child: GridView.count(
            childAspectRatio: 175 / height,
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 8,
            children: List.generate(savedList.length, (index) {
              if (orderItems != null) {
                if (orderItems.length > 0) {
                  orderItems.forEach((element) {
                    if ("p" + element.id == "p" + savedList[index].id!) {
                      // savedList[index].quantity =
                      // "${element.quantity}";
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            // width: 600,
                            height: height - 20,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: savedList[index].image!,
                            imageBuilder: (context, imageProvider) => Container(
                              height: height - 20,
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
                                height: height - 30,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'images/logo.png',
                                height: height - 30,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            savedList[index].package!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
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
  }

  Widget buildStageredSortCategoryList(double height) {
    print("xxxxxxxxxxxx");

    List<Categories> savedList = GetStorage().read(Constant.CATEGORIES);
    List<Categories> filterList = [];
    print("xxxxxxxxxxxx " + savedList.toString());

    if (searchText != null) {
      if (searchText!.length > 0) {
        savedList.forEach((element) {
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
          // savedList.length=0;
          setState(() {
            categoriesFound = false;
          });
        }
      } else {}
    } else {
      setState(() {
        categoriesFound = true;
      });
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
}

class CategoryModel {
  final String title;
  final Color color;

  CategoryModel(this.title, this.color);
}
