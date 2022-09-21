package com.cainiaowo.androidnativeproject;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.cainiaowo.androidnativeproject.plugins.PluginGetNameByPigeon;
import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        View viewById = findViewById(R.id.tv_go_flutter);
        viewById.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //通过新引擎跳转默认Flutter页面
//                startFlutterByDefault();
//                //通过新引擎跳转指定Flutter入口
//                startFlutterByNamedRoute();
//                //通过缓存引擎跳转
//                startFlutterByCachedEngine();
                //通过FlutterBoost开启页面
                initFlutterBoost();
                startFlutterByBoost();
            }
        });
    }
    public void startFlutterByDefault(){
                        startActivity(
                                FlutterActivity.createDefaultIntent(MainActivity.this)
                        );
    }
    public void startFlutterByNamedRoute(){
        startActivity(
                FlutterActivity
                        .withNewEngine()
                        .initialRoute("/second")
                        .build(MainActivity.this)
        );
    }

    public void startFlutterByCachedEngine(){

        startActivity(
                FlutterActivity
                        .withCachedEngine("my_engine_id")
                        .build(MainActivity.this)
        );
    }
    public void startFlutterByBoost(){
        HashMap map = new HashMap<>();
        map.put("key", "firstPageFromFlutterBoost");
        FlutterBoostRouteOptions options = new FlutterBoostRouteOptions.Builder()
                .pageName("firstPage")
                .arguments(map)
                .requestCode(1111)
                .build();
        FlutterBoost.instance().open(options);
    }

    //初始化flutterboost
    private void initFlutterBoost() {
        FlutterBoost.instance().setup(AppUtil.sApplication, new FlutterBoostDelegate() {
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

}