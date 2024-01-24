// To parse this JSON data, do
//
//     final chatsUserResp = chatsUserRespFromJson(jsonString);

import 'dart:convert';

List<ChatsUserResp> chatsUserRespFromJson(String str) =>
    List<ChatsUserResp>.from(
        json.decode(str).map((x) => ChatsUserResp.fromJson(x)));

String chatsUserRespToJson(List<ChatsUserResp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatsUserResp {
  String? id;
  String? nombre;
  String? message;
  String? otherPersonId;
  DateTime? createdAt;

  ChatsUserResp({
    this.id,
    this.nombre,
    this.message,
    this.otherPersonId,
    this.createdAt,
  });

  factory ChatsUserResp.fromJson(Map<String, dynamic> json) => ChatsUserResp(
        id: json["id"],
        nombre: json["nombre"],
        message: json["message"],
        otherPersonId: json["other_person_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "message": message,
        "other_person_id": otherPersonId,
        "created_at": createdAt?.toIso8601String(),
      };
}
