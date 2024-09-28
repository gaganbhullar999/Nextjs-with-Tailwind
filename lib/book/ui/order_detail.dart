import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medilabs/book/repository/model/get_all_order_response.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart';
import 'package:medilabs/cart/tokenmodel.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/helper/ap_constant.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/lab/web_view.dart';
import 'package:medilabs/login/ui/boarding_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatefulWidget {
  Data makeOrderModel;
  OrderDetail(this.makeOrderModel);
  // TestDetail({required this.data, this.refresh});
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  CartController cartController = CartController();
  String id = "1";
  late Future<void> _launched;
  String _phone = '';
  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      // ..progressColor = Colors.yellow
      // ..backgroundColor = Colors.green
      // ..indicatorColor = Colors.yellow
      // ..textColor = Colors.yellow
      // ..maskColor = Colors.blue.withOpacity(0.5)
      // ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();    // getPrefs();
  }

  final pageItemList = [
    PageItemModel("images/girl_shooping_two.jpg",
        "Be yourself, Everything else is already taken"),
  ];

  final PageController pageController = PageController();

  void _showRatingDialog() {
    // actual store listing review & rating
    void _rateAndReviewApp() async {
      // // refer to: https://pub.dev/packages/in_app_review
      // final _inAppReview = InAppReview.instance;
      //
      // if (await _inAppReview.isAvailable()) {
      //   print('request actual review from store');
      //   _inAppReview.requestReview();
      // } else {
      //   print('open actual store listing');
      //   // TODO: use your own store ids
      //   _inAppReview.openStoreListing(
      //     appStoreId: '<your app store id>',
      //     microsoftStoreId: '<your microsoft store id>',
      //   );
      // }
    }
    void submitRating(String rating, String comment) async {
      CartController cartController = CartController();
      EasyLoading.show(status: 'loading...');
      await cartController
          .setRating(
              rating,
              comment,
              widget.makeOrderModel.id!,
              widget.makeOrderModel.accepton!.id!,
              widget.makeOrderModel.accepton!.vendor_id!,
              widget.makeOrderModel.userid!)
          .then((value) {
        // await cartController.setRating(rating,comment,widget.makeOrderModel.id!,
        //     "1","2",widget.makeOrderModel.userid!).then((value){
        try {
          EasyLoading.dismiss();

          TokenModel tmodel = value;
          // debugPrint("getpaymenttokan");
          // Constant.showToast(
          //     "done getpaymenttokan");
          if (tmodel != null) {
            if (tmodel.success!) {
              // debugPrint("tokan-"+tmodel.ctoken);
              Constant.showToast(tmodel.message);
            } else {
              Constant.showToast(tmodel.message);
              // Navigator.of(context,rootNavigator: true).pop();//close the dialoge
              print("Payment gateway error " + tmodel.toString());
            }
          } else {
            Constant.showToast(tmodel.message);
            // Navigator.of(context,rootNavigator: true).pop();//close the dialoge
          }
        } on Exception catch (exception) {
          EasyLoading.dismiss();
          Constant.showToast("Server Error");
          // Navigator.of(context,rootNavigator: true).pop();//close the dialoge
        } catch (error) {
          EasyLoading.dismiss();
          Constant.showToast("Server Error");
          // Navigator.of(this.context,rootNavigator: true).pop();//close the dialoge
        }
      }).catchError((onError) {
        EasyLoading.dismiss();
        Constant.showToast("Server Error");
        // Navigator.of(this.context,rootNavigator: true).pop();//close the dialoge
        debugPrint("getpaymenttokan onError " + onError);
      });
    }

    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Rating',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      // image: const FlutterLogo(size: 100),
      submitButtonText: 'Submit',
      commentHint: 'comment',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        submitRating('${response.rating}', response.comment);
        // TODO: add your own logic
        // if (response.rating < 3.0) {
        //   // send their comments to your email or anywhere you wish
        //   // ask the user to contact you instead of leaving a bad review
        // } else {
        //   _rateAndReviewApp();
        // }
      },
    );

    // show the dialog
    showDialog(
      context: this.context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // builder: EasyLoading.init();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ID #${widget.makeOrderModel.id}"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(12),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 12),

                          // child: Text(
                          //   "Personal Details",
                          //   style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Personal Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: CustomButton(
                                      label: "View invoice",
                                      color: Constant.hexToColor(
                                          Constant.primaryBlue),
                                      textColor: Colors.white,
                                      borderColor: Constant.hexToColor(
                                          Constant.primaryBlue),
                                      onPressed: () {
                                        _launched = _launchInBrowser(
                                            "${ApiConstant.HOST_URL}admin/invoice.php?orderid=${widget.makeOrderModel.id}");
                                      },
                                      fontSize: 09,
                                      padding: 0,
                                      height: 20,
                                      width: 100)),
                              SizedBox(
                                width: 8,
                              ),
                              // Container(
                              //     margin: EdgeInsets.only(top: 8),
                              //     child: int.parse(widget.makeOrderModel.status!)==8 ? CustomButton(
                              //         label: "View Report",
                              //         color: Constant.hexToColor(Constant.primaryBlue),
                              //         textColor: Colors.white,
                              //         borderColor: Constant.hexToColor(Constant.primaryBlue),
                              //         onPressed: () {
                              //
                              //           _launched = _launchInBrowser("${ApiConstant.HOST_URL}vendor/${widget.makeOrderModel.testnmed_file!}");
                              //
                              //           // Get.to(AppWebView(typewebview: 4,
                              //           //     orderid: widget.makeOrderModel.id!,
                              //           //     userid: widget.makeOrderModel.userid!,path:widget.makeOrderModel.testnmed_file!));
                              //         },
                              //         fontSize: 12,
                              //         padding: 4,
                              //         height: 40,
                              //         width: 120) :null),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .45,
                          margin: EdgeInsets.all(12),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${widget.makeOrderModel.name}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Email: ${widget.makeOrderModel.email}",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Mobile: ${widget.makeOrderModel.mobile}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Age: ${widget.makeOrderModel.age} ",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Gender: ${widget.makeOrderModel.gender}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Address: ${widget.makeOrderModel.address} , ${widget.makeOrderModel.landmark}, ${widget.makeOrderModel.city}",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Collection on : ${widget.makeOrderModel.getcolletiondate} , ${widget.makeOrderModel.colletiontime}",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Order For: ${widget.makeOrderModel.orderfor}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Book On: ${widget.makeOrderModel.addedon}",
                                      style: TextStyle(fontSize: 9),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Status:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "${int.parse(widget.makeOrderModel.status!) == "1" ? "Pending" : int.parse(widget.makeOrderModel.status!) == "2" ? "Test Under Process" : (int.parse(widget.makeOrderModel.status!) > 3 && int.parse(widget.makeOrderModel.status!) < 7 ? "Test In-Process" : int.parse(widget.makeOrderModel.status!) == 7 ? "Test Complete" : int.parse(widget.makeOrderModel.status!) == 8 ? "Report Uploaded" : int.parse(widget.makeOrderModel.status!) > 99 ? "Cancel" : "Pending")}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Medical Conditions:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.redAccent),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${widget.makeOrderModel.personal_history_text!.replaceAll(",", '\n')}",
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ))
                                    ],
                                  ),
                                ),
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

                        // Container(
                        //   margin: EdgeInsets.only(left: 12, top: 12),
                        //
                        //   child: Text(
                        //     "Medical Details",
                        //     style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800),
                        //   ),
                        // ),

                        // Container(
                        //   height: widget.makeOrderModel.personalHistory!.length>5?200:50,
                        //   margin: EdgeInsets.all(12),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        // Container(
                        //   height: 30,
                        //   child: makeOrderModel.familyHistory!.length > 0
                        //       ? ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (c, index) {
                        //       return Container(
                        //         margin:
                        //         EdgeInsets.only(left: 8, right: 8),
                        //         color: Constant.hexToColor(
                        //             Constant.primaryBlue),
                        //         child: Center(
                        //             child: Text(
                        //                 makeOrderModel
                        //                     .familyHistory![index].name!,
                        //                 style: TextStyle(
                        //                     color: Colors.white))),
                        //       );
                        //     },
                        //     itemCount:
                        //     makeOrderModel.familyHistory!.length,
                        //   )
                        //       : Container(),
                        // ),
                        // Container(
                        //   height: 30,
                        //   child: widget.makeOrderModel.personalHistory!.length > 0
                        //       ? ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (c, index) {
                        //       return Container(
                        //         margin:
                        //         EdgeInsets.only(left: 8, right: 8),
                        //         // color: Constant.hexToColor(
                        //         //     Constant.primaryBlue),
                        //         child: Center(
                        //             child: Text(
                        //               widget.makeOrderModel
                        //                   .personalHistory![index].name!,
                        //               style: TextStyle(color: Colors.black),
                        //             )),
                        //       );
                        //     },
                        // itemCount:
                        // widget.makeOrderModel.personalHistory!.length,
                        // )
                        // : Container(),
                        // ),
                        // Container(
                        //   height: 30,
                        //   child: makeOrderModel.allergies!.length > 0
                        //       ? ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (c, index) {
                        //       return Container(
                        //         margin:
                        //         EdgeInsets.only(left: 8, right: 8),
                        //         color: Constant.hexToColor(
                        //             Constant.primaryBlue),
                        //         child: Center(
                        //             child: Text(
                        //                 makeOrderModel
                        //                     .allergies![index].name!,
                        //                 style: TextStyle(
                        //                     color: Colors.white))),
                        //       );
                        //     },
                        //     itemCount: makeOrderModel.allergies!.length,
                        //   )
                        //       : Container(),
                        // )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 4),
                          child: Text(
                            "Tests Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          //  height: widget.makeOrderModel.orderitem!.length>2?220:100,
                          margin: EdgeInsets.all(12),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            primary: false,
                            itemBuilder: (c, index) {
                              if (widget.makeOrderModel.orderitem![index]
                                      .itemtype ==
                                  "Test") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.makeOrderModel.orderitem![index]
                                          .test![0].testname!,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "₹ " +
                                          widget
                                              .makeOrderModel
                                              .orderitem![index]
                                              .test![0]
                                              .displayPrice!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        (widget.makeOrderModel.orderitem![index]
                                                        .testnmed_file !=
                                                    null &&
                                                widget
                                                        .makeOrderModel
                                                        .orderitem![index]
                                                        .testnmed_file ==
                                                    "")
                                            ? Text(
                                                "Report not Upload",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(top: 8),
                                                child: CustomButton(
                                                  label: "View Report",
                                                  color: Constant.hexToColor(
                                                      Constant.primaryBlue),
                                                  textColor: Colors.white,
                                                  borderColor:
                                                      Constant.hexToColor(
                                                          Constant.primaryBlue),
                                                  onPressed: () {
                                                    _launched = _launchInBrowser(
                                                        "${ApiConstant.HOST_URL}vendor/${widget.makeOrderModel.orderitem![index].testnmed_file!}");

                                                    // Get.to(AppWebView(typewebview: 4,
                                                    //     orderid: widget.makeOrderModel.id!,
                                                    //     userid: widget.makeOrderModel.userid!,path:widget.makeOrderModel.testnmed_file!));
                                                  },
                                                  fontSize: 09,
                                                  padding: 0,
                                                  height: 20,
                                                  width: 100,
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.makeOrderModel.orderitem![index].packagename!} (Package)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "₹ " +
                                            widget
                                                .makeOrderModel
                                                .orderitem![index]
                                                .displayPrice!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        //  height: widget.makeOrderModel.orderitem!.length>2?220:100,
                                        margin: EdgeInsets.all(12),
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          primary: false,
                                          itemBuilder: (c, index22) {
                                            return ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget
                                                        .makeOrderModel
                                                        .orderitem![index]
                                                        .test![index22]
                                                        .testname!,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              trailing: widget
                                                          .makeOrderModel
                                                          .orderitem![index]
                                                          .test![index22]
                                                          .testnmed_file! ==
                                                      ""
                                                  ? Text(
                                                      "Report not Upload",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0),
                                                      child: CustomButton(
                                                          label: "View Report",
                                                          color: Constant
                                                              .hexToColor(Constant
                                                                  .primaryBlue),
                                                          textColor:
                                                              Colors.white,
                                                          borderColor: Constant
                                                              .hexToColor(Constant
                                                                  .primaryBlue),
                                                          onPressed: () {
                                                            _launched =
                                                                _launchInBrowser(
                                                                    "${ApiConstant.HOST_URL}vendor/${widget.makeOrderModel.orderitem![index].test![index22].testnmed_file!}");

                                                            // Get.to(AppWebView(typewebview: 4,
                                                            //     orderid: widget.makeOrderModel.id!,
                                                            //     userid: widget.makeOrderModel.userid!,path:widget.makeOrderModel.testnmed_file!));
                                                          },
                                                          fontSize: 09,
                                                          padding: 0,
                                                          height: 20,
                                                          width: 100)),
                                            );
                                          },
                                          itemCount: widget.makeOrderModel
                                              .orderitem![index].test!.length,
                                        ),
                                      )
                                    ]);
                              }
                            },
                            separatorBuilder: (ctx, i) => Divider(),
                            itemCount: widget.makeOrderModel.orderitem!.length,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 12, top: 4),
                            child: int.parse(
                                        '${widget.makeOrderModel.status}') >
                                    6
                                ? (widget.makeOrderModel.rating?.rating !=
                                            null &&
                                        widget.makeOrderModel.rating?.rating !=
                                            "")
                                    ? Container(
                                        height: 200,
                                        margin: EdgeInsets.all(12),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "My Rating",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    "Rating: ${widget.makeOrderModel.rating?.rating}",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 12),
                                                  child: Text(
                                                    "Comment: ${widget.makeOrderModel.rating?.comment}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                            // CustomButton(
                                            //   label: "View Report",
                                            //   color: Constant.hexToColor(Constant.primaryBlue),
                                            //   textColor: Colors.white,
                                            //   borderColor: Constant.hexToColor(Constant.primaryBlue),
                                            //   onPressed: () {
                                            //     // Get.to(OrderDetail(data));
                                            //   },
                                            //   fontSize: 12,
                                            //   padding: 4,
                                            //   height: 40,
                                            //   width: 120),
                                            CustomButton(
                                                label: "Add Rating",
                                                color: Colors.green,
                                                textColor: Colors.white,
                                                borderColor: Colors.green,
                                                onPressed: _showRatingDialog,
                                                fontSize: 12,
                                                padding: 4,
                                                height: 40,
                                                width: 120)
                                          ])
                                : null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    // Uri uri1 =Uri.parse("http://docs.google.com/viewer?url="+url);
    Uri uri1 = Uri.parse(url);
    if (!await launchUrl(
      uri1,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }

    // if (await canLaunch(url)) {
    //   await launch(url, forceSafariVC: false, forceWebView: false);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // Widget buildTopUi(double size, Size width, BuildContext context) {
  //   return Container(
  //     child: Stack(
  //       children: [
  //         Image.asset(
  //           "images/lab_1.jpg",
  //           scale: 2,
  //           width: width.width,
  //         ),
  //         Container(
  //             margin: EdgeInsets.all(4),
  //             child: IconButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 icon: Icon(
  //                   Icons.arrow_back_ios,
  //                   color: Colors.blueGrey,
  //                   size: 15,
  //                 ))),
  //         // Positioned(
  //         //     bottom: 0,
  //         //     child: Container(
  //         //         height: size * .2, width: width.width, child: BottomBar()))
  //       ],
  //     ),
  //   );
  // }
  //
  //
  // Widget buildProductSummaryNew() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Column(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(),
  //                   height: 340,
  //                   child:Image.asset("images/lab_1.jpg")
  //                   // child: buildProductPages(),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 8, bottom: 12, right: 8),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Icon(Icons.medical_services_outlined,color: Constant.hexToColor(Constant.primaryBlue),)
  //                       ,
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             margin: EdgeInsets.only(top: 8),
  //                             child: Text(
  //                              "Diabetes Test",
  //                               style: TextStyle(
  //                                   fontSize: 18, fontWeight: FontWeight.w600),
  //                               textAlign: TextAlign.start,
  //                             ),
  //                           ),
  //
  //
  //                           Container(
  //                             margin: EdgeInsets.only(top: 12),
  //                             child: Row(
  //                               children: [
  //                                 Text("Status "),
  //                                 Text("Pending",style: TextStyle(color: Colors.redAccent,
  //                                     fontWeight: FontWeight.bold),)
  //                               ],
  //                             ),
  //                           ),
  //
  //
  //                           Container(
  //                             margin: EdgeInsets.only(top: 12),
  //                             child: Text("Free diabetes test for all"),
  //                           ),
  //
  //                           Container(
  //                             margin: EdgeInsets.only(top: 12),
  //                             child: Text("Free insulin for concerned"),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //           ],
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

  // Widget buildPriceAndProceed() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(left: 12),
  //             child: Text(
  //               labModel.discountPrice,
  //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(left: 6),
  //             child: Text(
  //               labModel.regularPrice,
  //               style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //
  //       // InkWell(
  //       //   onTap: (){
  //       //     Get.to(CartList(labModel));
  //       //   },
  //       //   child: Container(
  //       //     margin: EdgeInsets.only(right: 12),
  //       //     height: 45,
  //       //     width: 150,
  //       //     decoration: BoxDecoration(
  //       //         borderRadius: BorderRadius.circular(25),
  //       //         color: Colors.deepOrangeAccent),
  //       //     child: Center(
  //       //       child: Text(
  //       //         "Add to Cart",
  //       //         style:
  //       //             TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  //       //       ),
  //       //     ),
  //       //   ),
  //       // )
  //     ],
  //   );
  // }

  // Widget buildProductPages() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Stack(
  //           children: [
  //             Container(
  //               height: 320,
  //               child: PageView.builder(
  //                 controller: pageController,
  //                 itemBuilder: (c, index) {
  //                   return Image.asset(
  //                     labModel.image,
  //                     fit: BoxFit.cover,
  //                   );
  //                 },
  //                 itemCount: 4,
  //               ),
  //             ),
  //             // Positioned(
  //             //     top: 0,
  //             //     right: 0,
  //             //     child: Container(
  //             //         margin: EdgeInsets.all(8),
  //             //         child: Icon(
  //             //           Icons.favorite,
  //             //           color: Colors.redAccent,
  //             //         )))
  //           ],
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 8),
  //           height: 4,
  //           child: SmoothPageIndicator(
  //               controller: pageController, // PageController
  //               count: 1,
  //               effect: SlideEffect(
  //                   dotHeight: 8,
  //                   dotWidth: 8,
  //                   dotColor: Colors.grey,
  //                   activeDotColor: Constant.hexToColor(Constant.primaryBlue)),
  //               onDotClicked: (index) {
  //
  //
  //
  //               }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
