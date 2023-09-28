import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instamessenger/pages/chat_page.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.document, required this.ctx});

  final DocumentSnapshot document;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    void onTap() {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (ctx) => ChatPage(
           receiverEmail: data['email'],
           receiverId: data['uid'],
           receiverDoc: document,
          ),
        ),
      );
    }

    return data['uid'] != FirebaseAuth.instance.currentUser!.uid?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 169, 167, 167),
                      radius: 35,
                      child: ClipOval(
                        child: Image.network(
                          data['imageUrl'],
                          width: 80,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                     Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  data['username'],
                  style: const TextStyle(color: Colors.white,
                  fontSize: 16,
                  ),
                ),
              ),
                  ],

                  
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined,size: 26,color: Color.fromARGB(212, 158, 158, 158),))
            ],
          ),
        ),
      ),
    ) : Container();
  }
}
