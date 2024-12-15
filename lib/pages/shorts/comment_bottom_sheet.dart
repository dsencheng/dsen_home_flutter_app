import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentBottomSheet extends StatefulWidget {
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final CommentController commentController = CommentController();

  final TextEditingController textController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 监听焦点变化
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('TextField 获得焦点');
        // _scrollToBottom();
      } else {
        print('TextField 失去焦点');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '评论',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 1),
          // 评论列表
          Obx(() {
            return commentController.comments.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '暂无评论，快来添加吧！',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(commentController.comments[index]),
                          leading: Icon(Icons.person),
                        );
                      },
                    ),
                  );
          }),
          Divider(height: 1),
          // 输入框和按钮
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: '写下你的评论...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    commentController.addComment(textController.text.trim());
                    textController.clear();
                    _scrollToBottom();
                  },
                  child: Text('发送'),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: Colors.white,
          )
        ],
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

class CommentController extends GetxController {
  var comments = <String>[
    "这视频太震撼了！剪辑手法超棒，音乐和画面完美融合，每个镜头都像是在讲故事，已三连支持，期待博主更多佳作！",
    "视频内容挺有趣的，就是开头节奏有点慢，差点没看下去，不过中间开始高能，还是值得一看，加油博主，注意下节奏把控哦。",
    "看这个视频让我想起了很多美好的回忆，拍摄的场景太美了，仿佛身临其境，希望博主能多去一些小众但超美的地方拍摄呀!",
    "说实话，创意不错，但是画质有点模糊，有些细节都看不清楚，影响了整体观感，如果能提升画质就无敌了。",
    "哈哈哈，这个视频太搞笑了，博主太有喜剧天赋了，笑得我肚子疼，强烈推荐给大家，心情不好的时候一定要来看！"
  ].obs; // 使用 RxList 管理评论列表

  void addComment(String comment) {
    if (comment.isNotEmpty) {
      comments.add(comment); // 添加新评论
    }
  }
}
