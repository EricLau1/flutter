import 'package:http/http.dart' as http;

const _baseUrl = 'https://jsonplaceholder.typicode.com';

class API {
  static Future getUsers() async {
    var url = _baseUrl + "/users";
    return await http.get(url);
  }
}