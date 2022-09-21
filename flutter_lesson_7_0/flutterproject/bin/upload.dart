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
