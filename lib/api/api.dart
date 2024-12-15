import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// 测试token "Bearer 00261056-dcce-4d5b-9e2a-2f0a69c583ec"

class Api {
  //单例
  static final Api _singleton = Api._internal();
  factory Api() {
    return _singleton;
  }
  Api._internal();

  final _dio = Dio();

  final list = [
    "你听说最近 AI 又有新突破了吗？",
    "合理运用这些特性，可以显著提升代码的表达能力和开发效率！",
    "好像是在图像识别领域，准确率又大幅提升了。",
    "那可真是厉害，这对很多行业都会有很大影响吧。",
    "通过这些技巧，VSCode 的多行操作可以大幅提高你的效率，尤其在需要快速编辑或批量操作代码的场景中非常有用。"
  ];

  final _endFlag = "[DONE]";
  var random = 0;

  Future<String> getData(String prompt, String token) async {
    // 模拟网络请求
    // await Future.delayed(Duration(seconds: 2));
    // random++;
    // if (random >= list.length) {
    //   random = 0;
    // }
    // return list[random];
    // 创建dio请求

    try {
      var response = await _dio.post(
          'https://ark.cn-beijing.volces.com/api/v3/chat/completions',
          data: {
            "model": "ep-20241213230627-nmq5m",
            "messages": [
              {
                "role": "system",
                "content": "你是豆包，是由字节跳动开发的 AI 人工智能助手.",
              },
              {"role": "user", "content": prompt}
            ]
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": token
          }));
      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      return '请求失败';
    }
  }

  Stream<String> getDataStream(String prompt, String token) async* {
    // for (int i = 0; i < 10; i++) {
    //   // 模拟网络请求延迟
    //   await Future.delayed(Duration(seconds: 1));
    //   yield '数据 $i';
    // }
    try {
      var response = await _dio.post<ResponseBody>(
          'https://ark.cn-beijing.volces.com/api/v3/chat/completions',
          data: {
            "model": "ep-20241213230627-nmq5m",
            "stream": true,
            "messages": [
              {
                "role": "system",
                "content": "你是豆包，是由字节跳动开发的 AI 人工智能助手.",
              },
              {"role": "user", "content": prompt}
            ]
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": token
          }, responseType: ResponseType.stream));

      final steam = response.data!.stream.transform(
          StreamTransformer<Uint8List, String>.fromHandlers(
              handleData: (data, sink) {
        sink.add(utf8.decode(data));
      }));

      // String accumulatedMessage = '';
      await for (var chunk in steam) {
        // print("chunk: $chunk");
        try {
          // 修复data连续的问题
          var prefix = 'data: ';
          final splits =
              chunk.split(prefix).where((e) => e.isNotEmpty).toList();
          for (var e in splits) {
            e = e.trim();
            if (e.contains("finish_reason")) {
              // print("finish_reason");
              return;
            }
            // 结束句
            if (_endFlag == e) {
              yield "";
            } else {
              var jsonData = jsonDecode(e);
              final content =
                  jsonData['choices'][0]['delta']['content'] as String?;
              // print("content: $content");
              yield content ?? "";
            }
          }
        } catch (e) {
          // 处理 JSON 解析错误
          print('JSON 解析错误: $e');
          throw '解析失败';
        }
      }
    } catch (e) {
      throw '请求失败';
    }
  }

  // StreamController<String> getStreamController() {
  //   StreamController<String> controller = StreamController();
  //   getDataStream().listen(
  //     (data) {
  //       controller.add(data);
  //     },
  //     onDone: () {
  //       print('onDone');
  //       controller.close();
  //     },
  //     onError: (e) {
  //       controller.addError(e);
  //     },
  //   );
  //   return controller;
  // }
}

/*
{
	"choices": [
		{
			"finish_reason": "stop",
			"index": 0,
			"logprobs": null,
			"message": {
				"content": "我是由字节跳动公司训练的人工智能，我的模型是基于 Transformer 架构的大型语言模型。具体来说，我使用了字节跳动的云雀模型作为基础架构，并进行了大量的训练和优化，以提高我的语言理解和生成能力。",
				"role": "assistant"
			}
		}
	],
	"created": 1734102474,
	"id": "02173410247323182365d4a5b5274956b3afa8f956d92c4db80fd",
	"model": "doubao-lite-4k-240328",
	"object": "chat.completion",
	"usage": {
		"completion_tokens": 56,
		"prompt_tokens": 32,
		"total_tokens": 88,
		"prompt_tokens_details": {
			"cached_tokens": 0
		}
	}
}
*/

/*
data: {"choices":[{"delta":{"content":"好","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"的","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"，","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"这","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"是","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"一个","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"笑话","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"：","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"\n \n","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"有","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"一天","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"螃蟹","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"出门","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"不小心","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"撞倒","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"了","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"泥鳅","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"，","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"泥鳅","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"很","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"生气","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"地","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"说","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"：","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"“","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"你","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"是不是","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"瞎","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"啊","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"？","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"”","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"螃蟹","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"说","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"：","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"“","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"不是","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"啊","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"，","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"我","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"是","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"螃蟹","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"。","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"”","role":"assistant"},"index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: {"choices":[{"delta":{"content":"","role":"assistant"},"finish_reason":"stop","index":0}],"created":1734104046,"id":"021734104046345164a27376a8ae6eee5d7d6e49573246693a5a1","model":"doubao-lite-4k-240328","object":"chat.completion.chunk","usage":null}

data: [DONE]


*/