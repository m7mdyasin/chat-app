import 'package:chat_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String message;
  final String email;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.message,
    required this.email,
    required this.createdAt,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    final jsonData = doc.data() as Map<String, dynamic>;
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
      id: doc.id,
      message: jsonData[kMessage],
      email: jsonData['email'] ?? 'unknown',
      createdAt: createdAt,
    );
  }
}
