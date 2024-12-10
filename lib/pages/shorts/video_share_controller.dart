import 'package:get/get.dart';

class VideoShareController extends GetxController{
  var isPlaying = false.obs;

  void changePlaying(){
    isPlaying.value = !isPlaying.value;
  }

  @override
  void onInit() {
    super.onInit();
    print("VideoShareController 初始化了");
    isPlaying.listen((p){
      print("播放状态监听：$p");
    });
  }

  @override
  void onClose() {
    print("VideoShareController 关闭了");
    super.onClose();
  }
}