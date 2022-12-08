import 'package:get/get.dart';
import 'dart:html';

class Controller extends GetxController {
  var isPlayerFullScreen = false.obs;
  var tvName = "".obs;

  setPlayerFullScreen() {
    isPlayerFullScreen.value = !isPlayerFullScreen.value;
    if (isPlayerFullScreen.value) {
      setTvName("tamekran:${tvName.value}");
      document.documentElement!.requestFullscreen();
    } else {
      setTvName(tvName.value.replaceAll("tamekran:", ""));
      document.exitFullscreen();
    }
    isPlayerFullScreen.refresh();
  }

  setTvName(String name) {
    tvName.value = name;
    tvName.refresh();
  }
}
