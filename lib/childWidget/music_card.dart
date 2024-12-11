import 'package:flutter/material.dart';

class MusicCard extends StatefulWidget {
  const MusicCard({super.key});

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  double _volume = 50;
  double _progress = 30;
  final String _time = "00:00";
  final String _totalTime = "00:00";
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //封面、进度、标题、控制
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              //封面
              Expanded(
                flex: 3,
                child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("images/music_cover.png"))),
              ),
              SizedBox(
                width: 10,
              ),
              // 进度、控制
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("歌曲名",
                              style: TextStyle(color: Colors.black, fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("歌手",
                              style:
                                  TextStyle(color: Colors.grey[500], fontSize: 14)),
                        ],
                      ),
                      _musicProgress(),
                      _playControl(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          //音量
          _volumeControl(),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          //封面、进度、标题、控制
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              //封面
              Expanded(
                flex: 3,
                child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("images/music_cover.png"))),
              ),
              SizedBox(
                width: 10,
              ),
              // 进度、控制
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("歌曲名",
                              style: TextStyle(color: Colors.black, fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("歌手",
                              style:
                                  TextStyle(color: Colors.grey[500], fontSize: 14)),
                        ],
                      ),
                      _musicProgress(),
                      _playControl(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          //音量
          _volumeControl(),
        ],
      ),
    );
  }

  Widget _musicProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _time,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        
        Expanded(
          child: Slider(
            max: 100,
            min: 0,
            value: _progress,
            activeColor: Colors.black,
            onChanged: (value) {
              setState(() {
                _progress = value;
              });
            },
            allowedInteraction: SliderInteraction.slideOnly,
          ),
        ),
        
        Text(_totalTime, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _playControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            print("上一首");
          },
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          decoration: _isPlaying
              ? BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                )
              : null,
          child: IconButton(
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            icon: _isPlaying
                ? const Icon(
                    Icons.pause,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                  ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: () {
            print("下一首");
          },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _volumeControl() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.volume_down),
          color: Colors.grey,
          highlightColor: Colors.black,
          onPressed: () {
            print("音量--");
            setState(() {
              _volume--;
            });
          },
        ),
        Expanded(
          child: Slider(
            max: 100,
            min: 0,
            value: _volume,
            activeColor: Colors.black,
            onChanged: (value) {
              setState(() {
                _volume = value;
              });
            },
            allowedInteraction: SliderInteraction.slideOnly,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.volume_up),
          color: Colors.grey,
          highlightColor: Colors.black,
          onPressed: () {
            print("音量++");
            setState(() {
              _volume++;
            });
          },
        ),
      ],
    );
  }
}
