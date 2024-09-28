import 'dart:convert';

StateModel? stateModelFromJson(String? str) =>
    str != null ? StateModel.fromJson(json.decode(str)) : null;

String? stateModelToJson(StateModel? data) =>
    data != null ? json.encode(data.toJson()) : null;

class StateListResponse {
  bool success;
  String? message;
  List<StateModel> data;

  StateListResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory StateListResponse.fromJson(Map<String, dynamic> json) =>
      StateListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StateModel>.from(
                json["data"]!.map((x) => StateModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StateModel {
  String? isActive;
  String? id;
  String? name;
  String? countryId;
  String? status;

  StateModel({
    this.isActive,
    this.id,
    this.name,
    this.countryId,
    this.status,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        isActive: json["is_active"],
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "is_active": isActive,
        "id": id,
        "name": name,
        "country_id": countryId,
        "status": status,
      };
}
