import 'dart:convert';

List<GetTechniciansListModel> getTechniciansListModelFromJson(String str) =>
    List<GetTechniciansListModel>.from(
      json.decode(str).map((x) => GetTechniciansListModel.fromJson(x)),
    );

String getTechniciansListModelToJson(List<GetTechniciansListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTechniciansListModel {
  int? technicianId;
  String? fullName;
  String? email;
  String? phone;
  String? status;
  List<String>? workTypes;
  String? doorNumber;
  String? landMark;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? postalCode;
  String? otherDetails;
  String? latitude;
  String? longitude;

  GetTechniciansListModel({
    this.technicianId,
    this.fullName,
    this.email,
    this.phone,
    this.status,
    this.workTypes,
    this.doorNumber,
    this.landMark,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.otherDetails,
    this.latitude,
    this.longitude,
  });

  factory GetTechniciansListModel.fromJson(Map<String, dynamic> json) {
    return GetTechniciansListModel(
      technicianId: json["technicianId"],
      fullName: json["fullName"],
      email: json["email"],
      phone: json["phone"],
      status: json["status"],
      workTypes: (json["workTypes"] is List)
          ? List<String>.from(json["workTypes"].map((e) => e.toString()))
          : [], // ✅ Safe conversion
      doorNumber: json["doorNumber"],
      landMark: json["landMark"],
      addressLine1: json["addressLine1"],
      addressLine2: json["addressLine2"],
      city: json["city"],
      state: json["state"],
      postalCode: json["postalCode"],
      otherDetails: json["otherDetails"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
    "technicianId": technicianId,
    "fullName": fullName,
    "email": email,
    "phone": phone,
    "status": status,
    "workTypes": workTypes ?? [],
    "doorNumber": doorNumber,
    "landMark": landMark,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "state": state,
    "postalCode": postalCode,
    "otherDetails": otherDetails,
    "latitude": latitude,
    "longitude": longitude,
  };
}
