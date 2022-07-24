import 'package:chat_app/constant.dart';
import 'package:chat_app/widgets/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static const String id = 'ChatPage';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          List<Message> messagesList = [];

          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            print(snapshot.data!.docs[0]['message']);
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'i',
                    child: Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (messagesList[index].id == email) {
                        return ChatBuble(
                          message: messagesList[index],
                        );
                      } else {
                        return ChatBubleForFriend(message: messagesList[index]);
                      }
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        'message': data,
                        'createdAt': DateTime.now(),
                        'id': email
                      }).then((value) {
                        print('message added');
                      }).catchError((e) {
                        print(e.toString());
                      });
                      _controller.animateTo(0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                      controller.clear();
                    },
                    decoration: InputDecoration(
                        hintText: 'send message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                              size: 40,
                            ))),
                  ),
                )
              ],
            ),
          );
        });
  }
}
