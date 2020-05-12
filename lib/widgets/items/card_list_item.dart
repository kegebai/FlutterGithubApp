import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final String title;

  const CardListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor.withAlpha(66),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.zero,
          bottomLeft: Radius.zero,
          bottomRight: Radius.circular(20.0)
        ),
      ),
      clipBehavior: Clip.antiAlias,
      semanticContainer: false,
      child: Container(
        height: 95,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Row(
          children: <Widget>[
            // Wrap(
            //   spacing: 5,
            //   direction: Axis.vertical,
            //   alignment: WrapAlignment.center,
            //   crossAxisAlignment: WrapCrossAlignment.center,
            //   children: <Widget>[
            //     _buildIcon(),
            //   ],
            // ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(),
                  // _buildSubTitle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {}

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title, 
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]
            )
          ),
        ),
      ],
    );
  }

  Widget _buildSubTitle() {}
}
