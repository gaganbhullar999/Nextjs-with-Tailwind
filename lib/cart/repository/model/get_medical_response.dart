import 'make_order_model.dart';

/// success : true
/// message : "found"
/// family_history : [{"id":"1","name":"Hypertension","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Aastma","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]
/// personal_history : [{"id":"1","name":"Smoking","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Alcohol","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]
/// allergies : [{"id":"1","name":"Thyroid disorder ","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"},{"id":"2","name":"Fever","detail":"","addedon":"2022-01-03 13:31:02","addedby":"0","status":"1","app_client_id":"1"}]

class GetMedicalResponse {
  GetMedicalResponse({
      bool? success, 
      String? message,
      List<Family_history>? familyHistory,
      List<Personal_history>? personalHistory, 
      List<Allergies>? allergies,List<TimeSlot>? timeslot}){
    _success = success;
    _message = message;
    _familyHistory = familyHistory;
    _personalHistory = personalHistory;
    _allergies = allergies;
    _timeslot=timeslot;
}

  GetMedicalResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
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
    if (json['timeslot'] != null) {
      _timeslot = [];
      json['timeslot'].forEach((v) {
        _timeslot?.add(TimeSlot.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Family_history>? _familyHistory;
  List<Personal_history>? _personalHistory;
  List<Allergies>? _allergies;
  List<TimeSlot>? _timeslot;

  bool? get success => _success;
  String? get message => _message;
  List<Family_history>? get familyHistory => _familyHistory;
  List<Personal_history>? get personalHistory => _personalHistory;
  List<Allergies>? get allergies => _allergies;
  List<TimeSlot>? get timeslot => _timeslot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_familyHistory != null) {
      map['family_history'] = _familyHistory?.map((v) => v.toJson()).toList();
    }
    if (_personalHistory != null) {
      map['personal_history'] = _personalHistory?.map((v) => v.toJson()).toList();
    }
    if (_allergies != null) {
      map['allergies'] = _allergies?.map((v) => v.toJson()).toList();
    }
    if (_timeslot != null) {
      map['timeslot'] = _timeslot?.map((v) => v.toJson()).toList();
    }
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
//
// class Allergies {
//   Allergies({
//       String? id,
//       String? name,
//       String? detail,
//       String? addedon,
//       String? addedby,
//       String? status,
//       String? appClientId,}){
//     _id = id;
//     _name = name;
//     _detail = detail;
//     _addedon = addedon;
//     _addedby = addedby;
//     _status = status;
//     _appClientId = appClientId;
// }
//
//   Allergies.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _detail = json['detail'];
//     _addedon = json['addedon'];
//     _addedby = json['addedby'];
//     _status = json['status'];
//     _appClientId = json['app_client_id'];
//   }
//   String? _id;
//   String? _name;
//   String? _detail;
//   String? _addedon;
//   String? _addedby;
//   String? _status;
//   String? _appClientId;
//
//   String? get id => _id;
//   String? get name => _name;
//   String? get detail => _detail;
//   String? get addedon => _addedon;
//   String? get addedby => _addedby;
//   String? get status => _status;
//   String? get appClientId => _appClientId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['detail'] = _detail;
//     map['addedon'] = _addedon;
//     map['addedby'] = _addedby;
//     map['status'] = _status;
//     map['app_client_id'] = _appClientId;
//     return map;
//   }
//
// }
//
// /// id : "1"
// /// name : "Smoking"
// /// detail : ""
// /// addedon : "2022-01-03 13:31:02"
// /// addedby : "0"
// /// status : "1"
// /// app_client_id : "1"
//
// class Personal_history {
//   Personal_history({
//       String? id,
//       String? name,
//       String? detail,
//       String? addedon,
//       String? addedby,
//       String? status,
//       String? appClientId,}){
//     _id = id;
//     _name = name;
//     _detail = detail;
//     _addedon = addedon;
//     _addedby = addedby;
//     _status = status;
//     _appClientId = appClientId;
// }
//
//   Personal_history.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _detail = json['detail'];
//     _addedon = json['addedon'];
//     _addedby = json['addedby'];
//     _status = json['status'];
//     _appClientId = json['app_client_id'];
//   }
//   String? _id;
//   String? _name;
//   String? _detail;
//   String? _addedon;
//   String? _addedby;
//   String? _status;
//   String? _appClientId;
//
//   String? get id => _id;
//   String? get name => _name;
//   String? get detail => _detail;
//   String? get addedon => _addedon;
//   String? get addedby => _addedby;
//   String? get status => _status;
//   String? get appClientId => _appClientId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['detail'] = _detail;
//     map['addedon'] = _addedon;
//     map['addedby'] = _addedby;
//     map['status'] = _status;
//     map['app_client_id'] = _appClientId;
//     return map;
//   }
//
// }
//
// /// id : "1"
// /// name : "Hypertension"
// /// detail : ""
// /// addedon : "2022-01-03 13:31:02"
// /// addedby : "0"
// /// status : "1"
// /// app_client_id : "1"
//
// class Family_history {
//   Family_history({
//       String? id,
//       String? name,
//       String? detail,
//       String? addedon,
//       String? addedby,
//       String? status,
//       String? appClientId,}){
//     _id = id;
//     _name = name;
//     _detail = detail;
//     _addedon = addedon;
//     _addedby = addedby;
//     _status = status;
//     _appClientId = appClientId;
// }
//
//   Family_history.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _detail = json['detail'];
//     _addedon = json['addedon'];
//     _addedby = json['addedby'];
//     _status = json['status'];
//     _appClientId = json['app_client_id'];
//   }
//   String? _id;
//   String? _name;
//   String? _detail;
//   String? _addedon;
//   String? _addedby;
//   String? _status;
//   String? _appClientId;
//
//   String? get id => _id;
//   String? get name => _name;
//   String? get detail => _detail;
//   String? get addedon => _addedon;
//   String? get addedby => _addedby;
//   String? get status => _status;
//   String? get appClientId => _appClientId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['detail'] = _detail;
//     map['addedon'] = _addedon;
//     map['addedby'] = _addedby;
//     map['status'] = _status;
//     map['app_client_id'] = _appClientId;
//     return map;
//   }
//
// }