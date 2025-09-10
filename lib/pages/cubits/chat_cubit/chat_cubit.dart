import 'package:bloc/bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        'createdAt': DateTime.now(),
        'email': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      });
    } catch (e) {
      // TODO
    }
  }

  void getMessage() {
    messages.orderBy('createdAt').snapshots().listen((event) {
      List<Message> messagesList = [];
      print(event.docs);
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromDocument(doc));
        print(doc);
      }
      emit(ChatSucsses(messagesList: messagesList));
      print('get message');
    });
  }

  void deleteMessage(String messageId) {
    try {
      messages.doc(messageId).delete();
    } catch (e) {
      // Handle errors if necessary
    }
  }
}
