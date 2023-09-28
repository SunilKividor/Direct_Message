import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instamessenger/services/auth/auth_services.dart';
import 'package:instamessenger/widgets/user_tile.dart';

class ChatUsers extends StatefulWidget {
  const ChatUsers({super.key});

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {

  void logOut() async {
    final AuthServices auth = AuthServices();
    await auth.logOutUser();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar( shadowColor: Colors.grey,elevation: 0.8,title: Row(
        children: [
          const Text('Messenger',
          style: TextStyle(
            fontSize: 28,
            color: Color.fromARGB(255, 83, 46, 204),
          ),
          ),
          const SizedBox(width: 8,),
           Image.asset('assets/images/arrow.png',color: Colors.white,height: 30,),
        ],
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(onPressed: logOut, icon: const Icon(Icons.logout)),
      ],),

      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: StreamBuilder(stream: firebaseFirestore.collection('users').snapshots(), builder: (context,snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        final loadedUsers = snapshot.data!.docs;
          return ListView.builder( itemCount: loadedUsers.length ,itemBuilder: (context,index) => UserTile(document : loadedUsers[index],ctx: context,));
        }),
      ),
    );
  }
}