import 'package:dio/dio.dart';
import 'package:mywallet/model/token.dart';

class CoinMarketCapService {
  String apiKey = 'a5d1498b-ecc1-4fa8-8c5a-9b2338fcfd6a';
  String apiUrl = 'https://pro-api.coinmarketcap.com';
  late Dio http = new Dio();

  Future<dynamic> getCoinsInfo(List<String> symbols) async {
    dynamic coins = {};

    final response =
        await this.http.get("$apiUrl/v1/cryptocurrency/info", queryParameters: {
      "CMC_PRO_API_KEY": apiKey,
      "symbol": symbols.join(','),
    });

    for (final coin in response.data['data'].keys.toList()) {
      TokenInfo tokenInfo = TokenInfo.fromJson(response.data['data'][coin]);
      coins[coin] = tokenInfo;
    }
    return coins;
  }
}
