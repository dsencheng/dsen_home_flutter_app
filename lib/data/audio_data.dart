final audio_play_list = [
  AudioData(
    title: '突然的自我 (Live)',
    artist: '伍佰',
    album: 'album_1',
    imageUrl: 'https://picsum.photos/id/237/200/300',
    audioUrl: 'http://dsen.us.kg:3000/audios/伍佰%20-%20突然的自我%20(Live).mp3',
  ),
  AudioData(
      title: '离歌',
      artist: '信乐团',
      album: 'album_2',
      imageUrl: 'https://picsum.photos/id/238/200/300',
      audioUrl: 'http://dsen.us.kg:3000/audios/信乐团%20-%20离歌.mp3'
  ),
  AudioData(
      title: '刀剑如梦',
      artist: '周华健',
      album: 'album_3',
      imageUrl: 'https://picsum.photos/id/239/200/300',
      audioUrl: 'http://dsen.us.kg:3000/audios/周华健%20-%20刀剑如梦.mp3'
  ),
];

class AudioData {
  final String title;
  final String artist;
  final String album;
  final String imageUrl;
  final String audioUrl;

  AudioData({
    required this.title,
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.audioUrl,
  });
}