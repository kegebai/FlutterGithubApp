import 'package:flutter/material.dart';

class ScienceFictionShapeBorder extends ShapeBorder {
  final Paint _paint = Paint();
  final Path outerLinePath = Path();
  final Path innerLinePath = Path();
  final Path topInnerLinePath = Path();
  final Color color;

  final cornerWidth;
  final spanWidth;
  final strokeWidth;
  final innerRate;

  ScienceFictionShapeBorder({
    this.color = Colors.green,
    this.cornerWidth = 10.0,
    this.spanWidth = 2.5,
    this.innerRate = 0.15,
    this.strokeWidth = 1.0,
  }) {
    _paint
      ..color = color
      ..strokeWidth = strokeWidth;
  }

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(5)));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    outerLinePath
      ..moveTo(cornerWidth, 0)
      ..lineTo(rect.width - cornerWidth, 0)
      ..lineTo(rect.width, cornerWidth)
      ..lineTo(rect.width, rect.height - cornerWidth)
      ..lineTo(rect.width - cornerWidth, rect.height)
      ..lineTo(cornerWidth, rect.height)
      ..lineTo(0, rect.height - cornerWidth)
      ..lineTo(0, cornerWidth)
      ..close();
    
    innerLinePath
      ..moveTo(rect.width / 2, rect.height)
      ..relativeLineTo(rect.width * innerRate, 0)
      ..relativeLineTo(-spanWidth * 2, -spanWidth)
      ..relativeLineTo(-rect.width * innerRate * 2, 0)
      ..relativeLineTo(-spanWidth * 2, spanWidth)
      ..close();
    
    return Path.combine(
      PathOperation.difference, 
      outerLinePath, 
      innerLinePath
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    canvas.drawPath(
      Path.combine(
        PathOperation.difference, 
        outerLinePath, 
        innerLinePath
      ),
      _paint..style = PaintingStyle.stroke,
    );

    topInnerLinePath
      ..moveTo(rect.width / 2, 0)
      ..relativeLineTo(rect.width * innerRate, 0)
      ..relativeLineTo(-spanWidth * 2, spanWidth)
      ..relativeLineTo(-rect.width * innerRate * 2, 0)
      ..relativeLineTo(-spanWidth * 2, -spanWidth)
      ..close();
    
    canvas.drawPath(topInnerLinePath, _paint..style = PaintingStyle.fill);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
