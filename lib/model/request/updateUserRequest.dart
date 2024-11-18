// To parse this JSON data, do
//
//     final updateUserDetailRequest = updateUserDetailRequestFromJson(jsonString);

import 'dart:convert';

UpdateUserDetailRequest updateUserDetailRequestFromJson(String str) => UpdateUserDetailRequest.fromJson(json.decode(str));

String updateUserDetailRequestToJson(UpdateUserDetailRequest data) => json.encode(data.toJson());

class UpdateUserDetailRequest {
  String userId;
  String firstName;
  String lastName;
  String otherNames;
  String userName;
  String phoneNumber;
  String? addressStreet;
  String? dob;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? identificationType;
  String? identificationNumber;
  String? photo;
  String? identityType;
  String? identityNumber;
  String? identityImage;

  UpdateUserDetailRequest({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.otherNames,
    required this.userName,
    required this.phoneNumber,
     this.addressStreet,
     this.dob,
     this.city,
     this.state,
     this.country,
     this.postalCode,
     this.identificationType,
     this.identificationNumber,
     this.photo,
     this.identityType,
     this.identityNumber,
     this.identityImage,
  });

  factory UpdateUserDetailRequest.fromJson(Map<String, dynamic> json) => UpdateUserDetailRequest(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    otherNames: json["other_names"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    addressStreet: json["address_street"]??"",
    dob: json["dob"]??"",
    city: json["city"]??"",
    state: json["state"]??"",
    country: json["country"]??"",
    postalCode: json["postal_code"]??"",
    identificationType: json["identification_type"]??"",
    identificationNumber: json["identification_number"]??"",
    photo: json["photo"]??"",
    identityType: json["identity_type"]??"",
    identityNumber: json["identity_number"]??"",
    identityImage: json["identity_image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "other_names": otherNames,
    "user_name": userName,
    "phone_number": phoneNumber,
    "address_street": addressStreet,
    "dob": dob,
    "city": city,
    "state": state,
    "country": country,
    "postal_code": postalCode,
    "identification_type": identificationType,
    "identification_number": identificationNumber,
    "photo": photo,
    "identity_type": identityType,
    "identity_number": identityNumber,
    "identity_image": identityImage,
  };
}
