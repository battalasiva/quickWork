// To parse this JSON data, do
//
//     final getWorkRequestsListModel = getWorkRequestsListModelFromJson(jsonString);

import 'dart:convert';

List<GetWorkRequestsListModel> getWorkRequestsListModelFromJson(String str) =>
    List<GetWorkRequestsListModel>.from(
      json.decode(str).map((x) => GetWorkRequestsListModel.fromJson(x)),
    );

String getWorkRequestsListModelToJson(List<GetWorkRequestsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWorkRequestsListModel {
  int? id;
  String? customerName;
  String? technicianName;
  List<String>? workTypes;
  String? status;
  String? description;
  DateTime? createdAt;

  GetWorkRequestsListModel({
    this.id,
    this.customerName,
    this.technicianName,
    this.workTypes,
    this.status,
    this.description,
    this.createdAt,
  });

  factory GetWorkRequestsListModel.fromJson(Map<String, dynamic> json) =>
      GetWorkRequestsListModel(
        id: json["id"],
        customerName: json["customerName"],
        technicianName: json["technicianName"],
        workTypes: json["workTypes"] == null
            ? []
            : List<String>.from(json["workTypes"]!.map((x) => x)),
        status: json["status"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerName": customerName,
    "technicianName": technicianName,
    "workTypes": workTypes == null
        ? []
        : List<dynamic>.from(workTypes!.map((x) => x)),
    "status": status,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
  };
}
