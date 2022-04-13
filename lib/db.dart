import 'dart:async';
import 'dart:convert';
import 'package:postgres/postgres.dart';

class DBService {
  var connection;

  DBService(creds) {
    connection = PostgreSQLConnection(
        creds["host"], int.parse(creds["port"]), creds["db"],
        username: creds["user"], password: creds["password"], useSSL: true);
  }

  Future<void> connect() async {
    await connection.open();
    print("Connecting... ${connection.toString()}");
  }

  Future<String> getQuestions() async {
    final query = '''SELECT * FROM questions
                        OFFSET floor(random() * (
                            SELECT
                                    COUNT(*)
                                    FROM questions
                                          )
                              ) LIMIT 10;''';
    List<List<dynamic>> results = await connection.query(query);

    return jsonEncode(results);
  }

  Future<void> createQuestion(data) async {
    final query =
        '''INSERT INTO questions(data) values('${data.toString()}')''';
    await connection.query(query);
  }
}
