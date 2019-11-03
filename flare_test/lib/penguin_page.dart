import 'package:flutter/material.dart';

import 'package:flare_dart/math/mat2d.dart';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

class PenguinPage extends StatefulWidget {
  const PenguinPage();

  @override
  _PenguinPageState createState() => _PenguinPageState();
}

class _PenguinPageState extends State<PenguinPage> with FlareController {
  double _rockAmount = 0.5;
  double _speed = 1.0;
  double _rockTime = 0.0;
  bool _isPaused = false;

  ActorAnimation _rock;

  @override
  void initialize(FlutterActorArtboard artboard) {
    // 처음에 캐릭터가 등장했을때 (idle상태) 애니매이션 지정 및 변수로 저장하고 속도, 움직임을 나중에 업데이트 할 수 있음
    _rock = artboard.getAnimation('music_walk');
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
      appBar: AppBar(title: Text('Penguin')),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlareActor(
              'assets/Penguin.flr',
              isPaused: _isPaused,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              // 캐릭터를 띄우면서 그 캐릭터가 어떤 애니매이션을 할 것인지 지정한다.
              animation: 'walk',
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
                      Text('Mix Amount', style: TextStyle(color: Colors.white)),
                      Slider(
                        value: _rockAmount,
                        min: 0.0,
                        max: 1.0,
                        divisions: null,
                        onChanged: (double value) {
                          setState(() {
                            _rockAmount = value;
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
                      )
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
