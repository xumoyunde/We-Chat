import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/models/chat_user.dart';
import '../api/apis.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Sozlamalari'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          icon: Icon(Icons.logout),
          label: Text('Tark etish'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: Column(
          children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .3),
              child: CachedNetworkImage(
                width: mq.height * .2,
                height: mq.height * .2,
                imageUrl: widget.user.image,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(CupertinoIcons.person)),
              ),
            ),
            SizedBox(height: mq.height * .03),
            Text(
              widget.user.email,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: mq.height * .05),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'm. Valijon Aliyev',
                label: Text('Ismingiz'),
              ),
            ),
            SizedBox(height: mq.height * .02),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'm. juda ham baxtli insonman',
                label: Text('O\'zingiz haqingizda'),
              ),
            ),
            SizedBox(height: mq.height * .05),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                minimumSize: Size(mq.width * .5, mq.height * .06),
              ),
              onPressed: () {},
              icon: Icon(Icons.edit, size: 28,),
              label: Text('Yangilash', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
