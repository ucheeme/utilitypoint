// To parse this JSON data, do
//
//     final networkList = networkListFromJson(jsonString);

import 'dart:convert';

List<NetworkList> networkListFromJson(String str) => List<NetworkList>.from(json.decode(str).map((x) => NetworkList.fromJson(x)));

String networkListToJson(List<NetworkList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NetworkList {
  String id;
  String networkName;
  String visibility;
  DateTime createdAt;
  DateTime updatedAt;

  NetworkList({
    required this.id,
    required this.networkName,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    id: json["id"],
    networkName: json["network_name"],
    visibility: json["visibility"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "network_name": networkName,
    "visibility": visibility,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
