import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String senderId; // ID отправителя
  final DateTime sentAt;   // Время отправки

  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.sentAt,
  });

  @override
  List<Object?> get props => [id, text, senderId, sentAt];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text' : text,
      'senderId' : senderId,
      'sentAt' : sentAt.toIso8601String(),
    };
  }

  factory MessageEntity.fromJson(Map<String, dynamic> json){
    return MessageEntity(
      id: json['id'] as String,
      text: json['text'] as String,
      senderId: json['senderId'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String));
  }

}