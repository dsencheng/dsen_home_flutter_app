// final chat_list = [
//   {"message": "你听说最近 AI 又有新突破了吗？", "user": "A"},
//   {"message": "哦？是什么突破？我还没关注到。", "user": "B"},
//   {"message": "好像是在图像识别领域，准确率又大幅提升了。", "user": "A"},
//   {"message": "那可真是厉害，这对很多行业都会有很大影响吧。", "user": "B"},
// ];

class ChatData {
  final String message;
  final bool isMe;

  ChatData({
    required this.message,
    required this.isMe,
  });
}
