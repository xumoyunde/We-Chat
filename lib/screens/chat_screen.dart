import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/widgets/message_card.dart';
import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),

        backgroundColor: Color(0xffF0F8FF),

        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    // if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    // if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      log('Data: ${jsonEncode(data![0].data())}');
                      // _list =
                      //     data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                      //         [];
                      _list.clear();
                      _list.add(Message(
                          msg: 'Hii',
                          read: '',
                          told: 'xyz',
                          type: Type.text,
                          fromId: APIs.user.uid,
                          sent: '12:00 AM'));
                      _list.add(Message(
                          msg: 'Hello',
                          read: '',
                          told: APIs.user.uid,
                          type: Type.text,
                          fromId: 'xyz',
                          sent: '12:05 AM'));

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.only(
                              top: mq.height * .01, bottom: mq.height * .06),
                          physics: BouncingScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return MessageCard(
                              message: _list[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: Text(
                          '👋 Salom, menga yozing ...',
                          style: TextStyle(fontSize: 20),
                        ));
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: mq.height * .055,
              height: mq.height * .055,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2),
              Text(
                'Tarmoqda mavjud emas',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.blueAccent,
                        size: 25,
                      )),
                  const Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Salom, yaxshimisiz...',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: Colors.blueAccent,
                        size: 26,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.blueAccent,
                        size: 26,
                      )),
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: CircleBorder(),
            color: Colors.green,
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
