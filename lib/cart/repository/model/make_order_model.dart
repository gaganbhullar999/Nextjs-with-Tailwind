import 'package:medilabs/dashboard/repository/model/get_home_data_response.dart';
import 'package:intl/intl.dart';
/// userid : "3"
/// orderfor : "self"
/// name : "Sourabh Tiwar"
/// mobile : "958432225"
/// email : "surabhtiwary@gmail.com"
/// age : "29"
/// gender : "Male"
/// address : "Indore"
/// landmark : "Indore"
/// pincode : "452002"
/// country : "India"
/// state : "Madhya Pradesh"
/// city : "Indore"
/// latitude : "42.5666"
/// longitude : "22.5555"
/// family_history : [{"id":"1","name":"Hypertension","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Aastma","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]
/// personal_history : [{"id":"1","name":"Smoking","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Alcohol","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]
/// allergies : [{"id":"1","name":"Thyroid disorder ","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Fever","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]
/// prescription_file : ""
/// previous_report_file : ""
/// medical_condition_file : ""
/// other_file : ""
/// payment_mode : "online"
/// subtotal : "1000"
/// cgst : "0"
/// sgst : "0"
/// igst : "0"
/// finalamount : "1000"
/// orderitem : [{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"1000","quantity":"2","subtotal":"2000","cgst":"2","sgst":"2","igst":"2","finalamount":"2","testimage":"","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":"","categoryname":"test3","subcategoryname":"subtest2"}]

class MakeOrderModel {


  MakeOrderModel({
      String? userid,
    String? bookby_name,
    String? bookby_mobile,
    String? bookby_email,
      String? orderfor,

    String? name,
      String? mobile,
    String? othermobile,
    String? email,
      String? age, 
      String? gender, 
      String? address, 
      String? landmark, 
      String? pincode, 
      String? country, 
      String? state, 
      String? city, 
      String? latitude, 
      String? longitude, 
      List<Family_history>? familyHistory, 
      List<Personal_history>? personalHistory, 
      List<Allergies>? allergies, 
      String? prescriptionFile, 
      String? previousReportFile, 
      String? medicalConditionFile, 
      String? otherFile, 
      String? paymentMode, 
      String? subtotal, 
      String? cgst, 
      String? sgst, 
      String? igst, 
      String? finalamount,
      String? paymentorderid,
      String? paymenttokan,
      String? transaction_id,
    String? payment_signature,
    String? payment_gateway_mode,
    String? payment_by_id,
    String? payment_status,
    String? payment_date,
    List<Orderitem>? orderitem,
    String? colletiondate,
    String? couponcodeid,
    String? colletiontime,String? couponcode,String? amounttype,
    String? couponamount,String? amountwithoutcoupon,
    String? coupondiscountamount}){
    _userid = userid;
    _bookby_name=bookby_name;
    _bookby_mobile=bookby_mobile;
    _bookby_email=bookby_email;
    _orderfor = orderfor;
    _name = name;
    _mobile = mobile;
    _othermobile=othermobile;
    _email = email;
    _age = age;
    _gender = gender;
    _address = address;
    _landmark = landmark;
    _pincode = pincode;
    _country = country;
    _state = state;
    _city = city;
    _latitude = latitude;
    _longitude = longitude;
    _familyHistory = familyHistory;
    _personalHistory = personalHistory;
    _allergies = allergies;
    _prescriptionFile = prescriptionFile;
    _previousReportFile = previousReportFile;
    _medicalConditionFile = medicalConditionFile;
    _otherFile = otherFile;
    _paymentMode = paymentMode;
    _subtotal = subtotal;
    _cgst = cgst;
    _sgst = sgst;
    _igst = igst;
    _finalamount = finalamount;
    _orderitem = orderitem;
    _paymentorderid = paymentorderid;
    _paymenttokan = paymenttokan;
    _transaction_id = transaction_id;
    _payment_signature= payment_signature;
    _payment_gateway_mode= payment_gateway_mode;
    _payment_by_id=payment_by_id;
    _payment_status=payment_status;
    _payment_date=payment_date;
  _colletiondate=colletiondate;
    _colletiontime=colletiontime;
    _couponcode=couponcode;
    _amounttype=amounttype;
    _couponamount=couponamount;
    _amountwithoutcoupon=amountwithoutcoupon;
    _coupondiscountamount= coupondiscountamount;
    _couponcodeid=couponcodeid;
}

