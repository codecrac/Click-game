// To parse this JSON data, do
//
//     final envoiDeMessage = envoiDeMessageFromJson(jsonString);

import 'dart:convert';

EnvoiDeMessage envoiDeMessageFromJson(String str) => EnvoiDeMessage.fromJson(json.decode(str));

String envoiDeMessageToJson(EnvoiDeMessage data) => json.encode(data.toJson());

class EnvoiDeMessage {
  String statut;
  String notif;
  String contact;
  String message;

  EnvoiDeMessage({
    this.statut,
    this.notif,
    this.contact,
    this.message,
  });

  factory EnvoiDeMessage.fromJson(Map<String, dynamic> json) => EnvoiDeMessage(
    statut: json["statut"],
    notif: json["notif"],
    contact: json["contact"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statut": statut,
    "notif": notif,
    "contact": contact,
    "message": message,
  };
}
