/// success : true
/// message : "OTP has been sent to your mobile number 9425688897"
/// data : {"id":"4","name":"","mobile":"9425688897","email":"","age":"","gender":"","landmark":"","pincode":"","address":"","country":"","state":"","city":"","latitude":"","longitude":"","device_token":"","otp":"1234","image":"","status":"1","addedon":"2022-01-04 14:59:36","addedby":"0","updated_on":"2022-01-04 14:59:36","updated_by":"0","app_client_id":"1"}

class SkyCallResponse {


  SkyCallResponse({
    String? status,
    String? message,
    }){
    _status = status;
    _message = message;
  }

  SkyCallResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;


  String? get status => _status;
  String? get message => _message;


  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _status;
    map['message'] = _message;

    return map;
  }

  @override
  String toString() {
    return 'LoginResponse{_success: $_status, _message: $_message}';
  }
}

