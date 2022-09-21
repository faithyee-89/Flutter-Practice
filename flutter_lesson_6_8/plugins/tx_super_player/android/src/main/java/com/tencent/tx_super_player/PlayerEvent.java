package com.tencent.tx_super_player;

/**
 * 菜鸟窝http://www.cniao5.com 一个高端的互联网技能学习平台
 *
 * @author Ivan
 * @version V1.0
 * @Package com.tencent.tx_super_player
 * @Description: (用一句话描述该文件做什么)
 * @date
 */
public class PlayerEvent {

    //播放器已初始化
    public  static final  String INITIALIZED="initialized";

    public  static final  String DESTROY="destroy";


    //开始播放
    public  static final  String BEGIN_PLAY="begin_play";

    //暂停播放
    public  static final  String PAUSE="pause";

    public  static final  String STOP="stop";

    // 播放器进入缓冲
    public  static final  String LOADING="loading";

    // 缓冲结束
    public  static final  String LOADING_END="loading_end";

    public  static final  String ERROR="error";

    public  static final  String PROGRESS="progress";

    public  static final  String VIDEO_QUALITY_LIST_CHANGE="video_quality_list_change";

    /**
     * 网络状态
     */
    public  static final  String NET_STATUS="net_status";

    /**
     * 开始切换清晰度
     */
    public  static final  String SWITCH_QUALITY_START="switch_quality_start";

    /**
     * 清晰度切换成功
     */
    public  static final  String SWITCH_QUALITY_END="switch_quality_end";




}
