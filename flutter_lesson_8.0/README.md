> # 课程目标
> - 定制Flutter引擎
> - 通过定制源码动态加载so库

# 代码

# 正文

## 一、定制Flutter引擎（安卓）

### 本节课目标

1. 了解修改Flutter引擎的步骤

#### 步骤1. 下载谷歌的工具包depot_tools

下载地址： [https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up)

depot_tools Google代码管理工具包

环境配置
1. 源码获取

    国外：git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

    国内：git clone https://source.codeaurora.org/quic/lc/chromium/tools/depot_tools

    其他：https://storage.googleapis.com/chrome-infra/depot_tools.zip

2. 配置环境变量

    将depot_tools路径加到PATH， export PATH=～/depot_tools:"$PATH"

3. 测试

    gclient是该工具包中的一个工具，执行：gclient config --name src https://source.codeaurora.org/quic/lc/chromium/tools/depot_tools，在当前路径下会生成.gclient文件夹生成

4. 使用
    https://www.chromium.org/developers/how-tos/depottools

#### 步骤2. 在自己的github账号里，fork官方的仓库

官方仓库地址是： [https://github.com/flutter/engine](https://github.com/flutter/engine)

#### 步骤3. 在电脑本地创建文件夹

第三步：在自己的电脑某处创建一个文件夹，名字必须叫engine

#### 步骤4. 创建.gclient

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/7B2FBCAB45C548AFB18BF666A32399AD?ynotemdtimestamp=1663925274257)

#### 步骤5. 运行gclient sync 命令

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/EA002DF1A78E4CB2BC074A945A0A6B1C?ynotemdtimestamp=1663925274257)

#### 步骤6. 获得你想要编译的engine的版本号

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/ECB9C9AE630043D087879FFEF3E018A3?ynotemdtimestamp=1663925274257)

#### 步骤7. 切换分支

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/697555AE2CC9417E8F750F8126D96799?ynotemdtimestamp=1663925274257)

#### 步骤8. client sync

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/FE4A67ACA06541C39B559D0B98E7BCEE?ynotemdtimestamp=1663925274257)

#### 步骤9. 修改源码

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/3024258DB33C4EC1A6E930796121F304?ynotemdtimestamp=1663925274257)

#### 步骤10. 编译源码，生成flutter.jar包

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/A14C11F5907541FFBDA9DA638412F388?ynotemdtimestamp=1663925274257)

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/985E17ED5C5449209AB940AB9E093628?ynotemdtimestamp=1663925274257)

## 二、通过定制源码动态加载so库

示例项目：AndroidNativeProject

### 本节课目标

1. 了解如何在项目里动态加载flutter引擎

#### 步骤1. 移除原有下载so库依赖

在AndroidNativeProject项目下的build.gradle文件进行移除


```gradle
// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {
    repositories {
        jcenter()
        google()
        mavenCentral()
        maven {
            url 'https://jitpack.io'
        }
//        maven {
//            url "https://storage.googleapis.com/download.flutter.io"
//        }
        maven {
            url '/Users/houzirui/Documents/cainiaowo/flutterproject/build/host/outputs/repo'
        }

    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.3.0'
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}
allprojects {
    repositories {
//        flatDir {
//            dirs '../BAF_Flutter_Android/libs'
//        }
        jcenter()
        google()
        mavenCentral()
        maven {
            url 'https://jitpack.io'
        }
//        maven {
//            url "https://storage.googleapis.com/download.flutter.io"
//        }
        // aliyun
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/releases/' }
        maven {
            url 'https://maven.aliyun.com/repository/releases'
        }
        // central&jcenter
        maven { url 'http://maven.aliyun.com/repository/public' }
        // google()
        maven { url 'http://maven.aliyun.com/repository/google' }
        // gradle-plugin
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/gradle-plugin' }
        // jitpack
        maven { url 'https://raw.githubusercontent.com/xiaomi-passport/maven-repository/master/releases' }
        maven { url "http://repo.baichuan-android.taobao.com/content/groups/BaichuanRepositories/" }
        maven { url "http://repo.baichuan-android.taobao.com/content/repositories/BaichuanRepo-staged/" }
        maven {
            url '/Users/houzirui/Documents/cainiaowo/flutterproject/build/host/outputs/repo'
        }
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```


#### 步骤2. 移除原有flutter源码依赖

在项目AndroidNativeProject下的FlutterBridge文件夹下的build.gradle进行移除


```gradle
dependencies {
    api project(':flutter')//需要移除
//
//    api ('com.cainiaowo.flutterproject:flutter_release:1.0'){
//        exclude group: 'io.flutter'
//    }
//    api fileTree(include: ['*.jar'], dir: 'libs')
    implementation 'androidx.appcompat:appcompat:1.3.1'
    implementation 'com.google.android.material:material:1.4.0'
    testImplementation 'junit:junit:4.+'
    androidTestImplementation 'androidx.test.ext:junit:1.1.2'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.3.0'
}
```


#### 步骤3. 添加自己的flutter.jar包依赖

![image](https://note.youdao.com/yws/public/resource/198b0cdfa3bf9b65a8bafc2e8afe829b/E45D322288214A6EAB09BD1A95413170?ynotemdtimestamp=1663925274257)

#### 步骤4. 动态加载flutter.so库

编写工具类，解压保存在本地的so库jar文件。而保存的过程有很多，有的是通过网络拉取，有的是直接保存在本地。

```java
public class FlutterUtil {
    public static final String FLUTTER_SO_NAME = "libflutter.so";

    /**
     * 将文件从assets目录，考贝到 /data/data/包名/files/ 目录中。assets 目录中的文件，会不经压缩打包至APK包中，使用时还应从apk包中导出来
     */
    public static void copyAssetsFile2flutter(Context context) {
        try {
            InputStream inputStream = context.getAssets().open(FLUTTER_SO_NAME);
            //getFilesDir() 获得当前APP的安装路径 /data/data/包名/files 目录
            File file = new File(context.getDir("flutter", Context.MODE_PRIVATE).getPath() + File.separator + FLUTTER_SO_NAME);
            if (!file.exists() || file.length() == 0) {
                FileOutputStream fos = new FileOutputStream(file);//如果文件不存在，FileOutputStream会自动创建文件
                int len = -1;
                byte[] buffer = new byte[1024];
                while ((len = inputStream.read(buffer)) != -1) {
                    fos.write(buffer, 0, len);
                }
                fos.flush();//刷新缓存区
                inputStream.close();
                fos.close();
            } else {
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}

```






#### 步骤5. 初始化flutter引擎

Native的app层，Application类里面进行初始化和加载解压好的so库

```java
public class NativeApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        AppUtil.sApplication = this;
        FlutterUtil.copyAssetsFile2flutter(this);
        //初始化缓存引擎
        initFlutterEngine();
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


```