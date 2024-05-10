import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  isStoragePermissionGranted() async {
    var isStorageGranted = await Permission.storage.status;
    if (!isStorageGranted.isGranted) {
      await Permission.storage.request();
      if (!isStorageGranted.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
