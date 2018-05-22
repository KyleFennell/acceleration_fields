
World world;


void setup() {
  world = new World();
  size(800, 600, P2D);
  background(255);
  strokeWeight(3);
  frameRate(60);
  ellipseMode(CENTER);
}

void draw() {
  background(255);
  world.update();
  world.display();
}

void mousePressed() {
  if (keyPressed && keyCode == SHIFT && mouseButton == LEFT) {
    world.fields.add(new Field(new PVector(mouseX, mouseY), 0.03, 50));
  } else if (keyPressed && keyCode == SHIFT && mouseButton == RIGHT) {
    world.fields.add(new Field(new PVector(mouseX, mouseY), -0.03, 50));
  } else if (keyPressed && key == 'd' && mouseButton == LEFT) {
    world.emitters.add(new Emitter(new PVector(mouseX, mouseY), new PVector( 1, 0)));
  } else if (keyPressed && key == 'w' && mouseButton == LEFT) {
    world.emitters.add(new Emitter(new PVector(mouseX, mouseY), new PVector( 0, -1)));
  } else if (keyPressed && key == 'a' && mouseButton == LEFT) {
    world.emitters.add(new Emitter(new PVector(mouseX, mouseY), new PVector(-1, 0)));
  } else if (keyPressed && key == 's' && mouseButton == LEFT) {
    world.emitters.add(new Emitter(new PVector(mouseX, mouseY), new PVector( 0, 1)));
  } else if (keyPressed && keyCode == CONTROL) {
    for (Field f : world.fields) {
      if (f.calcForce(new PVector(mouseX, mouseY)).mag() != 0) {
        world.fields.remove(f);
      }
      break;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    setup();
  }
}
