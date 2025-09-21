// To parse this JSON data, do
//
//     final currentCustomerModal = currentCustomerModalFromJson(jsonString);

import 'dart:convert';

CurrentCustomerModal currentCustomerModalFromJson(String str) =>
    CurrentCustomerModal.fromJson(json.decode(str));

String currentCustomerModalToJson(CurrentCustomerModal data) =>
    json.encode(data.toJson());

class CurrentCustomerModal {
  String? message;
  String? status;
  Data? data;

  CurrentCustomerModal({this.message, this.status, this.data});

  factory CurrentCustomerModal.fromJson(Map<String, dynamic> json) =>
      CurrentCustomerModal(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  List<Role>? roles;
  String? primaryContact;
  List<dynamic>? addresses;
  bool? register;

  Data({
    this.id,
    this.roles,
    this.primaryContact,
    this.addresses,
    this.register,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    roles: json["roles"] == null
        ? []
        : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    primaryContact: json["primaryContact"],
    addresses: json["addresses"] == null
        ? []
        : List<dynamic>.from(json["addresses"]!.map((x) => x)),
    register: json["register"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roles": roles == null
        ? []
        : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "primaryContact": primaryContact,
    "addresses": addresses == null
        ? []
        : List<dynamic>.from(addresses!.map((x) => x)),
    "register": register,
  };
}

class Role {
  String? name;
  int? id;

  Role({this.name, this.id});

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(name: json["name"], id: json["id"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}
