import 'dart:async';

import 'package:DsenHome/api/api.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  List<ChatViewModelItem> streams = [];

  void sendMessage(String text) async {
    Api().getData(text).then((value) {
      streams.add(ChatViewModelItem(
          isMe: false, message: value, stream: StreamController<String>()));
      notifyListeners();
    });
  }
}

class ChatViewModelItem {
  final bool isMe;
  final String message;
  final StreamController<String> stream;
  ChatViewModelItem(
      {required this.isMe, required this.stream, required this.message});
}
