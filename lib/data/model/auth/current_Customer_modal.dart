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
  String? fullName;
  List<Role>? roles;
  String? primaryContact;
  List<Address>? addresses;
  bool? register;

  Data({
    this.id,
    this.fullName,
    this.roles,
    this.primaryContact,
    this.addresses,
    this.register,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["fullName"],
    roles: json["roles"] == null
        ? []
        : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    primaryContact: json["primaryContact"],
    addresses: json["addresses"] == null
        ? []
        : List<Address>.from(
            json["addresses"]!.map((x) => Address.fromJson(x)),
          ),
    register: json["register"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "roles": roles == null
        ? []
        : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "primaryContact": primaryContact,
    "addresses": addresses == null
        ? []
        : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "register": register,
  };
}

class Address {
  int? id;
  String? city;
  String? postalCode;
  bool? isDefaultAddress;

  Address({this.id, this.city, this.postalCode, this.isDefaultAddress});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    city: json["city"],
    postalCode: json["postalCode"],
    isDefaultAddress: json["isDefaultAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "postalCode": postalCode,
    "isDefaultAddress": isDefaultAddress,
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
