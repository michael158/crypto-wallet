import 'dart:math';

import 'package:http/http.dart'; //You can also import the browser version
import 'package:mywallet/model/token.dart';
import 'package:mywallet/services/binance.dart';
import 'package:web3dart/web3dart.dart';

class Web3Service {
  static const chainUrl = 'https://bsc-dataseed.binance.org/';
  late Web3Client ethClient;
  late EthereumAddress walletAddress;

  Web3Service() {
    Client httpClient = new Client();
    this.ethClient = new Web3Client(chainUrl, httpClient);

    this.walletAddress =
        EthereumAddress.fromHex('0x2a0402c12E7E3ec5b542E3149CE54b9e518d3E3C');
  }

  /// Return a token balance by contract address
  /// @author Michael Douglas
  Future<TokenBalance> getTokenBalance(
      Token token, EthereumAddress walletAddress) async {
    BinanceSmartChainService smartChainService = new BinanceSmartChainService();
    String abi =
        await smartChainService.getAbiByContractAddress(token.contract);
    ContractAbi contractAbi = ContractAbi.fromJson(abi, token.name);

    DeployedContract contract =
        DeployedContract(contractAbi, EthereumAddress.fromHex(token.contract));

    final decimalsResponse = await this.ethClient.call(
        contract: contract,
        function: contract.function('decimals'),
        params: []);

    final balanceResponse = await this.ethClient.call(
        contract: contract,
        function: contract.function('balanceOf'),
        params: [walletAddress]);

    double decimals = decimalsResponse[0].toDouble();
    double rawBalance = balanceResponse[0].toDouble();
    double balance = rawBalance / pow(10, decimals);

    return TokenBalance(value: balance, decimals: decimals);
  }
}
