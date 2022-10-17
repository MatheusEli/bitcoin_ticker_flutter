import 'package:bitcoin_ticker_flutter/services/currency.dart';
import 'package:flutter/material.dart';
import '../utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Currency currency = Currency();
  late double valueBitcoin;
  late double valueEthereum;
  late double valueLitecoin;
  late String currencyAbrev;
  @override
  void initState() {
    super.initState();
    getData('aud');
    currencyAbrev = 'aud';
  }

  void getData(currencyAbrev) async {
    var dataBitcoin = await currency.getBitcoinData(currencyAbrev);
    valueBitcoin = dataBitcoin['bitcoin'][currencyAbrev] + 0.0;

    var dataEthereum = await currency.getEthereumData(currencyAbrev);
    valueEthereum = dataEthereum['ethereum'][currencyAbrev] + 0.0;

    var dataLitecoin = await currency.getLitecoinData(currencyAbrev);
    valueLitecoin = dataLitecoin['litecoin'][currencyAbrev] + 0.0;
  }

  String selectedCurrency = currenciesList.first;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
          },
        );
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> items = [];

    for (String e in currenciesList) {
      items.add(
        Text(e),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            String selectedCurrency = currenciesList[selectedIndex];
            getData(selectedCurrency);
            currencyAbrev = selectedCurrency;
          },
        );
      },
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${hasBitcoin()} $currencyAbrev',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${hasEthereum()} $currencyAbrev',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${hasLitecoin()} $currencyAbrev',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  hasBitcoin() {
    return valueBitcoin == null ? '?' : valueBitcoin.toStringAsFixed(2);
  }

  hasEthereum() {
    return valueEthereum == null ? '?' : valueEthereum.toStringAsFixed(2);
  }

  hasLitecoin() {
    return valueLitecoin == null ? '?' : valueLitecoin.toStringAsFixed(2);
  }
}