  MakeOrderModel.fromJson(dynamic json) {
    _userid = json['userid'];
    _orderfor = json['orderfor'];
    _name = json['name'];
    _bookby_name=json['bookby_name'];
    _bookby_mobile=json['bookby_mobile'];
    _bookby_email=json['bookby_email'];
    _mobile = json['mobile'];
    _othermobile=json['othermobile'];
    _email = json['email'];
    _age = json['age'];
    _gender = json['gender'];
    _address = json['address'];
    _landmark = json['landmark'];
    _pincode = json['pincode'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _paymentorderid = json['paymentorderid'];
    _paymenttokan = json['paymenttokan'];
    _transaction_id = json['transaction_id'];
    _payment_signature = json['payment_signature'];
    _payment_gateway_mode = json['payment_gateway_mode'];
    _payment_by_id = json['payment_by_id'];
    _payment_status= json['payment_status'];
    _payment_date=json['payment_date'];
    if (json['family_history'] != null) {
      _familyHistory = [];
      json['family_history'].forEach((v) {
        _familyHistory?.add(Family_history.fromJson(v));
      });
    }
    if (json['personal_history'] != null) {
      _personalHistory = [];
      json['personal_history'].forEach((v) {
        _personalHistory?.add(Personal_history.fromJson(v));
      });
    }
    if (json['allergies'] != null) {
      _allergies = [];
      json['allergies'].forEach((v) {
        _allergies?.add(Allergies.fromJson(v));
      });
    }
    _prescriptionFile = json['prescription_file'];
    _previousReportFile = json['previous_report_file'];
    _medicalConditionFile = json['medical_condition_file'];
    _otherFile = json['other_file'];
    _paymentMode = json['payment_mode'];
    _subtotal = json['subtotal'];
    _cgst = json['cgst'];
    _sgst = json['sgst'];
    _igst = json['igst'];
    _colletiondate=json['colletiondate'];
    _colletiontime=json['colletiontime'];
    _couponcode=json['couponcode'];
    _amounttype=json['amounttype'];
    _couponamount=json['couponamount'];
    _couponcodeid=json['couponcodeid'];
    _amountwithoutcoupon=json['amountwithoutcoupon'];
_coupondiscountamount=json[' coupondiscountamount'];
    _finalamount = json['finalamount'];
    if (json['orderitem'] != null) {
      _orderitem = [];
      json['orderitem'].forEach((v) {
        _orderitem?.add(Orderitem.fromJson(v));
      });
    }
  }
  String? _userid;
  String? _orderfor;
  String? _bookby_name;
  String? _bookby_mobile;
  String? _bookby_email;
  String? _name;
  String? _mobile;
  String? _othermobile;
  String? _email;
  String? _age;
  String? _gender;
  String? _address;
  String? _landmark;
  String? _pincode;
  String? _country;
  String? _state;
  String? _city;
  String? _latitude;
  String? _longitude;
  List<Family_history>? _familyHistory;
  List<Personal_history>? _personalHistory;
  List<Allergies>? _allergies;
  String? _prescriptionFile;
  String? _previousReportFile;
  String? _medicalConditionFile;
  String? _otherFile;
  String? _paymentMode;
  String? _subtotal;
  String? _cgst;
  String? _sgst;
  String? _igst;
  String? _finalamount;
  String?  _paymentorderid;
  String?  _paymenttokan;
  String?  _transaction_id ;
  String? _payment_signature;
  String? _payment_gateway_mode;
  String? _payment_by_id;
  String? _payment_status;
  String? _payment_date;
  List<Orderitem>? _orderitem;
  String? _colletiondate;
  String? _colletiontime;
  String? _couponcodeid;
  String? _couponcode;
  String? _amounttype;
String? _coupondiscountamount;

  String? get coupondiscountamount => _coupondiscountamount;

  String? get couponcodeid=> _couponcodeid;

  set couponcodeid(String? value){
    _couponcodeid=value;
  }
  set coupondiscountamount(String? value) {
    _coupondiscountamount = value;
  }

  String? get couponcode => _couponcode;

  set couponcode(String? value) {
    _couponcode = value;
  }

  String? _couponamount;
  String? _amountwithoutcoupon;

  String? get colletiondate=> _colletiondate;//DateFormat("dd-MM-yyyy").format(DateTime.parse(_colletiondate!));//_colletiondate;
  String? get colletiontime=>_colletiontime;
  String? get userid => _userid;
  String? get orderfor => _orderfor;
  String? get name => _name;
  String? get bookby_name => _bookby_name;
  String? get bookby_mobile => _bookby_mobile;
  String? get bookby_email => _bookby_email;
  String? get mobile => _mobile;
  String? get othermobile=>_othermobile;
  String? get email => _email;
  String? get age => _age;
  String? get gender => _gender;
  String? get address => _address;
  String? get landmark => _landmark;
  String? get pincode => _pincode;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  List<Family_history>? get familyHistory => _familyHistory;
  List<Personal_history>? get personalHistory => _personalHistory;
  List<Allergies>? get allergies => _allergies;
  String? get prescriptionFile => _prescriptionFile;
  String? get previousReportFile => _previousReportFile;
  String? get medicalConditionFile => _medicalConditionFile;
  String? get otherFile => _otherFile;
  String? get paymentMode => _paymentMode;
  String? get subtotal => _subtotal;
  String? get cgst => _cgst;
  String? get sgst => _sgst;
  String? get igst => _igst;
  String? get finalamount => _finalamount;
  String? get paymentorderid => _paymentorderid;
  String? get paymenttokan => _paymenttokan;
  String? get transaction_id => _transaction_id;
  String? get payment_signature =>  _payment_signature;
  String? get payment_gateway_mode => _payment_gateway_mode;
  String? get payment_by_id => _payment_by_id;
  String? get payment_status =>  _payment_status;
  String? get payment_date=> _payment_date;


  List<Orderitem>? get orderitem => _orderitem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userid'] = _userid;
    map['orderfor'] = _orderfor;
    map['name'] = _name;
    map['bookby_name'] = _bookby_name;
    map['bookby_mobile'] = _bookby_mobile;
    map['bookby_email'] = _bookby_email;

    map['mobile'] = _mobile;
    map['othermobile']=_othermobile;
    map['email'] = _email;
    map['age'] = _age;
    map['gender'] = _gender;
    map['address'] = _address;
    map['landmark'] = _landmark;
    map['pincode'] = _pincode;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    if (_familyHistory != null) {
      map['family_history'] = _familyHistory?.map((v) => v.toJson()).toList();
    }
    if (_personalHistory != null) {
      map['personal_history'] = _personalHistory?.map((v) => v.toJson()).toList();
    }
    if (_allergies != null) {
      map['allergies'] = _allergies?.map((v) => v.toJson()).toList();
    }
    map['prescription_file'] = _prescriptionFile;
    map['previous_report_file'] = _previousReportFile;
    map['medical_condition_file'] = _medicalConditionFile;
    map['other_file'] = _otherFile;
    map['payment_mode'] = _paymentMode;
    map['subtotal'] = _subtotal;
    map['cgst'] = _cgst;
    map['sgst'] = _sgst;
    map['igst'] = _igst;
    map['finalamount'] = _finalamount;
    map['paymentorderid'] = _paymentorderid;
    map['paymenttokan'] = _paymenttokan;
    map['transaction_id'] = _transaction_id;
    map['payment_signature'] =  _payment_signature;
    map['payment_gateway_mode'] =  _payment_gateway_mode;
    map['payment_by_id'] =  _payment_by_id;
    map['payment_status'] =  _payment_status;
    map['payment_date'] =  _payment_date;
map['colletiondate']=_colletiondate;
map['colletiontime']=_colletiontime;
map['couponcodeid']=_couponcodeid;
    map['couponcode']=_couponcode;
    map['amounttype']=_amounttype;
    map['couponamount']=_couponamount;
    map['amountwithoutcoupon']=_amountwithoutcoupon;
  map['coupondiscountamount']=_coupondiscountamount;
    if (_orderitem != null) {
      map['orderitem'] = _orderitem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set colletiondate(String? value){
    _colletiondate=value;
  }

  set colletiontime(String? value){
    _colletiontime=value;
  }
  set
  orderitem(List<Orderitem>? value) {
    _orderitem = value;
  }

  set finalamount(String? value) {
    _finalamount = value;
  }

  set paymentorderid(String? value) {
    _paymentorderid = value;
  }

  set transaction_id(String? value) {
    _transaction_id = value;
  }

  set payment_status(String? value) {
    _payment_status = value;
  }


  set payment_signature(String? value) {
    _payment_signature = value;
  }

  set payment_gateway_mode(String? value) {
    _payment_gateway_mode = value;
  }

  set payment_by_id(String? value) {
    _payment_by_id = value;
  }
  set payment_date(String? value) {
    _payment_date = value;
  }

  set paymenttokan(String? value) {
    _paymenttokan = value;
  }

  set igst(String? value) {
    _igst = value;
  }

  set sgst(String? value) {
    _sgst = value;
  }

  set cgst(String? value) {
    _cgst = value;
  }

  set subtotal(String? value) {
    _subtotal = value;
  }

  set paymentMode(String? value) {
    _paymentMode = value;
  }

  set otherFile(String? value) {
    _otherFile = value;
  }

  set medicalConditionFile(String? value) {
    _medicalConditionFile = value;
  }

  set previousReportFile(String? value) {
    _previousReportFile = value;
  }

  set prescriptionFile(String? value) {
    _prescriptionFile = value;
  }

  set allergies(List<Allergies>? value) {
    _allergies = value;
  }

  set personalHistory(List<Personal_history>? value) {
    _personalHistory = value;
  }

  set familyHistory(List<Family_history>? value) {
    _familyHistory = value;
  }

  set longitude(String? value) {
    _longitude = value;
  }

  set latitude(String? value) {
    _latitude = value;
  }

  set city(String? value) {
    _city = value;
  }

  set state(String? value) {
    _state = value;
  }

  set country(String? value) {
    _country = value;
  }

  set pincode(String? value) {
    _pincode = value;
  }

  set landmark(String? value) {
    _landmark = value;
  }

  set address(String? value) {
    _address = value;
  }

  set gender(String? value) {
    _gender = value;
  }

  set age(String? value) {
    _age = value;
  }

  set email(String? value) {
    _email = value;
  }

  set mobile(String? value) {
    _mobile = value;
  }
  set othermobile(String? value){
    _othermobile=value;
  }

  set name(String? value) {
    _name = value;
  }

  set bookby_name(String? value) {
    _bookby_name = value;
  }

  set bookby_mobile(String? value) {
    _bookby_mobile = value;
  }


  set bookby_email(String? value) {
    _bookby_email = value;
  }


  set orderfor(String? value) {
    _orderfor = value;
  }

  set userid(String? value) {
    _userid = value;
  }

  @override
  String toString() {
    return 'MakeOrderModel{_userid: $_userid, _orderfor: $_orderfor, _name: $_name, _mobile: $_mobile,'
        ' _email: $_email, _age: $_age, _gender: $_gender, _address: $_address, _landmark: $_landmark,'
        ' _pincode: $_pincode, _country: $_country, _state: $_state, _city: $_city, _latitude: $_latitude,'
        ' _longitude: $_longitude, _familyHistory: $_familyHistory, _personalHistory: $_personalHistory, '
        '_allergies: $_allergies, _prescriptionFile: $_prescriptionFile, _previousReportFile: $_previousReportFile,'
        ' _medicalConditionFile: $_medicalConditionFile, _otherFile: $_otherFile, _paymentMode: $_paymentMode, '
        '_subtotal: $_subtotal, _cgst: $_cgst, _sgst: $_sgst, _igst: $_igst, _finalamount: $_finalamount,'
        ' _orderitem: $_orderitem}';
  }

  String? get amounttype => _amounttype;

  set amounttype(String? value) {
    _amounttype = value;
  }

  String? get couponamount => _couponamount;

  set couponamount(String? value) {
    _couponamount = value;
  }

  String? get amountwithoutcoupon => _amountwithoutcoupon;

  set amountwithoutcoupon(String? value) {
    _amountwithoutcoupon = value;
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
/// display_price : "1000"
/// quantity : "2"
/// subtotal : "2000"
/// cgst : "2"
/// sgst : "2"
/// igst : "2"
/// finalamount : "2"
/// testimage : ""
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

class Orderitem {
  Orderitem({
      String? id, 
      String? categoryId, 
      String? subcategoryId, 
      String? testname, 
      String? vendorPrice, 
      String? medilabsPrice, 
      String? totalPrice, 
      String? discount, 
      String? displayPrice, 
      String? quantity, 
      String? subtotal, 
      String? cgst, 
      String? sgst, 
      String? igst, 
      String? finalamount, 
      String? testimage, 
      String? description, 
      String? status, 
      String? addedon, 
      String? addedby, 
      String? updatedOn, 
      String? updatedBy, 
      String? appClientId, 
      String? image, 
      String? categoryname,
      String? itemtype,
      List<Tests>? packagetest,
      String? subcategoryname,}){
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _testname = testname;
    _vendorPrice = vendorPrice;
    _medilabsPrice = medilabsPrice;
    _totalPrice = totalPrice;
    _discount = discount;
    _displayPrice = displayPrice;
    _quantity = quantity;
    _subtotal = subtotal;
    _cgst = cgst;
    _sgst = sgst;
    _igst = igst;
    _finalamount = finalamount;
    _testimage = testimage;
    _description = description;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
    _appClientId = appClientId;
    _image = image;
    _categoryname = categoryname;
    _itemtype=itemtype;
    _packagetest=packagetest;
    _subcategoryname = subcategoryname;

}

  Orderitem.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _testname = json['testname'];
    _vendorPrice = json['vendor_price'];
    _medilabsPrice = json['medilabs_price'];
    _totalPrice = json['total_price'];
    _discount = json['discount'];
    _displayPrice = json['display_price'];
    _quantity = json['quantity'];
    _subtotal = json['subtotal'];
    _cgst = json['cgst'];
    _sgst = json['sgst'];
    _igst = json['igst'];
    _finalamount = json['finalamount'];
    _testimage = json['testimage'];
    _description = json['description'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
    _appClientId = json['app_client_id'];
    _image = json['image'];
    _categoryname = json['categoryname'];
    _subcategoryname = json['subcategoryname'];
    _itemtype=json['itemtype'];
    if (json['packagetest'] != null) {
      _packagetest = [];
      json['packagetest'].forEach((v) {
        _packagetest?.add(Tests.fromJson(v));
      });
    }
  }
  String? _id;
  String? _categoryId;
  String? _subcategoryId;
  String? _testname;
  String? _vendorPrice;
  String? _medilabsPrice;
  String? _totalPrice;
  String? _discount;
  String? _displayPrice;
  String? _quantity;
  String? _subtotal;
  String? _cgst;
  String? _sgst;
  String? _igst;
  String? _finalamount;
  String? _testimage;
  String? _description;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _updatedOn;
  String? _updatedBy;
  String? _appClientId;
  String? _image;
  String? _categoryname;
  String? _subcategoryname;
  String ? _itemtype;
List<Tests>? _packagetest;

  List<Tests>? get packagetest=>_packagetest;
  String? get id => _id;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get testname => _testname;
  String? get vendorPrice => _vendorPrice;
  String? get medilabsPrice => _medilabsPrice;
  String? get totalPrice => _totalPrice;
  String? get discount => _discount;
  String? get displayPrice => _displayPrice;
  String? get quantity => _quantity;
  String? get subtotal => _subtotal;
  String? get cgst => _cgst;
  String? get sgst => _sgst;
  String? get igst => _igst;
  String? get finalamount => _finalamount;
  String? get testimage => _testimage;
  String? get description => _description;
  String? get status => _status;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get updatedOn => _updatedOn;
  String? get updatedBy => _updatedBy;
  String? get appClientId => _appClientId;
  String? get image => _image;
  String? get categoryname => _categoryname;
  String? get subcategoryname => _subcategoryname;
String? get itemtype => _itemtype;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['testname'] = _testname;
    map['vendor_price'] = _vendorPrice;
    map['medilabs_price'] = _medilabsPrice;
    map['total_price'] = _totalPrice;
    map['discount'] = _discount;
    map['display_price'] = _displayPrice;
    map['quantity'] = _quantity;
    map['subtotal'] = _subtotal;
    map['cgst'] = _cgst;
    map['sgst'] = _sgst;
    map['igst'] = _igst;
    map['finalamount'] = _finalamount;
    map['testimage'] = _testimage;
    map['description'] = _description;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    map['app_client_id'] = _appClientId;
    map['image'] = _image;
    map['categoryname'] = _categoryname;
    map['subcategoryname'] = _subcategoryname;
    map['itemtype']=_itemtype;
    if (_packagetest != null) {
      map['packagetest'] = _packagetest?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set packagetest(List<Tests>? value){
    _packagetest=value;
  }
  set id(String? value) {
    _id = value;
  }
  set categoryId(String? value) {
    _categoryId = value;
  }

  set itemtype(String? value){
    _itemtype=value;
  }
  set subcategoryId(String? value) {
    _subcategoryId = value;
  }

  set testname(String? value) {
    _testname = value;
  }

  set vendorPrice(String? value) {
    _vendorPrice = value;
  }

  set medilabsPrice(String? value) {
    _medilabsPrice = value;
  }

  set totalPrice(String? value) {
    _totalPrice = value;
  }

  set discount(String? value) {
    _discount = value;
  }

  set displayPrice(String? value) {
    _displayPrice = value;
  }

  set quantity(String? value) {
    _quantity = value;
  }

  set subtotal(String? value) {
    _subtotal = value;
  }

  set cgst(String? value) {
    _cgst = value;
  }

  set sgst(String? value) {
    _sgst = value;
  }

  set igst(String? value) {
    _igst = value;
  }

  set finalamount(String? value) {
    _finalamount = value;
  }

  set testimage(String? value) {
    _testimage = value;
  }

  set description(String? value) {
    _description = value;
  }

  set status(String? value) {
    _status = value;
  }

  set addedon(String? value) {
    _addedon = value;
  }

  set addedby(String? value) {
    _addedby = value;
  }

  set updatedOn(String? value) {
    _updatedOn = value;
  }

  set updatedBy(String? value) {
    _updatedBy = value;
  }

  set appClientId(String? value) {
    _appClientId = value;
  }

  set image(String? value) {
    _image = value;
  }

  set categoryname(String? value) {
    _categoryname = value;
  }

  set subcategoryname(String? value) {
    _subcategoryname = value;
  }

  @override
  String toString() {
    return 'Orderitem{_id: $_id, _categoryId: $_categoryId, _subcategoryId: $_subcategoryId, _testname: $_testname, _vendorPrice: $_vendorPrice, _medilabsPrice: $_medilabsPrice, _totalPrice: $_totalPrice, _discount: $_discount, _displayPrice: $_displayPrice, _quantity: $_quantity, _subtotal: $_subtotal, _cgst: $_cgst, _sgst: $_sgst, _igst: $_igst, _finalamount: $_finalamount, _testimage: $_testimage, _description: $_description, _status: $_status, _addedon: $_addedon, _addedby: $_addedby, _updatedOn: $_updatedOn, _updatedBy: $_updatedBy, _appClientId: $_appClientId, _image: $_image, _categoryname: $_categoryname, _subcategoryname: $_subcategoryname,_itemtype: $_itemtype}';
  }
}

/// id : "1"
/// name : "Thyroid disorder "
/// detail : ""
/// addedon : "2022-01-03 13:31:02"
/// addedby : "0"
/// status : "1"
/// app_client_id : "1"

class TimeSlot{
  TimeSlot({
  String? name,
  String? time
}){
    _name=name;
    _time=time;
  }

  TimeSlot.fromJson(dynamic json) {
    _name = json['name'];
    _time = json['time'];
  }
  String? _time;
  String? _name;
  String? get time => _time;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['name'] = _name;
    return map;
  }


}

class Allergies {


  Allergies({
      String? id, 
      String? name, 
      String? detail, 
      String? addedon, 
      String? addedby, 
      String? status, 
      String? appClientId,}){
    _id = id;
    _name = name;
    _detail = detail;
    _addedon = addedon;
    _addedby = addedby;
    _status = status;
    _appClientId = appClientId;
}

  Allergies.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _detail = json['detail'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _status = json['status'];
    _appClientId = json['app_client_id'];
  }
  String? _id;
  String? _name;
  String? _detail;
  String? _addedon;
  String? _addedby;
  String? _status;
  String? _appClientId;

  String? get id => _id;
  String? get name => _name;
  String? get detail => _detail;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get status => _status;
  String? get appClientId => _appClientId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['detail'] = _detail;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['status'] = _status;
    map['app_client_id'] = _appClientId;
    return map;
  }

  @override
  String toString() {
    return 'Allergies{_id: $_id, _name: $_name, _detail: $_detail, _addedon: $_addedon, _addedby: $_addedby, _status: $_status, _appClientId: $_appClientId}';
  }
}

/// id : "1"
/// name : "Smoking"
/// detail : ""
/// addedon : "2022-01-03 13:31:02"
/// addedby : "0"
/// status : "1"
/// app_client_id : "1"

class Personal_history {


  Personal_history({
      String? id, 
      String? name, 
      String? detail, 
      String? addedon, 
      String? addedby, 
      String? status, 
      String? appClientId,}){
    _id = id;
    _name = name;
    _detail = detail;
    _addedon = addedon;
    _addedby = addedby;
    _status = status;
    _appClientId = appClientId;
}

  Personal_history.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _detail = json['detail'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _status = json['status'];
    _appClientId = json['app_client_id'];
  }
  String? _id;
  String? _name;
  String? _detail;
  String? _addedon;
  String? _addedby;
  String? _status;
  String? _appClientId;

  String? get id => _id;
  String? get name => _name;
  String? get detail => _detail;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get status => _status;
  String? get appClientId => _appClientId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['detail'] = _detail;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['status'] = _status;
    map['app_client_id'] = _appClientId;
    return map;
  }

  @override
  String toString() {
    return 'Personal_history{_id: $_id, _name: $_name, _detail: $_detail, _addedon: $_addedon, _addedby: $_addedby, _status: $_status, _appClientId: $_appClientId}';
  }
}

/// id : "1"
/// name : "Hypertension"
/// detail : ""
/// addedon : "2022-01-03 13:31:02"
/// addedby : "0"
/// status : "1"
/// app_client_id : "1"

class Family_history {


  Family_history({
      String? id, 
      String? name, 
      String? detail, 
      String? addedon, 
      String? addedby, 
      String? status, 
      String? appClientId,}){
    _id = id;
    _name = name;
    _detail = detail;
    _addedon = addedon;
    _addedby = addedby;
    _status = status;
    _appClientId = appClientId;
}

  Family_history.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _detail = json['detail'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _status = json['status'];
    _appClientId = json['app_client_id'];
  }
  String? _id;
  String? _name;
  String? _detail;
  String? _addedon;
  String? _addedby;
  String? _status;
  String? _appClientId;

  String? get id => _id;
  String? get name => _name;
  String? get detail => _detail;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get status => _status;
  String? get appClientId => _appClientId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['detail'] = _detail;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['status'] = _status;
    map['app_client_id'] = _appClientId;
    return map;
  }

  @override
  String toString() {
    return 'Family_history{_id: $_id, _name: $_name, _detail: $_detail, _addedon: $_addedon, _addedby: $_addedby, _status: $_status, _appClientId: $_appClientId}';
  }
}