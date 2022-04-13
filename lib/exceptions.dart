import 'dart:async';
import 'dart:io';
import 'package:style_dart/style_dart.dart';
import 'package:path/path.dart' as p;

class ErrorEndpoint extends ExceptionEndpoint<StyleException> {
  var fileContent = "<h1>Hello!</h1>";

  ErrorEndpoint() {
    final filePath = p.join(Directory.current.path, 'templates', 'error.html');
    File file = File(filePath);
    fileContent = file.readAsStringSync();
  }

  @override
  FutureOr<Object> onError(
      Message message, StyleException exception, StackTrace stackTrace) {
    return fileContent;
  }
}