import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat({super.key, required this.message});
  Message message;

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      text: message.message,
      seen: true,

      isSender: true,
      color: kSenderColor,
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),

        fontSize: 16,
      ),
    );
  }
}

class ReciverBubbleChat extends StatelessWidget {
  ReciverBubbleChat({super.key, required this.message});
  Message message;

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      text: message.message,
      seen: true,

      isSender: false,
      color: kReceiverColor,
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),

        fontSize: 16,
      ),
    );
  }
}
