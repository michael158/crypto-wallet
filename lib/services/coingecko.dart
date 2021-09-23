import 'package:dio/dio.dart';
import 'package:mywallet/model/token.dart';

class CoingeckoService {
  Dio http = new Dio();

  /// Return token cotations by tokens id`s
  /// @author Michael Douglas
  Future<dynamic> getTokensPrice(List<String> tokenIds) async {
    String tokens = tokenIds.join(',');
    dynamic cotations = {};
    final response = await this.http.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {"ids": tokens, "vs_currencies": 'brl,usd'});

    tokenIds.forEach((String id) {
      dynamic cotationRaw = response.data[id];
      TokenCotation cotation =
          TokenCotation(brl: cotationRaw['brl'], usd: cotationRaw['usd']);
      cotations[id] = cotation;
    });

    return cotations;
  }
}
