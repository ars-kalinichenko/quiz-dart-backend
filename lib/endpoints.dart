import 'dart:async';
import 'dart:io';
import 'package:style_dart/style_dart.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'package:quiz_app/utils.dart';
import 'package:quiz_app/db.dart';

class HelloEndpoint extends Endpoint {
  var fileContent = "<h1>Hello!</h1>";

  HelloEndpoint() {
    final filePath =
        p.join(Directory.current.path, 'templates', 'welcome.html');
    File file = File(filePath);
    fileContent = file.readAsStringSync();
  }

  @override
  FutureOr<Object> onCall(Request request) {
    return fileContent;
  }
}

class GetQuizEndpoint extends Endpoint {
  DBService db;

  GetQuizEndpoint(this.db);

  @override
  Future<FutureOr<Object>> onCall(Request request) async {
    final res = await db.getQuestions();
    return request.response(Body(res),
        contentType: ContentType("application", "json"));
  }
}

class CreateQuizEndpoint extends Endpoint {
  DBService db;

  CreateQuizEndpoint(this.db);
  @override
  FutureOr<Object> onCall(Request request) {
    var parsedData = jsonDecode(request.body.toString());
    if (isValidPostQuestion(parsedData)) {
      db.createQuestion(request.body.toString());
    }
    return request.response(Body(parsedData));
  }
}
