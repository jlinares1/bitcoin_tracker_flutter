import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(
      {required this.urlPath,
      required this.unEncodedPath,
      required this.headers});

  final String urlPath;
  final String unEncodedPath;
  final Map<String, String> headers;

  Future getData() async {
    Uri url = Uri.https(urlPath, unEncodedPath);
    Response response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
