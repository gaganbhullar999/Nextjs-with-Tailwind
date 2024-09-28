import 'package:flutter/material.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:medilabs/dashboard/widgets/search_bar.dart' as sb;
import 'package:medilabs/helper/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/lab/lab_detail.dart';

class AllTest extends StatefulWidget {
  final bool cateogoryTest;
  final String? categoryId, categoryName, testType;
  final String title;

  AllTest(
      {required this.cateogoryTest,
      required this.title,
      this.categoryId,
      this.categoryName,
      this.testType});

  @override
  State<AllTest> createState() => _AllTestState();
}

class _AllTestState extends State<AllTest> {
  DashboardController dashboardController = Get.find();
  List<Orderitem> orderItems =
      GetStorage().read(Constant.items) ?? <Orderitem>[];

  // SearchBar? searchBar;
  String? searchText;

  bool testsFound = true;
  bool searchClicked = false;

  TextEditingController searchController = TextEditingController();

  _AllTestState() {
    // searchBar = new SearchBar(
    //   controller: searchController,
    //     inBar: false,
    //     setState: setState,
    //     buildDefaultAppBar: buildAppBar,);
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return new AppBar(
  //       title: new Text('Tests'),
  //       actions: [searchBar!.getSearchAction(context)]);
  // }

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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {
                        Get.to(CartList(() {
                          var sorderItems = GetStorage().read(Constant.items);

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
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 12),
          child: buildStageredSortProductList(190)),
    );
  }

  Widget buildStageredSortProductList(double height) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetAllTestResponse> data) {
        if (data.hasData) {
          if (data.data!.data!.length > 0) {
            GetStorage().write(Constant.ALLTESTS, data.data!.data!);
            return buildTestsItems(height);
            // Container(
            //   child: GridView.count(
            //     childAspectRatio: 175 / height,
            //     shrinkWrap: true,
            //     primary: false,
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 24,
            //     children: List.generate(data.data!.data!.length, (index) {
            //
            //       var itemInCart = false;
            //       if (orderItems != null) {
            //         if (orderItems.length > 0) {
            //           orderItems.forEach((element) {
            //             if (element.id == data.data!.data![index].id) {
            //               itemInCart = true;
            //               data.data!.data![index].quantity =
            //                   "${element.quantity}";
            //               data.data!.data![index].subtotal =
            //                   "${element.subtotal}";
            //             }
            //           });
            //         }
            //       }
            //
            //       return InkWell(
            //         onTap: () {
            //           Get.to(TestDetail(
            //               data: data.data!.data![index],
            //               refresh: () {
            //                 setState(() {
            //                   orderItems = GetStorage().read(Constant.items);
            //                 });
            //               }));
            //         },
            //         child: Container(
            //           margin: EdgeInsets.only(right: 12),
            //           child: Stack(
            //             children: [
            //               Card(
            //                 elevation: 4,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(12)),
            //                 child: Container(
            //                   padding: EdgeInsets.all(12),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.end,
            //                     children: [
            //                       Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceEvenly,
            //                         children: [
            //                           Text(
            //                             data.data!.data![index].testname!,
            //                             maxLines: 2,
            //                             style: TextStyle(
            //                                 fontSize: 12,
            //                                 color: Colors.black87,
            //                                 fontWeight: FontWeight.w600),
            //                           ),
            //                           Text(
            //                             data.data!.data![index].description!,
            //                             style: TextStyle(fontSize: 10),
            //                             overflow: TextOverflow.ellipsis,
            //                             maxLines: 1,
            //                           ),
            //
            //                           Container(
            //                             margin: EdgeInsets.only(top: 2),
            //                             color: Colors.redAccent,
            //                             child: Text(
            //                               data.data!.data![index].displayPrice!
            //                                       .isEmpty
            //                                   ? "0% OFF"
            //                                   : "${data.data!.data![index].discount!}% OFF",
            //                               style: TextStyle(color: Colors.white),
            //                             ),
            //                           ),
            //                           Container(
            //                             margin: EdgeInsets.only(top: 5,bottom: 10),
            //                             child: Row(
            //                               children: [
            //                                 Text(data.data!.data![index]
            //                                         .displayPrice!.isEmpty
            //                                     ? "₹ 0"
            //                                     : "₹ ${data.data!.data![index].displayPrice!}"),
            //                                 SizedBox(
            //                                   width: 2,
            //                                 ),
            //                                 Text(
            //                                   data.data!.data![index]
            //                                           .totalPrice!.isEmpty
            //                                       ? "₹ 0"
            //                                       : "₹ ${data.data!.data![index].totalPrice!}",
            //                                   style: TextStyle(
            //                                       decoration: TextDecoration
            //                                           .lineThrough),
            //                                 ),
            //                                 SizedBox(
            //                                   width: 4,
            //                                   height: 8,
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //
            //                         ],
            //                       ),
            //
            //
            //                       InkWell(
            //                         onTap: () {
            //
            //
            //                           if(itemInCart){
            //                             // Constant.showToast("Test already in cart");
            //                             Constant.showToast("Remove from the cart");
            //                             setState(() {
            //                               itemInCart = false;
            //                             });
            //                             orderItems.removeWhere((item) => item.id == data.data!.data![index].id);
            //                             GetStorage()
            //                                 .write(Constant.items, orderItems);
            //                             dashboardController.cartCount.value =
            //                                 orderItems.length;
            //                           }else {
            //
            //                             int incre = int.parse(
            //                                 data.data!.data![index].quantity!) + 1;
            //
            //                             setState(() {
            //                               data.data!.data![index].quantity = "${incre}";
            //                             });
            //
            //
            //                             orderItems.add(getOrderItem(
            //                                 data.data!.data![index], "${incre}"));
            //                             GetStorage()
            //                                 .write(Constant.items, orderItems);
            //                             dashboardController.cartCount.value =
            //                                 orderItems.length;
            //
            //                             setState(() {
            //                               itemInCart = true;
            //                             });
            //                             Constant.showToast("Test added to cart");
            //
            //
            //                           }
            //
            //
            //
            //                         },
            //
            //                         child:Container(
            //                           width: 80,
            //                           height: 30,
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                 BorderRadius.circular(25),
            //                                 color: itemInCart ? Colors.green:Constant.hexToColor(
            //                                     Constant.primaryBlue)),
            //                             child: Center(
            //                               child:
            //                               itemInCart?  RichText(
            //                                  text: TextSpan(
            //                                   children: [
            //                                     TextSpan(
            //                                       text: "Done ", style: TextStyle(
            //                                         fontWeight: FontWeight.w600,
            //                                         color: Colors.white),
            //                                     ),
            //                                     WidgetSpan(
            //                                       child: Icon(Icons.check, size: 14,color: Colors.white),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ) : RichText(
            //                                 text: TextSpan(
            //                                   children: [
            //                                     TextSpan(
            //                                       text: "Book ", style: TextStyle(
            //                                         fontWeight: FontWeight.w600,
            //                                         color: Colors.white)
            //                                     ),
            //                                     WidgetSpan(
            //                                       child: Icon(Icons.add, size: 14,color: Colors.white,),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               )
            //
            //
            //
            //                             ),
            //                           ),
            //
            //
            //
            //                         ),
            //                       )
            //
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // );
          } else {
            return Center(
              child: Text("No Tests found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _getFuture(),
    );
  }

  Future<GetAllTestResponse> _getFuture() {
    if (widget.testType != null) {
      return dashboardController.getAllTestsByType(widget.testType!);
    } else {
      return widget.cateogoryTest
          ? dashboardController.getAllTestsByCategory(widget.categoryId!)
          : dashboardController.getAllTests();
    }
  }

  Widget buildTestsItems(double height) {
    List<Tests> savedList = GetStorage().read(Constant.ALLTESTS);
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
          // setState(() {
          //   testsFound = true;
          // });
          savedList = filterList;
        } else {
          // savedList.length=0;
          // setState(() {
          testsFound = false;
          // });
        }
      } else {}
    } else {
      // if(!testsFound) {
      //   setState(() {
      testsFound = true;
      //   });
      // }
    }

    if (savedList != null) {
      if (testsFound) {
        return Container(
          child: GridView.count(
            childAspectRatio: 175 / height,
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            children: List.generate(savedList.length, (index) {
              var itemInCart = false;
              if (orderItems != null) {
                if (orderItems.length > 0) {
                  orderItems.forEach((element) {
                    if (element.id == savedList[index].id) {
                      itemInCart = true;
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
                        var sorderItemsss = GetStorage().read(Constant.items);
                        if (sorderItemsss != null) {
                          setState(() {
                            orderItems = sorderItemsss;
                          });
                        } else {
                          orderItems = <Orderitem>[];
                        }

                        //    orderItems = GetStorage().read(Constant.items);
                        // });
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
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    savedList![index].testname!,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    savedList![index].description!,
                                    style: TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    color: Colors.redAccent,
                                    child: Text(
                                      savedList![index].displayPrice!.isEmpty
                                          ? "0% OFF"
                                          : "${savedList![index].discount!}% OFF",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 10),
                                    child: Row(
                                      children: [
                                        Text(savedList![index]
                                                .displayPrice!
                                                .isEmpty
                                            ? "₹ 0"
                                            : "₹ ${savedList![index].displayPrice!}"),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          savedList![index].totalPrice!.isEmpty
                                              ? "₹ 0"
                                              : "₹ ${savedList![index].totalPrice!}",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(
                                          width: 4,
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (itemInCart) {
                                    // Constant.showToast("Test already in cart");
                                    Constant.showToast("Remove from the cart");
                                    setState(() {
                                      itemInCart = false;
                                    });
                                    orderItems.removeWhere((item) =>
                                        item.id == savedList![index].id);
                                    GetStorage()
                                        .write(Constant.items, orderItems);
                                    dashboardController.cartCount.value =
                                        orderItems.length;
                                  } else {
                                    // match current test's category id with orderItems category id, so that only same category order can be placed
                                    final tmp = savedList![index];
                                    print(tmp);
                                    if (orderItems.isNotEmpty &&
                                        orderItems.last.categoryId !=
                                            savedList![index].categoryId) {
                                      Constant.showToast(
                                          "You have to Make Separate Booking For ${savedList[index].categoryname ?? widget.categoryName}");
                                      return;
                                    }
                                    int incre =
                                        int.parse(savedList![index].quantity!) +
                                            1;

                                    setState(() {
                                      savedList![index].quantity = "${incre}";
                                    });

                                    orderItems.add(getOrderItem(
                                        savedList![index], "${incre}"));
                                    GetStorage()
                                        .write(Constant.items, orderItems);
                                    dashboardController.cartCount.value =
                                        orderItems.length;

                                    setState(() {
                                      itemInCart = true;
                                    });
                                    Constant.showToast("Test added to cart");
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: itemInCart
                                            ? Colors.green
                                            : Constant.hexToColor(
                                                Constant.primaryBlue)),
                                    child: Center(
                                        child: itemInCart
                                            ? RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Done ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                            color:
                                                                Colors.white)),
                                                    WidgetSpan(
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                  ),
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
            }),
          ),
        );
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
      ..categoryname = test.categoryname
      ..subcategoryname = test.subcategoryname;
  }
}
