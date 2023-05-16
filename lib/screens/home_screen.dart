import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('We Chat'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(onPressed: () async {
          await APIs.auth.signOut();
          await GoogleSignIn().signOut();
        }, child: Icon(Icons.add_comment_rounded)),
      ),

      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          final list = [];

          if(snapshot.hasData){
            final data = snapshot.data?.docs;
            for(var i in data!){
              log('Data: ${i.data()}');
              list.add(i.data()['name']);
            }
          }
          return ListView.builder(
            padding: EdgeInsets.only(top: mq.height * .01, bottom: mq.height * .06),
            physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index){
            // return ChatUserCard();
                return Text('Name: ${list[index]}');
          },
          );
        }
      ),
    );
  }
}
