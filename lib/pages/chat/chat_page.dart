import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../data/chat_data.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
        title: const Text('ChatGPT'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Map<String, String> map = chat_list[index];
                  return buildChatItem(map['message']!, map['user']! == "A");
                },
                itemCount: chat_list.length,
              ),
            ),
            if (isLoading) ...[
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 20,
              ),
            ],
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type a message",
                          hintStyle: TextStyle(color: Colors.black54)),
                    )),
                    IconButton(
                        onPressed: () {
                          print("send msessage");
                        },
                        icon: const Icon(Icons.send)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChatItem(String message, bool isMe) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: isMe ? 40 : 10,
                right: isMe ? 10 : 40,
                top: 10,
                bottom: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: isMe ? Colors.grey[200] : Colors.blue[200],
                borderRadius: BorderRadius.circular(10)),
            child:  Text(
              message,
              style: const TextStyle(fontSize: 14),
              maxLines: null,
            ),
          ),
        ),
      ],
    );
  }
}
