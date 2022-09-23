> # 课程目标
> - Android发布模式流程
> - Android 打包aar 实战
> - iOS的发布模式

# 正文

### 一、Android发布模式流程

- 本节课目标

    1. 了解如何将flutter打包成aar
    2. 将nativeFlutterBridge模块打包aar

#### 1. 将flutter模块打包成aar

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/B0FE3CA5B7A24145B62565B1C0D0C6D0?ynotemdtimestamp=1663952153937)

#### 2. 将依赖flutter工程aar的AndroidFlutterBridge工程打包成aar上传

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/F4084EDC1A1F42E98402A484FFB339D9?ynotemdtimestamp=1663952153937)

#### 3. 主工程项目使用远程maven的aar依赖

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/8A9892465CB9404597CE21D71BD836FE?ynotemdtimestamp=1663952153937)

### 二、Android 打包aar 实战

项目：flutterproject、AndroidNativeProject

#### 1. 构建flutter项目的aar文件

在flutterproject项目中运行aar打包命令


```
///自动化步骤
///1、flutter build aar --target-platform android-arm --no-debug --no-profile
///1、flutter build aar --target-platform android-arm --no-release --no-profile
///1、flutter build aar --no-release --no-profile
//////1、flutter build aar
//////1、flutter build aar --no-debug --no-release
//////1、flutter build aar --no-debug --no-profile
///2、找到所有的 aar 文件对应的 pom 文件, 使用 xml 解析并将版本号修改, 同时修改依赖对应的版本号
///3、上传 aar 和 pom
///4、修改 android 端的依赖到最新的 flutter 版本号
```


#### 2. 上传文件到maven仓库中

执行flutterproject项目中的脚本：upload.dart


```
dart bin/upload.dart
```


```dart
// @dart=2.8

import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart' as xml;

///自动化步骤
///1、flutter build aar --target-platform android-arm --no-debug --no-profile
///1、flutter build aar --target-platform android-arm --no-release --no-profile
///1、flutter build aar --no-release --no-profile
//////1、flutter build aar
//////1、flutter build aar --no-debug --no-release
//////1、flutter build aar --no-debug --no-profile
///2、找到所有的 aar 文件对应的 pom 文件, 使用 xml 解析并将版本号修改, 同时修改依赖对应的版本号
///3、上传 aar 和 pom
///4、修改 android 端的依赖到最新的 flutter 版本号

///找到所有的 aar 文件对应的 pom 文件, 使用 xml 解析并将版本号修改, 同时修改依赖对应的版本号,上传 aar 和 pom
const targetVersion = "0.0.1-SNAPSHOT";

class DeployObject {
  File pomFile;
  File aarFile;
}

void main() {
  List<File> aarFiles = [];
  List<String> needChangeList = [];
  List<DeployObject> deploys = [];

  final dir = Directory("build/host/outputs/repo");

  // 扫描aar
  for (final file in dir.listSync(recursive: true)) {
    if (file.path.endsWith(".aar")) {
      aarFiles.add(file); // aar文件
      needChangeList.add(
        file.uri.pathSegments[file.uri.pathSegments.length - 3],
      ); // 库的名称, 只扫描了项目名称, 没有扫描组名, 如果有重名, 需要增加对于包名的处理
    }
  }

  for (final aar in aarFiles) {
    final pomFile = handlePom(needChangeList, aar); // 处理pom文件
    deploys.add(DeployObject()
      ..aarFile = aar
      ..pomFile = pomFile);
  }

  for (final deploy in deploys) {
    // 只传release包
    if (deploy.pomFile.absolute.path.contains("_release-")) {
      // if (deploy.pomFile.absolute.path.contains("_debug-")) {
      deployPkt(deploy);
    }
  }
}

File handlePom(List<String> needChangeVersionList, File aarFile) {
  final pomPath = aarFile.path.substring(0, aarFile.path.length - 3) + 'pom';

  final file = File(pomPath);

  final doc = xml.parse(file.readAsStringSync());

  {
    // 修改自身的版本号
    final xml.XmlText versionNode =
        doc.findAllElements("version").first.firstChild;
    versionNode.text = targetVersion;

    // 这里添加大括号只是为了看的清楚, 实际可不加
  }

  final elements = doc.findAllElements("dependency");
  for (final element in elements) {
    final artifactId = element.findElements("artifactId").first.text;
    if (needChangeVersionList.contains(artifactId)) {
      final xml.XmlText versionNode =
          element.findElements("version").first.firstChild;
      versionNode.text = targetVersion; // 修改依赖的版本号
    }
  }

//  final buffer = StringBuffer();

//  doc.writePrettyTo(buffer, 0, "  ");
//  print(buffer);

//  return file..writeAsStringSync(buffer.toString());

  // dart升级造成的写法变更
  return file..writeAsStringSync(doc.toXmlString(pretty: true));
}

Future<void> deployPkt(DeployObject deploy) async {
  final configPath = File('mvn-settings.xml').absolute.path;
  print("mvn-settings.xml路径为：" + configPath);

  List<String> args = [
    'deploy:deploy-file',
    '-DpomFile="${deploy.pomFile.absolute.path}"',
    '-DgeneratePom=false',
    '-Dfile="${deploy.aarFile.absolute.path}"',
    '-Durl="http://xxx/repositories/beijing-maven-snapshot/"',
    '-DrepositoryId="beijing-maven-snapshot"',
    '-Dpackaging=aar',
    '-s="$configPath"',
  ];
  print("上传pom文件为：" + deploy.pomFile.absolute.path);
  print("上传aar文件为：" + deploy.aarFile.absolute.path);
  final shell = "mvn ${args.join(' \\\n    ')}";

  final f = File(
      "${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.sh");

  print("文件路径：" + f.absolute.path);

  f.writeAsStringSync(shell);
  print("文件路径：" + f.absolute.path);

  final process = await Process.start('sh', [f.path]);
  final stdout = await utf8.decodeStream(process.stdout);
  final stderr = await utf8.decodeStream(process.stderr);
  print(stdout);
  print(stderr);
  // final exitCode = await process.exitCode;
  // if (exitCode != 0) {
  //   exit(exitCode);
  // }
}

```


