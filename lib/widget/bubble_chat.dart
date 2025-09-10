import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BubbleNormal(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Delete Message',
                  style: TextStyle(
                    color: Color.fromARGB(255, 180, 29, 127),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  'Please press ok to delete this message',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(
                        context,
                      ).deleteMessage(message.id);
                      Navigator.of(context).pop();
                    },

                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Color.fromARGB(255, 180, 29, 127),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          onDoubleTap: () {
            Clipboard.setData(ClipboardData(text: message.message));
            final snackBar = SnackBar(
              content: Text(
                'Message copied to clipboard',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
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
  const ReciverBubbleChat({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BubbleNormal(
          onLongPress: () {},
          onDoubleTap: () {
            Clipboard.setData(ClipboardData(text: message.message));
            final snackBar = SnackBar(
              content: Text(
                'Message copied to clipboard',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
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
