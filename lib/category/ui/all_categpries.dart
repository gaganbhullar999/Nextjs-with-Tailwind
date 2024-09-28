import 'package:flutter/material.dart';
import 'package:medilabs/all_test/repository/model/get_all_test_response.dart';
import 'package:medilabs/category/repository/model/get_category_response.dart';
import 'package:medilabs/dashboard/dashboard_screen.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/constant.dart';

class AllCategories extends StatelessWidget {




  DashboardController dashboardController = Get.find();
  final catList = [
    CategoryModel("Mom & Baby", Colors.blue),
    CategoryModel("Fighting the infection", Colors.deepPurple),
    CategoryModel("Diabetes", Colors.pinkAccent),
    CategoryModel("Antibiotics", Colors.redAccent)
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 12),
          child: buildStageredSortProductList(120)),

    );
  }

  Widget buildStageredSortProductList(double height) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetCategoryResponse> data) {
        if (data.hasData) {
          if (data.data!.data!.length > 0) {
            return Container(
              margin: EdgeInsets.only(left: 8,right: 8),
              child: GridView.count(
                childAspectRatio: 160 / height,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 8,
                children: List.generate(data.data!.data!.length, (index) {
                  return Container(
                    child: Center(
                      child: Text(
                        data.data!.data![index].name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18)),
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: Text("No Categories found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: dashboardController.getCategories(),
    );
  }
}
