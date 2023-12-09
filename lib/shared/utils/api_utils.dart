import 'dart:convert';

abstract class ApiUtils {
  static dynamic convertResponse(response) =>
      json.decode(json.encode(response));
}
