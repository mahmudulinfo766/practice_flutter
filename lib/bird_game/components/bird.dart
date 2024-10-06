import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/painting.dart';

class Bird extends SpriteComponent with HasGameRef {
  double gravity = 600; // Gravity for the bird's fall
  double flySpeed = -300; // Speed of the bird's fly movement
  double velocity = 0; // Current vertical velocity
  bool isDead = false;

  Bird() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bird.jpg');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isDead) return;

    velocity += gravity * dt;
    y += velocity * dt;

    if (y > gameRef.size.y - 50) {
      isDead = true;
    }
  }

  void fly() {
    if (!isDead) {
      velocity = flySpeed;
    }
  }
}
