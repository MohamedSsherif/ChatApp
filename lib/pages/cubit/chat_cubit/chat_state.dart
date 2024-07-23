part of 'chat_cubit.dart';


abstract class ChatState {}

final class ChatCubitInitial extends ChatState {}

final class ChatSuccess extends ChatState {
   List<Message> messages;
  ChatSuccess({required this.messages});
}
