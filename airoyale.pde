import java.util.*;

DebugManager dm;
List<Agent> agents = new ArrayList<Agent>();
FireRing fireRing;
int nAgents = 3;

int width = 1024;
int height = 1024;
int translateX = width / 2;
int translateY = height / 2;
boolean loop = false;

void setup() {
  size(1024, 1024);
  noLoop();
  dm = new DebugManager(new PVector(-translateX + 150,-translateY + 150), 0, false);
  fireRing = new FireRing(new PVector(0,0), 100, width/2, 0.5, 1, dm);
  fireRing.dye = color(255, 60, 60);  
  fireRing.setDebug(true);
  
  for (int i = 0; i < nAgents; i++) {
    float x = random(-translateX, translateX);
    float y = random(-translateY, translateY);
    Agent agent = new Agent(new PVector(x, y), 15, new float[]{random(-1, 1), random(-1, 1)});
    // agent.setDebug(true);
    agent.dye = color(random(50, 255), random(50, 255), random(50, 255));
    agent.rotateTo(random(0, 361));

    // Sensors
    ISignal sensor1 = new LocationSensorDirection(agent, fireRing, agent.dm, agent.dye + 200 );
    // sensor1.setDebug(true);
    agent.addSensor(sensor1);

    agent.wakeUp();
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
  
  this.dm.draw();
}



void keyPressed() {
  if (key == 32) loop = !loop;

  if(!loop) writeDebug("pausado. SPACE ou MOUSE 1", "", new PVector(translateX, translateY), -1, color(128, 128, 128));

  if(loop) loop(); else noLoop();
}

void keyTyped() {
  // println("typed " + int(key) + " " + keyCode);
  if (key == 100) this.agents.get(0).sprin(5);
  if (key == 97) this.agents.get(0).sprin(-5);
  if (key == 119) this.agents.get(0).move(5);
  if (key == 115) this.agents.get(0).move(-5);
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