// To parse this JSON data, do
//
//     final triggerOtpModel = triggerOtpModelFromJson(jsonString);

import 'dart:convert';

TriggerOtpModel triggerOtpModelFromJson(String str) =>
    TriggerOtpModel.fromJson(json.decode(str));

String triggerOtpModelToJson(TriggerOtpModel data) =>
    json.encode(data.toJson());

class TriggerOtpModel {
  int? id;
  String? otpType;
  DateTime? creationTime;
  String? otp;

  TriggerOtpModel({this.id, this.otpType, this.creationTime, this.otp});

  factory TriggerOtpModel.fromJson(Map<String, dynamic> json) =>
      TriggerOtpModel(
        id: json["id"],
        otpType: json["otpType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "otpType": otpType,
    "creationTime": creationTime?.toIso8601String(),
    "otp": otp,
  };
}
