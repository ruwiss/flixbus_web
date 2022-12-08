import 'package:flixbus/consts/colors.dart';
import 'package:flixbus/controller.dart';
import 'package:flixbus/services/fetch_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  VideoPlayerController? _playerController;
  final Controller _controller = Get.find();
  String _currentName = "";
  bool _permanent = false;

  Future _startVideoPlayer() async {
    if (_playerController == null) {
      _setPlayer();
    } else {
      _removeController();
    }
  }

  Future _removeController({bool permanent = false}) async {
    _permanent = permanent;
    await _playerController!.pause();
    final oldController = _playerController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await oldController!.dispose();
      if (!permanent) {
        setState(() => _playerController = null);
        _startVideoPlayer();
      } else {
        setState(() => _playerController!.pause());
        setState(() => _playerController = null);
      }
    });
  }

  Future _setPlayer() async {
    _controller.tvName.listen((val) {
      if (!val.contains("tamekran:") && _currentName != val) {
        _currentName = val;
        _startVideoPlayer();
      }
    });
    final url = await FetchService()
        .getUrl(_controller.tvName.value.replaceAll("tamekran:", ""));
    _playerController = VideoPlayerController.network(url,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false));
    try {
      await _playerController!.initialize();
      if (!_permanent) {
        _playerController!.play();
      }
      setState(() {});
    } catch (e) {
      print("-" * 5 + e.toString() + "-" * 5);
    }
  }

  @override
  void initState() {
    _startVideoPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _playerController != null
          ? _playerWidget()
          : Center(
              child: CircularProgressIndicator(
                color: MyColors.svgIconColor,
              ),
            ),
    );
  }

  Widget _playerWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_playerController!.value.isInitialized)
          Container(color: Colors.black),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: _playerController!.value.aspectRatio,
                child: VideoPlayer(_playerController!),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _playerController!.value.isPlaying
                            ? _playerController!.pause()
                            : _playerController!.play();
                        setState(() {});
                      },
                      icon: Icon(
                          _playerController!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 25)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "CANLI",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                        onPressed: () async {
                          await _playerController!.pause();
                          await _removeController(permanent: true);
                          _controller.setPlayerFullScreen();
                        },
                        icon: Icon(
                            _controller.isPlayerFullScreen.value
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Colors.white,
                            size: 25)),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _playerController!.dispose();
    super.dispose();
  }
}
