class World {

  ArrayList<Particle> particles;
  ArrayList<Field> fields;
  ArrayList<Emitter> emitters;

  World() {
    particles = new ArrayList<Particle>();
    fields = new ArrayList<Field>();
    emitters = new ArrayList<Emitter>();
  }
  
  void update(){
    for (Emitter e : emitters){
      if (frameCount%e.speed == 0){
        particles.add(e.emit());
      }
    }
    for (Particle p : particles){
      ArrayList<PVector> forces = new ArrayList<PVector>();
      for (Field f : fields){
        forces.add(f.calcForce(p.pos));
      }
      p.applyForce(forces);
      p.update();
    }
    for (int i = particles.size()-1; i >=0; i--){
      if (particles.get(i).isDead()){
        particles.remove(i);
      }
    }
  }
  
  void display(){
    for (Field f : fields){
      f.display();
    }
    for (Particle p : particles){
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
      fill(0, 255, 0, strength*1000);
    } else {
      fill(255, 0, 0, -strength*1000);
    }
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  PVector calcForce(PVector pos) {
    float dist = dist(pos.x, pos.y, this.pos.x, this.pos.y);
    if (dist < radius) {
      PVector force = new PVector(pos.x-this.pos.x, pos.y-this.pos.y);
      return force.mult(-strength);
    }
    return new PVector(0, 0);
  }
}
