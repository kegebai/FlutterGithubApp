import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String message;
  final FlutterErrorDetails details;

  const ErrorPage({this.message, this.details});

  @override
  _ErrorPageState createState() => new _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  static var errorStack = new List<Map<String, dynamic>>();
  static var errorName = new List<String>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Container(
      child: new Center(
        child: Container(
          alignment: Alignment.center,
          width: w,
          height: w,
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient: RadialGradient(
              tileMode: TileMode.mirror, 
              radius: 0.1, 
              colors: [
                Colors.white.withAlpha(10),
                Theme.of(context).primaryColor.withAlpha(100),
              ]
            ),
            borderRadius: BorderRadius.all(Radius.circular(w / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // new Image(
              //   image: new AssetImage(GSYICons.DEFAULT_USER_ICON),
              //   width: 90.0,
              //   height: 90.0
              // ),
              new SizedBox(height: 11,),
              Material(
                child: new Text(
                  "Error Occur",
                  style: new TextStyle(fontSize: 24, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              new SizedBox(height: 40,),
              new Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      //todo Commit issue information to author
                    }, 
                    child: Text('Commit issue'),
                  ),
                ],
              ),
              new SizedBox(height: 40,),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('Back')
              ),
            ],
          ),
        ),
      )
    );
  }
  
}