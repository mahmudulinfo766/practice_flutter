import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Pipe extends SpriteComponent with HasGameRef {

  Pipe(double height,) : super(size: Vector2(60, height));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('pipe.jpg');
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= 200 * dt; // Move pipe to the left

    if (x < -width) {
      removeFromParent();
    }
  }
}
