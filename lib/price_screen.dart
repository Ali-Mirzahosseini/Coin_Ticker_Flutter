import 'package:flutter/material.dart';
import 'crypto_container.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';
import 'dart:convert';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';


class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Timer? timer;
  bool apiFunctionWasTriggered = false;
  String BTCExchangeData = 'No data found.';
  String ETHExchangeData = 'No data found.';
  String USDTExchangeData = 'No data found.';
  String BTCRate = '0.0';
  String ETHRate = '0.0';
  String USDTRate = '0.0';

  @override
  void initState() {
    super.initState();
    if (currency != '?') {
      timer = Timer.periodic(
          const Duration(seconds: 10), (timer) => updateRate(currency));
    }
  }

  String getRate(String exchangeData) {
    var decodedData = json.decode(exchangeData);
    if (decodedData['asset_id_base'] == 'USDT') {
      return decodedData['rate'].toStringAsFixed(5);
    }
    return decodedData['rate'].toStringAsFixed(2);
  }

  void updateRate(currency) async {
    BTCExchangeData = await fetchDataFromAPI('BTC', currency);
    BTCRate = getRate(BTCExchangeData);
    ETHExchangeData = await fetchDataFromAPI('ETH', currency);
    ETHRate = getRate(ETHExchangeData);
    USDTExchangeData = await fetchDataFromAPI('USDT', currency);
    USDTRate = getRate(USDTExchangeData);
    setState(() {
      apiFunctionWasTriggered = false;
    });
  }

  Future<String> fetchDataFromAPI(String crypto, String? currency) async {
    setState(() {
      apiFunctionWasTriggered = true;
    });
    Networking networking = Networking(crypto, currency!);
    return await networking.getData();
  }

  String currency = '?';
  List<String> currencies = CoinData().getCoinData();

  CupertinoPicker iOSPicker() {
    List<Widget> currenciesAsWidgets = [];
    for (currency in currencies) {
      currenciesAsWidgets.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: const Color.fromRGBO(28, 41, 90, 1.0),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          currency = currencies[selectedIndex];
        });
        updateRate(currency);
        timer = Timer.periodic(
            const Duration(seconds: 10), (timer) => updateRate(currency));
      },
      children: currenciesAsWidgets,
    );
  }

  DropdownButton<String> androidDropDownButton() {
    return DropdownButton(
      dropdownColor: Colors.blue[900],
      menuMaxHeight: 390.0,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      hint: Text('CURRENCY'),
      items: [
        for (final currency in currencies)
          DropdownMenuItem(
            value: currency,
            child: Text(currency),
          ),
      ],
      onChanged: (value) {
        updateRate(value);
        setState(() {
          currency = value ?? '?';
          timer = Timer.periodic(
              const Duration(seconds: 10), (timer) => updateRate(currency));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(28, 41, 90, 1.0),
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Hello world!',
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 2000),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        actions: <Widget>[
          apiFunctionWasTriggered
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CryptoContainer('1 BTC = $BTCRate $currency'),
                CryptoContainer('1 ETH = $ETHRate $currency'),
                CryptoContainer('1 USDT = $USDTRate $currency'),
              ],
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.all(32.0),
              margin: EdgeInsets.only(top: 270.0),
              color: const Color.fromRGBO(28, 41, 90, 1.0),
              child: Center(
                  child:
                      Platform.isIOS ? iOSPicker() : androidDropDownButton()),
            ),
          ],
        ),
      ),
    );
  }
}
