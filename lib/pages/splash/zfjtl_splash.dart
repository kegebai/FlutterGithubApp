import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/router.dart';
import '../../blocs/oauth/oauth_bloc.dart';
import '../../blocs/oauth/oauth_event.dart';
import '../../blocs/oauth/oauth_state.dart';
import '../../repositories/itf/user_repository.dart';

class ZfjtlSplash extends StatefulWidget {
  final OAuthState authState;
  final UserRepository userRepo;

  ZfjtlSplash({
    double size=200, 
    this.authState, 
    this.userRepo,
  });

  @override
  _ZfjtlSplashState createState() => new _ZfjtlSplashState();
}

class _ZfjtlSplashState extends State<ZfjtlSplash> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _secController;
  double _factor;
  double _secFactor = 0.0;

  Animation _curveAnim;
  Animation _secCurveAnim;
  Animation _bouncAnim;

  bool _animComplete = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    // SystemUiOverlayStyle systemUiOverlayStyle =
    //     SystemUiOverlayStyle(statusBarColor: Colors.red);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.blue));

    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    // SystemChrome.setEnabledSystemUIOverlays([]);

    _controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 1000)
    )
      ..addListener(() => setState(() {
            return _factor = _curveAnim.value;
          }))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animComplete = true;
            _secController.forward();
          });
        }
      });

    _secController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 600)
    )
      ..addListener(() => setState(() {
            return _secFactor = _secCurveAnim.value;
          }))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.authState is OAuthed) {
            Navigator.of(context).pushReplacementNamed(Router.module_scaffold);
          } 
          if (widget.authState is UnOAuthed) {
            BlocProvider.of<OAuthBloc>(context).add(UnInited());
            Navigator.of(context).pushReplacementNamed(Router.login);
          }
        }
      });

    _curveAnim = CurvedAnimation(
      parent: _controller, 
      curve: Curves.fastOutSlowIn,
    );
    _bouncAnim = CurvedAnimation(
      parent: _secController, 
      curve: Curves.bounceOut,
    );
    _secCurveAnim = CurvedAnimation(
      parent: _secController, 
      curve: Curves.fastOutSlowIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _secController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var winH = MediaQuery.of(context).size.height;
    var winW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //
          _buildFlutterLogo(Colors.blue),
          //
          Container(
            width: winW,
            height: winH,
            child: CustomPaint(
              painter: SplashPainter(factor: _factor),
            ),
          ),
          //
          _buildDescText(winW, winH),
        ],
      ),
    );
  }

  Widget _buildFlutterLogo(Color primaryColor) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(0, -1.5),
      ).animate(_controller),
      child: RotationTransition(
        turns: _controller,
        child: ScaleTransition(
          scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
          child: FadeTransition(
            opacity: _controller,
            child: Container(
              height: 120,
              child: FlutterLogo(
                colors: primaryColor,
                style: _animComplete
                    ? FlutterLogoStyle.horizontal
                    : FlutterLogoStyle.markOnly,
                size: _animComplete ? 150 : 45,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildDescText(double winW, double winH) {
    final style = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
        ),
      ],
    );

    return Positioned(
      top: winH / 1.5,
      child: Container(
        width: winW,
        height: 150,
        child: AlignTransition(
          alignment:
              AlignmentTween(begin: Alignment(-1, 0), end: Alignment.center)
                  .animate(_controller),
          child: AnimatedOpacity(
            opacity: _animComplete ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: ShaderMask(
              shaderCallback: _buildShader,
              child: Text('Hi, Flutter!', style: style),
            ),
          ),
        ),
      ),
    );
  }

  Shader _buildShader(Rect bounds) {
    return RadialGradient(
      colors: [
        Colors.red,
        Colors.yellow,
        Colors.blue,
      ],
      center: Alignment.center,
      radius: 1.0,
      tileMode: TileMode.mirror,
    ).createShader(bounds);
  }
}

class SplashPainter extends CustomPainter {
  Paint _paint;
  double width;
  double factor;
  Color color;
  Path _path1 = Path();
  Path _path2 = Path();
  Path _path3 = Path();
  Path _path4 = Path();

  SplashPainter({this.width = 200.0, this.factor, this.color = Colors.blue}) {
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(
        size.width / 2 - width * 0.5, size.height / 2 - width * 0.5);
    _drawColors(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _drawColors(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    _path1.moveTo(0, 0);
    _path1.lineTo(width * 0.618 * factor - 1, 0);
    _path1.lineTo(width * 0.5 - 1, width * 0.5 - 1);
    _path1.lineTo(0, width * (1 - 0.618) * factor - 1);
    canvas.drawPath(_clipAngle(_path1), _paint..color = Colors.red);
    canvas.restore();

    canvas.save();
    canvas.translate(
        size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    _path2.moveTo(width * 0.618 * factor, 0);
    _path2.lineTo(width, 0);
    _path2.lineTo(width, width * 0.618 * factor);
    _path2.lineTo(width * 0.5, width * 0.5);
    canvas.drawPath(_clipAngle(_path2), _paint..color = Colors.blue);
    canvas.restore();

    canvas.save();
    canvas.translate(
        size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    _path3.moveTo(width * 0.5 + 1, width * 0.5 + 1);
    _path3.lineTo(width, width * 0.618 * factor + 1);
    _path3.lineTo(width, width);
    _path3.lineTo(width * (1 - 0.618) * factor + 1, width);
    canvas.drawPath(_clipAngle(_path3), _paint..color = Colors.green);
    canvas.restore();

    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    _path4.moveTo(0, width * (1 - 0.618) * factor);
    _path4.lineTo(width * 0.5, width * 0.5);
    _path4.lineTo(width * (1 - 0.618) * factor, width);
    _path4.lineTo(0, width);
    canvas.drawPath(_clipAngle(_path4), _paint..color = Colors.yellow);
    canvas.restore();
  }

  Path _clipAngle(Path path) {
    return Path.combine(
        PathOperation.difference,
        path,
        Path()
          ..addOval(Rect.fromCircle(
              center: Offset(width * 0.5, width * 0.5), radius: 25.0)));
  }
}
