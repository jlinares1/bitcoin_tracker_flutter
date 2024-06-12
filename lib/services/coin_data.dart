import 'package:bitcoin_tracker_flutter/services/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final coinApiKey = dotenv.env['API_KEY'];

//get specific rate url: https://rest.coinapi.io/v1/exchangerate/:asset_id_base/:asset_id_quote
class CoinData {
  Future<dynamic> getCoinData(String coinId, String currencyId) async {
    NetworkHelper networkHelper = NetworkHelper(
        urlPath: 'rest.coinapi.io',
        unEncodedPath: '/v1/exchangerate/$coinId/$currencyId',
        headers: {
          'Accept': 'application/json',
          'X-CoinAPI-Key': coinApiKey.toString()
        });

    return await networkHelper.getData();
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
