import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'dart:math';

abstract final class AssistantMethods {
  // ignore: unused_element
  static String _generateRandomString(int len) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(len, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  static Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor!;
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      return windowsInfo.deviceId;
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      return linuxInfo.id;
    } else if (Platform.isMacOS) {
      final macosInfo = await deviceInfo.macOsInfo;
      return macosInfo.systemGUID;
    } else {
      // maybe this is error in the future
      final webInfo = await deviceInfo.webBrowserInfo;
      return webInfo.userAgent;
    }
  }
}
