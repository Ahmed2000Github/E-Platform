import 'dart:convert';
import 'package:http/http.dart';
import 'dart:developer' as developer;


class HttpService {
  //https://jsonplaceholder.typicode.com/posts
  final url = "https://text-recog.herokuapp.com/identify";
   Future<String> postData(var color,String imageBase64) async {
    final uri = Uri.parse('https://text-recog.herokuapp.com/identify');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'color': color,
      'bytes':imageBase64
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      Response response = await post(
        uri,
       headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      print(response.statusCode);
     String responseBody = response.body;
      developer.log('base64 after:'+responseBody);
    } catch (er) {
      print(er.toString());
    }
  }
}