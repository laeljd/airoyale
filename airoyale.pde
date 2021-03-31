Agent agent;
FireRing fireRing;

int width = 512;
int height = 512;
int translateX = width / 2;
int translateY = height / 2;

void setup() {
  size(512, 512);
  
  agent = new Agent(new PVector(-200, 0), 60);
  fireRing = new FireRing(new PVector(0, 0), width, 1, 0);
  fireRing.setDebug(true);
  fireRing.setDebugPosition(new PVector(-150,-200));
}

void draw() {
  background(0);
  translate(translateX, translateY);
  
  agent.update();
  fireRing.update();
}
