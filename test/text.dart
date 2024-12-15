import 'dart:async';

void main() {
  // 创建一个 StreamController
  final controller = StreamController<int>();

  // 监听 Stream
  final subscription = controller.stream.listen(
    (value) {
      print('Received: $value');
    },
    onError: (error) {
      print('Error: $error');
    },
    onDone: () {
      print('Stream is done.');
    },
    cancelOnError: false,
  );

  // 发送一些数据
  for (int i = 0; i < 5; i++) {
    controller.sink.add(i);
  }
  // controller.close();
}
