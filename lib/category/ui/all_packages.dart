import 'package:flutter/material.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/category/repository/model/get_category_response.dart';
import 'package:medilabs/category/repository/model/get_package_response.dart';
import 'package:medilabs/dashboard/dashboard_screen.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/size_config.dart';
import 'package:medilabs/lab/package_detail.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllPackages extends StatelessWidget {
  final String title;
  final String? packageType;
  final DashboardController dashboardController = Get.find();
  final orderItems = GetStorage().read(Constant.items);

  AllPackages({Key? key, required this.title, this.packageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (orderItems != null && orderItems.length > 0)
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
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 12),
          child: buildStageredSortProductList(120)),
    );
  }

  Widget buildStageredSortProductList(double height) {
    height = SizeConfig.blockSizeVertical * 25;
    double imgheight = SizeConfig.blockSizeVertical * 20;
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetPackageResponse> data) {
        if (data.hasData) {
          if (data.data!.data!.length > 0) {
            return Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: GridView.count(
                childAspectRatio: 175 / height,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 8,
                children: List.generate(data.data!.data!.length, (index) {
                  if (orderItems != null) {
                    if (orderItems.length > 0) {
                      orderItems.forEach((element) {
                        if ("p" + element.id ==
                            "p${data.data!.data![index]!.id}") {
                          data.data!.data![index]!.quantity =
                              "${element.quantity}";
                          // data.data!.data![index]!.subtotal =
                          // "${element.subtotal}";
                        }
                      });
                    }
                  }
                  //return Text(data.data!.data![index].package!);
                  return InkWell(
                    onTap: () {
                      Get.to(PackageDetail(
                          data: data.data!.data![index],
                          refresh: () {
                            var sorderItems = GetStorage().read(Constant.items);
                          }));
                    },
                    child: Container(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                // width: 600,
                                height: imgheight,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: data.data!.data![index].image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: imgheight,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset(
                                    'images/logo.png',
                                    height: imgheight,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset(
                                    'images/logo.png',
                                    height: imgheight,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(data.data!.data![index].package!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2)
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
      },
      future: _getFuture(),
    );
  }

  Future<GetPackageResponse> _getFuture() {
    if (packageType != null) {
      return dashboardController.getPackagesbyType(packageType!);
    } else {
      return dashboardController.getPackages();
    }
  }
}
