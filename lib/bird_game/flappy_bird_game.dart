import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:mach_managed/bird_game/components/bird.dart';
import 'package:mach_managed/bird_game/components/ground.dart';
import 'package:mach_managed/bird_game/components/pipe.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird _bird;
  late Ground _ground;
  late List<Pipe> _pipes;
  final double _pipeSpawnTime = 2.0;
  double _timeSinceLastPipe = 0.0;

  @override
  Future<void> onLoad() async {
    // Load the background
    _bird = Bird()
      ..position = Vector2(100, 200)
      ..anchor = Anchor.center;
    add(_bird);

    _ground = Ground(size: size);
    add(_ground);

    _pipes = [];
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipe += dt;

    // Spawn new pipes
    if (_timeSinceLastPipe > _pipeSpawnTime) {
      _timeSinceLastPipe = 0.0;
      addPipe();
    }

    // Check for collisions with the ground or pipes
    if (_bird.isDead) {
      pauseEngine();
    }
  }

  void addPipe() {
    double gapHeight = 200;
    double pipeHeight = Random().nextDouble() * (size.y - gapHeight - 100);

    Pipe topPipe = Pipe(pipeHeight, )
      ..position = Vector2(size.x, pipeHeight - size.y);
    Pipe bottomPipe = Pipe(pipeHeight + gapHeight)
      ..position = Vector2(size.x, pipeHeight + gapHeight);

    addAll([topPipe, bottomPipe]);
    _pipes.addAll([topPipe, bottomPipe]);
  }

  @override
  void onTap() {
    _bird.fly();
  }
}