mvn-settings.xml


```
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <pluginGroups>
  </pluginGroups>

  <proxies>
   
  </proxies>

  <servers>
    <server>
      <id>用户id</id>
      <username>用户名</username>
      <password>用户密码</password>
    </server>
  </servers>

  <mirrors>
  </mirrors>

  <profiles>
  </profiles>
</settings>
```


#### 3. native工程下的组件包`"flutterbridge"`，配置引用远程仓库中的aar库，然后再把该组件包`"flutterbridge"`进行打包输出aar包，最后让native项目引用该aar

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/EE072D53CFC94C60A5E91BC11BF17322?ynotemdtimestamp=1663952153937)

flutterbridge项目下的push.gradle


```gradle
//支持将项目发布到maven仓库的插件
apply plugin: 'maven'
//支持对库文件数字签名的插件，可以通过签名知道文件的创建者，创建时间等信息
apply plugin: 'signing'
apply plugin: 'maven-publish'
group = '组的名字'
version = '0.0.1-SNAPSHOT'
description = """Flutter-Native Bridge"""
publishing {
    publications {
        println('进入publications')
        maven(MavenPublication) {
            artifact "${project.buildDir}/outputs/aar/flutter-${version}.aar"
            artifactId 'flutter-release'
            pom.withXml {
                def dependenciesNode = asNode().appendNode('dependencies')
                //build.gradle里有api的依赖配置到pom里
                configurations.api.allDependencies.each {
                    if (it.group) {
                        def dependencyNode = dependenciesNode.appendNode('dependency')
                        dependencyNode.appendNode('groupId', it.group)
                        dependencyNode.appendNode('artifactId', it.name)
                        dependencyNode.appendNode('version', it.version)
                    }
                }
            }
        }
    }
}
publishing {
    if (version.endsWith("-SNAPSHOT")) {
        repositories {
            maven {
                url "http://上传地址"
                credentials {
                    username = "用户名"
                    password = "密码"
                }
            }
        }
    }
}


```

AndroidNativeProject项目下的app层，build.gradle引用上传到maven的flutterbridge仓库


```

dependencies {
    implementation 'androidx.appcompat:appcompat:1.3.0'
    implementation fileTree(include: ['*.jar'], dir: 'libs')
//    //Flutter库(源码依赖)
//    implementation project(':flutterbridge')
    //Flutter库(aar依赖)
    api('组名:库名:版本号')

}
```

    
### 三、iOS的发布模式

- 本节课目标

    1. 了解如何将flutter打包成framework
    2. 如何让主工程依赖到flutter的framework
    
#### 一、将flutter模块打包成framework的两种形式

1. flutter build ios-framework
2. flutter build ios-framework --cocoapods


#### 二、两种依赖模式

- 第一种模式

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/D10E9CDE302E48D2BAB6DDB2056DAD77?ynotemdtimestamp=1663952153937)

- 第二种模式

![image](https://note.youdao.com/yws/public/resource/57a8cfe4d32073c47cbaab2dc9c28e68/A13496F13D22418186D1C31FC051386C?ynotemdtimestamp=1663952153937)