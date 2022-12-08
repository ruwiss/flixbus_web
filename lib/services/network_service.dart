import 'package:http/http.dart' as http;

class NetworkService {
  Future<bool> checkIpAdress() async {
    final currentIpUrl = Uri.parse("https://api.ipify.org/");
    final websiteIpUrl = Uri.parse("${Uri.base}/b/get_ip.php");
    //final websiteIpUrl = Uri.parse("http://orjinbus.com/b/get_ip.php");

    final currentIp = await http.get(currentIpUrl).then((value) => value.body);
    final websiteIp = await http.get(websiteIpUrl).then((value) => value.body);

    return currentIp == websiteIp;
  }
}
