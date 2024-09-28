import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/lab/model/lab_model.dart';
import 'package:get_storage/get_storage.dart';

class CartCard extends StatefulWidget {
  Orderitem productDetail;
  Function() subtotalValueChange;

  CartCard(this.productDetail, this.subtotalValueChange);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  var subtotal;
  var quantity;

  List<Orderitem> orderItems = GetStorage().read(Constant.items);

  @override
  void initState() {
    quantity = widget.productDetail.quantity!;
    subtotal = widget.productDetail.displayPrice!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 4,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.productDetail.testimage == null
                        ? Image.asset(
                            "images/logo.png",
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.productDetail.testimage!,
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
              ),
              title: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:120,
                        margin: EdgeInsets.only(top: 24),
                        child: Text(
                          widget.productDetail.testname!,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Constant.hexToColor(Constant.primaryBlue)),

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Category ${widget.productDetail.categoryname}",
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: Constant.hexToColor(
                            //           Constant.primaryBlue)),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            Text(
                              "₹ ${widget.productDetail.totalPrice}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Constant.hexToColor(
                                      Constant.primaryBlue)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),     SizedBox(
                        width: 4,
                      ),
                      Container(
                        color: Colors.redAccent,
                        child: Text(
                          widget.productDetail.discount!
                              .isEmpty
                              ? "0% OFF"
                              : "${widget.productDetail.discount}% OFF",
                          style: TextStyle(
                              color: Colors.white),
                        ),
                      )
                      // Container(
                      //   margin: EdgeInsets.only(top: 8),
                      //   child: Text(
                      //    productDetail.description!,
                      //     style: TextStyle(
                      //         fontSize: 20,
                      //         color: Constant.hexToColor(Constant.primaryBlue),
                      //         fontWeight: FontWeight.bold),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {

                  if (orderItems.length > 0) {
                    orderItems.forEach((element) {
                      if (element.id == widget.productDetail.id) {
                        var preQuantity = int.parse(element.quantity!);

                        if (preQuantity >= 1) {
                          preQuantity = preQuantity - 1;

                          if (preQuantity == 0) {
                            orderItems.remove(element);
                            GetStorage().write(Constant.items, orderItems);
                            widget.subtotalValueChange();
                            setState(() {});
                          }

                          // else {
                          //   element.quantity = "${preQuantity}";
                          //   element.subtotal =
                          //   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                          //   element.finalamount =
                          //   "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
                          //   setState(() {
                          //     quantity = element.quantity!;
                          //     subtotal = element.subtotal!;
                          //   });
                          // }
                        }
                        GetStorage().write(Constant.items, orderItems);
                        widget.subtotalValueChange();
                      }
                    });
                  }


                },
                icon: Icon(
                  Icons.close_rounded,
                  color: Constant.hexToColor(Constant.primaryBlue),
                ),
              ),
            ),
            // Container(
            //   width: 120,
            //   margin: EdgeInsets.only(left: 12, bottom: 8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           if (orderItems.length > 0) {
            //             orderItems.forEach((element) {
            //               if (element.id == widget.productDetail.id) {
            //                 var preQuantity = int.parse(element.quantity!);
            //
            //                 if (preQuantity >= 1) {
            //                   preQuantity = preQuantity - 1;
            //
            //                   if (preQuantity == 0) {
            //                     orderItems.remove(element);
            //                     GetStorage().write(Constant.items, orderItems);
            //                     widget.subtotalValueChange();
            //                     setState(() {});
            //                   } else {
            //                     element.quantity = "${preQuantity}";
            //                     element.subtotal =
            //                         "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
            //                     element.finalamount =
            //                         "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
            //                     setState(() {
            //                       quantity = element.quantity!;
            //                       subtotal = element.subtotal!;
            //                     });
            //                   }
            //                 }
            //
            //                 GetStorage().write(Constant.items, orderItems);
            //                 widget.subtotalValueChange();
            //               }
            //             });
            //           }
            //         },
            //         icon: Icon(
            //           Icons.remove_circle_outline,
            //           size: 30,
            //           color: Constant.hexToColor(Constant.primaryBlue),
            //         ),
            //       ),
            //       Container(
            //         child: Text(
            //           quantity!,
            //           style: TextStyle(
            //               color: Constant.hexToColor(Constant.primaryBlue)),
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {
            //           if (orderItems.length > 0) {
            //             orderItems.forEach((element) {
            //               if (element.id == widget.productDetail.id) {
            //                 var preQuantity =
            //                     int.parse(widget.productDetail.quantity!) + 1;
            //                 element.quantity = "${preQuantity}";
            //                 element.subtotal =
            //                     "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
            //                 element.finalamount =
            //                     "${double.tryParse("${preQuantity}")! * double.tryParse(element.medilabsPrice!)!}";
            //                 setState(() {
            //                   quantity = "${preQuantity}";
            //                   subtotal = element.subtotal!;
            //                 });
            //
            //                 print("innnnn" + preQuantity.toString());
            //               }
            //             });
            //             GetStorage().write(Constant.items, orderItems);
            //             widget.subtotalValueChange();
            //           }
            //         },
            //         icon: Icon(
            //           Icons.add_circle_outline_sharp,
            //           size: 30,
            //           color: Constant.hexToColor(Constant.primaryBlue),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 8, bottom: 2),
              child: Text(
                "₹ " + widget.productDetail.displayPrice!,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Constant.hexToColor(Constant.primaryBlue),
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
