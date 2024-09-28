import 'package:flutter/material.dart';
import 'package:medilabs/reports/repository/report_model.dart';

class ReportCard extends StatelessWidget {
  final double width;
  final double height;
  final ReportModel reportModel;

  ReportCard(this.width, this.height, this.reportModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: height,
      width: width,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4,left: 4),

                      child: Text(
                        reportModel.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4,left: 4),
                      child: Text(reportModel.description,maxLines: 1,
                          overflow: TextOverflow.ellipsis,style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4,left: 4),
                      child: Text(reportModel.date,maxLines: 1,
                          overflow: TextOverflow.ellipsis,style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    )
                  ],
                ),
                // Text(
                //   reportModel.date,
                //   style: TextStyle(fontSize: 10),
                // )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Image.asset(
                reportModel.imageReport,
                height: 120,
                fit: BoxFit.cover,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
