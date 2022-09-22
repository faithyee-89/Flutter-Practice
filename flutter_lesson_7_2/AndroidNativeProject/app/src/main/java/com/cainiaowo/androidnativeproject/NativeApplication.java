package com.cainiaowo.androidnativeproject;

import android.app.Application;
import android.content.Intent;

import com.cainiaowo.androidnativeproject.plugins.PluginGetNameByPigeon;
import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import io.flutter.embedding.android.FlutterActivityLaunchConfigs;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class NativeApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        AppUtil.sApplication = this;
//        FlutterUtil.copyAssetsFile2flutter(this);
        //初始化缓存引擎
//        initFlutterEngine();
        //初始化flutterBoost

        initFlutterBoost();

    }

    //初始化flutterboost
    private void initFlutterBoost() {
        FlutterBoost.instance().setup(this, new FlutterBoostDelegate() {
                    @Override
                    public void pushNativeRoute(FlutterBoostRouteOptions options) {
                        //这里根据options.pageName来判断你想跳转哪个页面，这里简单给一个
                        Intent intent = new Intent(FlutterBoost.instance().currentActivity(), MainActivity.class);
                        FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode());
                    }

                    @Override
                    public void pushFlutterRoute(FlutterBoostRouteOptions options) {
                        Intent intent = new FlutterBoostActivity.CachedEngineIntentBuilder(FlutterBoostActivity.class)
                                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                                .destroyEngineWithActivity(false)
                                .uniqueId(options.uniqueId())
                                .url(options.pageName())
                                .urlParams(options.arguments())
                                .build(FlutterBoost.instance().currentActivity());
                        FlutterBoost.instance().currentActivity().startActivity(intent);
                    }
                }, engine -> {
                    //引擎创建成功时的回调
                    //添加FlutterPlugin到引擎中
//                    engine.getPlugins().add(new PluginGetName());
                    engine.getPlugins().add(new PluginGetNameByPigeon());
                }
        );
    }

    public FlutterEngine flutterEngine;

    public void initFlutterEngine() {
        // Instantiate a FlutterEngine.
        flutterEngine = new FlutterEngine(this);

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);

    }
}
