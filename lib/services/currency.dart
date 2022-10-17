import 'dart:convert';
import 'package:http/http.dart' as http;

class Currency {
  getBitcoinData(currencyAbrev) async {
    final url = Uri.https(
      'api.coingecko.com',
      'api/v3/simple/price',
      {'ids': 'bitcoin', 'vs_currencies': currencyAbrev},
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  getEthereumData(currencyAbrev) async {
    final url = Uri.https(
      'api.coingecko.com',
      'api/v3/simple/price',
      {'ids': 'ethereum', 'vs_currencies': currencyAbrev},
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  getLitecoinData(currencyAbrev) async {
    final url = Uri.https(
      'api.coingecko.com',
      'api/v3/simple/price',
      {'ids': 'litecoin', 'vs_currencies': currencyAbrev},
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
