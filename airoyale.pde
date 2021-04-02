import java.util.*;

List<Agent> agents = new ArrayList<Agent>();
FireRing fireRing;
int nAgents = 10;

int width = 512;
int height = 512;
int translateX = width / 2;
int translateY = height / 2;

void setup() {
  size(1024, 512);

  for (int i = 0; i < nAgents; i++) {
    float x = random(-200, 200);
    float y = random(-200, 200);
    agents.add(new Agent(new PVector(x, y), 15));
  }

  fireRing = new FireRing(new PVector(0, 0), width, 0.5, 1);
  fireRing.setDebug(true);
  fireRing.setDebugPosition(new PVector(-150,-200));
}

void draw() {
  background(0);
  translate(translateX, translateY);

  for (Agent agent : agents) {
    agent.update();
  }
  fireRing.update();
  fireRing.dealDamage(agents);
}
