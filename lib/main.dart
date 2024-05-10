import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(const CoinTicker());
}

class CoinTicker extends StatelessWidget {
  const CoinTicker({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromRGBO(15, 19, 46, 1.0),
        scaffoldBackgroundColor: const Color.fromRGBO(15, 19, 46, 1.0),
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(28, 31, 46, 1.0),
          iconTheme: IconThemeData(color: Colors.white),
        ), ),
      home: const PriceScreen()
    );
  }
}


