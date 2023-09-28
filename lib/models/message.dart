import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({required this.senderId,required this.receiverId,required this.senderEmail,required this.timestamp,required this.message,});
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;
  final String message;

  Map<String,dynamic> toMap(){
    return  {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'senderEmail' : senderEmail,
      'timestamp' : timestamp,
      'message' : message,
    };
  }
}