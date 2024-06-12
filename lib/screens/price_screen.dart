import 'package:bitcoin_tracker_flutter/services/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_tracker_flutter/components/reusable_coin_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, dynamic> cryptoResponseList = {};

  @override
  void initState() {
    super.initState();
    getCryptoCoinData(selectedCurrency);
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      currencyList.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) async {
        setState(() {
          getCryptoCoinData(value ?? '');
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> currencyList = [];
    for (var currency in currenciesList) {
      currencyList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          getCryptoCoinData(currenciesList[selectedIndex]);
        });
      },
      children: currencyList,
    );
  }

  bool isWaiting = false;
  void getCryptoCoinData(String selectedCurrency) async {
    for (var crypto in cryptoList) {
      isWaiting = true;
      if (selectedCurrency != '') {
        var response = await CoinData().getCoinData(crypto, selectedCurrency);
        setState(() {
          cryptoResponseList[crypto] = response['rate'].toStringAsFixed(0);
          isWaiting = false;
        });
      }
    }
  }

  Column makeCards() {
    List<ReusableCoinCard> cryptoCards = [];
    for (var cryptoCoin in cryptoList) {
      cryptoCards.add(
        ReusableCoinCard(
            coin: cryptoCoin,
            coinRate: isWaiting ? '?' : cryptoResponseList[cryptoCoin],
            selectedCurrency: selectedCurrency),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
