import 'package:flutter/material.dart';

class TrendPage extends StatefulWidget {
  @override
  _TrendPageState createState() => new _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trend')),
      body: Center(child: Text('趋势', style: TextStyle(color: Colors.green, fontSize: 20),),),
    );
  }
}