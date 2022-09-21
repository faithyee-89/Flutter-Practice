package com.tencent.tx_super_player;

import android.graphics.Bitmap;
import android.graphics.SurfaceTexture;
import android.os.Bundle;
import android.util.Log;
import android.view.Surface;
import android.widget.Toast;

import com.tencent.liteav.demo.superplayer.SuperPlayerDef;
import com.tencent.liteav.demo.superplayer.model.PlayerNetStatusModel;
import com.tencent.liteav.demo.superplayer.model.SuperPlayer;
import com.tencent.liteav.demo.superplayer.model.SuperPlayerImpl;
import com.tencent.liteav.demo.superplayer.model.SuperPlayerObserver;
import com.tencent.liteav.demo.superplayer.model.entity.PlayImageSpriteInfo;
import com.tencent.liteav.demo.superplayer.model.entity.PlayKeyFrameDescInfo;
import com.tencent.liteav.demo.superplayer.model.entity.VideoQuality;
import com.tencent.liteav.demo.superplayer.model.utils.NetWatcher;
import com.tencent.rtmp.ITXVodPlayListener;
import com.tencent.rtmp.TXLivePlayer;
import com.tencent.rtmp.TXVodPlayer;
import com.tencent.rtmp.ui.TXCloudVideoView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

/**
 * 菜鸟窝http://www.cniao5.com 一个高端的互联网技能学习平台
 *
 * @author Ivan
 * @version V1.0
 * @Package com.tencent.tx_super_player
 * @Description: (用一句话描述该文件做什么)
 * @date
 */
public class Cniao5SuperPlayer extends FTXBasePlayer implements MethodChannel.MethodCallHandler {

    private FlutterPlugin.FlutterPluginBinding mFlutterPluginBinding;

    final private MethodChannel mMethodChannel;
    private final EventChannel mEventChannel;
    private final EventChannel mNetChannel;

    private SurfaceTexture mSurfaceTexture;
    private Surface mSurface;

    final private FTXPlayerEventSink mEventSink = new FTXPlayerEventSink();
    final private FTXPlayerEventSink mNetStatusSink = new FTXPlayerEventSink();

    private SuperPlayer mSuperPlayer;
    private TXCloudVideoView mTXCloudVideoView;

    private static final int Uninitialized = -102;
    private TextureRegistry.SurfaceTextureEntry mSurfaceTextureEntry;

    private final  String  channelName = "cloud.tencent.com/mysuperplayer/";
    private final  String  channelEventName = channelName + "event/";
    private final  String  channelNetName = channelName + "net/";



    private  final static String METHOD_INIT="init";
    private  final static String METHOD_PLAY="play";
    private  final static String METHOD_PLAY_TENCENT_VIDEO="play_tencent_video";
    private  final static String METHOD_STOP="stop";
    private  final static String METHOD_PAUSE="pause";
    private  final static String METHOD_RESUME="resume";
    private  final static String METHOD_RESTART="reStart";
    private  final static String METHOD_SNAPSHOT="snapshot";

    private  final static String METHOD_SEEK="seek";
    private  final static String METHOD_SET_RATE="setRate";
    private  final static String METHOD_SET_MUTE="setMute";
    private  final static String METHOD_SET_VOLUME="setVolume";
    private  final static String METHOD_SET_MIRROR="setMirror";

    private  final static String METHOD_SWITCH_VIDEOQUALITY="switchVideoQuality";
    private  final static String METHOD_IS_PLAYING="isPlaying";
    private  final static String METHOD_GET_PLAYERSTATE="getPlayerState";


    private final static String TAG_NAME="Cniao5SuperPlayer";



