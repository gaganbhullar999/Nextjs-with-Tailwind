import 'package:flutter/material.dart';
import 'package:medilabs/cart/ui/patient_details_screen.dart';
import 'package:medilabs/cart/ui/select_other_info.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:get/get.dart';

class SelectAddressList extends StatelessWidget {
  final addressList = [
    AddressModel(
        "Kolar Road", "Yagyesh homes 2 381 apartment", "462042, Bhopal"),
    AddressModel(
        "Kolar Road", "Yagyesh homes 2 381 apartment", "462042, Bhopal"),
    AddressModel(
        "Kolar Road", "Yagyesh homes 2 381 apartment", "462042, Bhopal"),
    AddressModel(
        "Kolar Road", "Yagyesh homes 2 381 apartment", "462042, Bhopal")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Address"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Container(
                margin: EdgeInsets.all(12),
                child: buildAddressList()),
          ),

          Positioned(
              left: 0,right: 0,bottom: 0,
              child:  Container(
                margin: EdgeInsets.all(24),
                child: CustomButton(
                    label: "Proceed",
                    color: Constant.hexToColor(Constant.primaryBlue),
                    textColor: Colors.white,
                    borderColor: Constant.hexToColor(Constant.primaryBlue),
                    onPressed: () {

                      Get.to(PatientDetailsScreen());

                    },
                    fontSize: 16,
                    padding: 8,
                    height: 45,
                    width: 150),
              ))

        ],
      ),
    );
  }

  Widget buildAddressList() {
    return ListView.builder(
      itemBuilder: (c, index) {
        return Container(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 12,top: 4),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressList[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(addressList[index].address1),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(addressList[index].address2),
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: addressList.length,
    );
  }
}

class AddressModel {
  final String name;
  final String address1;
  final String address2;

  AddressModel(this.name, this.address1, this.address2);
}
