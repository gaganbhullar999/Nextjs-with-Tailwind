import 'package:flutter/material.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:medilabs/reports/repository/report_model.dart';
import 'package:medilabs/reports/ui/report_detail.dart';
import 'package:medilabs/reports/ui/widgets/report_card.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {


  final reportsList = [
    ReportModel("DDiatest Test", "diabetes test for all ages", "20/12/2021",
        "images/diabetes.jpg"),
    ReportModel("Blood Sugar Test", "sugar test for all ages", "21/12/2021",
        "images/diabetes.jpg"),
    ReportModel("Cholestrol level test", "cholestrol level for all ages",
        "21/12/2021",
        "images/diabetes.jpg"),
    // ReportModel("Full body test", "full body test for all ages", "22/12/2021",
    //     "images/lab_4.png"),
    // ReportModel("Hairfall Test", "hairfall test for all ages", "23/12/2021",
    //     "images/lab_4.png"),
    ReportModel("DDiatest Test", "diabetes test for all ages", "20/12/2021",
        "images/diabetes.jpg")

  ];


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Reports"),),
      body: Container(

        margin: EdgeInsets.all(12),
      child: Center(child: Text("No Reports found"),),
      // child: ListView.builder(itemBuilder: (c,index){
      //
      //   return Stack(
      //     children: [
      //       Container(
      //         margin: EdgeInsets.only(bottom: 12),
      //         color: Colors.white,
      //           width: MediaQuery.of(context).size.width,
      //           child:Column(
      //         children: [
      //           ReportCard(175, 230, reportsList[index]),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 8,top: 8),
      //             child: CustomButton(
      //                 label: "Get Details",
      //                 color: Constant.hexToColor(Constant.primaryBlue),
      //                 textColor: Colors.white,
      //                 borderColor: Constant.hexToColor(Constant.primaryBlue),
      //                 onPressed: () {
      //
      //                   Get.to(ReportDetail(reportsList[index]));
      //
      //
      //
      //                 },
      //                 fontSize: 10,
      //                 padding: 4,
      //                 height: 45,
      //                 width: 150),
      //           )
      //
      //         ],
      //       )),
      //       Positioned(
      //           left: 0,
      //           child: Container(
      //               margin: EdgeInsets.only(bottom: 8, left: 8),
      //               child: Container(
      //                 height: 30,
      //                 width: 30,
      //                 decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     color: Constant.hexToColor(
      //                         Constant.primaryBlue)),
      //                 child: CircleAvatar(
      //                   backgroundColor:
      //                   Constant.hexToColor(Constant.primaryBlue),
      //                   child: Text(
      //                     "${index + 1}",
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ))),
      //
      //     ],
      //   );
      //
      // }, itemCount: reportsList.length,),

      ),
    );
  }
}
