import 'dart:io';

abstract class FileEradicator {
  void eradicate(String filePath);
}

class FileEradicatorImpl extends FileEradicator {
  @override
  void eradicate(String filePath) async {
    await File(filePath).delete();
  }
}
