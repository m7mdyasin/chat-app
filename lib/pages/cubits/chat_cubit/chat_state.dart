part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSucsses extends ChatState {
  List<Message> messagesList;
  ChatSucsses({required this.messagesList});
}
