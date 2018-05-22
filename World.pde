class World {

  ArrayList<Particle> particles;
  ArrayList<Particle> deadParticles;
  ArrayList<Field> fields;
  ArrayList<Emitter> emitters;

  World() {
    particles = new ArrayList<Particle>();
    fields = new ArrayList<Field>();
    emitters = new ArrayList<Emitter>();
    deadParticles = new ArrayList<Particle>();
  }

  void update() {
    for (Emitter e : emitters) {
      if (frameCount%e.speed == 0) {
        if (deadParticles.isEmpty()) {
          particles.add(e.emit());
        } else {
          particles.add(e.emit(deadParticles.get(0)));
          deadParticles.remove(0);
        }
      }
    }
    for (Particle p : particles) {
      ArrayList<PVector> forces = new ArrayList<PVector>();
      for (Field f : fields) {
        forces.add(f.calcForce(p.pos));
      }
      p.applyForce(forces);
      p.update();
    }
    for (int i = particles.size()-1; i >=0; i--) {
      if (particles.get(i).isDead()) {
        deadParticles.add(particles.get(i));
        particles.remove(i);
      }
    }
  }

  void display() {
    for (Field f : fields) {
      f.display();
    }
    for (Particle p : particles) {
      p.display();
    }
  }
}

class Field {

  PVector pos;
  float strength;
  float radius;

  Field(PVector pos, float strength, float radius) {
    this.pos = pos;
    this.strength = strength;
    this.radius = radius;
  }

  void display() {
    if (strength > 0) {
      fill(0, 255, 0, strength*10000);
    } else {
      fill(255, 0, 0, -strength*10000);
    }
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  PVector calcForce(PVector pos) {
    float dist = dist(pos.x, pos.y, this.pos.x, this.pos.y);
    if (dist < radius) {
      PVector force = new PVector(pos.x-this.pos.x, pos.y-this.pos.y).normalize();
      return force.mult(-strength/dist);
    }
    return new PVector(0, 0);
  }
}
