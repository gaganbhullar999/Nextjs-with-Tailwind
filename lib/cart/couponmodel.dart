class CoupenModel {
  CoupenModel({bool? success, String? message, Coupon? coupendate}) {
    _success = success;
    _message = message;
    _coupendate = coupendate;
  }

  CoupenModel.fromJson(dynamic json) {
    print("cjson ${json}");
    _success = json['success'];
    _message = json['message'];
    _coupendate = json['coupen_data'] != null
        ? Coupon.fromJson(json['coupen_data'])
        : null;
  }

  bool? _success;

  Coupon? get coupendate => _coupendate;
  String? _message;
  Coupon? _coupendate;

  bool? get success => _success;
  String? get message => _message;
  // dynamic? get ctoken => _ctoken;
  // dynamic? get orderid => _orderid;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_coupendate != null) {
      map['coupendate'] = _coupendate?.toJson();
    }

    return map;
  }

  @override
  String toString() {
    return 'TokenModel{_success: $_success, _message: $_message, _coupendate: $_coupendate}';
  }
}

class Coupon {
  Coupon({
    String? id,
    String? app_client_id,
    String? coupon_code,
    String? coupon_for,
    String? coupon_id,
    String? name,
    String? image,
    String? status,
    String? addedon,
    String? addedby,
    String? startdate,
    String? enddate,
    String? person,
    String? amount,
    String? percentage,
    String? detail,
    String? discounttype,
    String? discountvalue,
    String? rate,
    double? coupon_price,
    double? total_price,
  }) {
    _id = id;
    _app_client_id = app_client_id;
    _name = name;
    _coupon_code = coupon_code;
    _coupon_for = coupon_for;
    _coupon_id = coupon_id;
    _image = image;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _startdate = startdate;
    _enddate = enddate;
    _person = person;
    _amount = amount;
    _percentage = percentage;
    _detail = detail;
    _discounttype = discounttype;
    _discountvalue = discountvalue;
    _rate = rate;
    _coupon_price = coupon_price;
    _total_price = total_price;
  }

  Coupon.fromJson(dynamic json) {
    _id = json['id'];
    _app_client_id = json['app_client_id'];
    _name = json['name'];
    _coupon_code = json['coupon_code'];
    _coupon_for = json['coupon_for'];
    _coupon_id = json['coupon_id'];
    _image = json['image'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _startdate = json['startdate'];
    _enddate = json['enddate'];
    _person = json['person'];
    _amount = json['amount'];
    _percentage = json['percentage'];
    _detail = json['detail'];
    _discounttype = json['discounttype'];
    _discountvalue = json['discountvalue'];
    _rate = json['rate'];
    _total_price = double.tryParse(json['total_price'].toString());
    _coupon_price = double.tryParse(json['coupon_price'].toString());
  }

  String? _id;
  String? _app_client_id;
  String? _name;
  String? _coupon_code;
  String? _coupon_for;
  String? _coupon_id;
  String? _image;
  String? _rate;

  String? get id => _id;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _startdate;
  String? _enddate;
  String? _person;
  String? _amount;
  String? _percentage;
  String? _detail;
  String? _discounttype;
  String? _discountvalue;
  double? _total_price;
  double? _coupon_price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _app_client_id;
    map['name'] = _name;
    map['coupon_code'] = _coupon_code;
    map['coupon_for'] = _coupon_for;
    map['coupon_id'] = _coupon_id;
    map['image'] = _image;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['startdate'] = _startdate;
    map['enddate'] = _enddate;
    map['person'] = _person;
    map['amount'] = _amount;
    map['percentage'] = _percentage;
    map['detail'] = _detail;
    map['discounttype'] = _discounttype;
    map['discountvalue'] = _discountvalue;
    map['rate'] = _rate;
    map['total_price'] = _total_price;
    map['coupon_price'] = _coupon_price;
    return map;
  }

  String? get app_client_id => _app_client_id;

  String? get name => _name;
  String? get coupon_code => _coupon_code;
  String? get coupon_for => _coupon_for;
  String? get coupon_id => _coupon_id;

  String? get image => _image;

  String? get status => _status;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get startdate => _startdate;

  String? get enddate => _enddate;

  String? get person => _person;

  String? get amount => _amount;

  String? get percentage => _percentage;

  String? get detail => _detail;

  String? get discounttype => _discounttype;

  String? get discountvalue => _discountvalue;
  String? get rate => _rate;
  double? get coupon_price => _coupon_price;
  double? get total_price => _total_price;
}
