import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/pages/intro_page.dart';
import 'package:chat_app/widget/bubble_chat.dart';
import 'package:chat_app/widget/gradient_background.dart';
import 'package:chat_app/widget/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  final String? email = FirebaseAuth.instance.currentUser?.email;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  TextEditingController messageController = TextEditingController();
  final _controller = ScrollController();
  final String? email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          // Scroll to bottom after new message is added
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.animateTo(
                _controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/white_logo.png'),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    showSnackBar(context, 'Successfully logged out');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const IntroPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
              title: Text(email ?? ''),
              automaticallyImplyLeading: false,
              flexibleSpace: const GradientBackground(),
              elevation: 0.2,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].email == email
                          ? BubbleChat(message: messagesList[index])
                          : ReciverBubbleChat(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onSubmitted: (data) {
                              messages.add({
                                kMessage: data,
                                'createdAt': DateTime.now(),
                                'email':
                                    FirebaseAuth.instance.currentUser?.email ??
                                    'unknown',
                              });
                              messageController.clear();
                              // السكول سيتم بعد بناء الرسالة الجديدة
                            },
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              suffixIcon: Icon(Icons.send, color: kSenderColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading messages...');
        }
      },
    );
  }
}
