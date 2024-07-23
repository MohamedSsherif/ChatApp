import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatCubitInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
      
 List<Message> messagesList = [];
  void sendMessage({required String message,required String email}) {
    try {
  messages.add(
    {kMessage: message, kCreatedAt: DateTime.now(), 'id': email},
  );
} on Exception catch (e) {
  // TODO
}
  }


  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      
      for (var doc in event.docs){
        messagesList.add(Message.fromJson(doc));
      }
     
      emit(ChatSuccess(
        messages: messagesList,
      ));
    });
  }
}
