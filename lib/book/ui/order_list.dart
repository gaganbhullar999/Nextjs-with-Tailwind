import 'package:flutter/material.dart';
import 'package:medilabs/book/repository/model/get_all_order_response.dart';
import 'package:medilabs/book/ui/widgets/order_card.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/helper/back_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:get/get.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  CartController cartController = CartController();
  String id = "1";

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child:
            Container(margin: EdgeInsets.all(12), child: buildOrderList()),
          ),
        ],
      ),
    );
  }

  Widget buildOrderList() {
    return FutureBuilder(
        future: cartController.getAllOrders(
            id),
        builder: (context, AsyncSnapshot<GetAllOrderResponse> snapshot) {
          print("on da-- ${snapshot}");
          if (snapshot.hasData) {
            if (snapshot.data!.data!.length > 0) {
              return ListView.builder(
                itemBuilder: (c, index) {
                  print("on00000000------${snapshot.data!.data![index]}");
                  return OrderCard(snapshot.data!.data![index]);
                },
                itemCount: snapshot.data!.data!.length,
              );
            } else {
              return Center(
                child: Text("No order found"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<String?> getPrefs() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString(Constant.USERID) == null
          ? "1"
          : sharedPreferences.getString(Constant.USERID)!;
    });

    return "";
  }
}