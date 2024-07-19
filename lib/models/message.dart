import 'package:chat_app/constants.dart';

class Message{
  final String message;
  final String id;
  Message(this.message, this.id);



  factory Message.fromJson( jsonData) {
      return Message(jsonData[kMessage], jsonData['id']);
  }

  //   factory Message.fromJson(Map<String, dynamic> jsonData) {
  //   return Message(
  //     jsonData[
  //       kMessage
  //     ] ?? '', // Provide a default value if null
  //     jsonData['id'] ?? '', // Provide a default value if null
  //   );
  // }
}


