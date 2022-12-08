import 'package:http/http.dart' as http;

class FetchService {
  Future getUrl(String name) async {
    final url = Uri.parse("${Uri.base}/b/channel.php?name=$name");
    //final url = Uri.parse("http://orjinbus.com/b/channel.php?name=$name");
    final result = await http.get(url);
    return result.body;
  }
}
