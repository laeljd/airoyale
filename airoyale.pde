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
    Agent agent = new Agent(new PVector(x, y), 15);
    agent.debug = true;
    agent.dye = color(random(50, 255), random(50, 255), random(50, 255));
    agents.add(agent);
  }

  fireRing = new FireRing(new PVector(0, 0), width, 0.5, 1);
  fireRing.dye = color(255, 60, 60);
  fireRing.debug = true;
  fireRing.debugPosition = new PVector(-150,-200);
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
