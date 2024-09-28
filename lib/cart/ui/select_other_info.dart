import 'package:flutter/material.dart';
import 'package:medilabs/cart/repository/cart_controller.dart';
import 'package:medilabs/cart/repository/model/get_medical_response.dart';
import 'package:medilabs/cart/repository/model/make_order_model.dart' ;
import 'package:medilabs/cart/ui/payment_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:medilabs/helper/widgets/custom_title_textfield.dart';
import 'package:get_storage/get_storage.dart';

class SelectOtherInfo extends StatefulWidget {
  @override
  _SelectOtherInfoState createState() => _SelectOtherInfoState();
}

class _SelectOtherInfoState extends State<SelectOtherInfo> {
  CartController cartController = CartController();

  Map familyBool = Map();
  Map personalBool = Map();
  Map allergiesBool = Map();

  var familyHistory = <Family_history>[];
  var personalHistory = <Personal_history>[];
  var allergiesHistory = <Allergies>[];







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter other details"),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height,
            child: Container(child: buildDetailsUI()),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(24),
                child: CustomButton(
                    label: "Proceed",
                    color: Constant.hexToColor(Constant.primaryBlue),
                    textColor: Colors.white,
                    borderColor: Constant.hexToColor(Constant.primaryBlue),
                    onPressed: () {

                      MakeOrderModel makeOrderModel = GetStorage().read(Constant.Order);

                      if(allergiesHistory.length==0){
                        makeOrderModel.allergies = <Allergies>[];

                      }else {
                        makeOrderModel.allergies = allergiesHistory;

                      }

                      if(familyHistory.length==0){
                        makeOrderModel.familyHistory = <Family_history>[];

                      }else {
                        makeOrderModel.familyHistory = familyHistory;

                      }

                      if(personalHistory.length==0){
                        makeOrderModel.personalHistory = <Personal_history>[];

                      }else {
                        makeOrderModel.personalHistory = personalHistory;

                      }
                      GetStorage().write(Constant.Order,makeOrderModel);


                      Get.to(PaymentScreen());
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

  Widget buildDetailsUI() {
    return FutureBuilder(
        future: cartController.getMedicalForm(),
        builder: (context, AsyncSnapshot<GetMedicalResponse> snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.familyHistory!.forEach((element) {
              familyBool.putIfAbsent(element.name, () => false);

            });

            snapshot.data!.personalHistory!.forEach((element) {
              personalBool.putIfAbsent(element.name, () => false);
            });

            snapshot.data!.allergies!.forEach((element) {
              allergiesBool.putIfAbsent(element.name, () => false);
            });

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Family Medical History",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: List.generate(
                          snapshot.data!.familyHistory!.length, (index) {
                        return CheckboxListTile(
                          title: Text(
                              "${snapshot.data!.familyHistory![index].name!}"),
                          value: familyBool[
                              snapshot.data!.familyHistory![index].name],
                          onChanged: (newValue) {

                            if(newValue!){

                              familyHistory.add(snapshot.data!.familyHistory![index]);
                            }else {
                              if(familyHistory.contains(snapshot.data!.familyHistory![index])){
                                familyHistory.remove(snapshot.data!.familyHistory![index]);

                              }
                            }

                            setState(() {

                              familyBool.update(
                                  snapshot.data!.familyHistory![index].name,
                                  (value) => newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Personal Medical History",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: List.generate(
                          snapshot.data!.personalHistory!.length, (index) {
                        return CheckboxListTile(
                          title: Text(
                              "${snapshot.data!.personalHistory![index].name}"),
                          value: personalBool[
                              snapshot.data!.personalHistory![index].name],
                          onChanged: (newValue) {

                            if(newValue!){

                              personalHistory.add(snapshot.data!.personalHistory![index]);
                            }else {

                              if(personalHistory.contains(snapshot.data!.personalHistory![index])){
                                personalHistory.remove(snapshot.data!.personalHistory![index]);

                              }

                            }
                            setState(() {
                              personalBool.update(
                                  snapshot.data!.personalHistory![index].name,
                                  (value) => newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Allergies History",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: List.generate(snapshot.data!.allergies!.length,
                          (index) {
                        return CheckboxListTile(
                          title:
                              Text("${snapshot.data!.allergies![index].name}"),
                          value: allergiesBool[
                              snapshot.data!.allergies![index].name],
                          onChanged: (newValue) {
                            if(newValue!){

                              allergiesHistory.add(snapshot.data!.allergies![index]);
                            }else {

                              if(allergiesHistory.contains(snapshot.data!.allergies![index])){
                                allergiesHistory.remove(snapshot.data!.allergies![index]);

                              }

                            }

                            setState(() {
                              allergiesBool.update(
                                  snapshot.data!.allergies![index].name,
                                  (value) => newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        );
                      }),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // return Column(
          //   children: [
          //     CustomTitleTextfield("12pm", "Enter Time", (v) {}),
          //     CustomTitleTextfield("20/12/2021", "Enter Date", (v) {}),
          //     CustomTitleTextfield("Home", "Enter Location", (v) {}),
          //   ],
          // );
        });
  }
}
