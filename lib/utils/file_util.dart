import 'dart:io';
import 'package:flustars/flustars.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static Future<Directory> getAppDirectory() async {
    Directory? tempDir;
    if (Platform.isIOS) {
      tempDir = await getApplicationDocumentsDirectory(); //给ios用
    } else {
      tempDir = await getExternalStorageDirectory(); //给安卓用
    }
    final String tempPath = tempDir!.path + '/';
    final Directory file = Directory(tempPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Future<Directory> getAppApkDirectory() async {
    Directory? tempDir;
    if (Platform.isIOS) {
      tempDir = await getApplicationDocumentsDirectory();
    } else {
      tempDir = await getExternalStorageDirectory();
    }
    final String tempPath = tempDir!.path + '/apk';
    final Directory file = Directory(tempPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Future<Directory> _getTemporaryDirectory(String dirctor) async {
    final Directory tempDirectory = await getTemporaryDirectory();
    final String dirctorPath = tempDirectory.path + dirctor;
    final Directory file = Directory(dirctorPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Future<Directory> getVoiceTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/voice');
    return tempDirectory;
  }

  static Future<Directory> getVideoTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/video');
    return tempDirectory;
  }

  static Future<Directory> getImageTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/image');
    return tempDirectory;
  }

  static Future<Directory> getFileTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/file');
    return tempDirectory;
  }

  static Future<Directory> getUniappTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/uniapp');
    return tempDirectory;
  }

  static Future<Directory> getAudioTemporaryDirectory() async {
    final Directory tempDirectory = await _getTemporaryDirectory('/audio');
    return tempDirectory;
  }

  static deleteFile(String path){
    //因内置isEmpty不能判断是否为null, 所以这里用第三方flustars工具类库
    if(!TextUtil.isEmpty(path)){
      final lrsFloor = File(path);
      if(lrsFloor.existsSync()){
        lrsFloor.deleteSync();
      }
    }
  }
}