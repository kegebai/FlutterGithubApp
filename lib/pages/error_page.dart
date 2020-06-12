import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String errMsg;
  final FlutterErrorDetails errDetails;

  const ErrorPage({this.errMsg, this.errDetails});

  @override
  _ErrorPageState createState() => new _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  static var errStacks = new List<Map<String, dynamic>>();
  static var errorName = new List<String>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var msgs = widget.errMsg.split(",");

    return Container(
      child: new Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient: RadialGradient(
              tileMode: TileMode.mirror,
              radius: 0.1,
              colors: [
                Colors.white.withAlpha(10),
                Theme.of(context).primaryColor.withAlpha(100),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/images/36686.png"),
                width: 90.0,
                height: 90.0,
              ),
              new SizedBox(height: 10),
              new Text(
                "Error Occur",
                style: new TextStyle(fontSize: 24, color: Colors.redAccent),
              ),
              // Material(
              //   child: new Text(
              //     "Error Occur",
              //     style: new TextStyle(fontSize: 24, color: Colors.redAccent)
              //   ),
              //   color: Theme.of(context).primaryColor,
              // ),
              new SizedBox(height: 10),
              new SizedBox(
                height: 200,
                child: new ListView.builder(
                  itemBuilder: (context, int index) {
                    return ListTile(title: Text(msgs[index]), dense: true);
                  },
                  itemCount: msgs.length,
                ),
              ),
              new SizedBox(height: 10),
              new Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
