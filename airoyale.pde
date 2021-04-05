import java.util.*;

List<Agent> agents = new ArrayList<Agent>();
FireRing fireRing;
int nAgents = 1;

int width = 512;
int height = 512;
int translateX = width / 2;
int translateY = height / 2;
boolean loop = false;

void setup() {
  size(1024, 512);
  noLoop();

  fireRing = new FireRing(new PVector(0, 0), width, 0.5, 1);
  fireRing.dye = color(255, 60, 60);
  fireRing.debug = true;
  fireRing.debugPosition = new PVector(-150,-200);  
  
  for (int i = 0; i < nAgents; i++) {
    float x = random(-200, 200);
    float y = random(-200, 200);
    Agent agent = new Agent(new PVector(x, y), 15, fireRing);
    agent.debug = true;
    agent.dye = color(random(50, 255), random(50, 255), random(50, 255));
    // ISignal sensor1 = new SensorAgentMapDirection(agent, fireRing);
    // agent.addSensor(sensor1);
    agents.add(agent);
  }
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

void keyPressed() {
  if (key == 32) loop = !loop;

  if(!loop) writeDebug("pausado. SPACE ou MOUSE 1", "", new PVector(translateX, translateY), -1, color(128, 128, 128));

  if(loop) loop(); else noLoop();
}

void mousePressed() {
  loop = !loop;

  if(!loop) writeDebug("pausado. SPACE ou MOUSE 1", "", new PVector(translateX, translateY), -1, color(128, 128, 128));

  if(loop) loop(); else noLoop();
}

private void writeDebug(String label, String value, PVector position, int line, color dye) {
    fill(dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }