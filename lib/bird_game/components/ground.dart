import 'package:flame/components.dart';

class Ground extends SpriteComponent with HasGameRef {
  Ground({required Vector2 size}) : super(size: Vector2(size.x, 50)) ;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ground.png');
    position = Vector2(0, gameRef.size.y - height);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
