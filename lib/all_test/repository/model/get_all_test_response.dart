import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';

/// success : true
/// message : "Test found"
/// data : [{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"950","testimage":"http://medilabsdiagnostics.com/admin/","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":"","categoryname":"test3","subcategoryname":"subtest2"},{"id":"6","category_id":"2","subcategory_id":"1","testname":"Stool test","vendor_price":"550","medilabs_price":"","total_price":"","discount":"","display_price":"","testimage":"http://medilabsdiagnostics.com/admin/","description":"","status":"1","addedon":"2021-12-17 15:25:48","addedby":"1","updated_on":"2021-12-22 15:28:35","updated_by":"1","app_client_id":"1","image":"","categoryname":"test2","subcategoryname":"sub1test1"},{"id":"7","category_id":"7","subcategory_id":"5","testname":"shiven","vendor_price":"1000","medilabs_price":"","total_price":"","discount":"","display_price":"","testimage":"http://medilabsdiagnostics.com/admin/","description":"","status":"1","addedon":"2021-12-22 15:29:23","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0","app_client_id":"1","image":"","categoryname":"new","subcategoryname":"sub new"}]

class GetAllTestResponse {
  GetAllTestResponse({
      bool? success, 
      String? message, 
      List<Tests>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  GetAllTestResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Tests.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Tests>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Tests>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// category_id : "5"
/// subcategory_id : "2"
/// testname : "Hemoglobin Test"
/// vendor_price : "500"
/// medilabs_price : "500"
/// total_price : "1000"
/// discount : "10"
/// display_price : "950"
/// testimage : "http://medilabsdiagnostics.com/admin/"
/// description : "test description"
/// status : "1"
/// addedon : "2021-12-17 13:58:52"
/// addedby : "1"
/// updated_on : "2021-12-31 17:51:34"
/// updated_by : "1"
/// app_client_id : "1"
/// image : ""
/// categoryname : "test3"
/// subcategoryname : "subtest2"

// class Data {
//   Data({
//       String? id,
//       String? categoryId,
//       String? subcategoryId,
//       String? testname,
//       String? vendorPrice,
//       String? medilabsPrice,
//       String? totalPrice,
//       String? discount,
//       String? displayPrice,
//       String? testimage,
//       String? description,
//       String? status,
//       String? addedon,
//       String? addedby,
//       String? updatedOn,
//       String? updatedBy,
//       String? appClientId,
//       String? image,
//       String? categoryname,
//       String? subcategoryname,}){
//     _id = id;
//     _categoryId = categoryId;
//     _subcategoryId = subcategoryId;
//     _testname = testname;
//     _vendorPrice = vendorPrice;
//     _medilabsPrice = medilabsPrice;
//     _totalPrice = totalPrice;
//     _discount = discount;
//     _displayPrice = displayPrice;
//     _testimage = testimage;
//     _description = description;
//     _status = status;
//     _addedon = addedon;
//     _addedby = addedby;
//     _updatedOn = updatedOn;
//     _updatedBy = updatedBy;
//     _appClientId = appClientId;
//     _image = image;
//     _categoryname = categoryname;
//     _subcategoryname = subcategoryname;
// }
//
//   Data.fromJson(dynamic json) {
//     _id = json['id'];
//     _categoryId = json['category_id'];
//     _subcategoryId = json['subcategory_id'];
//     _testname = json['testname'];
//     _vendorPrice = json['vendor_price'];
//     _medilabsPrice = json['medilabs_price'];
//     _totalPrice = json['total_price'];
//     _discount = json['discount'];
//     _displayPrice = json['display_price'];
//     _testimage = json['testimage'];
//     _description = json['description'];
//     _status = json['status'];
//     _addedon = json['addedon'];
//     _addedby = json['addedby'];
//     _updatedOn = json['updated_on'];
//     _updatedBy = json['updated_by'];
//     _appClientId = json['app_client_id'];
//     _image = json['image'];
//     _categoryname = json['categoryname'];
//     _subcategoryname = json['subcategoryname'];
//   }
//   String? _id;
//   String? _categoryId;
//   String? _subcategoryId;
//   String? _testname;
//   String? _vendorPrice;
//   String? _medilabsPrice;
//   String? _totalPrice;
//   String? _discount;
//   String? _displayPrice;
//   String? _testimage;
//   String? _description;
//   String? _status;
//   String? _addedon;
//   String? _addedby;
//   String? _updatedOn;
//   String? _updatedBy;
//   String? _appClientId;
//   String? _image;
//   String? _categoryname;
//   String? _subcategoryname;
//
//   String? get id => _id;
//   String? get categoryId => _categoryId;
//   String? get subcategoryId => _subcategoryId;
//   String? get testname => _testname;
//   String? get vendorPrice => _vendorPrice;
//   String? get medilabsPrice => _medilabsPrice;
//   String? get totalPrice => _totalPrice;
//   String? get discount => _discount;
//   String? get displayPrice => _displayPrice;
//   String? get testimage => _testimage;
//   String? get description => _description;
//   String? get status => _status;
//   String? get addedon => _addedon;
//   String? get addedby => _addedby;
//   String? get updatedOn => _updatedOn;
//   String? get updatedBy => _updatedBy;
//   String? get appClientId => _appClientId;
//   String? get image => _image;
//   String? get categoryname => _categoryname;
//   String? get subcategoryname => _subcategoryname;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['category_id'] = _categoryId;
//     map['subcategory_id'] = _subcategoryId;
//     map['testname'] = _testname;
//     map['vendor_price'] = _vendorPrice;
//     map['medilabs_price'] = _medilabsPrice;
//     map['total_price'] = _totalPrice;
//     map['discount'] = _discount;
//     map['display_price'] = _displayPrice;
//     map['testimage'] = _testimage;
//     map['description'] = _description;
//     map['status'] = _status;
//     map['addedon'] = _addedon;
//     map['addedby'] = _addedby;
//     map['updated_on'] = _updatedOn;
//     map['updated_by'] = _updatedBy;
//     map['app_client_id'] = _appClientId;
//     map['image'] = _image;
//     map['categoryname'] = _categoryname;
//     map['subcategoryname'] = _subcategoryname;
//     return map;
//   }
//
// }