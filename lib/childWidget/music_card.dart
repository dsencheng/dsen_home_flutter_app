import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

import '../data/audio_data.dart';

enum AudioAction {
  Play,
  Paused,
  Stopped,
  Buffering,
  Error,
  Next,
  Previous,
}

class MusicCard extends StatefulWidget {
  const MusicCard({super.key});

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  double _volume = 0.5;
  double _progress = 0.0;
  String _time = "00:00";
  String _totalTime = "00:00";
  bool _isPlaying = false;
  String _name = "未知";
  String _artist = "未知";

  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    print(#initState);
    loadAudio();
  }

  @override
  void deactivate() {
    print(#deactivate);
    audioPlayerDispose();
    super.deactivate();
  }

  @override
  void dispose() {
    print(#dispose);
    audioPlayerDispose();
    super.dispose();
  }

  void audioPlayerDispose() async {
    // if (_audioPlayer?.playing == true) {
    //   print("播放中");
    //   await _audioPlayer?.stop();
    // }
    _audioPlayer?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const SizedBox(
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
              const SizedBox(
                width: 10,
              ),
              // 进度、控制
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(_name,
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(_artist,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 14)),
                        ],
                      ),
                      _musicProgress(),
                      _playControl(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              const SizedBox(
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
            max: 1.0,
            min: 0,
            value: _progress,
            activeColor: Colors.black,
            onChanged: (value) {
              _progress = value;
              _seekTo();
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
            _play(AudioAction.Previous);
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
              _play(_isPlaying ? AudioAction.Play : AudioAction.Paused);
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
            _play(AudioAction.Next);
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
              _volume -= 0.1;
            });
            _volumeChange();
          },
        ),
        Expanded(
          child: Slider(
            max: 1.0,
            min: 0,
            value: _volume,
            activeColor: Colors.black,
            onChanged: (value) {
              setState(() {
                _volume = value;
              });
              _volumeChange();
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
              _volume += 0.1;
            });
            _volumeChange();
          },
        ),
      ],
    );
  }

  void loadAudio() async {
    try {
      _audioPlayer = AudioPlayer();

      final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: audio_play_list
            .map((e) => AudioSource.uri(Uri.parse(e.audioUrl)))
            .toList(),
      );

      await _audioPlayer?.setAudioSource(playlist,
          initialIndex: 0, initialPosition: Duration.zero);
      await _audioPlayer?.setShuffleModeEnabled(true);
      await _audioPlayer?.setLoopMode(LoopMode.all);

      _audioPlayer?.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.idle) {
          print("Player is idle");
        } else if (playerState.processingState == ProcessingState.loading) {
          print("Player is loading");
        } else if (playerState.processingState == ProcessingState.buffering) {
          print("Player is buffering");
        } else if (playerState.processingState == ProcessingState.ready) {
          print("Player is ready");
        } else if (playerState.processingState == ProcessingState.completed) {
          print("Player has completed");
        }
      });

      _audioPlayer?.durationStream.listen((duration) {
        print("获取时间");
        if (mounted) {
          if (duration != null) {
            setState(() {
              _totalTime = _formatDuration(duration);
            });
          }
        }
      });

      _audioPlayer?.positionStream.listen((position) {
        print("播放时间偏移");
        if (mounted) {
          setState(() {
            _time = _formatDuration(position);
          });
        }
      });

      _audioPlayer?.currentIndexStream.listen((index) {
        print("当前播放索引");
        if (mounted) {
          if (index != null) {
            final item = audio_play_list[index];
            setState(() {
              _name = item.title;
              _artist = item.artist;
            });
          }
        }
      });
    } on Exception catch (e) {
      print("初始化播放器错误 $e");
    }
  }

  void _play(AudioAction state) async {
    switch (state) {
      case AudioAction.Play:
        await _audioPlayer?.play();
      case AudioAction.Paused:
        await _audioPlayer?.pause();
      case AudioAction.Stopped:
        await _audioPlayer?.stop();
      case AudioAction.Buffering:
      case AudioAction.Error:
      case AudioAction.Next:
        await _audioPlayer?.seekToNext();
        setState(() {
          _progress = 0.0;
        });
      case AudioAction.Previous:
        await _audioPlayer?.seekToPrevious();
        setState(() {
          _progress = 0.0;
        });
    }
  }

  void _volumeChange() async {
    await _audioPlayer?.setVolume(_volume);
  }

  void _seekTo() async {
    if (_audioPlayer?.duration != null) {
      final seekTime = Duration(
          milliseconds:
              (_audioPlayer!.duration!.inMilliseconds * _progress).toInt());
      await _audioPlayer?.seek(seekTime);
    }
  }

  String _formatDuration(Duration duration) {
    return DateFormat('mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds));
  }
}
