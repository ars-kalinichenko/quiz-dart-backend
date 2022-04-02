import 'dart:async';
import 'dart:developer';
import 'package:style_dart/style_dart.dart';


class HelloEndpoint extends Endpoint {
  @override
  FutureOr<Object> onCall(Request request) {
    return "So crazy!";
  }
}

class MyServer extends StatelessComponent {
  const MyServer({Key? key}) : super(key: key);

  @override
  Component build(BuildContext context) {
    return Server(
        /// default localhost:80
        httpService: DefaultHttpServiceHandler(host: "0.0.0.0", port: 8080),
        children: [Route("hello", root: HelloEndpoint())]);
  }
}

void runApp() {
  print("Strat...");
  runService(MyServer());
}
