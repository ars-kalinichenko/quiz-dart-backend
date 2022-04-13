import 'package:json_schema2/json_schema2.dart';
import 'package:uri/uri.dart';

bool isValidPostQuestion(data) {
  final descriptionJson = {
    "title": "Question for quiz",
    "required": ["title", "wrong", "ok"],
    "type": "object",
    "properties": {
      "name": {"type": "string"},
      "wrong": {
        "type": "array",
        "items": {"type": "string"}
      },
      "ok": {
        "type": "array",
        "items": {"type": "string"}
      },
    }
  };

  final schema = JsonSchema.createSchema(descriptionJson);
  return schema.validate(data);
}

Map<String, Object> getCredsFromURI(String uriString) {
  final uriData = uriString.split("postgres:/")[1];
  final pattern = "/{user}:{password}@{host}:{port}/{db}";
  final uri = Uri.parse(uriData);
  final uriTemplate = UriTemplate(pattern);
  final parser = UriParser(uriTemplate);
  return parser.parse(uri);
}
