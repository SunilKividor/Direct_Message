import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instamessenger/models/message.dart';

class ChatServices {
  //getting all instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    //get user info
    final String senderId = _firebaseAuth.currentUser!.uid;
    final String senderEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create message
    final newMessage = Message(
      senderId: senderId,
      receiverId: receiverId,
      senderEmail: senderEmail,
      timestamp: timestamp,
      message: message,
    );

    //create chat room for these two users
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //storing the message in chatroom
    await _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
  }

  //get message
  Stream<QuerySnapshot> getMessages(
      String userId, String receiverId) {
    List<String> ids = [userId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
