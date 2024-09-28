import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/login/repository/login_controller.dart';
import 'package:medilabs/login/repository/model/splash_response.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:medilabs/profile/ui/profile_screen.dart';
import 'package:medilabs/profile/ui/update_profile_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'widgets/page_item.dart';

class BoardingScreen extends StatelessWidget {
  final PageController pageController = PageController();
   LoginController loginController = Get.find();

  // SplashResponse pageItemList = GetStorage().read(Constant.SPLASHDATA);

  static const pChannel=MethodChannel("PAYUMONEY");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: loginController.getSplashData(),
                builder: (context, AsyncSnapshot<SplashResponse> snapshot) {

                  if(snapshot.hasData){
                    return Column(
                      children: [


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .5,
                              child: PageView.builder(
                                controller: pageController,
                                itemBuilder: (c, index) {
                                  return PageItem(snapshot.data!.data![index],MediaQuery.of(context).size.height);
                                },
                                itemCount:snapshot.data!.data!.length,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              height: 4,
                              child: Center(
                                child: SmoothPageIndicator(
                                    controller: pageController, // PageController
                                    count: snapshot.data!.data!.length,
                                    effect: WormEffect(
                                        dotHeight: 8,
                                        dotWidth: 8,
                                        dotColor: Colors.grey,
                                        activeDotColor: Constant.hexToColor(
                                            Constant.primaryBlue)),
                                    onDotClicked: (index) {}),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 18),
                              child: Center(
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Constant.hexToColor(
                                                Constant.primaryBlue)),
                                      ),
                                      Icon(Icons.chevron_right,
                                          color: Constant.hexToColor(
                                              Constant.primaryBlue))
                                    ],
                                  ),
                                  onTap: ()  {
                                    // pChannel.invokeMethod("callPayu");
                                    //
                                    //
                                    // // print("cccccccccccc ${data}");
                                    // // printToast();

                                    Get.offAll(HomeBottomBar(0));

                                  },
                                ),
                              ),
                            )
                          ],
                        ),

                        // Container(
                        //   margin: EdgeInsets.only(top: 24, left: 72),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Get.to(LoginScreen());
                        //     },
                        //     child: Card(
                        //       color: Constant.hexToColor(Constant.primaryBlue),
                        //       elevation: 10,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(24),
                        //               bottomLeft: Radius.circular(24))),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(12.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Container(
                        //               margin: EdgeInsets.only(left: 4),
                        //               child: Text(
                        //                 "Sign up",
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 18),
                        //               ),
                        //             ),
                        //             Icon(
                        //               Icons.arrow_right_alt_outlined,
                        //               color: Colors.white,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    );


                  }else {

                    return Center(child: CircularProgressIndicator(),);
                  }

                }
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  
  Future printToast() async{
    
    var data = await pChannel.invokeMethod("printToast");


    print("cccccccccccc ${data}");


  }
}

class PageItemModel {
  final String imageAsset;
  final String description;

  PageItemModel(this.imageAsset, this.description);
}
