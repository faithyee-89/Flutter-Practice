part of cniao5_super_player;

/// 调用原生播放器的方法
class PlayerControllerEvent {
  static final String methodInit = "init";
  static final String methodPlay = "play";
  static final String methodPlayTencentVideo = "play_tencent_video";

  static final String methodStop = "stop";
  static final String methodPause = "pause";
  static final String methodResume = "resume";
  static final String methodRestart = "reStart";
  static final String methodSnapshot = "snapshot";

  static final String methodSeek = "seek";
  static final String methodSetRate = "setRate";
  static final String methodSetMirror = "setMirror";
  static final String methodSetMute = "setMute";
  static final String methodSetVolume = "setVolume";

  static final String methodSwitchVideoQuality = "switchVideoQuality";
  static final String methodIsPlaying = "isPlaying";
  static final String methodGetPlayerstate = "getPlayerState";
}
