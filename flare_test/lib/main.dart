import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flare Demo - penguin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Penguin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with FlareController {
  double _rockAmount = 0.5;
  double _speed = 1.0;
  double _rockTime = 0.0;
  bool _isPaused = false;

  ActorAnimation _rock;

  @override
  void initialize(FlutterActorArtboard artboard) {
    // 이미 asset을 만들때 animation 이름을 등록해놓고 이렇게 이름으로 불러와서 실행시키는듯?
    _rock = artboard.getAnimation("music_walk");
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _rockTime += elapsed * _speed;
    _rock.apply(_rockTime % _rock.duration, artboard, _rockAmount);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlareActor(
              "assets/Penguin.flr",
              isPaused: _isPaused,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              animation: "walk",
              controller: this,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'mix amount',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