    public Cniao5SuperPlayer(FlutterPlugin.FlutterPluginBinding flutterPluginBinding){
        super();
        mFlutterPluginBinding = flutterPluginBinding;


        mMethodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), channelName + super.getPlayerId());
        mMethodChannel.setMethodCallHandler(this);

        mEventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), channelEventName + super.getPlayerId());
        mEventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                mEventSink.setEventSinkProxy(eventSink);
            }

            @Override
            public void onCancel(Object o) {
                mEventSink.setEventSinkProxy(null);
            }
        });

        mNetChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), channelNetName + super.getPlayerId());
        mNetChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                mNetStatusSink.setEventSinkProxy(eventSink);
            }

            @Override
            public void onCancel(Object o) {
                mNetStatusSink.setEventSinkProxy(null);
            }
        });

    }


    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {

        String evenName = methodCall.method;

        switch (evenName){

            case METHOD_INIT:
                boolean onlyAudio = methodCall.argument("onlyAudio");
                long id = init(onlyAudio);
                result.success(id);
                break;
            case  METHOD_PLAY:
                String url = methodCall.argument("url");
                result.success(this.play(url));
                break;

            case METHOD_PLAY_TENCENT_VIDEO:
                this.playTencentVideo(methodCall);
                break;

            case METHOD_STOP:
                this.stop();
                break;

            case METHOD_PAUSE:
                this.pause();
                break;

            case METHOD_RESUME:
                this.resume();
                break;

            case METHOD_RESTART:
                this.reStart();
                break;

            case METHOD_SNAPSHOT:
                this.snapshot();
                break;

            case METHOD_SEEK:

                int position = methodCall.argument("position");
                this.seek(position);
                break;

            case METHOD_SET_RATE:
                Double rate = methodCall.argument("rate");
                this.setRate(rate.floatValue());
                break;

            case METHOD_SET_MUTE:
                boolean isMute = methodCall.argument("isMute");
                this.setMute(isMute);
                break;

            case METHOD_SET_VOLUME:
                int volume = methodCall.argument("volume");
                this.setVolume(volume);
                break;


            case METHOD_SET_MIRROR:
                boolean isMirror = methodCall.argument("isMirror");
                this.setMirror(isMirror);
                break;


            case METHOD_IS_PLAYING:
               boolean isPlaying =  this.isPlaying();
                result.success(isPlaying);
                break;


            case METHOD_GET_PLAYERSTATE:
                String state=  this.getPlayerState();
                result.success(state);
                break;



            case  METHOD_SWITCH_VIDEOQUALITY:
                int index = methodCall.argument("index");
                String videoUrl = methodCall.argument("url");

                this.switchVideoQuality(index,videoUrl);
                break;


        }


    }

    protected long init(boolean onlyAudio){

        if(mSuperPlayer ==null){
            mTXCloudVideoView = new TXCloudVideoView(mFlutterPluginBinding.getApplicationContext());
            mSuperPlayer =  new SuperPlayerImpl(mFlutterPluginBinding.getApplicationContext(),mTXCloudVideoView);

            //事件监听器
            mSuperPlayer.setObserver(new VodSuperPlayerObserver(mEventSink));
            // todo 网络监听

            setPlayer(onlyAudio);

            Log.d(TAG_NAME, "mSuperPlayerView 初始化完成"+ mSuperPlayer);

        }
        return mSurfaceTextureEntry == null ? -1 : mSurfaceTextureEntry.id();
    }

    void setPlayer(boolean onlyAudio) {
        if (!onlyAudio) {
            mSurfaceTextureEntry =  mFlutterPluginBinding.getTextureRegistry().createSurfaceTexture();
            mSurfaceTexture = mSurfaceTextureEntry.surfaceTexture();
            mSurface = new Surface(mSurfaceTexture);

            if (mSuperPlayer != null) {

                mSuperPlayer.setSurface(mSurface);
                Log.d(TAG_NAME, "设置 mSurface 完成"+ mSurface);
            }
        }
    }


    int play(String url) {
        if (mSuperPlayer != null) {
            Log.d("MySuperPlayer", "开始播放："+url );
            mSuperPlayer.play(url);
        }
        return Uninitialized;
    }

    // 播放腾讯视频
    void playTencentVideo(MethodCall methodCall){

        int appId = methodCall.argument("appId");
        String fileId = methodCall.argument("fileId");
        String psign = methodCall.argument("psign");

        if(this.mSuperPlayer !=null){
            this.mSuperPlayer.play(appId,fileId,psign);
        }

    }

    // 停止播放
    int stop() {
        if (mSuperPlayer != null) {
            mSuperPlayer.stop();
        }
        return Uninitialized;
    }

    void pause(){

        if (mSuperPlayer != null) {
            mSuperPlayer.pause();
        }

    }
    void resume(){

        if (mSuperPlayer != null) {
            mSuperPlayer.resume();
        }

    }

    void reStart(){

        if (mSuperPlayer != null) {
            mSuperPlayer.reStart();
        }

    }

    void snapshot(){

        if (mSuperPlayer != null) {
            mSuperPlayer.snapshot(new TXLivePlayer.ITXSnapshotListener() {
                @Override
                public void onSnapshot(Bitmap bitmap) {

                }
            });
        }

    }

    void seek(int position){

        if (mSuperPlayer != null) {
            mSuperPlayer.seek(position);
        }

    }

    /**
     * 设置播放速率
     * @param rate
     */
    void setRate(float rate){

        if (mSuperPlayer != null) {
            mSuperPlayer.setRate(rate);
        }

    }

    void setMute(boolean isMute){

        if (mSuperPlayer != null) {
            mSuperPlayer.setMute(isMute);
        }

    }

   void  setVolume(int volume){
       if (mSuperPlayer != null) {
           mSuperPlayer.setVolume(volume);
       }
    }

    /**
     * 设置镜像
     * @param isMirror
     */
    void setMirror(boolean isMirror){

        if (mSuperPlayer != null) {
            mSuperPlayer.setMirror(isMirror);
        }
    }

    /**
     * 设置清晰度
     * @param index
     * @param url
     */

    void switchVideoQuality(int index,String url){

        if (mSuperPlayer != null) {
            VideoQuality quality = new VideoQuality();
            quality.index = index;
            quality.url = url;
            mSuperPlayer.switchStream(quality);
        }
    }

    boolean isPlaying() {
        if (mSuperPlayer != null) {
            return  mSuperPlayer.isPlaying();
        }
        return false;
    }

    String  getPlayerState(){

        if (mSuperPlayer != null) {
            return  mSuperPlayer.getPlayerState().name();
        }
        return  "";
    }


    @Override
    public void destory() {
        if (mSuperPlayer != null) {
            mSuperPlayer.stop();
            mSuperPlayer.destroy();
            mSuperPlayer =null;
        }

        if (mSurfaceTextureEntry != null) {
            mSurfaceTextureEntry.release();
            mSurfaceTextureEntry = null;
        }

        if (mSurfaceTexture != null) {
            mSurfaceTexture.release();
            mSurfaceTexture = null;
        }

        if (mSurface != null) {
            mSurface.release();
            mSurface = null;
        }

        mMethodChannel.setMethodCallHandler(null);
        mEventChannel.setStreamHandler(null);
        mNetChannel.setStreamHandler(null);

//        mEventSink.success();
    }



    // 点播播放器事件观察者, 回调给Flutter 端
    class  VodSuperPlayerObserver extends SuperPlayerObserver{
        FTXPlayerEventSink mEventSink;

        public VodSuperPlayerObserver(FTXPlayerEventSink eventSink){
            this.mEventSink = eventSink;
        }

        private Map<String, Object> getParams(String eventName){

            Map<String,Object> map = new HashMap<>();
            map.put("event",eventName);

            return map;
        }

        private void callbackToFlutter(Map<String,Object> map ){
            this.mEventSink.success(map);
        }


        @Override
        public void initialized() {
            this.callbackToFlutter(this.getParams(PlayerEvent.INITIALIZED));
        }

        @Override
        public void destroy() {
            this.callbackToFlutter(this.getParams(PlayerEvent.DESTROY));
        }

        @Override
        public void onPlayBegin(String name) {

            Map<String,Object> map = this.getParams(PlayerEvent.BEGIN_PLAY);
            map.put("videoName",name);

            this.callbackToFlutter(map);

        }

        @Override
        public void onPlayPause() {
            this.callbackToFlutter(this.getParams(PlayerEvent.PAUSE));

        }

        @Override
        public void onPlayStop() {
            this.callbackToFlutter(this.getParams(PlayerEvent.STOP));

        }

        @Override
        public void onPlayLoading() {
            this.callbackToFlutter(this.getParams(PlayerEvent.LOADING));
        }

        @Override
        public void onPlayLoadingEnd() {
            this.getParams(PlayerEvent.LOADING_END);
        }

        @Override
        public void onPlayProgress(long current, long duration,long playableDuration) {
            Map<String,Object> map = this.getParams(PlayerEvent.PROGRESS);
            map.put("current",current);
            map.put("duration",duration);
            map.put("playableDuration",playableDuration);

            this.callbackToFlutter(map);
        }

        @Override
        public void onSeek(int position) {

        }

        @Override
        public void onSwitchStreamStart(boolean success, SuperPlayerDef.PlayerType playerType, VideoQuality quality) {

            Map<String,Object> map = this.getParams(PlayerEvent.SWITCH_QUALITY_START);
            map.put("success",success);
            map.put("quality",this.videoQualityToJsonObj(quality).toString());


            this.callbackToFlutter(map);
        }

        @Override
        public void onSwitchStreamEnd(boolean success, SuperPlayerDef.PlayerType playerType, VideoQuality quality) {

            Log.d(TAG_NAME,"切换清晰度结束:"+success);

            Map<String,Object> map = this.getParams(PlayerEvent.SWITCH_QUALITY_END);
            map.put("success",success);
            map.put("quality",this.videoQualityToJsonObj(quality).toString());

            Log.d(TAG_NAME,"切换清晰度结束通知成功");

        }

        @Override
        public void onPlayerTypeChange(SuperPlayerDef.PlayerType playType) {

        }

        @Override
        public void onPlayTimeShiftLive(TXLivePlayer player, String url) {

        }

        @Override
        public void onVideoQualityListChange(List<VideoQuality> videoQualities, VideoQuality defaultVideoQuality) {

            try {

                String defaultJson ="";

                if(defaultVideoQuality !=null) {

                    JSONObject objectDefault = this.videoQualityToJsonObj(defaultVideoQuality);
                    defaultJson = objectDefault.toString();
                }


                String urls = "";
                if (videoQualities != null && videoQualities.size() > 0) {

                    JSONArray array = new JSONArray();

                    for (VideoQuality videoQuality : videoQualities) {

                        JSONObject object = this.videoQualityToJsonObj(videoQuality);

                        array.put(object);
                    }

                    urls = array.toString();
                }

                Map<String, Object> map = this.getParams(PlayerEvent.VIDEO_QUALITY_LIST_CHANGE);
                map.put("urls", urls);
                map.put("default",  defaultJson);

                this.callbackToFlutter(map);
            }catch (Exception e){
                e.printStackTrace();
                Log.e(TAG_NAME, "更新画质信息出错"+e.toString());
            };

        }

        @Override
        public void onVideoImageSpriteAndKeyFrameChanged(PlayImageSpriteInfo info, List<PlayKeyFrameDescInfo> list) {

        }

        @Override
        public void onError(int code, String message) {

            Map<String,Object> map = this.getParams(PlayerEvent.ERROR);
            map.put("code",code);
            map.put("message",message);

            this.callbackToFlutter(map);

        }

        @Override
        public void onPlayerNetStatus(PlayerNetStatusModel netStatus) {
            Map<String, Object> map = this.getParams(PlayerEvent.NET_STATUS);
            map.put("netStatus",netStatus.toJson());
            this.callbackToFlutter(map);
        }


        private JSONObject videoQualityToJsonObj(VideoQuality videoQuality){

            try {

                JSONObject object = new JSONObject();
                object.put("url", videoQuality.url==null?"":videoQuality.url);
                object.put("index", videoQuality.index);
                object.put("name", videoQuality.name==null?"":videoQuality.name);
                object.put("title", videoQuality.title!=null?videoQuality.title:"");
                object.put("bitrate", videoQuality.bitrate);

                return object;

            }catch (Exception e){
                e.printStackTrace();
                Log.d(TAG_NAME,"VideoQuality 转换成JSONObject 错误： "+e.toString());
            }

            return  null;

        }
    }
}
