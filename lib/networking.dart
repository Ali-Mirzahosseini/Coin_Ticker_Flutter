import 'package:http/http.dart' as http;

class Networking {
  final String url;
  final Map<String, String> header;
  final String currency;
  final String crypto;

  Networking(this.crypto, this.currency)
      : url = 'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency',
        header = {'X-CoinAPI-Key': 'D3D9E317-9CB7-47D0-84D4-AF71074B6850'};

  Future<String> getData() async{
    http.Response response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200){
      return response.body;
    } else {
      return 'This is the response code: $response.statusCode';
    }
  }
}