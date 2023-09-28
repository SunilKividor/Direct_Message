import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instamessenger/services/chat/chat_services.dart';
import 'package:instamessenger/widgets/build_chat_item.dart';
import 'package:instamessenger/widgets/build_message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
    required this.receiverDoc,
  });
  final String receiverEmail;
  final String receiverId;
  final DocumentSnapshot receiverDoc;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    final message = messageController.text;
     messageController.clear();
     FocusScope.of(context).unfocus();
    if (message.isNotEmpty) {
      await ChatServices()
          .sendMessage(widget.receiverId, message);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    //receiver data
    Map<String, dynamic> receiverData = widget.receiverDoc.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 169, 167, 167),
                radius: 16,
                child: ClipOval(
                  child: Image.network(
                    receiverData['imageUrl'],
                    width: 40,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(receiverData['username'],style: const TextStyle(
                  fontSize: 16
                ),),
                Text(receiverData['email'],style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 158, 158, 158)
                ),)
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
           
            //message list
            Expanded(child: _buildChatList()),
      
            //message input field
            MessageInput(
              controller: messageController,
              sendMessage: sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return StreamBuilder(
      stream: ChatServices()
          .getMessages(_firebaseAuth.currentUser!.uid, widget.receiverId),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong. Try again!'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final loadedMessages = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {

              bool isSameUser = false;
              bool isSamePrev = false;

             if(index+1 <loadedMessages.length) {

                 final DocumentSnapshot nextUser = loadedMessages[index + 1];
                final DocumentSnapshot currUser = loadedMessages[index];
               

                Map<String, dynamic> nextDoc =
                    nextUser.data() as Map<String, dynamic>;
                Map<String, dynamic> currDoc =
                    currUser.data() as Map<String, dynamic>;
                if (currDoc['senderId'] == nextDoc['senderId']) {
                  isSameUser = true;
                }
                if(index > 0){
                   final DocumentSnapshot prevUser = loadedMessages[index - 1];
                    Map<String, dynamic> prevDoc =
                    prevUser.data() as Map<String, dynamic>;
                    if(currDoc['senderId'] == prevDoc['senderId']){
                      isSamePrev = true;
                    }
                }
              }

              return ChatItem(
                document: loadedMessages[index],
                isSameNext: isSameUser,
                receiverId: widget.receiverId,
                isSamePrev: isSamePrev,
                receiverDoc: widget.receiverDoc,
              );
            });
      },
    );
  }
}
