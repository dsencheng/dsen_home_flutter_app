import 'dart:async';

import 'package:DsenHome/api/api.dart';
import 'package:get/get.dart';

import '../data/chat_data.dart';
import 'chat_view_model.dart';

class ChatController extends GetxController {
  final chatList = <ChatData>[].obs;
  final isLoading = false.obs;
  final scrollToBottom = true.obs;
  // 是否流式返回
  bool isStreaming = true;
  // 是否正在输入
  bool isTyping = false;

  StreamController<String>? streamController;
  String _streamMessage = '';

  get chatCount {
    var count = chatList.length;
    if (isStreaming) {
      count += 1;
    }
    return count;
  }

  void sendMessage(String message) {
    if (message.isEmpty) return;
    chatList.add(ChatData(message: message, isMe: true));
    isLoading.trigger(true);
    scrollToBottom.trigger(true);
    // 接口请求
    if (isStreaming) {
      if (streamController != null) {
        print("释放上次的streamController");
        streamController?.close();
        streamController = null;
      }
      streamController = StreamController.broadcast();
      isTyping = true;
      Api().getDataStream(message).listen((value) {
        // print("value: $value");
        isTyping = true;
        _streamMessage += value;
        streamController?.add(value);

        isLoading.trigger(true);
        scrollToBottom.trigger(true);
      }, onDone: () {
        print("stream done");
        isTyping = false;
        chatList.add(ChatData(message: _streamMessage, isMe: false));
        _streamMessage = '';
        streamController?.close();
        isLoading.trigger(false);
        scrollToBottom.trigger(true);
      }, onError: (error) {
        isTyping = false;
        streamController?.close();
        isLoading.trigger(false);
        scrollToBottom.trigger(true);
        print("stream error: $error");
      });
    } else {
      Api().getData(message).then((value) {
        chatList.add(ChatData(message: value, isMe: false));
        isLoading.toggle();
        scrollToBottom.trigger(true);
      });
    }
  }
}
