/// success : true
/// message : "Order found"
/// data : [{"id":"16","app_client_id":"1","userid":"4","orderfor":"self","name":"Sourabh Tiwar","mobile":"958432225","email":"surabhtiwary@gmail.com","age":"29","gender":"Male","address":"Indore","landmark":"Indore","pincode":"452002","country":"India","state":"Madhya Pradesh","city":"Indore","latitude":"42.5666","longitude":"22.5555","family_history":[{"id":"1","name":"Hypertension","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Aastma","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}],"personal_history":[{"id":"1","name":"Smoking","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Alcohol","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}],"allergies":[{"id":"1","name":"Thyroid disorder ","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Fever","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}],"prescription_file":"","previous_report_file":"","medical_condition_file":"","other_file":"","payment_mode":"online","subtotal":"1000","cgst":"0","sgst":"0","igst":"0","finalamount":"1000","payment_status":"Pending","transaction_id":"","payment_date":"0000-00-00","payment_by":"","status":"1","addedon":"2022-01-07 13:37:01","addedby":"0","vendorid":"0","orderitem":[{"id":"8","app_client_id":"1","userid":"4","orderid":"16","testitemid":"2","quantity":"2","rate":"1000","subtotal":"2000","cgst":"2","sgst":"2","igst":"2","finalamount":"2","addedon":"2022-01-07 13:37:01","addedby":"0","testdoneon":"0000-00-00 00:00:00","testdoneby":"0","status":"1","vendor_price":"500","medilabs_price":"500","discount":"10","display_price":"1000","total_price":"1000","test":[{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"950","testimage":"","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":""}]}]}]
import 'package:intl/intl.dart';
class GetAllOrderResponse {
  GetAllOrderResponse({
      bool? success, 
      String? message, 
      List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  GetAllOrderResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : "16"
/// app_client_id : "1"
/// userid : "4"
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
/// payment_status : "Pending"
/// transaction_id : ""
/// payment_date : "0000-00-00"
/// payment_by : ""
/// status : "1"
/// addedon : "2022-01-07 13:37:01"
/// addedby : "0"
/// vendorid : "0"
/// orderitem : [{"id":"8","app_client_id":"1","userid":"4","orderid":"16","testitemid":"2","quantity":"2","rate":"1000","subtotal":"2000","cgst":"2","sgst":"2","igst":"2","finalamount":"2","addedon":"2022-01-07 13:37:01","addedby":"0","testdoneon":"0000-00-00 00:00:00","testdoneby":"0","status":"1","vendor_price":"500","medilabs_price":"500","discount":"10","display_price":"1000","total_price":"1000","test":[{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"950","testimage":"","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":""}]}]

class Data {
  Data({
      String? id, 
      String? appClientId, 
      String? userid, 
      String? orderfor, 
      String? name, 
      String? mobile, 
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
      String? paymentStatus, 
      String? transactionId, 
      String? paymentDate, 
      String? paymentBy, 
      String? status, 
      String? addedon, 
      String? addedby, 
      String? vendorid, 
      List<Orderitem>? orderitem,
        Accepton? accepton,
    String? personal_history_text,
    Rating? rating,String? colletiondate, String? colletiontime,String? testnmed_file
      }){
    _id = id;
    _appClientId = appClientId;
    _userid = userid;
    _orderfor = orderfor;
    _name = name;
    _mobile = mobile;
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
    _paymentStatus = paymentStatus;
    _transactionId = transactionId;
    _paymentDate = paymentDate;
    _paymentBy = paymentBy;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _vendorid = vendorid;
    _orderitem = orderitem;
    _accepton=accepton;
    _rating=rating;
    _colletiondate=colletiondate;
    _colletiontime=colletiontime;
    _testnmed_file=testnmed_file;
    personal_history_text=_personal_history_text;

}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _userid = json['userid'];
    _orderfor = json['orderfor'];
    _name = json['name'];
    _mobile = json['mobile'];
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
    _finalamount = json['finalamount'];
    _paymentStatus = json['payment_status'];
    _transactionId = json['transaction_id'];
    _paymentDate = json['payment_date'];
    _paymentBy = json['payment_by'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _vendorid = json['vendorid'];
    _colletiondate=json['colletiondate'];
    _colletiontime=json['colletiontime'];
    _testnmed_file=json['testnmed_file'];
    _personal_history_text=json['personal_history_text'];
    if (json['orderitem'] != null) {
      _orderitem = [];
      json['orderitem'].forEach((v) {
        _orderitem?.add(Orderitem.fromJson(v));
      });
    }
    if (json['accepton'] != null) {
      _accepton = Accepton.fromJson(json['accepton']);
    }
    if (json['rating'] != null) {
      _rating = Rating.fromJson(json['rating']);
    }
  }
  String? _id;
  String? _appClientId;
  String? _userid;
  String? _orderfor;
  String? _name;
  String? _mobile;
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
  String? _paymentStatus;
  String? _transactionId;
  String? _paymentDate;
  String? _paymentBy;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _vendorid;
  List<Orderitem>? _orderitem;
  Accepton ? _accepton;
  Rating? _rating;
  String? _colletiondate;
  String? _colletiontime;
  String? _testnmed_file;
  String? _personal_history_text;
  String? get personal_history_text=>_personal_history_text;

  String? get getcolletiondate=>DateFormat("dd-MM-yyyy").format(DateTime.parse(_colletiondate!)); //_colletiondate;

  String?get testnmed_file=>_testnmed_file;
  String? get colletiondate=>_colletiondate!; //_colletiondate;
  String? get colletiontime=>_colletiontime;
  String? get id => _id;
  String? get appClientId => _appClientId;
  String? get userid => _userid;
  String? get orderfor => _orderfor;
  String? get name => _name;
  String? get mobile => _mobile;
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
  String? get paymentStatus => _paymentStatus;
  String? get transactionId => _transactionId;
  String? get paymentDate => _paymentDate;
  String? get paymentBy => _paymentBy;
  String? get status => _status;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get vendorid => _vendorid;


  List<Orderitem>? get orderitem => _orderitem;
  Accepton? get accepton=>_accepton;
  Rating? get rating=>_rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _appClientId;
    map['userid'] = _userid;
    map['orderfor'] = _orderfor;
    map['name'] = _name;
    map['mobile'] = _mobile;
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
    map['payment_status'] = _paymentStatus;
    map['transaction_id'] = _transactionId;
    map['payment_date'] = _paymentDate;
    map['payment_by'] = _paymentBy;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['vendorid'] = _vendorid;
    map['colletiondate']=_colletiondate;
    map['colletiontime']=_colletiontime;
    map['testnmed_file']=_testnmed_file;
    map['personal_history_text']=_personal_history_text;
    if (_orderitem != null) {
      map['orderitem'] = _orderitem?.map((v) => v.toJson()).toList();
    }
    if (_accepton != null) {
      map['accepton'] = _accepton;
      // map['accepton'] = _accepton?.map((v) => v.toJson());

    }
    if(_rating!=null){
      map['rating']=_rating;
    }
    return map;
  }

}

/// id : "8"
/// app_client_id : "1"
/// userid : "4"
/// orderid : "16"
/// testitemid : "2"
/// quantity : "2"
/// rate : "1000"
/// subtotal : "2000"
/// cgst : "2"
/// sgst : "2"
/// igst : "2"
/// finalamount : "2"
/// addedon : "2022-01-07 13:37:01"
/// addedby : "0"
/// testdoneon : "0000-00-00 00:00:00"
/// testdoneby : "0"
/// status : "1"
/// vendor_price : "500"
/// medilabs_price : "500"
/// discount : "10"
/// display_price : "1000"
/// total_price : "1000"
/// test : [{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"950","testimage":"","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":""}]

class VendorUser{
  VendorUser({
    String? id,
    String? app_client_id,
    String? vendor_id,
    String? name,
    String? lastname,
    String? fullname,
    String? joiningdate,
    String? fathername,
    String? gender,
    String? dob,
    String? bgroup,
    String? mobileno,
    String? official_mobileno,
    String? email,
    String? personal_email,
    String? ip,
    String? employeecode,
    String? panno,
    String? aadhar_no,
    String? password,
    String? addedon,
    String? addedby,
    String? status,
    String? maritalstatus,
    String? designationId,
    String? expiry,
    String? role,
    String? image,
}){
    _id=id;
    _app_client_id=app_client_id;
    _vendor_id=vendor_id;
    _name=name;
    _lastname=lastname;
    _fullname=fullname;
    _joiningdate=joiningdate;
    _fathername=fathername;
    _gender=gender;
    _dob=dob;
    _bgroup=bgroup;
    _mobileno=mobileno;
    _official_mobileno=official_mobileno;
    _email=email;
    _personal_email=personal_email;
    _ip=ip;
    _employeecode=employeecode;
    _panno=panno;
    _aadhar_no=aadhar_no;
    _password=password;
    _addedon=addedon;
    _addedby=addedby;
    _status=status;
    _maritalstatus=maritalstatus;
    _designationId=designationId;
    _expiry=expiry;
    _role=role;
    _image=image;
  }

  VendorUser.fromJson(dynamic json) {
    _id = json['id'];
    _app_client_id=json['app_client_id'];
    _vendor_id=json['vendor_id'];
    _name=json['name'];
    _lastname=json['lastname'];
    _fullname=json['fullname'];
    _joiningdate=json['joiningdate'];
    _fathername=json['fathername'];
    _gender=json['gender'];
    _dob=json['dob'];
    _bgroup=json['bgroup'];
    _mobileno=json['mobileno'];
    _official_mobileno=json['official_mobileno'];
    _email=json['email'];
    _personal_email=json['personal_email'];
    _ip=json['ip'];
    _employeecode=json['employeecode'];
    _panno=json['panno'];
    _aadhar_no=json['aadhar_no'];
    _password=json['password'];
    _addedon=json['addedon'];
    _addedby=json['addedby'];
    _status=json['status'];
    _maritalstatus=json['maritalstatus'];
    _designationId=json['designationId'];
    _expiry=json['expiry'];
    _role=json['role'];
    _image=json['image'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id']=_id;
    map['app_client_id']=_app_client_id;
    map['vendor_id']=_vendor_id;
    map['name']=_name;
    map['lastname']=_lastname;
    map['fullname']=_fullname;
    map['joiningdate']=_joiningdate;
    map['fathername']=_fathername;
    map['gender']=_gender;
    map['dob']=_dob;
    map['bgroup']=_bgroup;
    map['mobileno']=_mobileno;
    map['official_mobileno']=_official_mobileno;
    map['email']=_email;
    map['personal_email']=_personal_email;
    map['ip']=_ip;
    map['employeecode']=_employeecode;
    map['panno']=_panno;
    map['aadhar_no']=_aadhar_no;
    map['password']=_password;
    map['addedon']=_addedon;
    map['addedby']=_addedby;
    map['status']=_status;
    map['maritalstatus']=_maritalstatus;
    map['designationId']=_designationId;
    map['expiry']=_expiry;
    map['role']=_role;
    map['image']=_image;

    return map;
  }

  String? _id;
  String? _app_client_id;
  String? _vendor_id;
  String? _name;
  String? _lastname;
  String? _fullname;
  String? _joiningdate;
  String? _fathername;
  String? _gender;
  String? _dob;
  String? _bgroup;
  String? _mobileno;
  String? _official_mobileno;
  String? _email;
  String? _personal_email;
  String? _ip;
  String? _employeecode;


  String? _panno;
  String? _aadhar_no;
  String? _password;
  String? _addedon;
  String? _addedby;
  String? _status;
  String? _maritalstatus;
  String? _designationId;
  String? _expiry;
  String? _role;
  String? _image;
  String? get id => _id;
  String? get app_client_id => _app_client_id;

  String? get vendor_id => _vendor_id;

  String? get name => _name;

  String? get lastname => _lastname;

  String? get fullname => _fullname;

  String? get joiningdate => _joiningdate;

  String? get fathername => _fathername;

  String? get gender => _gender;

  String? get dob => _dob;

  String? get bgroup => _bgroup;

  String? get mobileno => _mobileno;

  String? get official_mobileno => _official_mobileno;

  String? get email => _email;

  String? get personal_email => _personal_email;

  String? get ip => _ip;

  String? get employeecode => _employeecode;

  String? get panno => _panno;

  String? get aadhar_no => _aadhar_no;

  String? get password => _password;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get status => _status;

  String? get maritalstatus => _maritalstatus;

  String? get designationId => _designationId;

  String? get expiry => _expiry;

  String? get role => _role;

  String? get image => _image;
}


class Vendor{
  Vendor({String? id,
    String? name,
    String? pathology_name,
    String? mobile,
    String? email,
    String? regno,
    String? pannum,
    String? bankname,
    String? bankaccno,
    String? ifsccode,
    String? address,
    String? servicedays,
    String? services,
    String? password,
    String? adhaar,
    String? document,
    String? agree,
    String? status: "1",
    String?  microbiologist_name,
    String? microbiologist_mobile,
    String? microbiologist_email,
    String? microbiologist_address,
    String? microbiologist_regno,
    String? microbiologist_adhaar,
    String? biochemist_name,
    String? biochemist_mobile,
    String? biochemist_email,
    String? biochemist_regno,
    String? biochemist_address,
    String? biochemist_adhaar,
    String? addedon,
    String? addedby,
    String? updated_on,
    String? updated_by,
    String? app_client_id,
    String? testids,
    String? city,
    String? latitude,
    String? longtitud,
    VendorUser? assignto

}){
    _id=id;
    _name=name;
    _pathology_name=pathology_name;
    _mobile=mobile;
    _email=email;
    _regno=regno;
    _pannum=pannum;
    _bankname=bankname;
    _bankaccno=bankaccno;
    _ifsccode=ifsccode;
    _address=address;
    _servicedays=servicedays;
    _services=services;
    _password=password;
    _adhaar=adhaar;
    _document=document;
    _agree=agree;
    _status=status;
    _microbiologist_name= microbiologist_name;
    _microbiologist_mobile=microbiologist_mobile;
    _microbiologist_email=microbiologist_email;
    _microbiologist_address=microbiologist_address;
    _microbiologist_regno=microbiologist_regno;
    _microbiologist_adhaar=microbiologist_adhaar;
    _biochemist_name=biochemist_name;
    _biochemist_mobile=biochemist_mobile;
    _biochemist_email=biochemist_email;
    _biochemist_regno=biochemist_regno;
    _biochemist_address=biochemist_address;
    _biochemist_adhaar=biochemist_adhaar;
    _addedon=addedon;
    _addedby=addedby;
    _updated_on=updated_on;
    _updated_by=updated_by;
    _app_client_id=app_client_id;
    _testids=testids;
    _city=city;
    _latitude=latitude;
    _longtitud=longtitud;
    _assignto=assignto;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id']=_id;
    map['name']=_name;
    map['pathology_name']=_pathology_name;
    map['mobile']=_mobile;
    map['email']=_email;
    map['regno']=_regno;
    map['pannum']=_pannum;
    map['bankname']=_bankname;
    map['bankaccno']=_bankaccno;
    map['ifsccode']=_ifsccode;
    map['address']=_address;
    map['servicedays']=_servicedays;
    map['services']=_services;
    map['password']=_password;
    map['adhaar']=_adhaar;
    map['document']=_document;
    map['agree']=_agree;
    map['status']=_status;
    map['microbiologist_name']=_microbiologist_name;
    map['microbiologist_mobile']=_microbiologist_mobile;
    map['microbiologist_email']=_microbiologist_email;
    map['microbiologist_address']=_microbiologist_address;
    map['microbiologist_regno']=_microbiologist_regno;
    map['microbiologist_adhaar']=_microbiologist_adhaar;
    map['biochemist_name']=_biochemist_name;
    map['biochemist_mobile']=_biochemist_mobile;
    map['biochemist_email']=_biochemist_email;
    map['biochemist_regno']=_biochemist_regno;
    map['biochemist_address']=_biochemist_address;
    map['biochemist_adhaar']=_biochemist_adhaar;
    map['addedon']=_addedon;
    map['addedby']=_addedby;
    map['updated_on']=_updated_on;
    map['updated_by']=_updated_by;
    map['app_client_id']=_app_client_id;
    map['testids']=_testids;
    map['city']=_city;
    map['latitude']=_latitude;
    map['longtitud']=_longtitud;
    map['assignto']=_assignto;
    if (_assignto != null) {
      map['assignto'] = _assignto?.toJson();
    }


    return map;
  }
  Vendor.fromJson(dynamic json) {
    _id=json['id'];
    _name=json['name'];
    _pathology_name=json['pathology_name'];
    _mobile=json['mobile'];
    _email=json['email'];
    _regno=json['regno'];
    _pannum=json['pannum'];
    _bankname=json['bankname'];
    _bankaccno=json['bankaccno'];
    _ifsccode=json['ifsccode'];
    _address=json['address'];
    _servicedays=json['servicedays'];
    _services=json['services'];
    _password=json['password'];
    _adhaar=json['adhaar'];
    _document=json['document'];
    _agree=json['agree'];
    _status=json['status'];
    _microbiologist_name=json['microbiologist_name'];
    _microbiologist_mobile=json['microbiologist_mobile'];
    _microbiologist_email=json['microbiologist_email'];
    _microbiologist_address=json['microbiologist_address'];
    _microbiologist_regno=json['microbiologist_regno'];
    _microbiologist_adhaar=json['microbiologist_adhaar'];
    _biochemist_name=json['biochemist_name'];
    _biochemist_mobile=json['biochemist_mobile'];
    _biochemist_email=json['biochemist_email'];
    _biochemist_regno=json['biochemist_regno'];
    _biochemist_address=json['biochemist_address'];
    _biochemist_adhaar=json['biochemist_adhaar'];
    _addedon=json['addedon'];
    _addedby=json['addedby'];
    _updated_on=json['updated_on'];
    _updated_by=json['updated_by'];
    _app_client_id=json['app_client_id'];
    _testids=json['testids'];
    _city=json['city'];
    _latitude=json['latitude'];
    _longtitud=json['longtitud'];
  _assignto=VendorUser.fromJson(json['assignto']);



  }
  String? _id;
  String? _name;
  String? _pathology_name;
  String? _mobile;
  String? _email;
  String? _regno;
  String? _pannum;
  String? _bankname;
  String? _bankaccno;
  String? _ifsccode;
  String? _address;
  String? _servicedays;
  String? _services;
  String? _password;
  String? _adhaar;
  String? _document;
  String? _agree;
  String? _status;
  String? _microbiologist_name;
  String? _microbiologist_mobile;
  String? _microbiologist_email;
  String? _microbiologist_address;
  String? _microbiologist_regno;
  String? _microbiologist_adhaar;
  String? _biochemist_name;
  String? _biochemist_mobile;
  String? _biochemist_email;
  String? _biochemist_regno;
  String? _biochemist_address;
  String? _biochemist_adhaar;
  String? _addedon;
  String? _addedby;
  String? _updated_on;
  String? _updated_by;
  String? _app_client_id;
  String? _testids;
  String? _city;
  String? _latitude;
  String? _longtitud;
  VendorUser? _assignto;

  VendorUser? get assignto => _assignto;

  String? get id => _id;
  String? get name => _name;

  String? get pathology_name => _pathology_name;

  String? get mobile => _mobile;

  String? get email => _email;

  String? get regno => _regno;

  String? get pannum => _pannum;

  String? get bankname => _bankname;

  String? get bankaccno => _bankaccno;

  String? get ifsccode => _ifsccode;

  String? get address => _address;

  String? get servicedays => _servicedays;

  String? get services => _services;

  String? get password => _password;

  String? get adhaar => _adhaar;

  String? get document => _document;

  String? get agree => _agree;

  String? get status => _status;

  String? get microbiologist_name => _microbiologist_name;

  String? get microbiologist_mobile => _microbiologist_mobile;

  String? get microbiologist_email => _microbiologist_email;

  String? get microbiologist_address => _microbiologist_address;

  String? get microbiologist_regno => _microbiologist_regno;

  String? get microbiologist_adhaar => _microbiologist_adhaar;

  String? get biochemist_name => _biochemist_name;

  String? get biochemist_mobile => _biochemist_mobile;

  String? get biochemist_email => _biochemist_email;

  String? get biochemist_regno => _biochemist_regno;

  String? get biochemist_address => _biochemist_address;

  String? get biochemist_adhaar => _biochemist_adhaar;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get updated_on => _updated_on;

  String? get updated_by => _updated_by;

  String? get app_client_id => _app_client_id;

  String? get testids => _testids;

  String? get city => _city;

  String? get latitude => _latitude;

  String? get longtitud => _longtitud;
}

class Rating{
  Rating({
    String? id,
    String? rating,
    String? comment,
    String? orderid,
    String? vendororderid,
    String? vendorid,
    String? userid,
    String? addedon,
    String? app_client_id,
    String? status,
}){
    _id=id;
    _rating=rating;
    _comment=comment;
    _orderid=orderid;
    _vendororderid=vendororderid;
    _vendorid=vendorid;
    _userid=userid;
    _addedon=addedon;
    _app_client_id=app_client_id;
    _status=status;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id']=_id;
    map['rating']=_rating;
    map['comment']=_comment;
    map['orderid']=_orderid;
    map['vendororderid']=_vendororderid;
    map['vendorid']=_vendorid;
    map['userid']=_userid;
    map['addedon']=_addedon;
    map['app_client_id']=_app_client_id;
    map['status']=_status;
    return map;
  }
Rating.fromJson(dynamic json){
  _id=json['id'];
  _rating=json['rating'];
  _comment=json['comment'];
  _orderid=json['orderid'];
  _vendororderid=json['vendororderid'];
  _vendorid=json['vendorid'];
  _userid=json['userid'];
  _addedon=json['addedon'];
  _app_client_id=json['app_client_id'];
  _status=json['status'];
}

  String? get id => _id;
  String? _id;
  String? _rating;
  String? _comment;
  String? _orderid;
  String? _vendororderid;
  String? _vendorid;
  String? _userid;
  String? _addedon;
  String? _app_client_id;
  String? _status;

  String? get rating => _rating;

  String? get comment => _comment;

  String? get orderid => _orderid;

  String? get vendororderid => _vendororderid;

  String? get vendorid => _vendorid;

  String? get userid => _userid;

  String? get addedon => _addedon;

  String? get app_client_id => _app_client_id;

  String? get status => _status;
}

class Accepton{
  Accepton({
  String? id,
  String? app_client_id,
  String? vendor_id,
  String? order_id,
  String? assignto,
  String? assignby,
  String? assignon,
  String? addedon,
  String? addedby,
  String? status,
  String? startotp,
  String? starton,
  String? startby,
  String? completeotp,
  String? completeon,
  String? completeby,
  String? cancelby,
  String? cancelon,
  String? cancelresone,
  Vendor? vendor
}){
  _id=id;
  _app_client_id=app_client_id;
  _vendor_id=vendor_id;
  _order_id=order_id;
  _assignto=assignto;
  _assignby=assignby;
  _assignon=assignon;
  _addedon=addedon;
  _addedby=addedby;
  _status=status;
  _startotp=startotp;
  _starton=starton;
  _startby=startby;
  _completeotp=completeotp;
  _completeon=completeon;
  _completeby=completeby;
  _cancelby=cancelby;
  _cancelon=cancelon;
  _cancelresone=cancelresone;
  _vendor=vendor;
}
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id']=_id;
    map['app_client_id']=_app_client_id;
    map['vendor_id']=_vendor_id;
    map['order_id']=_order_id;
    map['assignto']=_assignto;
    map['assignby']=_assignby;
    map['assignon']=_assignon;
    map['addedon']=_addedon;
    map['addedby']=_addedby;
    map['status']=_status;
    map['startotp']=_startotp;
    map['starton']=_starton;
    map['startby']=_startby;
    map['completeotp']=_completeotp;
    map['completeon']=_completeon;
    map['completeby']=_completeby;
    map['cancelby']=_cancelby;
    map['cancelon']=_cancelon;
    map['cancelresone']=_cancelresone;
    // map['vendor']=_vendor;
    if (_vendor != null) {
      map['vendor'] = _vendor?.toJson();
    }
    return map;
  }
  Accepton.fromJson(dynamic json) {
    // _id = json['id'];
    _id=json['id'];
    _app_client_id=json['app_client_id'];
    _vendor_id=json['vendor_id'];
    _order_id=json['order_id'];
    _assignto=json['assignto'];
    _assignby=json['assignby'];
    _assignon=json['assignon'];
    _addedon=json['addedon'];
    _addedby=json['addedby'];
    _status=json['status'];
    _startotp=json['startotp'];
    _starton=json['starton'];
    _startby=json['startby'];
    _completeotp=json['completeotp'];
    _completeon=json['completeon'];
    _completeby=json['completeby'];
    _cancelby=json['cancelby'];
    _cancelon=json['cancelon'];
    _cancelresone=json['cancelresone'];
    if(json['vendor']!=null) {
      _vendor = Vendor.fromJson(json['vendor']);
    }
  }

String? _id;
String? _app_client_id;
String? _vendor_id;
String? _order_id;
String? _assignto;
String? _assignby;
String? _assignon;
String? _addedon;
String? _addedby;
String? _status;
String? _startotp;
String? _starton;
String? _startby;
String? _completeotp;
String? _completeon;
String? _completeby;


  String? _cancelby;
String? _cancelon;
String? _cancelresone;
Vendor? _vendor;
  String? get id => _id;
  String? get app_client_id => _app_client_id;

  String? get vendor_id => _vendor_id;

  String? get order_id => _order_id;

  String? get assignto => _assignto;

  String? get assignby => _assignby;

  String? get assignon => _assignon;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get status => _status;

  String? get startotp => _startotp;

  String? get starton => _starton;

  String? get startby => _startby;

  String? get completeotp => _completeotp;

  String? get completeon => _completeon;

  String? get completeby => _completeby;

  String? get cancelby => _cancelby;

  String? get cancelon => _cancelon;

  String? get cancelresone => _cancelresone;

  Vendor? get vendor => _vendor;
}
class Orderitem {
  Orderitem({
      String? id,
    String? itemtype,
    String? appClientId,
      String? userid, 
      String? orderid, 
      String? testitemid, 
      String? quantity, 
      String? rate, 
      String? subtotal, 
      String? cgst, 
      String? sgst, 
      String? igst, 
      String? finalamount, 
      String? addedon, 
      String? addedby, 
      String? testdoneon, 
      String? testdoneby, 
      String? status, 
      String? vendorPrice, 
      String? medilabsPrice, 
      String? discount, 
      String? displayPrice, 
      String? totalPrice, 
      List<Test>? test,
    String? testnmed_file,
  String? packagename,}){
    _id = id;
    _itemtype=itemtype;
    _appClientId = appClientId;
    _userid = userid;
    _orderid = orderid;
    _testitemid = testitemid;
    _quantity = quantity;
    _rate = rate;
    _subtotal = subtotal;
    _cgst = cgst;
    _sgst = sgst;
    _igst = igst;
    _finalamount = finalamount;
    _addedon = addedon;
    _addedby = addedby;
    _testdoneon = testdoneon;
    _testdoneby = testdoneby;
    _status = status;
    _vendorPrice = vendorPrice;
    _medilabsPrice = medilabsPrice;
    _discount = discount;
    _displayPrice = displayPrice;
    _totalPrice = totalPrice;
    _test = test;
    _testnmed_file=testnmed_file;
    _packagename=packagename;
}

  Orderitem.fromJson(dynamic json) {
    _id = json['id'];
    _itemtype=json['itemtype'];
    _appClientId = json['app_client_id'];
    _userid = json['userid'];
    _orderid = json['orderid'];
    _testitemid = json['testitemid'];
    _quantity = json['quantity'];
    _rate = json['rate'];
    _subtotal = json['subtotal'];
    _cgst = json['cgst'];
    _sgst = json['sgst'];
    _igst = json['igst'];
    _finalamount = json['finalamount'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _testdoneon = json['testdoneon'];
    _testdoneby = json['testdoneby'];
    _status = json['status'];
    _vendorPrice = json['vendor_price'];
    _medilabsPrice = json['medilabs_price'];
    _discount = json['discount'];
    _displayPrice = json['display_price'];
    _totalPrice = json['total_price'];
    _testnmed_file=json['testnmed_file'];
    _packagename=json['packagename'];
    if (json['test'] != null) {
      _test = [];
      json['test'].forEach((v) {
        _test?.add(Test.fromJson(v));
      });
    }
  }
  String? _id;
  String? _itemtype;
  String? _appClientId;
  String? _userid;
  String? _orderid;
  String? _testitemid;
  String? _quantity;
  String? _rate;
  String? _subtotal;
  String? _cgst;
  String? _sgst;
  String? _igst;
  String? _finalamount;
  String? _addedon;
  String? _addedby;
  String? _testdoneon;
  String? _testdoneby;
  String? _status;
  String? _vendorPrice;
  String? _medilabsPrice;
  String? _discount;
  String? _displayPrice;
  String? _totalPrice;
  String? _packagename;
  List<Test>? _test;

String? _testnmed_file;
  String? get packagename=>_packagename;

String?get testnmed_file=>_testnmed_file;
String? get itemtype=> _itemtype;
  String? get id => _id;
  String? get appClientId => _appClientId;
  String? get userid => _userid;
  String? get orderid => _orderid;
  String? get testitemid => _testitemid;
  String? get quantity => _quantity;
  String? get rate => _rate;
  String? get subtotal => _subtotal;
  String? get cgst => _cgst;
  String? get sgst => _sgst;
  String? get igst => _igst;
  String? get finalamount => _finalamount;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get testdoneon => _testdoneon;
  String? get testdoneby => _testdoneby;
  String? get status => _status;
  String? get vendorPrice => _vendorPrice;
  String? get medilabsPrice => _medilabsPrice;
  String? get discount => _discount;
  String? get displayPrice => _displayPrice;
  String? get totalPrice => _totalPrice;
  List<Test>? get test => _test;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['itemtype']=_itemtype;
    map['app_client_id'] = _appClientId;
    map['userid'] = _userid;
    map['orderid'] = _orderid;
    map['testitemid'] = _testitemid;
    map['quantity'] = _quantity;
    map['rate'] = _rate;
    map['subtotal'] = _subtotal;
    map['cgst'] = _cgst;
    map['sgst'] = _sgst;
    map['igst'] = _igst;
    map['finalamount'] = _finalamount;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['testdoneon'] = _testdoneon;
    map['testdoneby'] = _testdoneby;
    map['status'] = _status;
    map['vendor_price'] = _vendorPrice;
    map['medilabs_price'] = _medilabsPrice;
    map['discount'] = _discount;
    map['display_price'] = _displayPrice;
    map['total_price'] = _totalPrice;
    map['testnmed_file']=_testnmed_file;
    map['packagename']=_packagename;
    if (_test != null) {
      map['test'] = _test?.map((v) => v.toJson()).toList();
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
/// testimage : ""
/// description : "test description"
/// status : "1"
/// addedon : "2021-12-17 13:58:52"
/// addedby : "1"
/// updated_on : "2021-12-31 17:51:34"
/// updated_by : "1"
/// app_client_id : "1"
/// image : ""

class Test {
  Test({
      String? id, 
      String? categoryId, 
      String? subcategoryId, 
      String? testname, 
      String? vendorPrice, 
      String? medilabsPrice, 
      String? totalPrice, 
      String? discount, 
      String? displayPrice, 
      String? testimage, 
      String? description, 
      String? status, 
      String? addedon, 
      String? addedby, 
      String? updatedOn, 
      String? updatedBy, 
      String? appClientId, 
      String? image,
    String? testnmed_file}){
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _testname = testname;
    _vendorPrice = vendorPrice;
    _medilabsPrice = medilabsPrice;
    _totalPrice = totalPrice;
    _discount = discount;
    _displayPrice = displayPrice;
    _testimage = testimage;
    _description = description;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
    _appClientId = appClientId;
    _image = image;
    _testnmed_file=testnmed_file;
}

  Test.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _testname = json['testname'];
    _vendorPrice = json['vendor_price'];
    _medilabsPrice = json['medilabs_price'];
    _totalPrice = json['total_price'];
    _discount = json['discount'];
    _displayPrice = json['display_price'];
    _testimage = json['testimage'];
    _description = json['description'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
    _appClientId = json['app_client_id'];
    _image = json['image'];
    _testnmed_file=json['testnmed_file'];
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
  String? _testimage;
  String? _description;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _updatedOn;
  String? _updatedBy;
  String? _appClientId;
  String? _image;
  String? _testnmed_file;

  String? get testnmed_file=> _testnmed_file;
  String? get id => _id;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get testname => _testname;
  String? get vendorPrice => _vendorPrice;
  String? get medilabsPrice => _medilabsPrice;
  String? get totalPrice => _totalPrice;
  String? get discount => _discount;
  String? get displayPrice => _displayPrice;
  String? get testimage => _testimage;
  String? get description => _description;
  String? get status => _status;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get updatedOn => _updatedOn;
  String? get updatedBy => _updatedBy;
  String? get appClientId => _appClientId;
  String? get image => _image;

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
    map['testimage'] = _testimage;
    map['description'] = _description;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    map['app_client_id'] = _appClientId;
    map['image'] = _image;
    map['testnmed_file']=_testnmed_file;
    return map;
  }

}

/// id : "1"
/// name : "Thyroid disorder "
/// detail : ""
/// addedon : "2022-01-03 13:31:02"
/// addedby : "0"
/// status : "1"
/// app_client_id : "1"

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

}