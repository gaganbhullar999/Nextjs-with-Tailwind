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
import 'package:cached_network_image/cached_network_image.dart';
import 'model/lab_model.dart';

class PackageDetail extends StatefulWidget {
  // final LabModel labModel;

  Packages data;

  Function()? refresh;

    PackageDetail({required this.data, this.refresh});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  late Tests testdata;
  final pageItemList = [
    PageItemModel("images/girl_shooping_two.jpg",
        "Be yourself, Everything else is already taken"),
  ];

  final PageController pageController = PageController();

  String? quantity = "0";
  String? subtotal;
  String? finalamount = "0";
  var itemFound = false;

  DashboardController dashboardController = Get.find();

  var orderItems = GetStorage().read(Constant.items);

  @override
  void initState() {
    super.initState();


    subtotal = widget.data.display;

     testdata=new Tests();
     testdata.id=widget.data.id!;
     testdata.testname=widget.data.package!;
     testdata.vendorPrice=widget.data.vendor_price!;
     testdata.medilabsPrice=widget.data.mediprice;
     testdata.totalPrice=widget.data.totalprice!;
     testdata.discount=widget.data.discount!;
     testdata.displayPrice=widget.data.display!;
     testdata.testimage=widget.data.image!;
     testdata.description=widget.data.description!;
     testdata.status=widget.data.status!;

     testdata.quantity=widget.data.quantity!=null ? widget.data.quantity: "0";
    testdata.subtotal=widget.data.display;

    quantity="0";
    if (orderItems == null) {
      orderItems = <Orderitem>[];
    }else{
      // quantity = orderItems.where((item) => item["id"] == 'p${testdata.id}') ? "1": "0";

      print(testdata.id);
      print('p${testdata.id}');
      var contain =  orderItems.where((element) => element.id == 'p${testdata.id}');
      print('p3333${contain}');
          if (!contain.isEmpty){
            // setState(() {
              quantity = "1";
            // });
      }


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
              "${widget.data.package}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
                    margin: EdgeInsets.only(bottom: 70),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:230,
                              margin: EdgeInsets.only(top: 24),
                              child: Text(
                                "${widget.data.package}",
                                style: TextStyle(
                                  color:  Constant.hexToColor(Constant.primaryBlue),
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 12),
                            //   child:
                            //   Text("Category "),
                            // ),
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
                              testdata.quantity="0";
                              orderItems.removeWhere((item) => item.id == "p${testdata.id}");
                              GetStorage()
                                  .write(Constant.items, orderItems);
                              dashboardController.cartCount.value =
                                  orderItems.length;
                            } else {
                              int incre = int.parse(quantity!) + 1;
                              testdata.quantity="1";
                              orderItems
                                  .add(getOrderItem(testdata, "${incre}"));
                              GetStorage().write(Constant.items, orderItems);
                              dashboardController.cartCount.value =
                                  orderItems.length;
                              setState(() {
                                quantity = "${incre}";
                              });
                              Constant.showToast("Test added to cart");
                            }

                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: int.parse(quantity!) >= 1 ? Colors.green:Constant.hexToColor(
                                      Constant.primaryBlue)),
                              child: Center(
                                child:
                                int.parse(quantity!) >= 1 ?  RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Done ", style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                      ),
                                      WidgetSpan(
                                        child: Icon(Icons.check, size: 14,color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ) : RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Book ", style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)
                                      ),
                                      WidgetSpan(
                                        child: Icon(Icons.add, size: 14,color: Colors.white,),
                                      ),
                                    ],
                                  ),
                                )

                              ),
                            ),

                          ),
                        )


                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Test Cover",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 12),
                 child:widget.data.packagestest!.length>0 ? ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      children: [
                        for (var i = 0; i < widget.data.packagestest!.length; i++)
                          Text("${i+1}. ${widget.data.packagestest![i].testname}",

                          style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ]// and set this
                      )
                     :  Text(
                   "No Test Found",
                   style: TextStyle(
                       fontWeight: FontWeight.normal, fontSize: 10,color: Colors.red),
                 ),
                  ),
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
                            margin: EdgeInsets.only(top: 16, left: 12),
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
                "₹ ${testdata.displayPrice}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                "₹ ${testdata.totalPrice}",
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
                    testdata.quantity = element.quantity;
                    testdata.subtotal = element.subtotal;
                  });
                  // return;
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
                color: int.parse(testdata.quantity!) >= 1
                    ? Colors.green
                    : Colors.deepOrangeAccent),
            child: Center(
              child: Text(
                int.parse(testdata.quantity!) >= 1
                    ? "(Added) Go to cart"
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
                    if (!testdata.testimage!.isEmpty) {
                      return  CachedNetworkImage(
                        // width: 600,
                        height: 320,
                        fit: BoxFit.cover,
                        imageUrl: testdata.testimage!,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>  Image.asset(
                          "images/lab_1.jpg",
                          fit: BoxFit.cover,
                        ),
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
      ..id = "p"+test.id! //add "p" for deffrentshite id for remove from cart.// also remove "P" in PHP Api
      ..categoryId = ""
      ..subcategoryId = ""!
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
      ..updatedOn = DateTime.now().toString()
      ..itemtype="Package"
      ..packagetest=widget.data.packagestest;
  }
}
