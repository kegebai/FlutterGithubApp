import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => new _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> with WidgetsBindingObserver {
  
  final _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Following')),
      body: Center(child: Text('动态', style: TextStyle(color: Colors.green, fontSize: 20),),),
    );
  }
}