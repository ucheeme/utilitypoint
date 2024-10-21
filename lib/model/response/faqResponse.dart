// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'dart:convert';

List<FaqResponse> faqResponseFromJson(String str) => List<FaqResponse>.from(json.decode(str).map((x) => FaqResponse.fromJson(x)));

String faqResponseToJson(List<FaqResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqResponse {
  String id;
  String question;
  String answer;
  String position;
  DateTime createdAt;
  DateTime updatedAt;

  FaqResponse({
    required this.id,
    required this.question,
    required this.answer,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    position: json["position"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "position": position,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
