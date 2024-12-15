import 'dart:async';

import 'package:DsenHome/api/api.dart';
import 'package:DsenHome/viewmodel/chat_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../data/chat_data.dart';
import '../../viewmodel/chat_view_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var _textEditingController = TextEditingController(text: "你是谁");
  var _scrollController = ScrollController();
  final _focusNode = FocusNode();

  // ChatViewModel _viewModel = ChatViewModel();

  // final streamer = StreamController<String>();

  TypeWriterController? _typeWriterController;

  final ChatController _chatController = Get.put(ChatController());
  final GlobalKey _moreButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // _streamController = TypeWriterController.fromStream(streamer.stream);
    // _chatController.chatList.listen((value) {
    //   print("stream received: $value");
    //   if (_isStreaming) {
    //   } else {
    //     Api().getData().then((value) {
    //       isLoading = false;
    //       setState(() {
    //         _viewModel.streams.add(ChatViewModelItem(
    //           isMe: false,
    //           stream: StreamController()..add(value),
    //           message: value,
    //         ));
    //       });
    //       _scrollToBottom();
    //     });
    //   }
    // },
    // onDone: () {
    //   _isStreaming = false;
    //   print("stream Done");
    // },
    // onError: (error) {
    //   _isStreaming = false;
    //   print("stream error $error");
    // });
    _chatController.scrollToBottom.listen((v) {
      v ? _scrollToBottom() : null;
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _typeWriterController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              key: _moreButtonKey,
              onPressed: () {
                final box = _moreButtonKey.currentContext!.findRenderObject()
                    as RenderBox;
                final position = box.localToGlobal(Offset.zero);
                showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        position.dx, position.dy + box.size.height, 0, 0),
                    items: [
                      PopupMenuItem<String>(
                          child: const Text('清空对话'),
                          onTap: () {
                            _chatController.chatList.clear();
                          }),
                      PopupMenuItem<String>(
                          child: Text(
                              _chatController.isStreaming ? '非流式输出' : '流式输出'),
                          onTap: () {
                            _chatController.isStreaming =
                                !_chatController.isStreaming;
                          }),
                    ]);
              },
              icon: const Icon(Icons.more_horiz))
        ],
        title: const Text('Chat'),
      ),
      body: Obx(() {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (_chatController.isStreaming &&
                        index >= _chatController.chatList.length) {
                      return _buildStreamingReply();
                    }
                    final s = _chatController.chatList[index];
                    return buildChatItem(s);
                  },
                  itemCount: _chatController.chatCount,
                  controller: _scrollController,
                ),
              ),
              StreamBuilder(
                  stream: _chatController.isLoading.stream,
                  builder: (_, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data == true) {
                      return const SpinKitThreeBounce(
                        color: Colors.black,
                        size: 20,
                      );
                    } else {
                      return Container();
                    }
                  }),
              Container(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                            hintText: "说点什么",
                            hintStyle: TextStyle(color: Colors.black54)),
                      )),
                      IconButton(
                          onPressed: () {
                            _sendMessage();
                          },
                          icon: const Icon(Icons.send)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildChatItem(ChatData item) {
    final isMe = item.isMe;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
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
              child: _buildNoStreamText(item)),
        ),
      ],
    );
  }

  Widget _buildNoStreamText(ChatData item) {
    return Text(
      item.message,
      style: const TextStyle(fontSize: 14),
      maxLines: null,
    );
  }

  Widget _buildStreamingText(ChatData item) {
    return item.isMe ? _buildNoStreamText(item) : _buildStreamingReply();
  }

  void _sendMessage() async {
    _chatController.sendMessage(_textEditingController.text);
    setState(() {
      _textEditingController.clear();
      _focusNode.unfocus();
    });

    // _scrollToBottom();
  }

  Widget _buildStreamingReply() {
    final stream = _chatController.streamController?.stream;
    if (stream == null || !_chatController.isTyping) {
      return Container();
    }
    if (_typeWriterController != null) {
      print("销毁上次的打字机流");
      _typeWriterController!.dispose();
    }
    _typeWriterController = TypeWriterController.fromStream(stream);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 40, top: 10, bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: TypeWriter(
        controller: _typeWriterController,
        builder: (BuildContext context, TypeWriterValue value) {
          return Text(
            value.text,
            style: const TextStyle(fontSize: 14),
            maxLines: null,
          );
        },
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
