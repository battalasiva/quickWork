// To parse this JSON data, do
//
//     final getWorkCategoriesModel = getWorkCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<GetWorkCategoriesModel> getWorkCategoriesModelFromJson(String str) =>
    List<GetWorkCategoriesModel>.from(
      json.decode(str).map((x) => GetWorkCategoriesModel.fromJson(x)),
    );

String getWorkCategoriesModelToJson(List<GetWorkCategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWorkCategoriesModel {
  int? id;
  String? name;
  String? category;

  GetWorkCategoriesModel({this.id, this.name, this.category});

  factory GetWorkCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetWorkCategoriesModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
  };
}
