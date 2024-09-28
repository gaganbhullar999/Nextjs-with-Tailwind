import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medilabs/book/SkyCallResponse.dart';
import 'package:medilabs/book/repository/model/get_all_order_response.dart';
import 'package:medilabs/book/ui/order_detail.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/ap_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatelessWidget {
  Data data;

  OrderCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      height: (int.parse('${data.status}')>2 && int.parse('${data.status}')<7) ? 400: 270,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  padding:EdgeInsets.only(left: 4, right: 4) ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking id:",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("#${data.id}",style: TextStyle(
                                    fontSize: 11))
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Payment Status:",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${data.paymentStatus}",style: TextStyle(
                                    fontSize: 11))
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Payment Mode: ",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                            Text("${data.paymentMode}",style:
                            TextStyle(color: Colors.redAccent,fontSize: 11,
                                fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),

                          // Container(
                          //   margin: EdgeInsets.only(top: 5),
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Payment Status ${data.paymentStatus}",
                          //         style: TextStyle(
                          //             fontSize: 16, fontWeight: FontWeight.bold),
                          //       ),
                          //
                          //       Text("Payment Mode ${data.paymentMode}",style:
                          //       TextStyle(color: Colors.redAccent,
                          //       fontWeight: FontWeight.bold),)
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Final Amount:",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("₹ ${data.finalamount}",style: TextStyle(
                                    fontSize: 11))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Order for:",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${data.orderfor}",style: TextStyle(
                                    fontSize: 11))
                              ],
                            ),
                          ),Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Collection on : ${data.getcolletiondate} , ${data.colletiontime}",
                                style: TextStyle(fontSize: 11),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Book On:",
                                  style: TextStyle(
                                    fontSize: 9,),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${data.addedon}",style: TextStyle(
                                    fontSize: 11))
                              ],
                            ),
                          ),

                          // VerticalDivider(color: Colors.black,
                          //   thickness: 2, width: 20,
                          //   indent: 200,
                          //   endIndent: 200,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
            ,Divider(
              color: Colors.black38,
              thickness: 1.0,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  padding:EdgeInsets.only(left: 4, right: 4) ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Status:",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${int.parse(data.status!)=="1" ?
                                "Pending":int.parse(data.status!)=="2" ? "Test Under Process":(int.parse(data.status!)>3 && int.parse(data.status!)<7 ?
                                "Test In-Process":int.parse(data.status!)==7 ?
                                "Test Complete":int.parse(data.status!)==8 ?
                                "Report Uploaded":int.parse(data.status!)>99 ? "Cancel":"Pending")}",style:
                                TextStyle(
                                    fontSize: 11,color: Colors.redAccent,
                                    fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),


                          // Container(
                          //   margin: EdgeInsets.only(top: 5),
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Payment Status ${data.paymentStatus}",
                          //         style: TextStyle(
                          //             fontSize: 16, fontWeight: FontWeight.bold),
                          //       ),
                          //
                          //       Text("Payment Mode ${data.paymentMode}",style:
                          //       TextStyle(color: Colors.redAccent,
                          //       fontWeight: FontWeight.bold),)
                          //     ],
                          //   ),
                          // ),


                          // VerticalDivider(color: Colors.black,
                          //   thickness: 2, width: 20,
                          //   indent: 200,
                          //   endIndent: 200,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
            // child: Card(
            // elevation: 4,
                child:  int.parse('${data.status}')>2 && int.parse('${data.status}')<7 ? Container(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                ListTile(
                leading: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // widget.productDetail.testimage == null
                // ?
                Image.asset(
                "images/user.png",
                height: 45,
                width: 45,
                fit: BoxFit.cover,
                )
                //     : Image.network(
                // widget.productDetail.testimage!,
                // height: 45,
                // width: 45,
                // fit: BoxFit.cover,
                // ),
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
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  // "Waiting for panelists",
                  data.accepton?.vendor?.assignto?.name!=null ? "${data.accepton?.vendor?.assignto?.name}" : "Waiting for panelists",
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Constant.hexToColor(Constant.primaryBlue)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
                ),

                Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(

                  // "pathology_name",
                  data.accepton?.vendor?.pathology_name!=null ? "${data.accepton?.vendor?.pathology_name}":"",
                style: TextStyle(
                fontSize: 11,
                color: Constant.hexToColor(
                Constant.primaryBlue)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
                Text(
                "",
                style: TextStyle(
                fontSize: 11,
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
                ],
                ),
                ],
                ),

                // trailing: IconButton(
                // onPressed: () {
                //
                //
                //
                // },
                // icon: Icon(
                // Icons.close_rounded,
                // color: Constant.hexToColor(Constant.primaryBlue),
                // ),
                // ),
                ),

                ],
                ),
                ):null,
                // )
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8, top: 8,right: 8),
              child:  int.parse('${data.status}')>2 && int.parse('${data.status}')<7
                  && data.accepton?.vendor?.assignto?.mobileno!=null ?
              Row(  mainAxisAlignment: MainAxisAlignment.end,
                  children: [CustomButton(
                  label: "View details",
                  color: Constant.hexToColor(Constant.primaryBlue),
                  textColor: Colors.white,
                  borderColor: Constant.hexToColor(Constant.primaryBlue),
                  onPressed: () {
                    Get.to(OrderDetail(data));
                  },
                  fontSize: 12,
                  padding: 4,
                  height: 40,
                  width: 120),
                    CustomButton(
                    label: "Call Now",
                    color: Colors.green,
                    textColor: Colors.white,
                    borderColor: Colors.green,
                    onPressed: () {
                      _makePhoneCall("tel:0${data.accepton?.vendor?.assignto?.mobileno}");
                      // makeCall(data.accepton?.vendor?.assignto?.mobileno,data?.mobile);
                      // makeCall(data.accepton?.vendor?.assignto?.mobileno,data.mobile);

                    },
    fontSize: 12,
    padding: 4,
    height: 40,
    width: 120)]) : CustomButton(
    label: "View details",
    color: Constant.hexToColor(Constant.primaryBlue),
    textColor: Colors.white,
    borderColor: Constant.hexToColor(Constant.primaryBlue),
    onPressed: () {
    Get.to(OrderDetail(data));
    },
    fontSize: 12,
    padding: 4,
    height: 40,
    width: 120)
            )

          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not make call';// $url';
    }
  }

  void makeCall(String? numbervendor,String? userumber) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.SKYCALL}&agent_number=${numbervendor}&destination_number=${userumber}").catchError((e) {
      Constant.showToast("Error In Call Please try again");
    });
    try{
    SkyCallResponse callresponse =
    SkyCallResponse.fromJson(response.data);
    if(callresponse.status=="Success"){
      Constant.showToast("${callresponse.message} pickup call");
    }else{
      Constant.showToast("${callresponse.message}");
    }
    }on Exception catch (exception) {
      Constant.showToast("Error In Call Please try again");
    } catch (error) {
      Constant.showToast("Error In Call Please try again");
    }
  }
  //
  // Future<LoginResponse> createOrder(MakeOrderModel makeOrderModel) async {
  //   var dio = Dio();
  //   final response = await dio.post("${ApiConstant.BOOK_TEST}",data: makeOrderModel.toJson()).catchError((e) {
  //     print("Errrrrr ${e}");
  //   });
  //
  //
  //   print("Orderrrrrr ${makeOrderModel.toString()}");
  //
  //
  //   LoginResponse loginResponse =
  //   LoginResponse.fromJson(response.data);
  //
  //   return loginResponse;
  //
  //
  // }
}
