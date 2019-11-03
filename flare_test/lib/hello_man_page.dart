import 'package:flutter/material.dart';

import 'package:flare_dart/math/mat2d.dart';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

class HelloManPage extends StatefulWidget {
  const HelloManPage();

  @override
  _HelloManPageState createState() => _HelloManPageState();
}

class _HelloManPageState extends State<HelloManPage> with FlareController {
  double _shakeAmount = 0.5;
  double _speed = 1.0;
  double _shakeTime = 0.0;
  bool _isPaused = false;
  String _animationName = 'shake_arms';

  ActorAnimation _shakeLegs;

  @override
  void initialize(FlutterActorArtboard artboard) {
    // 처음에 캐릭터가 등장했을때 (idle상태) 애니매이션 지정 및 변수로 저장하고 속도, 움직임을 나중에 업데이트 할 수 있음
    _shakeLegs = artboard.getAnimation('shake_legs');
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _shakeTime += elapsed * _speed;
    _shakeLegs.apply(_shakeTime % _shakeLegs.duration, artboard, _shakeAmount);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HelloMan')),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlareActor(
              'assets/hello_man.flr',
              isPaused: _isPaused,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              // 캐릭터를 띄우면서 그 캐릭터가 어떤 애니매이션을 할 것인지 지정한다.
              animation: _animationName,
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
                  child: ListView(
                    children: <Widget>[
                      Text('Mix Amount', style: TextStyle(color: Colors.white)),
                      Slider(
                        value: _shakeAmount,
                        min: 0.0,
                        max: 1.0,
                        divisions: null,
                        onChanged: (double value) {
                          setState(() {
                            _shakeAmount = value;
                          });
                        },
                      ),
                      Text('Speed', style: TextStyle(color: Colors.white)),
                      Slider(
                        value: _speed,
                        min: 0.2,
                        max: 3.0,
                        divisions: null,
                        onChanged: (double value) {
                          setState(() {
                            _speed = value;
                          });
                        },
                      ),
                      Text('Paused', style: TextStyle(color: Colors.white)),
                      Checkbox(
                        value: _isPaused,
                        onChanged: (bool value) {
                          setState(() {
                            _isPaused = value;
                          });
                        },
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text('Shake head', style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              setState(() {
                                _animationName = 'shake_head';
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('Shake legs', style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              setState(() {
                                _animationName = 'shake_legs';
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('Shake arms', style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              setState(() {
                                _animationName = 'shake_arms';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
