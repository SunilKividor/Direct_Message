import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.document,
    required this.receiverId,
    required this.isSameNext,
    required this.isSamePrev,
    required this.receiverDoc,
    
  });

  final DocumentSnapshot document;
  final String receiverId;
  final bool isSameNext;
  final bool isSamePrev;
  final DocumentSnapshot receiverDoc;
  

  @override
  Widget build(BuildContext context) {

    //message doc
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //receiver data
    Map<String, dynamic> receiverData = receiverDoc.data() as Map<String, dynamic>;
    //Alignment alignment = data['senderId'] != FirebaseAuth.instance.currentUser!.uid ? Alignment.topLeft :Alignment.topRight;

     final BorderRadius borderRadius = BorderRadius.only(
      topLeft: isSameNext && data['senderId'] != FirebaseAuth.instance.currentUser!.uid ? Radius.circular(4) :  Radius.circular(20),
      topRight:  isSameNext && data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Radius.circular(4) :  Radius.circular(20),
      bottomLeft: isSamePrev && data['senderId'] != FirebaseAuth.instance.currentUser!.uid ? Radius.circular(4) :  Radius.circular(20),
      bottomRight: isSamePrev && data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Radius.circular(4) :  Radius.circular(20),
     );

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 6,top: 1),
      child: Row(
        mainAxisAlignment: data['senderId'] != FirebaseAuth.instance.currentUser!.uid? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
            if(data['senderId'] != FirebaseAuth.instance.currentUser!.uid)
            Padding(padding: const EdgeInsets.only(right: 10),child: !isSamePrev ?
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
              ) :  const CircleAvatar(
                radius: 16,
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                child: ClipOval(
                      child: Icon(Icons.person,color: Colors.black,),
                      
                    ),),
),
            
          
          // if (FirebaseAuth.instance.currentUser!.email != data['senderEmail'])
          //   Text(
          //     data['senderEmail'],
          //   ),
          Container(
             
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
              
              color: data['senderId'] != FirebaseAuth.instance.currentUser!.uid ?const Color.fromARGB(50, 158, 158, 158) : const Color.fromARGB(255, 20, 105, 184),
              borderRadius: borderRadius
            ),
            child: Text(data['message'],textAlign: TextAlign.start,style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400
            ),),),
        ],
      ),
    );
  }
}
