
class TokenModel {


  TokenModel({
    bool? success,
    dynamic? message,
    dynamic? ctoken, dynamic? orderid}){
    _success = success;
    _message = message;
    _ctoken =  ctoken;
    _orderid =  orderid;
  }

  TokenModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _ctoken = json['ctoken'];
    _orderid = json['orderid'];
  }
  bool? _success;
  dynamic? _message;
  dynamic? _ctoken;
  dynamic? _orderid;

  bool? get success => _success;
  dynamic? get message => _message;
  dynamic? get ctoken => _ctoken;
  dynamic? get orderid => _orderid;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['ctoken'] = _ctoken;
    map['orderid'] = _orderid;

    return map;
  }

  @override
  String toString() {
    return 'TokenModel{_success: $_success, _message: $_message, ctoken: $_ctoken}';
  }
}