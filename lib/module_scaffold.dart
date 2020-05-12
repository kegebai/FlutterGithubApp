import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/global/global_bloc.dart';
import './blocs/global/global_state.dart';
import './pages/home/home_page.dart';
import './pages/profile/profile_page.dart';

class ModuleScaffold extends StatefulWidget {
  @override
  _ModuleScaffoldState createState() => new _ModuleScaffoldState();
}

class _ModuleScaffoldState extends State<ModuleScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, state) => Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBotNavBar(),
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        HomePage(),
        ProfilePage(),
      ],
    );
  }

  Widget _buildBotNavBar() {
    return SafeArea(
      child: SizedBox(
        height: 50.0,
        child: Card(
          color: Platform.isIOS ? Colors.transparent : Colors.white,
          elevation: Platform.isIOS ? 0.0 : 8.0,
          // iphone 无阴影
          shape: RoundedRectangleBorder(),
          margin: EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(color: Color(0xFFE0E0E0), height: 0.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildItem(icon: Icons.widgets, text: '首页', index: 0),
                    _buildItem(icon: Icons.fingerprint, text: '我的', index: 1),
                  ]
                ),
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildItem({IconData icon, String text, int index}) {
    Color color = _currentIndex == index ? Theme.of(context).primaryColor : Colors.grey;
    // Color color = _currentIndex == index ? state.color : Colors.grey;
    return Expanded(
      child: InkResponse(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color, size: 22.0),
            Text(text, style: TextStyle(color: color, fontSize: 10.0))
          ]
        ),
        onTap: () => setState(() => _currentIndex = index)
      )
    );
  }
}