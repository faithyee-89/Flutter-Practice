package com.cainiaowo.androidnativeproject.plugins;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * Flutter 与 Native 通信的插件类
 * 1.实现FlutterPlugin接口
 * 2.在onAttachedToEngine方法中创建自己的方法通道
 * 3.在方法通道中根据名字调用Native方法
 *
 */
public class PluginGetNameByPigeon implements FlutterPlugin,RequestChannel.RequestChannelAPI {

    /**
     * 绑定到引擎时调用
     * @param flutterPluginBinding
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        RequestChannel.RequestChannelAPI.setup(flutterPluginBinding.getBinaryMessenger(),this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    }


    @Override
    public RequestChannel.Reply getFinalRequestParams(RequestChannel.RequestParams arg) {
        RequestChannel.Reply reply = new RequestChannel.Reply();
        reply.setReplyName("Android");
        reply.setReplyVersion("1.0");
        return reply;
    }
}
