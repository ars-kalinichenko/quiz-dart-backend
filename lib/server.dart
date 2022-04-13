import 'dart:io';
import 'package:quiz_app/db.dart';
import 'package:quiz_app/utils.dart';
import 'package:style_dart/style_dart.dart';

import 'endpoints.dart';
import 'exceptions.dart';

class QuizAppServer extends StatelessComponent {
  const QuizAppServer({Key? key}) : super(key: key);

  @override
  Component build(BuildContext context) {
    final creds = getCredsFromURI(Platform.environment['DATABASE_URL'] ?? "");
    final db = DBService(creds);
    db.connect();

    return Server(
        defaultExceptionEndpoints: {Exception: ErrorEndpoint()},
        httpService: DefaultHttpServiceHandler(
            host: "0.0.0.0",
            port: int.tryParse(Platform.environment['PORT'] ?? "8080")),
        rootEndpoint: HelloEndpoint(),
        children: [
          Route("quiz", root: GetQuizEndpoint(db)),
          Route("create", root: CreateQuizEndpoint(db))
        ]);
  }
}

void runApp() {
  print("Start quiz app...");
  runService(QuizAppServer());
}
