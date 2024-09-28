
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/login/ui/boarding_screen.dart';
import 'package:medilabs/reports/repository/report_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ReportDetail extends StatelessWidget {

  final ReportModel labModel;

  ReportDetail(this.labModel);





  final pageItemList = [
    PageItemModel("images/girl_shooping_two.jpg",
        "Be yourself, Everything else is already taken"),

  ];

  final PageController pageController = PageController();





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
    );
  }

  Widget buildTopUi(double size, Size width, BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            labModel.imageReport,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    height: 340,
                    child: buildProductPages(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, bottom: 12, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.medical_services_outlined,color: Constant.hexToColor(Constant.primaryBlue),)
                        ,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              child: Text(
                               labModel.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(labModel.description),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(labModel.date),
                            ),
                          ],
                        ),
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
    return InkWell(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Constant.hexToColor(Constant.primaryBlue)),
        child: Center(
          child: Text(
            "Download",
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );

    //
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Row(
    //       children: [
    //         Container(
    //           margin: EdgeInsets.only(left: 12),
    //           child: Text(
    //             labModel.discountPrice,
    //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         Container(
    //           margin: EdgeInsets.only(left: 6),
    //           child: Text(
    //             labModel.regularPrice,
    //             style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough),
    //           ),
    //         ),
    //       ],
    //     ),
    //
    //
    //     InkWell(
    //       onTap: (){
    //         Get.to(CartList(labModel));
    //       },
    //       child: Container(
    //         margin: EdgeInsets.only(right: 12),
    //         height: 45,
    //         width: 150,
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(25),
    //             color: Colors.deepOrangeAccent),
    //         child: Center(
    //           child: Text(
    //             "Add to Cart",
    //             style:
    //                 TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
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
                    return Image.asset(
                      labModel.imageReport,
                      fit: BoxFit.cover,
                    );
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
                onDotClicked: (index) {



                }),
          ),
        ],
      ),
    );
  }
}
