// Particle class repurposed to change particle based on theme selection

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  PImage obj;

  Particle(PVector l, int img) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-2, 2), random(0, 5));
    position = l.copy();
    lifespan = 255.0;
    
    switch(img) {
      case 0:
        obj = loadImage("coconutPX.png");
        break;
      case 1:
        obj = loadImage("autumnPX.png");
        break;
      case 2:
        obj = loadImage("winterPX.png");
        break;
      case 3:
        obj = loadImage("batPX.png");
        break;
    }
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    obj.resize(50, 50);
    tint(255, lifespan);
    image(obj, position.x, position.y);
    noTint();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
