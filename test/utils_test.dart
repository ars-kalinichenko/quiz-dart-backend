import 'dart:convert';

import 'package:test/test.dart';
import 'package:quiz_app/utils.dart';

void main() {
  test("Test validator for post-requests [ok data]", () {
    final data = jsonDecode(
        '''{"title": "Test 1", "ok": ["ok 1", "ok 2"], "wrong": ["wrong 1"]}''');

    expect(isValidPostQuestion(data), true);
  });

  test("Test validator for post-requests [error data]", () {
    final data =
        jsonDecode('''{"ok": ["ok 1", "ok 2"], "wrong": ["wrong 1"]}''');

    expect(isValidPostQuestion(data), false);
  });

  test("Test creds parser", () {
    final uri = "postgres://jsldbp:91211@ec2-3amazonaws.com:5432/test_db";
    expect(getCredsFromURI(uri), {
      "user": "jsldbp",
      "password": "91211",
      "host": "ec2-3amazonaws.com",
      "port": "5432",
      "db": "test_db"
    });
  });
}
