import 'dart:async';
import 'dart:io';
import 'package:style_dart/style_dart.dart';

class HelloEndpoint extends Endpoint {
  @override
  FutureOr<Object> onCall(Request request) {
    return "<h1> Hello world </h1>";
  }
}

class MyServer extends StatelessComponent {
  const MyServer({Key? key}) : super(key: key);

  @override
  Component build(BuildContext context) {
    return Server(

        /// default localhost:80
        httpService: DefaultHttpServiceHandler(
            host: "0.0.0.0",
            port: int.tryParse(Platform.environment['PORT'] ?? "8080")),
        children: [Route("hello", root: HelloEndpoint())]);
  }
}

void runApp() {
  print("Start...");
  runService(MyServer());
}
