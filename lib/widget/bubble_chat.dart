import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BubbleNormal(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 2,
            left: 20,
            right: 20,
          ),
          text: message.message,
          seen: true,
          isSender: true,
          color: kSenderColor,
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 22, bottom: 4),
          child: Text(
            _formatTime(message.createdAt),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

class ReciverBubbleChat extends StatelessWidget {
  ReciverBubbleChat({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BubbleNormal(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 2,
            left: 20,
            right: 20,
          ),
          text: message.message,
          seen: true,
          isSender: false,
          color: kReceiverColor,
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, bottom: 4),
          child: Text(
            _formatTime(message.createdAt),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
