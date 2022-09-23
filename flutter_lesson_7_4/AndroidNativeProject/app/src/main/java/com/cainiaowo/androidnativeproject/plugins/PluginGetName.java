package com.cainiaowo.androidnativeproject.plugins;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;

/**
 * Flutter 与 Native 通信的插件类
 * 1.实现FlutterPlugin接口
 * 2.在onAttachedToEngine方法中创建自己的方法通道
 * 3.在方法通道中根据名字调用Native方法
 *
 */
public class PluginGetName implements FlutterPlugin {
    //通道名称(与Native一致)
    static final String platformChannelName="platformChannelName";
    //通道调用方法名称(与Native一致)
    static final String platformChannelMethodName_getNativeName="platformChannelMethodName_getNativeName";

    /**
     * 绑定到引擎时调用
     * @param flutterPluginBinding
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        MethodChannel methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), platformChannelName);
        methodChannel.setMethodCallHandler(
                (call, result) -> {
                    // Note: this method is invoked on the main thread.
                    if (call.method.equals(platformChannelMethodName_getNativeName)) {

                        result.success("Android");
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    }
}
