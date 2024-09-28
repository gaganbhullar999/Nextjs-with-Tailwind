/// success : true
/// message : "OTP has been sent to your mobile number 9425688897"
/// data : {"id":"4","name":"","mobile":"9425688897","email":"","age":"","gender":"","landmark":"","pincode":"","address":"","country":"","state":"","city":"","latitude":"","longitude":"","device_token":"","otp":"1234","image":"","status":"1","addedon":"2022-01-04 14:59:36","addedby":"0","updated_on":"2022-01-04 14:59:36","updated_by":"0","app_client_id":"1"}

class CreateOrderResponse {


  CreateOrderResponse({
    bool? success,
    dynamic? message,
    dynamic? orderid,
    }){
    _success = success;
    _message = message;
    _orderid=orderid;

  }

  CreateOrderResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _orderid=json['orderid'];
    // _data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  bool? _success;
  dynamic? _message;
  dynamic? _orderid;
  // LoginData? _data;

  bool? get success => _success;
  dynamic? get message => _message;
  dynamic? get orderid=> _orderid;
  // LoginData? get data => _data;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['orderid'] = _orderid;
    // if (_data != null) {
    //   map['data'] = _data?.toJson();
    // }
    return map;
  }

  @override
  String toString() {
    return 'CreateOrderResponse{_success: $_success, _message: $_message,_orderid : $_orderid}';
  }
}
