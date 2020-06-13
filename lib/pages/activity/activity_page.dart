import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => new _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with WidgetsBindingObserver {
  
  final _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Following')),
      body: Center(child: Text('动态', style: TextStyle(color: Colors.green, fontSize: 20),),),
    );
  }
}