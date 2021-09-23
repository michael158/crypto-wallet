class Token {
  late String id;
  late String name;
  late String contract;
  late TokenInfo info;
  late TokenBalance? balance;

  Token({
    required this.id,
    required this.name,
    required this.contract,
    this.balance,
  });
}

class TokenInfo {
  late String name;
  late String symbol;
  late String category;
  late String logoUrl;
  late String? description;

  TokenInfo({
    required this.name,
    required this.symbol,
    required this.category,
    required this.logoUrl,
    this.description,
  });

  TokenInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    category = json['category'];
    logoUrl = json['logo'];
    description = json['description'];
  }
}

class TokenBalance {
  double value;
  double decimals;
  TokenCotation? cotation;

  TokenBalance({required this.value, required this.decimals, this.cotation});
}

class TokenCotation {
  double usd;
  double brl;

  TokenCotation({required this.brl, required this.usd});
}
