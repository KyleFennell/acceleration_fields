class Particle {

  PVector pos;
  PVector vel;
  PVector acc;

  Particle(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
  }

  void applyForce(ArrayList<PVector> forces) {
    for (PVector f : forces) {
      acc.add(f);
    }
  }

  void update() {
    vel.add(acc);
    capVelocity();
    pos.add(vel);
    acc = new PVector(0, 0);
  }

  void display() {
    point(pos.x, pos.y);
  }

  void capVelocity() {
    vel.setMag(10);
  }

  boolean isDead() {
    return (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0);
  }
}

class Emitter {

  PVector pos;
  PVector vel;
  int speed;

  Emitter(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    speed = 1;
  }

  Particle emit() {
    return new Particle(new PVector(pos.x, pos.y), new PVector(vel.x, vel.y));
  }
}
