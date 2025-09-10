import 'package:chat_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String email;
  final DateTime createdAt;

  Message(this.message, this.email, this.createdAt);

  factory Message.fromJson(jsonData) {
    DateTime createdAt;
    if (jsonData['createdAt'] is Timestamp) {
      createdAt = (jsonData['createdAt'] as Timestamp).toDate();
    } else if (jsonData['createdAt'] is DateTime) {
      createdAt = jsonData['createdAt'];
    } else {
      createdAt =
          DateTime.tryParse(jsonData['createdAt'].toString()) ?? DateTime.now();
    }
    return Message(
      jsonData[kMessage],
      jsonData['email'] ?? 'unknown',
      createdAt,
    );
  }
}
