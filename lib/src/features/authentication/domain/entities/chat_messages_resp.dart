// To parse this JSON data, do
//
//     final chatDetailsWithUserResp = chatDetailsWithUserRespFromJson(jsonString);

import 'dart:convert';

List<ChatDetailsWithUserResp> chatDetailsWithUserRespFromJson(String str) =>
    List<ChatDetailsWithUserResp>.from(
        json.decode(str).map((x) => ChatDetailsWithUserResp.fromJson(x)));

String chatDetailsWithUserRespToJson(List<ChatDetailsWithUserResp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatDetailsWithUserResp {
  String? id;
  String? senderName;
  String? receiverName;
  String? decodedMessage;
  String? userId;
  String? toId;
  DateTime? createdAt;

  ChatDetailsWithUserResp({
    this.id,
    this.senderName,
    this.receiverName,
    this.decodedMessage,
    this.userId,
    this.toId,
    this.createdAt,
  });

  factory ChatDetailsWithUserResp.fromJson(Map<String, dynamic> json) =>
      ChatDetailsWithUserResp(
        id: json["id"],
        senderName: json["sender_name"],
        receiverName: json["receiver_name"],
        decodedMessage: json["decoded_message"],
        userId: json["user_id"],
        toId: json["to_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_name": senderName,
        "receiver_name": receiverName,
        "decoded_message": decodedMessage,
        "user_id": userId,
        "to_id": toId,
        "created_at": createdAt?.toIso8601String(),
      };
}
