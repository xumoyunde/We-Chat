import 'package:flutter/material.dart';
import 'package:we_chat/api/apis.dart';
import 'package:we_chat/models/message.dart';

import '../main.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04,
              vertical: mq.height * .01,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
              color: Colors.lightBlueAccent.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            ),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            widget.message.sent,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        )
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: mq.width * .04),
            Icon(Icons.done_all_rounded, color: Colors.blue, size: 20,),
            SizedBox(width: 2),
            Text(
              '${widget.message.read}12:00 PM',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04,
              vertical: mq.height * .01,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen),
                color: Colors.lightGreenAccent.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
            ),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
