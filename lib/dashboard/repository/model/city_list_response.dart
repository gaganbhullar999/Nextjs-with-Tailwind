import 'dart:convert';

CityModel? cityModelFromJson(String? str) =>
    str != null ? CityModel.fromJson(json.decode(str)) : null;

String? cityModelToJson(CityModel? data) =>
    data != null ? json.encode(data.toJson()) : null;

class CityListResponse {
  bool success;
  String? message;
  List<CityModel> data;

  CityListResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory CityListResponse.fromJson(Map<String, dynamic> json) =>
      CityListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CityModel>.from(
                json["data"]!.map((x) => CityModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CityModel {
  String? id;
  String? name;
  String? stateId;
  String? status;

  CityModel({
    this.id,
    this.name,
    this.stateId,
    this.status,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "status": status,
      };
}
