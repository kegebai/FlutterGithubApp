import 'package:flutter/material.dart';
import '../../app/style/science_fiction_shape_border.dart';

class ScienceFictionListItem extends StatelessWidget {
  final String title;

  const ScienceFictionListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withAlpha(66),
      shape: ScienceFictionShapeBorder(color: Theme.of(context).primaryColor),
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