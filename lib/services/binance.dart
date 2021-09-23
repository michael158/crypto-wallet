import 'package:dio/dio.dart';

class BinanceSmartChainService {
  /// Return ABI String by contract addreess
  /// @author Michael Douglas
  Future<String> getAbiByContractAddress(String address) async {
    String baseUrl = "https://api.bscscan.com/api";
    String apiKey = 'NVNXV4Y9ZXF7NP2XSU815INB3DTPI9EVGS';

    final response = await Dio().get(baseUrl, queryParameters: {
      'module': 'contract',
      'action': 'getabi',
      'address': address,
      'apikey': apiKey
    });
    return response.data['result'];
  }
}
