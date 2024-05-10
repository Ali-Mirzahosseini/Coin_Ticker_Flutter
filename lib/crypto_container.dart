import 'package:flutter/material.dart';

class CryptoContainer extends StatelessWidget {
  final String text;
  CryptoContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 32.0, left: 24.0, right: 24.0,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(29, 27, 61, 1.0),
        gradient: const LinearGradient(colors: [Color.fromRGBO(29, 27, 61, 1.0), Color.fromRGBO(55, 61, 102, 1.0)]),
        boxShadow: const [BoxShadow(
          color: Colors.black54,
          offset: Offset(
            3.0,
            3.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),],),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}