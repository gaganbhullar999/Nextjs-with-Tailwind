import 'package:flutter/material.dart';
import 'package:medilabs/book/ui/order_confirm.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:medilabs/cart/repository/model/create_order_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
// import 'package:location/location.dart' as loc;
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';


class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late MakeOrderModel makeOrderModel;

  String groupValue = "Pay Online";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Booking"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .85,
            child: Stack(
              children: [
                buildBookingSummary(),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: CustomButton(
                      label: "Proceed",
                      color: Constant.hexToColor(Constant.primaryBlue),
                      textColor: Colors.white,
                      borderColor: Constant.hexToColor(Constant.primaryBlue),
                      onPressed: () {
                        buildPayUI(context);
                      },
                      fontSize: 16,
                      padding: 8,
                      height: 45,
                      width: 150),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void buildPayUI(BuildContext context) {
    showModalBottomSheet<void>(
        builder: (BuildContext context) {
          return BottomSheetSwitch(
            switchValue: groupValue,
            valueChanged: (value) {
              groupValue = value;
            },makeOrderModel: makeOrderModel,
          );
        },
        context: context);
  }

  Widget buildBookingSummary() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${makeOrderModel.name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Email: ${makeOrderModel.email}",
                                style: TextStyle(fontSize: 12),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "Mobile: ${makeOrderModel.mobile}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Age: ${makeOrderModel.age} ",
                                style: TextStyle(fontSize: 12),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "Gender ${makeOrderModel.gender}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Address ${makeOrderModel.address}",
                                style: TextStyle(fontSize: 12),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 24),
                              child: Text(
                                "Order For ${makeOrderModel.orderfor}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          // Container(
                          //     margin: EdgeInsets.only(top: 8),
                          //     child: Text(
                          //       "Kolar road bhopal",
                          //       style: TextStyle(fontSize: 12),
                          //     )),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(left: 12, top: 12),
                    color: Constant.hexToColor(Constant.primaryBlue),
                    child: Text(
                      "Personal Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  top: 0,
                  left: 0,
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: Stack(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          child: makeOrderModel.familyHistory!.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (c, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue),
                                      child: Center(
                                          child: Text(
                                              makeOrderModel
                                                  .familyHistory![index].name!,
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    );
                                  },
                                  itemCount:
                                      makeOrderModel.familyHistory!.length,
                                )
                              : Container(),
                        ),
                        Container(
                          height: 30,
                          child: makeOrderModel.personalHistory!.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (c, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue),
                                      child: Center(
                                          child: Text(
                                        makeOrderModel
                                            .personalHistory![index].name!,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    );
                                  },
                                  itemCount:
                                      makeOrderModel.personalHistory!.length,
                                )
                              : Container(),
                        ),
                        Container(
                          height: 30,
                          child: makeOrderModel.allergies!.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (c, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue),
                                      child: Center(
                                          child: Text(
                                              makeOrderModel
                                                  .allergies![index].name!,
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    );
                                  },
                                  itemCount: makeOrderModel.allergies!.length,
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.only(left: 12, top: 12),
                    color: Constant.hexToColor(Constant.primaryBlue),
                    child: Text(
                      "Medical Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  top: 0,
                  left: 0,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 48),
            height: 300,
            child: Stack(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.all(12),
                    child: ListView.builder(
                      itemBuilder: (c, index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                makeOrderModel.orderitem![index].testname!,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Quantity: " +
                                    makeOrderModel.orderitem![index].quantity!,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: Text(
                            "₹ " + makeOrderModel.orderitem![index].subtotal!,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      itemCount: makeOrderModel.orderitem!.length,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(left: 12, top: 4),
                    color: Constant.hexToColor(Constant.primaryBlue),
                    child: Text(
                      "Tests Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  top: 0,
                  left: 0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    makeOrderModel = GetStorage().read(Constant.Order);

    print("Order Model::::" + GetStorage().read(Constant.Order).toString());
  }
}

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch(
      {@required this.switchValue,
      @required this.valueChanged,
      @required this.makeOrderModel});

  final String? switchValue;
  final ValueChanged? valueChanged;
  final MakeOrderModel? makeOrderModel;

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  String? _switchValue;
  MakeOrderModel? _makeOrderModel;
  CartController? _cartController = CartController();

  @override
  void initState() {
    _switchValue = widget.switchValue;
    _makeOrderModel = widget.makeOrderModel;

    if (_switchValue!.contains("Online")) {
      _makeOrderModel!.paymentMode = "Online";
    } else {
      _makeOrderModel!.paymentMode = "Cash on testing";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 24),
            child: RadioGroup<String>.builder(
              direction: Axis.vertical,
              groupValue: _switchValue!,
              onChanged: (value) {
                setState(() {
                  _switchValue = value!;
                });

                if (value!.contains("Online")) {
                  _makeOrderModel!.paymentMode = "Online";
                } else {
                  _makeOrderModel!.paymentMode = "Cash on testing";
                }
              },
              items: ["Pay Online", "Pay Cash on testing"],
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: CustomButton(
                label: "Proceed",
                color: Constant.hexToColor(Constant.primaryBlue),
                textColor: Colors.white,
                borderColor: Constant.hexToColor(Constant.primaryBlue),
                onPressed: () {


                  makeOrder();

                },
                fontSize: 16,
                padding: 8,
                height: 45,
                width: 150),
          ),
        ],
      ),
    );
  }

  void makeOrder() async {

    CreateOrderResponse loginResponse = await _cartController!.createOrder(_makeOrderModel!);

    if(loginResponse!=null){

      if(loginResponse.success!){

        Get.to(OrderConfirm());

      }else {

        print("Book Order error "+loginResponse.toString());

      }

    }
  }

  void _getPlace() async {
    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    print(locations);

  }
}
