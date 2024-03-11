import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatelessWidget {
  // ChatPage({super.key});
  static String id = 'ChatPage';

  final _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
   CollectionReference messages = FirebaseFirestore.instance.collection('messages');
    TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   var email =  ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(
        'createdAt',
        descending: true,
      ).snapshots(),
      builder: (context, snapshot) {
       
       if(snapshot.hasData)
       {
        List<Message> messagesList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
        messagesList.add(Message.fromJson(snapshot.data!.docs[i].data() as Map<String, dynamic>));
        }
        // print(snapshot.data!.docs[0]['text']);
         return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 40),
            Text('Chat', style: const TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(   
            child: ListView.builder(
              controller: _controller,
              itemCount: messagesList.length,
              reverse: true,
              itemBuilder: (context, index) {
                return messagesList[index].id==email ? ChatBubble(
                 // Key(messagesList[index].message!),
                  message: messagesList[index],
                ): ChatBubbleForFriend(
                  //Key(messagesList[index].message!),
                  message: messagesList[index],
                );
              },
            ),
          ),
        TextField(
          controller: messageController,
          onSubmitted: (data) {
            messages.add({
              'text': data,
              'createdAt': DateTime.now(),
              'id': email,
            });
            messageController.clear();
            _controller.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
            );
          },
          decoration: InputDecoration(
            hintText: 'Type a message',
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(


              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            filled: true,
            fillColor: Colors.white10,
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, color: KPrimaryColor),
              onPressed: () {},
            ),
          ),
        )
        ],
      ),
 
    );
       }else{
        return Text('Loading...');
       }
      } ,
    );
  }
}
