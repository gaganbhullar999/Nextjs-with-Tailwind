import 'package:flutter/material.dart';
import 'package:medilabs/helper/constant.dart';

class SampleSearchBar extends StatelessWidget {
  SampleSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 1, color: Constant.hexToColor(Constant.primaryBlue))),
      child: Container(
        margin: EdgeInsets.only(left: 8,right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search for Tests",
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Constant.hexToColor(Constant.primaryBlueMin),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(
                Icons.search,
                size: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
