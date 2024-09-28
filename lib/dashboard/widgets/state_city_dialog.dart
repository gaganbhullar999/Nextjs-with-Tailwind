import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilabs/dashboard/repository/model/city_list_response.dart';
import 'package:medilabs/dashboard/repository/model/state_list_response.dart';
import '../../helper/constant.dart';
import '../../helper/widgets/custom_button.dart';
import '../repository/dashboard_controller.dart';
import 'package:get_storage/get_storage.dart';

class StateCityDialogController extends GetxController {
  final DashboardController dashboardController = Get.find();
  final _selectedState = Rxn<StateModel>();
  StateModel? get selectedState => this._selectedState.value;
  set selectedState(StateModel? value) {
    this._selectedState.value = value;
    cityStatus = RxStatus.loading();
    dashboardController.getCities(value?.id).then((value) {
      allCities = value.data;
      if (allCities.isEmpty) {
        cityStatus = RxStatus.error('No city in selected state');
      } else {
        cityStatus = RxStatus.success();
      }
    }).catchError((err) {
      print(err);
      cityStatus = RxStatus.error('Unable to fetch cities');
    });
  }

  final _selectedCity = Rxn<CityModel>();
  CityModel? get selectedCity => this._selectedCity.value;
  set selectedCity(CityModel? value) => this._selectedCity.value = value;

  final _allStates = RxList<StateModel>();
  List<StateModel> get allStates => _allStates.toList();
  set allStates(List<StateModel>? value) {
    _allStates.clear();
    _allStates.addAll(value ?? []);
  }

  final _allCities = RxList<CityModel>();
  List<CityModel> get allCities => _allCities.toList();
  set allCities(List<CityModel>? value) {
    _allCities.clear();
    _allCities.addAll(value ?? []);
  }

  final _stateStatus = Rx(RxStatus.empty());
  RxStatus get stateStatus => this._stateStatus.value;
  set stateStatus(value) => this._stateStatus.value = value;

  final _cityStatus = Rx(RxStatus.empty());
  RxStatus get cityStatus => this._cityStatus.value;
  set cityStatus(value) => this._cityStatus.value = value;

  @override
  void onReady() {
    super.onReady();

    dashboardController.getAllStates().then((value) {
      allStates = value.data;
      if (allStates.isEmpty) {
        stateStatus = RxStatus.error('No state available');
      } else {
        stateStatus = RxStatus.success();
      }
    }).catchError((err) {
      print(err);
      stateStatus = RxStatus.error('Unable to fetch states');
    });
  }
}

class StateCityDialog extends GetView<StateCityDialogController> {
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    //Get.put(StateCityDialogController());
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      insetPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Your\nState And City',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
            'images/logo.png',
            width: 150,
          ),
          Obx(() {
            if (controller.stateStatus.isLoading) {
              return CircularProgressIndicator();
            }
            if (controller.stateStatus.isError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.stateStatus.errorMessage ?? ''),
              );
            }
            if (controller.stateStatus.isSuccess) {
              return DropdownButton<StateModel>(
                hint: Text(controller.stateStatus.isError
                    ? controller.stateStatus.errorMessage ?? ''
                    : 'Select State'),
                value: controller.selectedState,
                onChanged: (StateModel? newValue) {
                  controller.selectedState = newValue;
                },
                items: controller.allStates
                    .map<DropdownMenuItem<StateModel>>((StateModel value) {
                  return DropdownMenuItem<StateModel>(
                    value: value,
                    child: Text(value.name ?? ''),
                  );
                }).toList(),
                isExpanded: true,
              );
            }
            return SizedBox();
          }),
          Obx(() {
            if (controller.cityStatus.isLoading) {
              return CircularProgressIndicator();
            }
            if (controller.cityStatus.isError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.cityStatus.errorMessage ?? ''),
              );
            }
            if (controller.cityStatus.isSuccess) {
              return DropdownButton<CityModel>(
                value: controller.selectedCity,
                hint: Text(controller.cityStatus.isError
                    ? controller.cityStatus.errorMessage ?? ''
                    : 'Select City'),
                onChanged: (CityModel? newValue) {
                  controller.selectedCity = newValue;
                },
                items: controller.allCities
                    .map<DropdownMenuItem<CityModel>>((CityModel value) {
                  return DropdownMenuItem<CityModel>(
                    value: value,
                    child: Text(value.name ?? ''),
                  );
                }).toList(),
                isExpanded: true,
              );
            }
            return SizedBox();
          }),
          SizedBox(
            height: 16,
          ),
          CustomButton(
            label: "Submit",
            color: Constant.hexToColor(Constant.primaryBlue),
            textColor: Colors.white,
            borderColor: Constant.hexToColor(Constant.primaryBlue),
            onPressed: () {
              if (controller.selectedState == null) {
                Get.snackbar(
                  'Error',
                  'Please select State',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                  shouldIconPulse: true,
                  margin: EdgeInsets.all(8),
                );
                return;
              }
              if (controller.selectedCity == null) {
                Get.snackbar(
                  'Error',
                  'Please select City',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                  shouldIconPulse: true,
                  margin: EdgeInsets.all(8),
                );
                return;
              }
              GetStorage().write(Constant.SELECTED_STATE,
                  stateModelToJson(controller.selectedState));
              GetStorage().write(Constant.SELECTED_CITY,
                  cityModelToJson(controller.selectedCity));
              Get.back();
            },
            fontSize: 16,
            padding: 8,
            height: 45,
            width: 150,
          ),
        ],
      ),
    );
  }
}
